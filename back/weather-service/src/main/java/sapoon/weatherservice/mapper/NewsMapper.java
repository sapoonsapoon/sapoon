package sapoon.weatherservice.mapper;

import org.apache.ibatis.annotations.Mapper;
import sapoon.weatherservice.vo.NewsPostVO;

import java.util.List;

@Mapper
public interface NewsMapper {

    NewsPostVO findNewsPost(String seq);
    List<NewsPostVO> findNewsPostList();

    int insertNewsPost(NewsPostVO newsPostVO);

}
