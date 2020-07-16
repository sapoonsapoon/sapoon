package sapoon.webservice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("/sapoon/web/promenade")
public class PromenadeController {
    /*
        인덱스 페이지
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String hello() {
        return "index";
    }
}