package sapoon.weatherservice.mapper;

import org.apache.ibatis.annotations.Mapper;
import sapoon.weatherservice.vo.AdministrativeAreaInfoVO;
import sapoon.weatherservice.vo.WeatherForcastVO;

@Mapper
//@Repository
public interface WeatherMapper {
    AdministrativeAreaInfoVO findCodeByWeather(String grid_x, String grid_y);

    //배치돌때 다음 함수를 통하여 db에 저장.
    int insertWeatherForcast(WeatherForcastVO weatherForcastVO);


}
