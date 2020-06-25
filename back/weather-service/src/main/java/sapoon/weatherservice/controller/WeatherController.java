package sapoon.weatherservice.controller;

import org.apache.kafka.common.utils.Shell;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.xml.sax.SAXException;
import sapoon.weatherservice.service.WeatherService;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;



@RestController
@RequestMapping("/sapoon/weather")
public class WeatherController {


    private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(WeatherController.class);
    double minNx = 124.7141;
    double maxNx = 131.8648471;
    double minNy = 33.223572222222224;
    double maxNy = 38.49164444444445;

    @Autowired
    WeatherService weatherService;


    @GetMapping("/current")
    public ResponseEntity<Map> currentWeather(@RequestParam String nx, @RequestParam String ny){
        LOGGER.info("WeatherController - sapoon/weather/current");
        Map weather = new HashMap();

        // 필수 값 체크 //
        if("".equals(nx) || nx ==null || "".equals(ny) || ny == null){
            weather.put("result","필수값 없음");
            return new ResponseEntity<Map>(weather, HttpStatus.BAD_REQUEST);
        }

        //nx 최소값 124.7141 최대값 131.8648471
        //ny 최소값 33.223572222222224 최대값 38.49164444444445
        double doubleNx = Double.parseDouble(nx);
        double doubleNy = Double.parseDouble(ny);
        if(doubleNx < minNx || doubleNx > maxNx || doubleNy < minNy || doubleNy > maxNy){
            weather.put("result","위도, 경도 범위 벗어남");
            return new ResponseEntity<Map>(weather, HttpStatus.BAD_REQUEST);
        }


        LOGGER.info("nx : "+nx+", ny : "+ny);

        weather = weatherService.getCurrentWeather(nx, ny);

        if(weather.get("result") == null){
            weather.put("result","db not found");
            return new ResponseEntity<Map>(weather, HttpStatus.BAD_REQUEST);
        }else{
            return new ResponseEntity<Map>(weather, HttpStatus.OK);
        }

    }

    @GetMapping("/mise")
    public ResponseEntity<Map> getMise(@RequestParam String nx, @RequestParam String ny){
        LOGGER.info("WeatherController - sapoon/weather/mise");
        Map weather = new HashMap();

        // 필수 값 체크 //
        if("".equals(nx) || nx ==null || "".equals(ny) || ny == null){
            weather.put("result","필수값 없음");
            return new ResponseEntity<Map>(weather, HttpStatus.BAD_REQUEST);
        }

        double doubleNx = Double.parseDouble(nx);
        double doubleNy = Double.parseDouble(ny);
        if(doubleNx < minNx || doubleNx > maxNx || doubleNy < minNy || doubleNy > maxNy){
            weather.put("result","위도, 경도 범위 벗어남");
            return new ResponseEntity<Map>(weather, HttpStatus.BAD_REQUEST);
        }

        LOGGER.info("nx : "+nx+", ny : "+ny);

        weather = weatherService.getCurrentMise(nx, ny);

        if(weather.get("result") == null){
            weather.put("result","db not found");
            return new ResponseEntity<Map>(weather, HttpStatus.BAD_REQUEST);
        }else{
            return new ResponseEntity<Map>(weather, HttpStatus.OK);
        }

    }

}
