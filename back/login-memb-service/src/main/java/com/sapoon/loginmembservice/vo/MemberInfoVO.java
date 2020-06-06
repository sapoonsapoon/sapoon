package com.sapoon.loginmembservice.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
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
}
