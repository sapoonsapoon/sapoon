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
import org.xml.sax.SAXException;
import sapoon.weatherservice.common.Common;
import sapoon.weatherservice.config.kafka.Producer;
import sapoon.weatherservice.mapper.WeatherMapper;
import sapoon.weatherservice.vo.AdministrativeAreaInfoVO;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
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
    private String key = "WRPy8feYZ9D%2FrB0v12gVfeyu3E%2BEWNFuYxpr4AKOtLbaBHzgIV7q5%2F8EXn2HbPc8oGTEN%2BcXh3173CX5kqXmEQ%3D%3D";

    @Autowired
    WeatherMapper weatherMapper;

    @Autowired
    Producer producer;


    public String mise() throws IOException {

//        HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
//        factory.setConnectTimeout(5000);
//        factory.setReadTimeout(5000);
//
//        HttpClient httpClient = HttpClientBuilder.create()
//                .setMaxConnPerRoute(5)
//                .setMaxConnTotal(100)
//                .build();
//        factory.setHttpClient(httpClient);
//
        String serviceKey = "WRPy8feYZ9D%2FrB0v12gVfeyu3E%2BEWNFuYxpr4AKOtLbaBHzgIV7q5%2F8EXn2HbPc8oGTEN%2BcXh3173CX5kqXmEQ%3D%3D";

        String numOfRows = "10";
        String pageNo = "1";
        String resultType = "json";
        String statiioncode = "1"; //
        String timecode = "RH02"; //RH02 2시간 이동 평균, RH24 24시간이동평균
        String itemcode = "90303"; //90303 - 납, 90310 칼슘
//
        Date today = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String date = format.format(today);
        System.out.println("date : "+date);
//
//
//        String mise_url = "http://apis.data.go.kr/1480523/MetalMeasuringResultService/MetalService";
//
//        mise_url += "?serviceKey"+serviceKey+"&numOfRows"+numOfRows +"&numOfRows"+numOfRows +"&pageNo"+pageNo +"&resultType"+resultType
//                +"&statiioncode"+statiioncode +"&timecode"+timecode +"&itemcode"+itemcode;
//
//        System.out.println("mise_url : "+mise_url);
//
//        URI uri = URI.create(mise_url);
//
//        RestTemplate restTemplate = new RestTemplate();
//        Map<String, Object> param = new HashMap<>();
//
//
//        ResponseEntity<Map> resposeMap=  restTemplate.getForEntity(uri,Map.class);
//        System.out.println("responseMap : " + resposeMap);

        //return resposeMap.toString();

        String mise_url = "http://apis.data.go.kr/1480523/MetalMeasuringResultService/MetalService";

        StringBuilder urlBuilder = new StringBuilder(mise_url); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "="+serviceKey); /*Service Key*/
        //  urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("-", "UTF-8")); /*공공데이터포털에서 받은 인증키*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("resultType","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*결과형식(XML/JSON)*/
        urlBuilder.append("&" + URLEncoder.encode("date","UTF-8") + "=" + URLEncoder.encode(date, "UTF-8")); /*검색조건 날짜 (예시 : 20171208)*/
        urlBuilder.append("&" + URLEncoder.encode("statiioncode","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*검색조건 측정소코드*/
        urlBuilder.append("&" + URLEncoder.encode("itemcode","UTF-8") + "=" + URLEncoder.encode("90303", "UTF-8")); /*검색조건 항목코드*/
        urlBuilder.append("&" + URLEncoder.encode("timecode","UTF-8") + "=" + URLEncoder.encode("RH02", "UTF-8")); /*검색조건 시간구분*/

        mise_url += "?serviceKey"+serviceKey+"&numOfRows"+numOfRows +"&numOfRows"+numOfRows +"&pageNo"+pageNo +"&resultType"+resultType
                +"&statiioncode"+statiioncode +"&timecode"+timecode +"&itemcode"+itemcode;
        URL url = new URL(urlBuilder.toString());

        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");

        System.out.println("url : "+url);

        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        System.out.println("sb : "+sb.toString());


        ObjectMapper mapper = new ObjectMapper();
        Map<String, Object> map = mapper.readValue(sb.toString(), Map.class);

        System.out.println("map : "+map);
        System.out.println("map.get() : "+map.get("MetalService"));


        return sb.toString();
    }

    //db에서 가져옴.
    public Map<String, Object> currentWeather(String nx, String ny) {

        Map<String, Object> result = new HashMap<>();
        String resultCode = Common.returnCode.SUCCESS;

        //db조회
        AdministrativeAreaInfoVO administrativeAreaInfoVO = weatherMapper.findCodeByWeather(nx, ny);
        if(administrativeAreaInfoVO == null){
            resultCode = Common.returnCode.FAIL;
        }

        result.put("resultCode",resultCode);
        result.put("result", administrativeAreaInfoVO);

        return result;
    }

    //kafka produce 테스트
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


    public String xmlTest(String code) throws MalformedURLException {


        BufferedReader br = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        DocumentBuilder builder;
        Document doc = null;


        // TODO Auto-generated method stub
        System.out.println("test");

        String urlStr = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone="+code;

        URL url = new URL(urlStr);
        String[] fieldNames ={"temp", "wfKor", "wfEn", "pop", "hour", "day"};
        ArrayList<HashMap<String,String>> pubList = new ArrayList<HashMap<String,String>>();

        try {
            HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();

            //응답 읽기
            br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(), "UTF-8"));
            String result = "";
            String line;
            while ((line = br.readLine()) != null) {
                result = result + line.trim();// result = URL로 XML을 읽은 값
            }
            DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
            DocumentBuilder b = f.newDocumentBuilder();

            //위에서 구성한 URL을 통해 XMl 파싱 시작
            doc = b.parse(urlStr);
            doc.getDocumentElement().normalize();

            System.out.println("doc : "+doc);
            NodeList items = doc.getElementsByTagName("data");
            System.out.println("items : "+items.getLength());
            int itemLen = items.getLength();

            //for 루프시작
            for(int i = 0; i < items.getLength(); i++){
                //i번째 publication 태그를 가져와서
                Node n = items.item(i);

                Element e = (Element) n;
                HashMap<String,String> pub = new HashMap<String,String>();

                //for 루프 시작
                for(String name : fieldNames){
                    //"hour", "day", "temp", "tmx", "tmn", "sky", "pty", "wfKor"....에 해당하는 값을 XML 노드에서 가져옴
                    NodeList titleList = e.getElementsByTagName(name);
                    Element titleElem = (Element) titleList.item(0);

                    Node titleNode = titleElem.getChildNodes().item(0);
                    // 가져온 XML 값을 맵에 엘리먼트 이름 - 값 쌍으로 넣음
                    pub.put(name, titleNode.getNodeValue());
                }
                //데이터가 전부 들어간 맵을 리스트에 넣고 화면에 뿌릴 준비.
                pubList.add(pub);

            }
            System.out.println("pubList "+pubList);


        } catch (IOException | ParserConfigurationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SAXException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return "";
    }




}
