package sapoon.weatherservice.controller;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import sapoon.weatherservice.service.WeatherService;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;



@RestController
@RequestMapping("/weather")
public class WeatherController {


    private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(WeatherController.class);

    @Autowired
    WeatherService weatherService;


    //1. 카프카로 전체 날씨를 던져. 그거를 weather에서 받아와서 db에 저장.
    //2. 현재 위치 받아와서 시, 구, 동 정보 받아와서
    //   db에서 조회 후 해당 날씨 리턴한다.
    //   동의를하면 사용자 좌표 가져오고, 동의안하면 default 서울방배 검색기능추가.
    //


    //1) 사용자의 위도 경도로 weather 테이블에서 code 값 알아낸다음 그걸로 다시 db에서 날씨가져오기.
    //2) 사용자의 위도 경도로
    @GetMapping("/currentWeather")
    public ResponseEntity<Map> currentWeather(String nx, String ny){
        HttpStatus status = HttpStatus.OK;

        Map weather = new HashMap();

        LOGGER.info("start nx : "+nx +", ny : "+ny);
        if(nx.contains(".")) nx = nx.split("\\.")[0];
        if(ny.contains(".")) ny = ny.split("\\.")[0];
        LOGGER.info("end nx : "+nx +", ny : "+ny);

        weather = weatherService.currentWeather(nx, ny);

        return new ResponseEntity<Map>(weather, status);
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
}
