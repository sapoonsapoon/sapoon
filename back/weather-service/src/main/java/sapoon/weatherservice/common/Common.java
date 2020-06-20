package sapoon.weatherservice.common;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Common {
    public class returnCode{
        public static final String SUCCESS = "200";
        public static final String FAIL = "400";
    }

}
