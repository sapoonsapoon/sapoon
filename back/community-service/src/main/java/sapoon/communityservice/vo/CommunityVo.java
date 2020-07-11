package sapoon.communityservice.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class CommunityVo {
    private String seq;
    private String writer;
    private String contents;
    private double score1;
    private double score2;
    private double score3;
    private double score4;
    private double starScore;
    private String startTime;
    private String endTime;
    private String imgUrl; //실제 이미지 url
    //추가로 이미지도 받아야함.


}
