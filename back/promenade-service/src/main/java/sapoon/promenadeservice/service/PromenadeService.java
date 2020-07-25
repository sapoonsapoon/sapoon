package sapoon.promenadeservice.service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
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

        String guName = getGuNameByGeo(x, y);

        List<DullegilVo> dullegilVoList = promenadeMapper.getMainDullegilInfoByGeo(guName);

        for(int i = 0; i < dullegilVoList.size(); i++){
            dullegilVoList.get(i).setDullegilDetailVo(promenadeMapper.selectDullegilDetail(dullegilVoList.get(i).getSeq()));
        }

        return dullegilVoList;
    }

    /*
        위치 정보로 둘레길 정보 가져오기
     */
    public List<DullegilVo> getDullegilInfoByGeo(double x, double y) {

        String guName = getGuNameByGeo(x, y);

        List<DullegilVo> dullegilVoList = promenadeMapper.getDullegilInfoByGeo(guName);

        for(int i = 0; i < dullegilVoList.size(); i++){
            dullegilVoList.get(i).setDullegilDetailVo(promenadeMapper.selectDullegilDetail(dullegilVoList.get(i).getSeq()));
        }

        return dullegilVoList;
    }

    /*
        테마별 메인 산책로 조회
     */
    public List<DullegilVo> getMainDullegilInfoByTheme(String theme, double x, double y) {
        String guName = getGuNameByGeo(x, y);

        Map<String, String> params = new HashMap<>();
        params.put("theme", theme);
        params.put("guName", guName);

        List<DullegilVo> dullegilVoList = promenadeMapper.getMainDullegilInfoByTheme(params);

        for(int i = 0; i < dullegilVoList.size(); i++){
            dullegilVoList.get(i).setDullegilDetailVo(promenadeMapper.selectDullegilDetail(dullegilVoList.get(i).getSeq()));
        }

        return dullegilVoList;
    }


    public String getGuNameByGeo(double x, double y){

        String guName = "종로구"; // default

        // x, y 가 0 처리
        if(x != 0.0 && y != 0.0 ) {
            String locationCoords = Double.toString(x) + "," + Double.toString(y);

//            // 위치정보 파라미터 World Open API
//            UriComponentsBuilder url = UriComponentsBuilder.fromHttpUrl("http://api.vworld.kr/req/address")
//                    .queryParam("service", "address")
//                    .queryParam("request", "getAddress")
//                    .queryParam("key", "54FADA08-E44F-302D-B5C8-74B2F992CC3F")
//                    .queryParam("type", "ROAD")
//                    .queryParam("point", locationCoords);
//
//            Map<String, Object> response = restTemplate.getForObject(url.toUriString(), Map.class);
//            Map<String, Object> tmpResponse = (Map)response.get("response");
//            List<Map> result = (List)tmpResponse.get("result");
//            Map<String, String> structure = (Map)result.get(0).get("structure");
//            guName = structure.get("level2");

            // 서울시 API
            UriComponentsBuilder url = UriComponentsBuilder.fromHttpUrl("https://map.seoul.go.kr/smgis/apps/geocoding.do")
                    .queryParam("cmd", "getReverseGeocoding")
                    .queryParam("key", "f6ea21de30ed49a3867d5068026838a1")
                    .queryParam("address_type", "S")
                    .queryParam("coord_x", x)
                    .queryParam("coord_y", y)
                    .queryParam("req_lang", "KOR")
                    .queryParam("res_lang", "KOR");

            String response = restTemplate.getForObject(url.toUriString(), String.class);
            if (response != null && !response.equals("")) {
                JsonParser jsonParser = new JsonParser();
                JsonObject jsonObject = jsonParser.parse(response).getAsJsonObject();
                String newAddr = jsonObject.getAsJsonObject("head").get("NEW_ADDR").toString();
                guName = newAddr.split(" ")[1];
            }
        }

        return guName;
    }
}
