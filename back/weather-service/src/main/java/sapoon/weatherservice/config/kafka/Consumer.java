package sapoon.weatherservice.config.kafka;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import sapoon.weatherservice.mapper.WeatherMapper;
import sapoon.weatherservice.vo.WeatherForcastVO;

import java.util.List;
import java.util.Map;

public class Consumer {
    private static final Logger LOGGER = LoggerFactory.getLogger(sapoon.weatherservice.config.kafka.Consumer.class);

    @Autowired
    WeatherMapper weatherMapper;


    @KafkaListener(topics="weather-topic")
    public  void consume(ConsumerRecord consumerRecord) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> payload = objectMapper.readValue(consumerRecord.value().toString(),Map.class);
        WeatherForcastVO weatherForcastVO = new WeatherForcastVO();
        String service = payload.get("service").toString();
        String key = payload.get("key").toString();
        String code = payload.get("code").toString();


        List<Map<String,Object>> value = (List<Map<String,Object>>) payload.get("value");

        LOGGER.info("kafkaListener - payload " + payload.toString());
        System.out.println("payload.get(\"service\").toString() " + service);
        System.out.println("payload.get(\"key\").toString() " + key);
        System.out.println("payload.get(\"value\").toString()" + value);
        System.out.println("payload.get(\"code\").toString()" + code);


        //받아온 json을 db에 저장해야된단말이야. list로 받아와
        //list log로 출력 -> db저장.

        if(service.equals("WeatherBatchService")){

            LOGGER.info("Receiver in WeatherBatchService -  " );

            if(key.equals("forcast")){
                LOGGER.info("in key forcast -  " );
                LOGGER.info("value.size() :  " +value.size());

                for (Map<String,Object> f :value ) {
                    weatherForcastVO = new WeatherForcastVO();
                    LOGGER.info("in for loop -  " );
                    //insert문.
                    weatherForcastVO.setDay((String) f.get("day"));
                    weatherForcastVO.setAreaCd(code);
                    weatherForcastVO.setHour((String) f.get("hour"));
                    weatherForcastVO.setPop((String) f.get("pop"));
                    weatherForcastVO.setPty((String) f.get("pty"));
                    weatherForcastVO.setR06((String) f.get("r06"));
                    weatherForcastVO.setR12((String) f.get("r12"));
                    weatherForcastVO.setReh((String) f.get("reh"));
                    weatherForcastVO.setS06((String) f.get("s06"));
                    weatherForcastVO.setS12((String) f.get("s12"));
                    weatherForcastVO.setSky((String) f.get("sky"));
                    weatherForcastVO.setTemp((String) f.get("temp"));
                    weatherForcastVO.setTmn((String) f.get("tmn"));
                    weatherForcastVO.setTmx((String) f.get("tmx"));
                    weatherForcastVO.setWd((String) f.get("wd"));
                    weatherForcastVO.setWdEn((String) f.get("wdEn"));
                    weatherForcastVO.setWfKor((String) f.get("wfKor"));
                    weatherForcastVO.setWfEn((String) f.get("wfEn"));
                    weatherForcastVO.setWs((String) f.get("ws"));
                    weatherForcastVO.setSky((String) f.get("sky"));

                    try{
                        weatherMapper.insertWeatherForcast(weatherForcastVO);
                        LOGGER.info("success insert  " +f);
                    }catch (Exception e){
                        LOGGER.info("fail insert  " + f);
                        LOGGER.error("error "+e);
                    }


                }

            }

        }else{
            LOGGER.debug("NOT MemberService");
        }

    }
    //년, 월, 일 가져오는 함수 만들기 따로따로

}
