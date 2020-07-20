package sapoon.promenadeservice.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import sapoon.promenadeservice.mapper.PromenadeMapper;
import sapoon.promenadeservice.vo.DullegilDetailVo;
import sapoon.promenadeservice.vo.DullegilVo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PromenadeService {
    static final Logger LOGGER = LoggerFactory.getLogger(PromenadeService.class);

    @Autowired
    RestTemplate restTemplate;

    @Autowired
    PromenadeMapper promenadeMapper;

    /*
        SEQ로 둘레길 정보 찾기
     */
    public DullegilVo getDullegilInfo(int seq){
        DullegilVo dullegilVo = promenadeMapper.selectDullegilInfo(seq);
        return dullegilVo;
    }

    /*
        둘레길 이름으로 둘레길 찾기
     */
    public List<DullegilVo> searchDullegil(String dullegilName){
        List<DullegilVo> dullegilVoList = promenadeMapper.searchDullegil(dullegilName);

        for(int i = 0; i < dullegilVoList.size(); i++){
            dullegilVoList.get(i).setDullegilDetailVo(promenadeMapper.selectDullegilDetail(dullegilVoList.get(i).getSeq()));
        }

        return dullegilVoList;
    }

    /*
        SEQ로 둘레길 상세 정보 찾기
     */
    public DullegilDetailVo getDullegilDetail(int seq){
        DullegilDetailVo dullegilDetailVo = promenadeMapper.selectDullegilDetail(seq);
        return dullegilDetailVo;
    }

    /*
        랜덤하게 5개 뽑아서 추천
     */
    public List<DullegilVo> getMainDullegilByRandom(){
        List<DullegilVo> dullegilVoList = promenadeMapper.getMainDullegilByRandom();
        for(int i = 0; i < dullegilVoList.size(); i++){
            dullegilVoList.get(i).setDullegilDetailVo(promenadeMapper.selectDullegilDetail(dullegilVoList.get(i).getSeq()));
        }
        return dullegilVoList;
    }

    /*
        구 이름으로 둘레길 수 뽑기
     */
    public int getDullegilCount(String guName){
        int dullegilCount = promenadeMapper.getDullegilCount(guName);
        return dullegilCount;
    }

    /*
        구 이름으로 둘레길 상세 정보 찾기
     */
    public List<DullegilVo> getDullegilInfoByGu(String guName){
        List<DullegilVo> dullegilVoList = promenadeMapper.getDullegilInfoByGu(guName);

        for(int i = 0; i < dullegilVoList.size(); i++){
            dullegilVoList.get(i).setDullegilDetailVo(promenadeMapper.selectDullegilDetail(dullegilVoList.get(i).getSeq()));
        }

        return dullegilVoList;
    }

    /*
        메인 화면 위치 정보로 둘레길 정보 가져오기
     */
    public List<DullegilVo> getMainDullegilInfoByGeo(double x, double y) {

        String guName = "종로구"; // default

        // x, y 가 0 처리
        if(x != 0.0 && y != 0.0 ){
            String locationCoords = Double.toString(x) + "," + Double.toString(y);

            // 위치정보 파라미터
            UriComponentsBuilder url = UriComponentsBuilder.fromHttpUrl("http://api.vworld.kr/req/address")
                    .queryParam("service", "address")
                    .queryParam("request", "getAddress")
                    .queryParam("key", "54FADA08-E44F-302D-B5C8-74B2F992CC3F")
                    .queryParam("type", "ROAD")
                    .queryParam("point", locationCoords);

            Map<String, Object> response =
                    restTemplate.getForObject(url.toUriString(), Map.class);

            // 구 이름 추출
            Map<String, Object> tmpResponse = (Map)response.get("response");
            List<Map> result = (List)tmpResponse.get("result");
            Map<String, String> structure = (Map)result.get(0).get("structure");
            guName = structure.get("level2");
        }

        List<DullegilVo> dullegilVoList = promenadeMapper.getMainDullegilInfoByGeo(guName);

        for(int i = 0; i < dullegilVoList.size(); i++){
            dullegilVoList.get(i).setDullegilDetailVo(promenadeMapper.selectDullegilDetail(dullegilVoList.get(i).getSeq()));
        }

        return dullegilVoList;
    }
}
