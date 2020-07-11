package sapoon.communityservice.common.Service;

//import com.google.auth.Credentials;
//import com.google.auth.oauth2.GoogleCredentials;
//import com.google.cloud.storage.Acl;
//import com.google.cloud.storage.BlobInfo;
//import com.google.cloud.storage.Storage;
//import com.google.cloud.storage.StorageOptions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import sapoon.communityservice.vo.UploadReqVo;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

@Service
public class GCPStorageService {

    Logger logger = LoggerFactory.getLogger(GCPStorageService.class);

//    private Credentials credentials = GoogleCredentials
//            .fromStream(
//                    new FileInputStream("/Users/wonhyeongcho/Development/sapoon/back" +
//                            "/community-service/sapoon-2bf5a1ea4480.json")
//            );
//
//    private Storage storage = StorageOptions.newBuilder().setCredentials(credentials).build().getService();
//
//    public GCPStorageService() throws IOException {
//    }
//
//    public BlobInfo uploadFileToGCP(UploadReqVo uploadReqVo) throws IOException {
//        logger.info(credentials.getAuthenticationType());
//        logger.info(credentials.toString());
//
//        BlobInfo blobInfo = storage.create(
//                BlobInfo.newBuilder(uploadReqVo.getBucketName(), uploadReqVo.getUploadFileName())
//                .setAcl(new ArrayList<>(Arrays.asList(Acl.of(Acl.User.ofAllAuthenticatedUsers(), Acl.Role.OWNER
//                ))))
//                .build(),
//                uploadReqVo.getMultipartFile().getBytes()
//        );
//
//        return blobInfo;
//    }
}
