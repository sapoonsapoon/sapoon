package sapoon.promenadeservice.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import sapoon.promenadeservice.service.PromenadeService;
import sapoon.promenadeservice.vo.DullegilDetailVo;
import sapoon.promenadeservice.vo.DullegilVo;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/sapoon/promenade")
public class PromenadeController {

    @Autowired
    PromenadeService promenadeService;

    /*
        둘레길 정보 조회
     */
    @GetMapping("/dullegil/get/{seq}")
    public @ResponseBody DullegilVo getDullegilInfo(@PathVariable int seq){
        DullegilVo dullegilVo = promenadeService.getDullegilInfo(seq);
        DullegilDetailVo dullegilDetailVo = promenadeService.getDullegilDetail(seq);
        dullegilVo.setDullegilDetailVo(dullegilDetailVo);

        return dullegilVo;
    }

    /*
        둘레길 검색
     */
    @GetMapping("/dullegil/search")
    public List<DullegilVo> searchDullegil(@RequestParam String dullegil_name){
        List<DullegilVo> dullegilVoList = new ArrayList<DullegilVo>();
        dullegilVoList = promenadeService.searchDullegil(dullegil_name);

        return dullegilVoList;
    }

    /*
        메인 화면 둘레길 추천
     */
    @GetMapping("/dullegil/main/recommend/random")
    public List<DullegilVo> mainRecommendByRandom(){
        List<DullegilVo> dullegilVoList = new ArrayList<DullegilVo>();
        dullegilVoList = promenadeService.getMainDullegilByRandom();
        return dullegilVoList;
    }

    /*
        위치 기반 둘레길 추천
     */
    @GetMapping("/dullegil/main/recommend")
    public List<DullegilVo> mainRecommendByLocation(){
        List<DullegilVo> dullegilVoList = new ArrayList<DullegilVo>();
        return dullegilVoList;
    }
}
