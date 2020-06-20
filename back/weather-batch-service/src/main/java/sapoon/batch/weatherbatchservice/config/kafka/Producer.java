package sapoon.batch.weatherbatchservice.config.kafka;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.kafka.clients.producer.ProducerRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;

import java.util.Map;

public class Producer {
    private final static Logger LOGGER = LoggerFactory.getLogger(sapoon.batch.weatherbatchservice.config.kafka.Producer.class);

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    public void produce(String topic, Map<String, Object> payload) throws JsonProcessingException {
        LOGGER.info("sending payload='{}'",payload.toString());

        ObjectMapper objectMapper = new ObjectMapper();

        ProducerRecord<String,String> producerRecord = new ProducerRecord<>(topic,objectMapper.writeValueAsString(payload));
        kafkaTemplate.send(producerRecord);
        kafkaTemplate.flush();
    }

}

