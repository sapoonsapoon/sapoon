package sapoon.communityservice.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sapoon.communityservice.mapper.NoticeMapper;
import sapoon.communityservice.vo.NoticeVo;

@Service
public class NoticeService {
    private static final Logger LOGGER = LoggerFactory.getLogger(NoticeService.class);

    @Autowired
    NoticeMapper noticeMapper;

    public String saveNotice(NoticeVo noticeVo){
        String result = "fail";

        try{
            noticeMapper.insertNoticePost(noticeVo);
            result = "success";
        } catch (Exception e) {
            LOGGER.error(e.toString());
        }

        return result;
    }

    public NoticeVo getNotice(int seq){
        NoticeVo noticeVo = null;

        try{
            noticeVo = noticeMapper.selectNoticePost(seq);
        } catch (Exception e) {
            LOGGER.error(e.toString());
        }

        return noticeVo;
    }
}
