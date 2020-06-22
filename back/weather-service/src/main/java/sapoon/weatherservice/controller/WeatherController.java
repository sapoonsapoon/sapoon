package sapoon.weatherservice.controller;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import sapoon.weatherservice.service.WeatherService;

import java.io.IOException;
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


    //1. 카프카로 전체 날씨를 던져. 그거를 weather에서 받아와서 db에 저장.
    //2. 현재 위치 받아와서 시, 구, 동 정보 받아와서
    //   db에서 조회 후 해당 날씨 리턴한다.
    //   동의를하면 사용자 좌표 가져오고, 동의안하면 default 서울방배 검색기능추가.
    //
    @GetMapping("/test")
    public String test(){
        return "test";
    }

    //1) 사용자의 위도 경도로 weather 테이블에서 code 값 알아낸다음 그걸로 다시 db에서 날씨가져오기.
    //2) 사용자의 위도 경도로
    @GetMapping("/currentWeather")
    public ResponseEntity<Map> currentWeather(String nx, String ny){
        LOGGER.info("WeatherController - sapoon/weather/currentWeather");
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
        if(doubleNx < minNx || doubleNx > maxNx ||
            doubleNy < minNy || doubleNy > maxNy){
            weather.put("result","위도, 경도 범위 벗어남");
            return new ResponseEntity<Map>(weather, HttpStatus.BAD_REQUEST);
        }


        LOGGER.info("nx : "+nx+", ny : "+ny);

        weather = weatherService.currentWeather(nx, ny);

        if(weather.get("result") == null){
            weather.put("result","db not found");
            return new ResponseEntity<Map>(weather, HttpStatus.BAD_REQUEST);
        }else{
            return new ResponseEntity<Map>(weather, HttpStatus.OK);
        }

    }

    @GetMapping("/mise")
    public ResponseEntity<Map> mise() throws IOException {
        HttpStatus status = HttpStatus.OK;


        Map member = new HashMap();
        member.put("result",1);
        member.put("resultStr",weatherService.mise());

        return new ResponseEntity<Map>(member, status);
    }
//    @GetMapping("/xmltest")
//    public ResponseEntity<Map> xmltest(String code) throws IOException {
//        HttpStatus status = HttpStatus.OK;
//
//        Map member = new HashMap();
//        member.put("result",1);
//        member.put("resultStr",weatherService.xmlTest(code));
//
//
//        return new ResponseEntity<Map>(member, status);
//
//    }

    private HttpHeaders getErrorHeader() {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        return httpHeaders;
    }

    private HttpHeaders getSuccessHeader() {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        return httpHeaders;
    }
    private HttpHeaders getTokenHeader(String token) {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set("Authorization",token);
        return httpHeaders;
    }

}
