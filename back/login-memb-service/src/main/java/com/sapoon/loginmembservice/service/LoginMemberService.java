package com.sapoon.loginmembservice.service;

import com.sapoon.loginmembservice.common.exception.InvalidDataException;
import com.sapoon.loginmembservice.mapper.MemberInfoMapper;
import com.sapoon.loginmembservice.mapper.MemberLoginMapper;
import com.sapoon.loginmembservice.util.ValidChecker;
import com.sapoon.loginmembservice.vo.MemberInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class LoginMemberService {

    @Autowired
    MemberInfoMapper memberInfoMapper;

    @Autowired
    MemberLoginMapper memberLoginMapper;

    public void selectId(String id) throws Exception{
        String checker = memberInfoMapper.selectId(id);
        if(checker.equals("1")){
            throw new Exception("이미 등록된 아이디 입니다.");
        }
    }

    public void insertMember(MemberInfoVO memberInfoVO) throws InvalidDataException {
        ValidChecker validChecker = new ValidChecker();
        String Keys = "id;password;name;gender;birthday;email;nickname";
        HashMap<String, Object> values = new HashMap<>();
        values.put("id",memberInfoVO.getId());
        values.put("password",memberInfoVO.getPassword());
        values.put("name",memberInfoVO.getName());
        values.put("gender",memberInfoVO.getGender());
        values.put("birthday",memberInfoVO.getBirthday());
        values.put("email",memberInfoVO.getEmail());
        values.put("nickname",memberInfoVO.getNickname());

        if(!validChecker.validcheck(Keys,values)){
            throw new InvalidDataException("필수 입력 값을 다시 확인 하십시오.");
        }

        int result = memberInfoMapper.insertMember(memberInfoVO);

        if(result != 1){
            throw new InvalidDataException("등록 과정 중 오류가 발생했습니다. ");
        }

    }

}
