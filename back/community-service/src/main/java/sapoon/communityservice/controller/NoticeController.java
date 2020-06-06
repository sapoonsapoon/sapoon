package sapoon.communityservice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import sapoon.communityservice.service.NoticeService;
import sapoon.communityservice.vo.NoticeVo;

import java.util.Map;



@RestController
@RequestMapping("/sapoon/notice")
public class NoticeController {

    @Autowired
    NoticeService noticeService;

    @RequestMapping(method=RequestMethod.POST, value="/save")
    public String saveNoticePost(@RequestBody NoticeVo noticeVo){

        String result = noticeService.saveNotice(noticeVo);
        return result;
    }
}
