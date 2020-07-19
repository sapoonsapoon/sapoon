package sapoon.webservice.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import sun.rmi.runtime.Log;

import javax.annotation.Resource;
import java.io.File;
import java.io.IOException;
import java.util.Map;

@Controller
@RequestMapping("/sapoon/web/promenade")
public class PromenadeController {
    private static final Logger logger = LoggerFactory.getLogger(PromenadeController.class);

    /*
        인덱스 페이지
     */
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String hello() {
        logger.info("****hello****");
        return "index";
    }

    /*
        서울 맵 리턴
     */
    @RequestMapping(value = "/seoul", method = RequestMethod.GET)
    public String getSeoulMap() {
        logger.info("****seoul****");
        return "map/seoulMap";
    }

    /*
        서울 맵 리턴
     */
    @RequestMapping(value = "/seoul/json", method = RequestMethod.GET)
    public @ResponseBody Map getSeoulMapJSON() throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        Map jsonFile = objectMapper.readValue(
                new File("/Users/wonhyeongcho/Development/sapoon/front/web-service/src/main/webapp/WEB-INF" +
                        "/jsp/map/seoul_municipalities_topo_simple.json"), Map.class);
        return jsonFile;
    }
}
