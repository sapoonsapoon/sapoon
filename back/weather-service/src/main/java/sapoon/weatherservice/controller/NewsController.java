package sapoon.weatherservice.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import sapoon.weatherservice.service.NewsService;


import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/sapoon/news")
public class NewsController {

    @Autowired
    NewsService newsService;

    @GetMapping("/test")
    public String test(){
        return "helloworld";
    }

    /**
     * 뉴스 정보 리스트 가져오기.
     *
     * @param x
     * @return
     */
    /**
     * db에 있는지 봐.(최근 1시간?) 또는 시간 정해서.
     * 없으면 crawling 해와서 db에 넣고. 가져와.
     * 있으면 db에서 가져와.
     */
    @GetMapping("/")
    public ResponseEntity<Map> getNewsList(){
        Map result = new HashMap();

        result = newsService.getNewsList();

        if (result.get("result") == null) {
            result.put("result", "뉴스 조회 db 없음");
            return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
        }  else {
            return new ResponseEntity<Map>(result, HttpStatus.OK);
        }

    }

    /**
     * 뉴스 정보 가져오기.(단건)
     *
     * @param seq
     * @return
     */
    @GetMapping("/{seq}")
    public ResponseEntity<Map> getNews(@PathVariable("seq") String seq){
        Map result = new HashMap();

        result = newsService.getNews(seq);

        if (result.get("result") == null) {
            result.put("result", "뉴스 조회 db 없음");
            return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
        }  else {
            return new ResponseEntity<Map>(result, HttpStatus.OK);
        }

    }

    /**
     * 뉴스 정보 insert.
     *
     * @param  X
     * @return
     */
    @GetMapping("/insert")
    public ResponseEntity<Map> insertNews(){
        Map result = new HashMap();

        result = newsService.insertNews();

        //service에서 news 파싱하기.

        if (result.get("result") == null) {
            return new ResponseEntity<Map>(result, HttpStatus.BAD_REQUEST);
        }  else {
            return new ResponseEntity<Map>(result, HttpStatus.OK);
        }

    }

}
