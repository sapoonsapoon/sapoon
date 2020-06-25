package sapoon.weatherservice.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Id;

@Getter
@Setter
@ToString
public class MiseVO {

    String date;
    String hour;
    String itemCode;
    String city;
    String value; //숫자
    String miseValue; //한글


}
