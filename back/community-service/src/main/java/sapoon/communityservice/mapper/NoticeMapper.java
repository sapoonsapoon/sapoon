package sapoon.communityservice.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import sapoon.communityservice.vo.NoticeVo;

@Mapper
@Repository
public interface NoticeMapper {
    void insertNoticePost(NoticeVo noticeVo);
    NoticeVo selectNoticePost();
}
