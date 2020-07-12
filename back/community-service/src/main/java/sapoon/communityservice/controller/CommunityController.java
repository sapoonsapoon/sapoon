package sapoon.communityservice.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sapoon.communityservice.service.CommunityService;
import sapoon.communityservice.vo.CommunityVo;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/sapoon/community")
public class CommunityController {
    Logger logger = LoggerFactory.getLogger(CommunityController.class);

    @Autowired
    CommunityService communityService;

    @PostMapping("")
    public ResponseEntity<Map> saveCommuity(@RequestBody CommunityVo communityVo){
        logger.info("/sapoon/community post");
        Map result = new HashMap();

        result = communityService.saveCommunity(communityVo);

        if (result.get("result") == null) {
            result.put("result", "커뮤니티 저장 실패");
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
    public ResponseEntity<Map> getNews(@PathVariable("seq") String seq){
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

}