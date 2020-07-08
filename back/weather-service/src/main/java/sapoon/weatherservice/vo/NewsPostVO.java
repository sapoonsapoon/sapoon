package sapoon.weatherservice.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Entity
public class NewsPostVO {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int seq;

    String title;
    String comment;
    String url;
    String thumbUrl;

    String newsCorp;
    String writer;

    String regId;
    String regDate;
    String updId;
    String updDate;




}
