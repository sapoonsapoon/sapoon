package sapoon.promenadeservice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sapoon.promenadeservice.mapper.PromenadeMapper;
import sapoon.promenadeservice.vo.DullegilDetailVo;
import sapoon.promenadeservice.vo.DullegilVo;

import java.util.ArrayList;
import java.util.List;

@Service
public class PromenadeService {

    @Autowired
    PromenadeMapper promenadeMapper;

    public DullegilVo getDullegilInfo(int seq){
        DullegilVo dullegilVo = promenadeMapper.selectDullegilInfo(seq);
        return dullegilVo;
    }

    public List<DullegilVo> searchDullegil(String dullegil_name){
        List<DullegilVo> dullegilVoList = promenadeMapper.searchDullegil(dullegil_name);

        return dullegilVoList;
    }

    public DullegilDetailVo getDullegilDetail(int seq){
        DullegilDetailVo dullegilDetailVo = promenadeMapper.selectDullegilDetail(seq);
        return dullegilDetailVo;
    }

    public List<DullegilVo> getMainDullegilByRandom(){
        List<DullegilVo> dullegilVoList = promenadeMapper.getMainDullegilByRandom();
        for(int i = 0; i < dullegilVoList.size(); i++){
            dullegilVoList.get(i).setDullegilDetailVo(promenadeMapper.selectDullegilDetail(dullegilVoList.get(i).getSeq()));
        }
        return dullegilVoList;
    }
}
