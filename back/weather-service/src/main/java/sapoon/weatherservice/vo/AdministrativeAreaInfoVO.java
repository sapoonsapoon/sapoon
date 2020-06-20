package sapoon.weatherservice.vo;


import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Getter
@Setter
@ToString
@NoArgsConstructor
@Entity
public class AdministrativeAreaInfoVO {
    @Id
    String area_cd;

    String first_ctgry;
    String second_ctgry;
    String third_ctgry;
    String grid_x;
    String grid_y;

    public AdministrativeAreaInfoVO(String area_cd, String first_ctgry, String second_ctgry, String third_ctgry,
                                    String grid_x, String ny){
        this.area_cd = area_cd;
        this.first_ctgry = first_ctgry;
        this.second_ctgry = second_ctgry;
        this.third_ctgry = third_ctgry;
        this.grid_x = grid_x;
        this.grid_y = grid_y;
    }
}
