package sapoon.batch.weatherbatchservice.job;


import com.fasterxml.jackson.core.JsonProcessingException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.LoggerFactory;
import org.springframework.batch.core.*;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.batch.core.configuration.annotation.JobBuilderFactory;
import org.springframework.batch.core.configuration.annotation.JobScope;
import org.springframework.batch.core.configuration.annotation.StepBuilderFactory;
import org.springframework.batch.core.launch.support.SimpleJobLauncher;

import org.springframework.batch.item.ItemProcessor;
import org.springframework.batch.item.database.JdbcBatchItemWriter;
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


import javax.persistence.EntityManagerFactory;
import javax.sql.DataSource;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
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
public class WeatherJobConfiguration {

    @Autowired
    Producer producer;

    private final DataSource dataSource;//데이터 소스, 오라클 jdbc 사용


    private final JobBuilderFactory jobBuilderFactory;
    private final StepBuilderFactory stepBuilderFactory;
    private final EntityManagerFactory entityManagerFactory;

    private boolean checkRestCall = false;

    private int nextIndex = 0;
    private int size =0;
    private int chunkSize = 210;
    private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(WeatherJobConfiguration.class);
    int pageNo = 1;
    // int numOfRows = 100;
    private static final String BATCH_NAME = "weatherApiBatch";

    SimpleDateFormat format1 = new SimpleDateFormat ( "YYYY-MM-dd");
    Date time = new Date();
    String time1 = format1.format(time);

    //kafka를 통해서 보낼 데이터
    ArrayList<HashMap<String,String>> kafkaList = new ArrayList<HashMap<String,String>>();
    
    @Autowired
    private SimpleJobLauncher jobLauncher;

    //0329 추가
    // 초(0~59), 분(0~59), 시(0~23), 일(1-31), 월(1~12), 요일(0~7)
    // @Scheduled(cron="0 0 06 * * *") = 매일 새벽2시에 실행
//    @Scheduled(cron = "*/10 * * * * *") //30초 마다 실행
    @Scheduled(cron = "0 0 0/3 * * *") //3시간마다
    public void perform() throws Exception {
        String jobId = String.valueOf(System.currentTimeMillis());
        LOGGER.info("job start11 : "+jobId);
        nextIndex = 0;
        JobParameters param = new JobParametersBuilder().addString("JobID",
                jobId).toJobParameters();

        JobExecution execution = jobLauncher.run(job(),param);
        LOGGER.info("job finished : "+ execution.getStatus());
    }

    @Bean
    public Job job(){
        return jobBuilderFactory.get(BATCH_NAME)
                .start(step())
                .build();
    }

    @Bean
    @JobScope
    public Step step(){
        return stepBuilderFactory.get("weather_batch_step")
                .<AdministrativeAreaInfo, AdministrativeAreaInfo>chunk(chunkSize)
                .reader(itemReader())
                .processor(itemProcessor())
                .writer(itemWriterDto())
                .build();
    }

    public JpaPagingItemReader<AdministrativeAreaInfo> itemReader(){
       return new JpaPagingItemReaderBuilder<AdministrativeAreaInfo>()
               .name("Weather_Reader")
               .entityManagerFactory(entityManagerFactory)
               .pageSize(chunkSize)
               .queryString("SELECT a  FROM AdministrativeAreaInfo a  WHERE updated_at <  DATE_FORMAT(NOW(), '%Y-%m-%d')  ORDER BY area_cd") //WHERE update_at <  DATE_FORMAT(NOW(), '%Y-%m-%d')
               .build();
    }

    @Bean
    public ItemProcessor<AdministrativeAreaInfo,AdministrativeAreaInfo> itemProcessor(){
        return administrativeAreaInfo ->{
            LOGGER.info("nextIndex : "+ nextIndex);
            LOGGER.info("chunkSize : "+ chunkSize);
            nextIndex++;

            if(nextIndex > chunkSize) return null;

            this.getWeather(administrativeAreaInfo.getArea_cd());
            LOGGER.info("administrative_area_info : "+administrativeAreaInfo.getArea_cd());
            LOGGER.info("info "+administrativeAreaInfo.getArea_cd());

            return administrativeAreaInfo;
        };
    }

    @Bean // beanMapped()를 사용할때는 필수
    public JdbcBatchItemWriter<AdministrativeAreaInfo> itemWriterDto(){// 오라클 db에 데이터를 쓴다.
        LOGGER.info("in here");
        return new JdbcBatchItemWriterBuilder<AdministrativeAreaInfo>()
                .dataSource(dataSource)
//                .sql("UPDATE AdministrativeAreaInfo  SET updated_at = DATE_FORMAT(NOW(), '%Y-%m-%d') WHERE area_cd = :area_cd ")
                .sql("UPDATE administrative_area_info  SET updated_at = '"+time1+"'  WHERE area_cd =  :area_cd ")
                .beanMapped()
                .build();
    }


    public ArrayList<HashMap<String,String>> getWeather(String code) throws MalformedURLException {
        BufferedReader br = null;
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        DocumentBuilder builder;
        Document doc = null;

        // TODO Auto-generated method stub
        System.out.println("test");

        String urlStr = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone="+code;

        URL url = new URL(urlStr);
        String[] fieldNames ={
                "day", "hour", "temp", "tmx", "tmn", "sky",
                "pty",  "wfKor",  "wfEn",  "pop",  "r12", "s12",
                "ws",  "wd", "wdKor", "wdEn", "reh", "r06",
                "s06"
        };

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
            for(int i = itemLen - 8 ; i < items.getLength(); i++){ //파싱해온 데이터중 마지막 8개 보냄. -> 1일치 자료
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
                kafkaList.add(pub);

            }
            System.out.println("pubList "+kafkaList);


        } catch (IOException | ParserConfigurationException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SAXException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        if (kafkaList.size() == 0) return null;

        int result = this.produce(code, kafkaList);

        return kafkaList;
    }

    //kafka produce 테스트
    public int produce(String code, ArrayList<HashMap<String,String>> weather){
        LOGGER.info("batch start produce");

        String topic = "weather-topic";
        Map<String, Object> payload = new HashMap<>();
        payload.put("service","WeatherBatchService");
        payload.put("key","forcast");

        payload.put("value",weather);

        payload.put("code",code);


        try {

            LOGGER.info("try start produce");
            producer.produce(topic,payload);
            LOGGER.info("try end produce");

        } catch (JsonProcessingException e) {
            e.printStackTrace();
            LOGGER.error("error : " +e);
            return 0;
        }
        LOGGER.info("weatherservice end produce");
        return 1;
    }
}
