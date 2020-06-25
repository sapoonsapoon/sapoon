package sapoon.weatherservice.mapper;

import org.apache.ibatis.annotations.Mapper;
import sapoon.weatherservice.vo.AdministrativeAreaInfoVO;
import sapoon.weatherservice.vo.MiseVO;
import sapoon.weatherservice.vo.WeatherForcastVO;

@Mapper
//@Repository
public interface WeatherMapper {
    AdministrativeAreaInfoVO findCurrentWeather(String nx, String ny, String hour);

    MiseVO findCurrentMise(String nx, String ny, String hour);

    //배치돌때 다음 함수를 통하여 db에 저장.
    int insertWeatherForcast(WeatherForcastVO weatherForcastVO);

    //배치돌때 다음 함수를 통하여 db에 저장. 미세먼지정보
    int insertMise(MiseVO miseVO);

}
