package sapoon.weatherservice.mapper;

import org.apache.ibatis.annotations.Mapper;
import sapoon.weatherservice.vo.WeatherForcastVO;

@Mapper
//@Repository
public interface WeatherMapper {
    WeatherVO findCodeByWeather(String nx, String ny);


    //배치돌때 다음 함수를 통하여 db에 저장.
    int insertWeatherForcast(WeatherForcastVO weatherForcastVO);


}
