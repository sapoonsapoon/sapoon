package sapoon.communityservice.controller;

import com.google.cloud.storage.BlobInfo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import sapoon.communityservice.common.Service.GCPStorageService;
import sapoon.communityservice.service.NoticeService;
import sapoon.communityservice.vo.NoticeVo;
import sapoon.communityservice.vo.UploadReqVo;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

@RestController
@RequestMapping("/sapoon/community/notice")
public class NoticeController {

    Logger logger = LoggerFactory.getLogger(NoticeController.class);

    @Value("${spring.cloud.gcp.storage.bucket}")
    private String gcpBucketName;

    @Autowired
    private NoticeService noticeService;

    @Autowired
    private GCPStorageService gcpStorageService;

    /*

     */
    @RequestMapping(method=RequestMethod.POST, value="/save")
    public String saveNoticePost(@RequestParam(value="title") String title,
                                 @RequestParam(value="comment") String comment,
                                 @RequestParam(value="regId") String regId,
                                 @RequestParam(value="file1", required = false) MultipartFile file1,
                                 @RequestParam(value="file2", required = false) MultipartFile file2,
                                 @RequestParam(value="file3", required = false) MultipartFile file3,
                                 @RequestParam(value="file4", required = false) MultipartFile file4,
                                 @RequestParam(value="file5", required = false) MultipartFile file5
                                 ) {

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        Calendar calendar = Calendar.getInstance();

        // 업로드 파일 이름
        String fileOriginalName = file1.getOriginalFilename();
        String uploadFileName = regId+"-"+simpleDateFormat.format(calendar.getTime());

        // 파일 확장자
        if(fileOriginalName != null && fileOriginalName.contains(".")){
            // uploadFileName += "." + fileOriginalName.split(".")[1]; // 에러남 왜지?
            uploadFileName += ".jpg";
        }

        // GCP 업로드 Vo
        UploadReqVo uploadReqVo = new UploadReqVo();
        uploadReqVo.setBucketName(gcpBucketName);
        uploadReqVo.setMultipartFile(file1);
        uploadReqVo.setUploadFileName(uploadFileName);

        BlobInfo blobInfo;
        // GCP 업로
        try {
            blobInfo = gcpStorageService.uploadFileToGCP(uploadReqVo);
            logger.info(blobInfo.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }




        /*
        String result = noticeService.saveNotice(noticeVo);
        */

        return "test";
    }

    @RequestMapping(method=RequestMethod.GET, value = "/get/{seq}")
    public NoticeVo getNoticePost(@PathVariable int seq){
        NoticeVo noticeVo = noticeService.getNotice(seq);

        /*
        ResultVo resultVo = new ResultVo();

        if(noticeVo != null){
            resultVo.setStatus("success");
            resultVo.setStatusCode("200");
        }
        */

        return noticeVo;
    }
}
