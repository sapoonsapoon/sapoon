package sapoon.loginmembservice.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/sapoon/login")
public class LoginController {

    @RequestMapping(method = RequestMethod.GET, value = "")
    public String login(){
        return "hello";
    }
}
