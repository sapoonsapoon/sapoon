package sapoon.communityservice.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.multipart.MultipartFile;

@Getter
@Setter
@ToString
public class UploadReqVo {
    private String bucketName;
    private String uploadFileName;
    private MultipartFile multipartFile;
    private String uploadGcpUrl;
}
