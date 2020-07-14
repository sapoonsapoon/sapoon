package sapoon.communityservice.controller;

import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import sapoon.communityservice.common.S3Uploader;
import sapoon.communityservice.service.CommunityService;

import java.io.IOException;

@RequiredArgsConstructor
@Controller
public class S3Controller {

    private static final Logger LOGGER = LoggerFactory.getLogger(S3Controller.class);

    private final S3Uploader s3Uploader;


    @PostMapping("/upload")
    @ResponseBody public String upload(
            @RequestParam(value="title") String title,
            @RequestParam(value="comment") String comment,
            @RequestParam(value="regId") String regId,
            @RequestParam("imgFile") MultipartFile multipartFile) throws IOException {


        LOGGER.info("title "+     title   );
        LOGGER.info("comment "+     comment   );
        LOGGER.info("regId "+     regId   );

        LOGGER.info("img upload "+        multipartFile.getName());
        LOGGER.info("img upload "+        multipartFile.getOriginalFilename());
        LOGGER.info("img upload "+        multipartFile.getSize());
        LOGGER.info("img upload "+        multipartFile.getContentType());
        LOGGER.info("img upload "+        multipartFile.getResource());

        LOGGER.info("multipartFile "+multipartFile);


        return s3Uploader.upload(multipartFile, "community/img");
    }

}


