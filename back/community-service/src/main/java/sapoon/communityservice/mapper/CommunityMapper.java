package sapoon.communityservice.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import sapoon.communityservice.vo.CommunityVo;

import java.util.List;


@Mapper
public interface CommunityMapper {
    int insertCommuity(CommunityVo communityVo);
    List<CommunityVo> selectCommunityList();
    CommunityVo selectCommunity(String seq);
}
