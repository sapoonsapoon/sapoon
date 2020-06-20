package sapoon.weatherservice.config.kafka;

import org.apache.kafka.common.serialization.StringSerializer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.kafka.core.DefaultKafkaProducerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.core.ProducerFactory;

import java.util.HashMap;
import java.util.Map;


@Configuration
public class ProducerConfig {
    //카프카 서버 주소
    @Value("${spring.kafka.bootstrap-servers}")
    private String broker;//= "localhost:9092";

    @Bean
    public Map<String, Object> producerConfiguration(){
        Map<String, Object> properties = new HashMap<>();
        properties.put(org.apache.kafka.clients.producer.ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, broker);
        properties.put(org.apache.kafka.clients.producer.ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class);
        properties.put(org.apache.kafka.clients.producer.ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class);

        return properties;
    }

    @Bean
    public ProducerFactory<String, String> producerFactory(){
        return new DefaultKafkaProducerFactory<>(producerConfiguration());
    }

    @Bean
    public KafkaTemplate<String, String> kafkaTemplate(){return new KafkaTemplate<>(producerFactory());}

    @Bean
    public sapoon.weatherservice.config.kafka.Producer producer(){return new sapoon.weatherservice.config.kafka.Producer();}
}
