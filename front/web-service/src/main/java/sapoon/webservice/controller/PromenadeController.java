package sapoon.webservice.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import sun.rmi.runtime.Log;

@Controller
@RequestMapping("/sapoon/web/promenade")
public class PromenadeController {
    private static final Logger logger = LoggerFactory.getLogger(PromenadeController.class);
    /*
        인덱스 페이지
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String hello() {
        logger.info("****hello****");
        return "index";
    }
}
