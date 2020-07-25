package sapoon.communityservice.controller;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sapoon.communityservice.common.S3Uploader;
import sapoon.communityservice.service.CommunityService;
import sapoon.communityservice.vo.CommunityVo;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@RequiredArgsConstructor // s3Uploader 때문에 사용
@RestController
@RequestMapping("/sapoon/community")
public class CommunityController {
    Logger logger = LoggerFactory.getLogger(CommunityController.class);

    @Autowired
    CommunityService communityService;

    @Autowired
    private final S3Uploader s3Uploader;

    @GetMapping("/test")
    public String hello(){
        return "index";
    }

    @PostMapping("")
    public ResponseEntity<Map> saveCommuity(CommunityVo communityVo) {

        Map result = new HashMap();

        logger.info("/sapoon/community post");
        logger.info("test log "+communityVo.getImgFile());
        String tempImgUrl =null;
        if(communityVo.getImgFile() != null ){
            logger.info("in if "+communityVo.getImgFile());
            try{
                logger.info("이미지 업로드 시작");
                tempImgUrl = s3Uploader.upload(communityVo.getImgFile(), "community/img");
                logger.info("이미지 업로드 성공");
            }catch (IOException e){
                logger.error(e.toString());

                result.put("result", "fail");
                result.put("resultCode","5");
                result.put("resultDesc","이미지 업로드 실패");
                return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
            }
        }else{
            result.put("result", "fail");
            result.put("resultCode","6");
            result.put("resultDesc","이미지가 없음");
            return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
        }

        communityVo.setImgUrl(tempImgUrl);
        result = communityService.saveCommunity(communityVo);

        if (result.get("result") == null) {
            result.put("result", "fail");
            return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
        }  else {
            return new ResponseEntity<Map>(result, HttpStatus.OK);
        }

    }

    /**
     * 커뮤니티 게시글 리스트 가져오기.
     *
     * @param x
     * @return
     */
    @GetMapping("")
    public ResponseEntity<Map> getCommunityList(){
        logger.info("/sapoon/community get");
        Map result = new HashMap();

        result = communityService.getCommunityList();

        if (result.get("result") == null) {
            result.put("result", "커뮤니티 조회 db 없음");
            logger.info("커뮤니티 조회 db 없음");
            return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
        }  else {
            logger.info("커뮤니티 리스트 조회 성공");
            return new ResponseEntity<Map>(result, HttpStatus.OK);
        }

    }

    /**
     * 커뮤니티 게시글 가져오기.(단건)
     *
     * @param seq
     * @return
     */
    @GetMapping("/{seq}")
    public ResponseEntity<Map> getCommunity(@PathVariable("seq") int seq){
        logger.info("/sapoon/community/{seq}");
        Map result = new HashMap();

        result = communityService.getCommunity(seq);

        if (result.get("result") == null) {
            result.put("result", "커뮤니티 조회 db 없음");
            logger.info("커뮤니티 조회 db 없음");
            return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
        }  else {
            logger.info("커뮤니티 조회 성공");
            return new ResponseEntity<Map>(result, HttpStatus.OK);
        }

    }
    // test
    /**
     * 커뮤니티 게시글 리스트 가져오기 by 둘레길별로.
     *
     * @param dulleSeq
     * @return
     */
    @GetMapping("/dulle/{dulleSeq}")
    public ResponseEntity<Map> getCommunityListByDulle(@PathVariable("dulleSeq") int dulleSeq){
        logger.info("/sapoon/community/dullegil/{dulleSeq}");
        Map result = new HashMap();

        result = communityService.getCommunityListByDulle(dulleSeq);

        if (result.get("result") == null) {
            result.put("result", "커뮤니티(둘레) 조회 db 없음");
            logger.info("커뮤니티(둘레) 조회 db 없음");
            return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
        }  else {
            logger.info("커뮤니티(둘레) 조회 성공");
            return new ResponseEntity<Map>(result, HttpStatus.OK);
        }

    }


    /**
     * dulleSeq로 커뮤니티의 평균점수, 총 게시글 갯수
     *
     * @param dulleSeq
     * @return communityPostsCount, 평균점수.
     */
    @GetMapping("/score/{dulleSeq}")
    public ResponseEntity<Map> getTotalCommunityCount(@PathVariable("dulleSeq") int dulleSeq){
        logger.info("/sapoon/community/score/{dulleSeq}");
        Map result = new HashMap();

        result = communityService.getTotalCommunityCount(dulleSeq);

        if (result.get("result") == null) {
            result.put("result", "fail");
            logger.info("커뮤니티 평균점수, 총게시글수 return success");
            return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
        }  else {
            logger.info("커뮤니티 평균점수, 총게시글수 return success");
            return new ResponseEntity<Map>(result, HttpStatus.OK);
        }

    }

}
