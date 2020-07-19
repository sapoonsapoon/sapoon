package sapoon.communityservice.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

@Getter
@Setter
@ToString
public class CommunityVo {
    private int seq;
    private String writer;
    private String contents;
    private int score1;
    private int score2;
    private int score3;
    private int score4;
    private int starScore;
    private int totalScore;
    private String startTime;
    private String endTime;
    private String imgUrl; //실제 이미지 url
    private String regDate; //커뮤니티 게시글 쓴 시각 ex) 2020-07-11 12:13:00
    private MultipartFile imgFile;
    private int dulleSeq;

}
