package sapoon.batch.weatherbatchservice.vo;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Id;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Entity
public class MiseInfo {

    @Id
    String miseId;

    String date;
    String stationcode;
    String itemcode ;//90303
    String timecode; //RH02 -> 두시간마다
    String value; // 측정값
    String value_kr; // 측정값 한글

}
