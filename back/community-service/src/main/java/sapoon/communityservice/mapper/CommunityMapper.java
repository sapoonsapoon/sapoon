package sapoon.communityservice.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import sapoon.communityservice.vo.CommunityVo;

import java.util.List;


@Mapper
public interface CommunityMapper {
    int insertCommuity(CommunityVo communityVo);
    List<CommunityVo> selectCommunityList();
    List<CommunityVo> selectCommunityListByDulle(int dulleSeq);

    int selectTotalCommunityCount(); //커뮤니티 전체 갯수 가져오기
    int selectAvrCommunityCount(int dulleSeq); //해당 둘레길 관련된 커뮤니티의 평균점수.

    CommunityVo selectCommunity(int seq);
}
