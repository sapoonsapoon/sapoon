package sapoon.weatherservice.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import sapoon.weatherservice.common.Common;
import sapoon.weatherservice.config.kafka.Producer;
import sapoon.weatherservice.mapper.WeatherMapper;
import sapoon.weatherservice.vo.AdministrativeAreaInfoVO;
import sapoon.weatherservice.vo.MiseVO;

import javax.security.sasl.SaslServer;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Service
public class WeatherService {

    private static final Logger LOGGER = LoggerFactory.getLogger(WeatherService.class);
    private String serviceKey = "WRPy8feYZ9D%2FrB0v12gVfeyu3E%2BEWNFuYxpr4AKOtLbaBHzgIV7q5%2F8EXn2HbPc8oGTEN%2BcXh3173CX5kqXmEQ%3D%3D";

    @Autowired
    WeatherMapper weatherMapper;

    @Autowired
    Producer producer;


    SimpleDateFormat format1 = new SimpleDateFormat ( "YYYY-MM-dd");
    Date time = new Date();
    String time1 = format1.format(time);





    public Map<String,Object> mise() throws IOException, ParserConfigurationException, SAXException {

        String[] fieldNames ={ "seoul", "busan", "daegu", "incheon", "gwangju"
                ,"daejeon","ulsan","gyeonggi","gangwon","chungbuk","chungnam","jeonbuk","jeonnam","gyeongbuk","gyeongnam"
                ,"jeju","sejong"
        };

        Map<String, Object> resultMap = new HashMap<String,Object>();

        StringBuilder urlBuilder = new StringBuilder("http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureLIst"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("itemCode","UTF-8") + "=" + URLEncoder.encode("PM10", "UTF-8")); /*측정항목 구분 (SO2, CO, O3, NO2, PM10, PM25)*/
        urlBuilder.append("&" + URLEncoder.encode("dataGubun","UTF-8") + "=" + URLEncoder.encode("HOUR", "UTF-8")); /*요청 자료 구분 (시간평균 : HOUR, 일평균 : DAILY)*/
        urlBuilder.append("&" + URLEncoder.encode("searchCondition","UTF-8") + "=" + URLEncoder.encode("MONTH", "UTF-8")); /*요청 데이터기간 (일주일 : WEEK, 한달 : MONTH)*/


        DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
        DocumentBuilder b = f.newDocumentBuilder();
        Document doc = null;

        NodeList item = null;
        HashMap<String,String> pub = new HashMap<String,String>();
        try{
            b = f.newDocumentBuilder();
            doc = b.parse(urlBuilder.toString());
            item = doc.getElementsByTagName("item");
            System.out.println("item : "+item);
            System.out.println("item : "+item.getLength());

            Node n = item.item(0);
            Element e = (Element) n;

            //for 루프 시작
            HashMap<String,String> city = new HashMap<String,String>();
            ArrayList<HashMap<String,String>> cityList = new ArrayList<HashMap<String,String>>();

            for(String name : fieldNames){
                city = new HashMap<String,String>();
                //"hour", "day", "temp", "tmx", "tmn", "sky", "pty", "wfKor"....에 해당하는 값을 XML 노드에서 가져옴
                NodeList titleList = e.getElementsByTagName(name);
                Element titleElem = (Element) titleList.item(0);

                Node titleNode = titleElem.getChildNodes().item(0);
                // 가져온 XML 값을 맵에 엘리먼트 이름 - 값 쌍으로 넣음
                pub.put(name, titleNode.getNodeValue());
                city.put("name",name);
                city.put("value",titleNode.getNodeValue());
                cityList.add(city);
            }

            resultMap.put("cityList",cityList);
            resultMap.put("dataTime",e.getElementsByTagName("dataTime").item(0).getChildNodes().item(0).getNodeValue());
            resultMap.put("itemCode",e.getElementsByTagName("itemCode").item(0).getChildNodes().item(0).getNodeValue());

//            """"

            System.out.println("pub : "+pub);
            System.out.println("city : "+city);

            System.out.println("resultMap : "+resultMap);
        }

        catch (Exception e) {
            e.printStackTrace();
        }

        LOGGER.info("WeatherService mise function end");
//        resultMap.put("result",pub);
        return resultMap;

    }

    //db에서 가져옴.
    public Map<String, Object> getCurrentWeather(String nx, String ny) {

        Map<String, Object> result = new HashMap<>();

        String hour = time1.split("-")[1];
        System.out.println("hour "+ hour);
        if(hour.contains("0")) hour = hour.split("0")[1];
        System.out.println("hour : "+hour);
        //db조회
        AdministrativeAreaInfoVO administrativeAreaInfoVO = weatherMapper.findCurrentWeather(nx, ny, hour);
        if(administrativeAreaInfoVO == null){
            LOGGER.info("날씨 조회 db 없음");
            result.put("result",null);
            return result;
        }else{
            LOGGER.info("날씨 조회 db 있음");
            result.put("result", administrativeAreaInfoVO);
            return result;
        }

    }

    //좌표 받아서 가장가까운 도시명 찾아내서. like문으로 찾기?
    public Map<String, Object> getCurrentMise(String nx, String ny) {

        Map<String, Object> result = new HashMap<>();

        String hour = time1.split("-")[1];
        System.out.println("hour "+ hour);
        if(hour.contains("0")) hour = hour.split("0")[1];
        System.out.println("hour : "+hour);
        //db조회
        MiseVO miseVO = weatherMapper.findCurrentMise(nx, ny, hour);

        if(miseVO == null){
            LOGGER.info("미세먼지 조회 db 없음");
            result.put("result",null);
            return result;
        }else{
            String miseValue = measureMise(miseVO.getValue());
            miseVO.setMiseValue(miseValue);
            LOGGER.info("날씨 조회 db 있음");
            result.put("result", miseVO);
            return result;
        }
    }

    public void produce(){
        LOGGER.info("memberservice start produce");

        String topic = "my-topic";
        Map<String, Object> payload = new HashMap<>();
        payload.put("service","MemberService");
        payload.put("key","dragonhee");
        payload.put("value","myname");

        try {

            LOGGER.info("try start produce");
            producer.produce(topic,payload);
            LOGGER.info("try end produce");

        } catch (JsonProcessingException e) {
            e.printStackTrace();
            LOGGER.error("error : " +e);
        }
        LOGGER.info("memberservice end produce");

    }

    //0~15 좋음, 16~35 보통, 35~75 나쁨, 76~ 매우나쁨
    public String measureMise(String miseValue){
        String miseResult = "";
        double mise = Double.parseDouble(miseValue);
        if(mise<= 15) miseResult = "좋음";
        else if(mise<= 35) miseResult = "보통";
        else if(mise<= 75) miseResult = "나쁨";
        else miseResult = "매우나쁨";
        
        return miseResult;
    }
// sample 코드
//    public String xmlTest(String code) throws MalformedURLException {
//
//
//        BufferedReader br = null;
//        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
//        factory.setNamespaceAware(true);
//        DocumentBuilder builder;
//        Document doc = null;
//
//
//        // TODO Auto-generated method stub
//        System.out.println("test");
//
//        String urlStr = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone="+code;
//
//        URL url = new URL(urlStr);
//        String[] fieldNames ={"temp", "wfKor", "wfEn", "pop", "hour", "day"};
//        ArrayList<HashMap<String,String>> pubList = new ArrayList<HashMap<String,String>>();
//
//        try {
//            HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
//
//            //응답 읽기
//            br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
//            String result = "";
//            String line;
//            while ((line = br.readLine()) != null) {
//                result = result + line.trim();// result = URL로 XML을 읽은 값
//            }
//            DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
//            DocumentBuilder b = f.newDocumentBuilder();
//
//            //위에서 구성한 URL을 통해 XMl 파싱 시작
//            doc = b.parse(urlStr);
//            doc.getDocumentElement().normalize();
//
//            System.out.println("doc : "+doc);
//            NodeList items = doc.getElementsByTagName("data");
//            System.out.println("items : "+items.getLength());
//            int itemLen = items.getLength();
//
//            //for 루프시작
//            for(int i = 0; i < items.getLength(); i++){
//                //i번째 publication 태그를 가져와서
//                Node n = items.item(i);
//
//                Element e = (Element) n;
//                HashMap<String,String> pub = new HashMap<String,String>();
//
//                //for 루프 시작
//                for(String name : fieldNames){
//                    //"hour", "day", "temp", "tmx", "tmn", "sky", "pty", "wfKor"....에 해당하는 값을 XML 노드에서 가져옴
//                    NodeList titleList = e.getElementsByTagName(name);
//                    Element titleElem = (Element) titleList.item(0);
//
//                    Node titleNode = titleElem.getChildNodes().item(0);
//                    // 가져온 XML 값을 맵에 엘리먼트 이름 - 값 쌍으로 넣음
//                    pub.put(name, titleNode.getNodeValue());
//                }
//                //데이터가 전부 들어간 맵을 리스트에 넣고 화면에 뿌릴 준비.
//                pubList.add(pub);
//
//            }
//            System.out.println("pubList "+pubList);
//
//
//        } catch (IOException | ParserConfigurationException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        } catch (SAXException e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//        return "";
//    }


}
