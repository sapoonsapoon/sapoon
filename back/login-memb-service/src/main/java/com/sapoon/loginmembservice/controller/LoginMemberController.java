package com.sapoon.loginmembservice.controller;

import com.sapoon.loginmembservice.common.exception.InvalidDataException;
import com.sapoon.loginmembservice.vo.MemberInfoVO;
import com.sapoon.loginmembservice.service.LoginMemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/sapoon/member")
public class LoginMemberController {

    Logger logger = LoggerFactory.getLogger(LoginMemberController.class);

    @Autowired
    private LoginMemberService loginMemberService;

    @GetMapping("/test")
    public String test(){
        logger.info("connection test");
        return "hello world";
    }

    @PostMapping("/login")
    public ResponseEntity<?> getLogin(@RequestBody MemberInfoVO memberInfoVO){
        logger.info("loginMemberController - sapoon/member/login");
        try{
            return ResponseEntity.ok().headers(getTokenHeader(loginMemberService.login(memberInfoVO))).build();
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @GetMapping("/overlap/{id}")
    public ResponseEntity<?> idOverlapCheck(@PathVariable("id") String id){
        logger.info("loginMemberController - sapoon/member/overlap/" + id);

        try{
            loginMemberService.selectId(id);
            return ResponseEntity.ok().build();
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @PostMapping("/regist")
    public ResponseEntity<?> insertMember(@RequestBody MemberInfoVO memberInfoVO){
        logger.info("loginMemberController - sapoon/member/regist");
        try{
            loginMemberService.insertMember(memberInfoVO);
            return ResponseEntity.ok().build();
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @PostMapping("/modify/password")
    public ResponseEntity<?> updatePassword(@RequestBody MemberInfoVO memberInfoVO){
        logger.info("loginMemberController - sapoon/member/modify/password");
        try{
            loginMemberService.updatePassword(memberInfoVO);
            return ResponseEntity.ok().build();
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @PostMapping("/modify/info")
    public ResponseEntity<?> updateInfo(@RequestBody MemberInfoVO memberInfoVO){
        logger.info("loginMemberController - sapoon/member/modify/info");
        try{
            loginMemberService.updateInfo(memberInfoVO);
            return ResponseEntity.ok().build();
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @GetMapping("/get/{id}")
    public ResponseEntity<?> getMember(@PathVariable("id") String id){
        logger.info("loginMemberController - sapoon/member/get/" + id);
        try{
            return ResponseEntity.ok().headers(getSuccessHeader()).body(loginMemberService.selectMember(id));
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @PostMapping("/find/id")
    public ResponseEntity<?> getId(@RequestBody MemberInfoVO memberInfoVO){
        logger.info("loginMemberController - sapoon/member/find/id");
        try{
            return ResponseEntity.ok().headers(getSuccessHeader()).body(loginMemberService.selectIdUsingNameEmailBirthday(memberInfoVO));
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());

        }
    }

    @PostMapping("/find/password")
    public ResponseEntity<?> changePw(@RequestBody MemberInfoVO memberInfoVO){
        logger.info("loginMemberController - sapoon/member/find/password");
        try{
            return ResponseEntity.ok().headers(getSuccessHeader()).body(loginMemberService.FindPassword(memberInfoVO));
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());

        }
    }

    private HttpHeaders getErrorHeader() {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        return httpHeaders;
    }

    private HttpHeaders getSuccessHeader() {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.APPLICATION_JSON);
        return httpHeaders;
    }
    private HttpHeaders getTokenHeader(String token) {
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.set("Authorization",token);
        return httpHeaders;
    }

}
