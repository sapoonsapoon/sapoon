package sapoon.promenadeservice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/sapoon/promenade/web")
public class WebController {

    /*
        인덱스 페이지
     */
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String hello() {
        return "index";
    }
}
