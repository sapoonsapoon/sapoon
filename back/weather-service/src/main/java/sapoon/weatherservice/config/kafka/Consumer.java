package sapoon.weatherservice.config.kafka;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.annotation.KafkaListener;
import sapoon.weatherservice.mapper.WeatherMapper;
import sapoon.weatherservice.vo.MiseVO;
import sapoon.weatherservice.vo.WeatherForcastVO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Consumer {
    private static final Logger LOGGER = LoggerFactory.getLogger(sapoon.weatherservice.config.kafka.Consumer.class);

    @Autowired
    WeatherMapper weatherMapper;

    @KafkaListener(topics="weather-topic")
    public  void consume(ConsumerRecord consumerRecord) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        Map<String, Object> payload = objectMapper.readValue(consumerRecord.value().toString(), Map.class);

        MiseVO miseVO = new MiseVO();
        String service = payload.get("service").toString();
        String key = payload.get("key").toString();

        LOGGER.info("kafkaListener - payload " + payload.toString());

        if (service.equals("WeatherBatchService")) {
            LOGGER.info("Receiver in WeatherBatchService -  ");
            WeatherForcastVO weatherForcastVO = new WeatherForcastVO();
            String code = payload.get("code").toString();

            if (key.equals("forcast")) {
                List<Map<String, Object>> value = (List<Map<String, Object>>) payload.get("value");
                LOGGER.info("in key forcast -  ");
                LOGGER.info("value.size() :  " + value.size());


                for (Map<String, Object> f : value) {
                    weatherForcastVO = new WeatherForcastVO();
                    LOGGER.info("in for loop -  ");
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

                    try {
                        weatherMapper.insertWeatherForcast(weatherForcastVO);
                        LOGGER.info("success insert  " + f);
                    } catch (Exception e) {
                        LOGGER.info("fail insert  " + f);
                        LOGGER.error("error " + e);
                    }

                }

            }
        } else if (service.equals("MiseBatchService")) {
                LOGGER.info("Receiver in MiseBatchService -  ");
                Map<String, Object> value = (Map<String, Object>) payload.get("value");

                if (key.equals("mise")) {
                    LOGGER.info("in key forcast -  ");
                    LOGGER.info("value.size() :  " + value.size());

                    String time = (String) value.get("dataTime"); //ex) 2020-06-23 18:00
                    String itemCode = (String) value.get("itemCode");

                    List<Map<String, Object>> cityList = (List<Map<String, Object>>) value.get("cityList");
                    //공동값 세팅(date, itemcode, hour)
                    miseVO.setDate(time.split(" ")[0]); //2020-06-23
                    miseVO.setItemCode(itemCode);
                    miseVO.setHour(time.split(" ")[1].split(":")[0]);// 18:00

                    for (Map<String, Object> city : cityList) {

                        miseVO.setCity(returnAreaName((String) city.get("name")));
                        miseVO.setValue((String) city.get("value"));

                        try {
                            weatherMapper.insertMise(miseVO);
                            LOGGER.info("success insert  " + city);
                        } catch (Exception e) {
                            LOGGER.info("fail insert  " + city);
                            LOGGER.error("error " + e);
                        }
                    }
                } else {
                    LOGGER.debug("NOT MemberService");
                }
        }
    }
    
    //영어 도시 이름 -> 한글 도시 이름
    public String returnAreaName(String enName){
        String korName=null;

        if("busan".equals(enName)){
            korName ="부산광역시";
        }else if("chungbuk".equals(enName)){
            korName ="충청북도";
        }else if("chungnam".equals(enName)){
            korName ="충청남도";
        }else if("daegu".equals(enName)){
            korName ="대구광역시";
        }else if("daejeon".equals(enName)){
            korName ="대전광역시";
        }else if("gangwon".equals(enName)){
            korName ="강원도";
        }else if("gwangju".equals(enName)){
            korName ="광주광역시";
        }else if("gyeongbuk".equals(enName)){
            korName ="경상북도";
        }else if("gyeonggi".equals(enName)){
            korName ="경기도";
        }else if("gyeongnam".equals(enName)){
            korName ="경상남도";
        }else if("incheon".equals(enName)){
            korName ="인천광역시";
        }else if("jeju".equals(enName)){
            korName ="제주특별자치도";
        }else if("jeonbuk".equals(enName)){
            korName ="전라북도";
        }else if("jeonnam".equals(enName)){
            korName ="전라남도";
        }else if("sejong".equals(enName)){
            korName ="세종특별자치시";
        }else if("seoul".equals(enName)){
            korName ="서울특별시";
        }else if("ulsan".equals(enName)){
            korName ="울산광역시";
        }

        return korName;
    }
}
