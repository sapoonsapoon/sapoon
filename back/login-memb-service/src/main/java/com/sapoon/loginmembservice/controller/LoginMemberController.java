package com.sapoon.loginmembservice.controller;

import com.sapoon.loginmembservice.common.exception.InvalidDataException;
import com.sapoon.loginmembservice.vo.MemberInfoVO;
import com.sapoon.loginmembservice.service.LoginMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/sapoon")
public class LoginMemberController {

    @Autowired
    private LoginMemberService loginMemberService;

    @PostMapping("/login")
    public ResponseEntity<?> getLogin(@RequestBody MemberInfoVO memberInfoVO){
        System.out.println(memberInfoVO.getId());
        try{
            return ResponseEntity.ok().build();
        }catch (Exception e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @GetMapping("member/overlap/{id}")
    public ResponseEntity<?> idOverlapCheck(@PathVariable("id") String id){
        try{
            loginMemberService.selectId(id);
            return ResponseEntity.ok().build();
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @PostMapping("member/regist")
    public ResponseEntity<?> insertMember(@RequestBody MemberInfoVO memberInfoVO){
        try{
            loginMemberService.insertMember(memberInfoVO);
            return ResponseEntity.ok().build();
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @PostMapping("member/modify/password")
    public ResponseEntity<?> updatePassword(@RequestBody MemberInfoVO memberInfoVO){
        try{
            loginMemberService.updatePassword(memberInfoVO);
            return ResponseEntity.ok().build();
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @PostMapping("member/modify/info")
    public ResponseEntity<?> updateInfo(@RequestBody MemberInfoVO memberInfoVO){
        try{
            loginMemberService.updateInfo(memberInfoVO);
            return ResponseEntity.ok().build();
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @GetMapping("member/get/{id}")
    public ResponseEntity<?> getMember(@PathVariable("id") String id){
        try{
            return ResponseEntity.ok().headers(getSuccessHeader()).body(loginMemberService.selectMember(id));
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());
        }
    }

    @PostMapping("member/find/id")
    public ResponseEntity<?> getId(@RequestBody MemberInfoVO memberInfoVO){
        try{
            return ResponseEntity.ok().headers(getSuccessHeader()).body(loginMemberService.selectIdUsingNameEmailBirthday(memberInfoVO));
        }catch (InvalidDataException e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).headers(getErrorHeader()).body(e.getMessage());

        }
    }

    @PostMapping("member/find/password")
    public ResponseEntity<?> changePw(@RequestBody MemberInfoVO memberInfoVO){
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

}
