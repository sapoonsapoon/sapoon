package sapoon.promenadeservice.mapper;

import org.apache.ibatis.annotations.Mapper;
import sapoon.promenadeservice.vo.DullegilDetailVo;
import sapoon.promenadeservice.vo.DullegilVo;

import java.util.List;

@Mapper
public interface PromenadeMapper {
    DullegilVo selectDullegilInfo(int seq);
    DullegilDetailVo selectDullegilDetail(int seq);
    List<DullegilVo> searchDullegil(String name);
    List<DullegilVo> getMainDullegilByRandom();
    int getDullegilCount(String guName);
    List<DullegilVo> getDullegilInfoByGu(String guName);
    List<DullegilVo> getMainDullegilInfoByGeo(String guName);
    List<DullegilVo> getDullegilInfoByGeo(String guName);
}
