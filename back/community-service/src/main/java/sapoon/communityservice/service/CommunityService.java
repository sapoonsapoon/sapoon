package sapoon.communityservice.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sapoon.communityservice.mapper.CommunityMapper;
import sapoon.communityservice.vo.CommunityVo;
import sapoon.communityservice.vo.NoticeVo;

import java.util.HashMap;
import java.util.Map;

@Service
public class CommunityService {
    private static final Logger LOGGER = LoggerFactory.getLogger(CommunityService.class);

    @Autowired
    CommunityMapper communityMapper;


    public Map<String, Object> saveCommunity(CommunityVo communityVo){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        resultMap.put("result",null);

        try{
            communityMapper.insertCommuity(communityVo);
            resultMap.put("result","success");
            resultMap.put("resultCode","1");
            resultMap.put("resultDesc","커뮤니티 게시글 저장 성공");
        }catch ( Exception e ){
            LOGGER.error(String.valueOf(e));
            resultMap.put("resultCode","4");
            resultMap.put("resultDesc","커뮤니티 게시글 저장 실패");
        }

        return resultMap;
    }

    public Map<String, Object> getCommunityList() {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        resultMap.put("result",null);

        try{
            resultMap.put("result",communityMapper.selectCommunityList());
            if(resultMap.get("result") == null){ // db 조회 없음
                resultMap.put("resultCode","2");
                resultMap.put("resultDesc","not found");
            }else{
                resultMap.put("resultCode","1");
                resultMap.put("resultDesc","success");
            }
        }catch ( Exception e ){
            LOGGER.error(String.valueOf(e));
            resultMap.put("resultCode","3");
            resultMap.put("resultDesc","parsing error");
        }

        return resultMap;
    }

    public Map<String, Object> getCommunity(int seq) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        resultMap.put("result",null);

        try{
            resultMap.put("result",communityMapper.selectCommunity(seq));
            if(resultMap.get("result") == null){ // db 조회 없음
                resultMap.put("resultCode","2");
                resultMap.put("resultDesc","not found");
            }else{
                resultMap.put("resultCode","1");
                resultMap.put("resultDesc","success");
            }
        }catch ( Exception e ){
            LOGGER.error(String.valueOf(e));
            resultMap.put("resultCode","3");
            resultMap.put("resultDesc","parsing error");
        }

        return resultMap;
    }


    public Map<String, Object> getCommunityListByDulle(int dulleSeq) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        resultMap.put("result",null);

        try{
            resultMap.put("result",communityMapper.selectCommunityListByDulle(dulleSeq));
            if(resultMap.get("result") == null){ // db 조회 없음
                resultMap.put("resultCode","2");
                resultMap.put("resultDesc","not found");
            }else{
                resultMap.put("resultCode","1");
                resultMap.put("resultDesc","success");
            }
        }catch ( Exception e ){
            LOGGER.error(String.valueOf(e));
            resultMap.put("resultCode","3");
            resultMap.put("resultDesc","parsing error");
        }

        return resultMap;
    }

    public Map<String, Object> getTotalCommunityCount(int dulleSeq) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();

        resultMap.put("result",null);
        int totalCount = 0;
        int avgScore = 0;

        try{
            totalCount = communityMapper.selectTotalCommunityCount(); //에러 절대 안남.
            avgScore = communityMapper.selectAvrCommunityCount(dulleSeq);//dulleSeq가 없으면 0으로 리턴
            result.put("totalCount" , totalCount);
            result.put("avgScore" , avgScore);
            result.put("dulleSeq" , dulleSeq);

            resultMap.put("result",result);

        }catch ( Exception e ){
            LOGGER.error(String.valueOf(e));
            resultMap.put("resultCode","3");
            resultMap.put("resultDesc","parsing error");
        }

        return resultMap;
    }
}
