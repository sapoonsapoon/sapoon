package sapoon.batch.weatherbatchservice.job;



import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.*;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.JobScope;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.support.SimpleJobLauncher;
import org.springframework.batch.item.*;
import org.springframework.batch.item.database.JdbcBatchItemWriter;
import org.springframework.batch.item.database.JpaItemWriter;
import org.springframework.batch.item.database.JpaPagingItemReader;
import org.springframework.batch.item.database.builder.JdbcBatchItemWriterBuilder;
import org.springframework.batch.item.database.builder.JpaPagingItemReaderBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;
import sapoon.batch.weatherbatchservice.config.kafka.Producer;
import sapoon.batch.weatherbatchservice.vo.AdministrativeAreaInfo;
import sapoon.batch.weatherbatchservice.vo.MiseInfo;

import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@EnableScheduling
@Slf4j
@RequiredArgsConstructor
@Configuration
@EnableBatchProcessing
public class MiseJobConfiguration {

    @Autowired
    Producer producer;

    private final DataSource dataSource;//데이터 소스, 오라클 jdbc 사용


    private final JobBuilderFactory jobBuilderFactory;
    private final StepBuilderFactory stepBuilderFactory;
    private final EntityManagerFactory entityManagerFactory;

    private boolean checkRestCall = false; //RestAPI 호출여부 판단

    private int nextIndex = 0;
    private int size =0;
    private int chunkSize = 10;
    private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(MiseJobConfiguration.class);
    int pageNo = 1;
    // int numOfRows = 100;
    private static final String BATCH_NAME = "MISE_API_BATCH";


    SimpleDateFormat format1 = new SimpleDateFormat ( "YYYY-MM-dd");
    Date time = new Date();
    String time1 = format1.format(time);

    Date today = new Date();
    SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
    String date = format.format(today);

    @Autowired
    private SimpleJobLauncher jobLauncher;

    // 초(0~59), 분(0~59), 시(0~23), 일(1-31), 월(1~12), 요일(0~7)
//    @Scheduled(cron = "* * * * * *") //매분 5초 실행
    @Scheduled(cron="0 5 0/1 * * *") //  매 1시간 5분마다
    public void perform() throws Exception {
        String jobId = String.valueOf(System.currentTimeMillis());
        LOGGER.info("mise job start : "+jobId);
        nextIndex = 0;
        JobParameters param = new JobParametersBuilder().addString("JobID",
                jobId).toJobParameters();

        JobExecution execution = jobLauncher.run(miseJob(),param);
        LOGGER.info("mise job finished : "+ execution.getStatus());
    }

    @Bean(name = "MISE_API_BATCH")
    public Job miseJob(){
        return jobBuilderFactory.get(BATCH_NAME)
                .start(miseStep())
                .build();
    }

    @Bean
    @JobScope
    public Step miseStep(){
        return stepBuilderFactory.get("apiBatch_step")
                .<MiseInfo, MiseInfo>chunk(chunkSize)
                .reader(miseItemReader())
                .writer(miseItemWriter())
                .build();
    }


    @Bean
    public ItemReader<MiseInfo> miseItemReader(){
        return new ItemReader<MiseInfo>() {
            @Override
            public MiseInfo read() throws Exception, UnexpectedInputException, ParseException {
                LOGGER.info("nextIndex : "+ nextIndex);

                if(nextIndex<1){
                    LOGGER.info("in if");
                    getMise();
                    nextIndex++;
                }

                LOGGER.info("read end");
                return null;
//                return memberReqeustDto;
            }
        };
    }



    @Bean // beanMapped()를 사용할때는 필수
    public JdbcBatchItemWriter<MiseInfo> miseItemWriter(){// 오라클 db에 데이터를 쓴다.

        return new JdbcBatchItemWriterBuilder<MiseInfo>()
                .dataSource(dataSource)
                .sql("INSERT INTO mise (date, stationcode,  itemcode, timecode, value, value_kr) " +
                        "values (:date, :stationcode, :itemcode, :timecode, :value, :value_kr)")
                .beanMapped()
                .build();
    }


    public Map<String,Object> getMise() throws IOException, ParserConfigurationException, SAXException {
        String serviceKey = "WRPy8feYZ9D%2FrB0v12gVfeyu3E%2BEWNFuYxpr4AKOtLbaBHzgIV7q5%2F8EXn2HbPc8oGTEN%2BcXh3173CX5kqXmEQ%3D%3D";

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


            System.out.println("resultMap : "+resultMap);
        }

        catch (Exception e) {
            e.printStackTrace();
        }

        int result = this.produce(resultMap);
        LOGGER.info("WeatherService mise function end");
//        resultMap.put("result",pub);
        return resultMap;

    }

    //kafka produce 테스트
    public int produce(Map<String,Object> mise){
        LOGGER.info("mise batch produce start ");

        String topic = "weather-topic";
        Map<String, Object> payload = new HashMap<>();
        payload.put("service","MiseBatchService");
        payload.put("key","mise");

        payload.put("value",mise);

        try {

            LOGGER.info("try start produce");
            producer.produce(topic,payload);
            LOGGER.info("try end produce");

        } catch (JsonProcessingException e) {
            e.printStackTrace();
            LOGGER.error("error : " +e);
            return 0;
        }
        LOGGER.info("mise batch produce start ");
        return 1;
    }


}

/*
 *
 * */