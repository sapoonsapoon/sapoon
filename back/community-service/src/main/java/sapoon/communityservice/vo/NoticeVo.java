package sapoon.communityservice.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.Date;

@Getter
@Setter
@ToString
public class NoticeVo{
    private int seq;
    private String title;
    private String comment;
    private String fileYn;
    private String imgYn;
    private String useYn;
    private int viewCount;
    private String regId;
    private Date regDate;
    private String updId;
    private Date updDate;
}
