package sapoon.weatherservice.service;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sapoon.weatherservice.mapper.NewsMapper;
import sapoon.weatherservice.vo.NewsPostVO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service
public class NewsService {
    private static final org.slf4j.Logger LOGGER = LoggerFactory.getLogger(NewsService.class);

    @Autowired
    NewsMapper newsMapper;


    public Map<String, Object> getNewsList() {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        resultMap.put("result",null);

        try{
            resultMap.put("result",newsMapper.findNewsPostList());
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

    public Map<String, Object> getNews(String seq) {
        Map<String, Object> resultMap = new HashMap<String, Object>();

        resultMap.put("result",null);

        try{
            resultMap.put("result",newsMapper.findNewsPost(seq));
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

    //존재하면 True, 없으면 false. false 일때 insert
    boolean checkNewsExist(List<NewsPostVO> newsPostVOListOld, NewsPostVO newsPostVONew) {
//        boolean result = true;

        for(NewsPostVO newsPostVoOld :newsPostVOListOld) {
//      title, content는 애매해서 url로 비교로직 설정
//      newsPostVoOld.getTitle().equals(newsPostVONew.getTitle()) &&
//      newsPostVoOld.getComment().equals(newsPostVONew.getComment())
            if(newsPostVoOld.getUrl().equals(newsPostVONew.getUrl())) {
                return true;
            }
        }
        return false;
    }

    public Map<String, Object> insertNews(){
        Map<String, Object> resultMap = new HashMap<String, Object>();

        resultMap.put("result",null);

        String searchTitle = "산책로";
        String url = "https://search.naver.com/search.naver?query="+searchTitle+"&where=news&ie=utf8&sm=nws_hty";
        try{
            Document doc = Jsoup.connect(url).get();
            Elements elem = doc.select("ul.type01");
            Elements thumb = elem.select("div.thumb a");
            Elements dl = elem.select("dl");

            System.out.println("elem size is "+elem.size());
            System.out.println("thumb is "+thumb.size());
            System.out.println("dl is "+dl.size());

            String imgUrl = ""; //썸네일url
            String newsUrl = ""; //뉴스 기사 url
            String newsTitle = ""; //뉴스 타이틀
            String newsComment = ""; //뉴스 기사 내용
            String newsCorp =""; //언론사

            //db에 있는값 비교하가 위한 변수
            List<NewsPostVO> newsPostVOListOld = newsMapper.findNewsPostList();
            List<NewsPostVO> newsPostVOListNew = new ArrayList<NewsPostVO>();


            NewsPostVO newsPostVO = new NewsPostVO();

            for (int i = 0 ; i < thumb.size() ; i++){

                newsComment = dl.get(i).select("dd").next().text();
                if(newsComment.length()>200) newsComment = newsComment.substring(200);

                newsPostVO.setTitle(dl.get(i).select("a").attr("title"));
                newsPostVO.setComment(newsComment);
                newsPostVO.setUrl(dl.get(i).select("a").attr("href"));
                newsPostVO.setThumbUrl(thumb.get(i).select("img").attr("src"));
                newsPostVO.setNewsCorp(dl.get(i).select("._sp_each_source").text());
                newsPostVO.setWriter("김용희");
                newsPostVO.setRegId("kimdragonhee");

                LOGGER.info("newsPostVO : "+newsPostVO);

                //insert전에 db에서 가져와서 데이터 확인.
                if(!checkNewsExist(newsPostVOListOld,newsPostVO)){
//                    newsMapper.insertNewsPost(newsPostVO);
                    newsPostVOListNew.add(newsPostVO);
                    LOGGER.info("VO : "+newsPostVO);
                }

            }

            resultMap.put("result",newsMapper.findNewsPostList());
            resultMap.put("resultCode","1");
            resultMap.put("resultDesc","success");
        }catch ( Exception e ){
            LOGGER.error(String.valueOf(e));
            resultMap.put("resultCode","3");
            resultMap.put("resultDesc","parsing error");
        }

        return resultMap;

    }

}
