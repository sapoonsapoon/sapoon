package com.sapoon.loginmembservice.service;

import com.sapoon.loginmembservice.mapper.MemberInfoMapper;
import com.sapoon.loginmembservice.mapper.MemberLoginMapper;
import com.sapoon.loginmembservice.mapper.TestCaseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginMemberService {

    @Autowired
    TestCaseMapper testCaseMapper;

    @Autowired
    MemberInfoMapper memberInfoMapper;

    @Autowired
    MemberLoginMapper memberLoginMapper;

    public void selectId(String id) throws Exception{
        String checker = memberInfoMapper.selectId(id);
        if(checker.equals("1")){
            throw new Exception("id already exists");
        }
    }

}
