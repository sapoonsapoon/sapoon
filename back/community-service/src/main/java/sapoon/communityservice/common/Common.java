package sapoon.communityservice.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;

public class Common {


    public String getCurrentTime(){
        SimpleDateFormat format1 = new SimpleDateFormat ( "yyyyMMdd_HHmmss");
        Calendar time = Calendar.getInstance();
        String format_time = format1.format(time.getTime());

        return format_time;
    }

}
