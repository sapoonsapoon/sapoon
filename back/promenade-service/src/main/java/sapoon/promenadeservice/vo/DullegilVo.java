package sapoon.promenadeservice.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class DullegilVo {
    private int seq;
    private String name;
    private String description;
    private String courseName;
    private String courseDescription;
    private String region1;
    private String region2;
    private String difficulty;
    private String distance;
    private double distanceDetail;
    private String leadTime;
    private String drinkingWaterInfo;
    private String toiletInfo;
    private String cafeteriaInfo;
    private DullegilDetailVo dullegilDetailVo;
}
