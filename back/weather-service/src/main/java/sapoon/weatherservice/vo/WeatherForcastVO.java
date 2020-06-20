package sapoon.weatherservice.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class WeatherForcastVO {

    String areaCd;
    String day; //yyyy-mm-dd
    String hour; //xx 시
    String temp;
    String tmx;
    String tmn;
    String sky;
    String pty;
    String wfKor;
    String wfEn;
    String pop;
    String r12;
    String s12;
    String ws;
    String wd;
    String wdKor;
    String wdEn;
    String reh;
    String r06;
    String s06;

}
