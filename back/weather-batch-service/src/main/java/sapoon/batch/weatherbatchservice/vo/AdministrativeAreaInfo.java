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
public class AdministrativeAreaInfo {
    @Id
    String area_cd;

    String first_ctgry;
    String second_ctgry;
    String third_ctgry;
    String grid_x;
    String grid_y;
    String updatedAt;

    public AdministrativeAreaInfo(String area_cd, String first_ctgry, String second_ctgry, String third_ctgry,
                    String grid_x, String ny, String updatedAt){
        this.area_cd = area_cd;
        this.first_ctgry = first_ctgry;
        this.second_ctgry = second_ctgry;
        this.third_ctgry = third_ctgry;
        this.grid_x = grid_x;
        this.grid_y = grid_y;
        this.updatedAt = updatedAt;

    }
}
