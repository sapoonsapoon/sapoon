package com.sapoon.loginmembservice.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class MemberInfoVO {
    private String id;
    private String password;
    private String name;
    private String gender;
    private String birthday;
    private String email;
    private String nickname;
    private String macId;
    private String loginIp;
    private String loginLocation;
    private String loginToken;
    private String registPath;
    private String regDate;
    private String regId;
    private String updId;
    private String updDate;
    private String updStatus;
    private String loginSuccessYn;
}
