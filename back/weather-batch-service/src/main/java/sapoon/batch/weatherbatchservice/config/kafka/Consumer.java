package sapoon.batch.weatherbatchservice.config.kafka;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.annotation.KafkaListener;

import java.util.Map;

public class Consumer {
    private static final Logger LOGGER = LoggerFactory.getLogger(sapoon.batch.weatherbatchservice.config.kafka.Consumer.class);


//    @KafkaListener(topics="weather-topic")
//    public  void consume(ConsumerRecord consumerRecord) throws JsonProcessingException {
//        ObjectMapper objectMapper = new ObjectMapper();
//        Map<String, String> payload = objectMapper.readValue(consumerRecord.value().toString(),Map.class);
//
//        LOGGER.info("kafkaListener - payload " + payload.toString());
//        System.out.println("kafkaListener - payload" + payload.toString());
//        String service = payload.get("service").toString();
//        String key = payload.get("key").toString();
//
//        if(service.equals("WeatherService")){
//
////            LOGGER.info("Receiver in MemberService -  " );
//
//            if(key.equals("weather")){
//                String category = payload.get("value").toString();
//
////                LOGGER.info("category "+category );
//
//            }
//
//        }else{
////            LOGGER.debug("NOT MemberService");
//        }
//
//    }
}
