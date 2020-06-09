package com.sapoon.loginmembservice.service;

import com.sapoon.loginmembservice.common.exception.InvalidDataException;
import com.sapoon.loginmembservice.mapper.MemberInfoMapper;
import com.sapoon.loginmembservice.mapper.MemberLoginMapper;
import com.sapoon.loginmembservice.util.ValidChecker;
import com.sapoon.loginmembservice.vo.MemberInfoVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Base64;
import java.util.HashMap;
import java.util.Random;

@Service
public class LoginMemberService {

    @Autowired
    MemberInfoMapper memberInfoMapper;

    @Autowired
    MemberLoginMapper memberLoginMapper;

    public String base64encoder(String str){
        Base64.Encoder encoder = Base64.getEncoder();
        String encodedString = encoder.encodeToString(str.getBytes());
        return encodedString;
    }

    public String base64decoder(String str){
        Base64.Decoder decoder = Base64.getDecoder();
        String decodedString = new String( decoder.decode(str));
        return decodedString;
    }

    public void selectId(String id) throws InvalidDataException{
        String checker = memberInfoMapper.selectId(id);
        if(checker.equals("1")){
            throw new InvalidDataException("이미 등록된 아이디 입니다.");
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

        memberInfoVO.setPassword(base64encoder(memberInfoVO.getPassword()));
        int result = memberInfoMapper.insertMember(memberInfoVO);

        if(result != 1){
            throw new InvalidDataException("등록실패");
        }
    }

    public void updatePassword(MemberInfoVO memberInfoVO) throws InvalidDataException{
        ValidChecker validChecker = new ValidChecker();
        String Keys = "id;password";
        HashMap<String, Object> values = new HashMap<>();
        values.put("id",memberInfoVO.getId());
        values.put("password",memberInfoVO.getPassword());

        if(!validChecker.validcheck(Keys,values)){
            throw new InvalidDataException("필수 입력 값을 다시 확인 하십시오.");
        }
        memberInfoVO.setPassword(base64encoder(memberInfoVO.getPassword()));
        int result = memberInfoMapper.updatePassword(memberInfoVO);

        if(result != 1){
            throw new InvalidDataException("변경실패");
        }
    }

    public void updateInfo(MemberInfoVO memberInfoVO) throws InvalidDataException{
        ValidChecker validChecker = new ValidChecker();
        String Keys = "id;birthday;nickname;email";
        HashMap<String, Object> values = new HashMap<>();
        values.put("id",memberInfoVO.getId());
        values.put("birthday",memberInfoVO.getBirthday());
        values.put("nickname",memberInfoVO.getNickname());
        values.put("email",memberInfoVO.getEmail());

        if(!validChecker.validcheck(Keys,values)){
            throw new InvalidDataException("필수 입력 값을 다시 확인 하십시오.");
        }

        int result = memberInfoMapper.updateInfo(memberInfoVO);

        if(result != 1){
            throw new InvalidDataException("변경실패");
        }
    }

    public MemberInfoVO selectMember(String id) throws InvalidDataException{
        ValidChecker validChecker = new ValidChecker();
        String Keys = "id";
        HashMap<String, Object> values = new HashMap<>();
        values.put("id",id);
        if(!validChecker.validcheck(Keys,values)){
            throw new InvalidDataException("필수 입력 값을 다시 확인 하십시오.");
        }
        MemberInfoVO  memberInfoVO = memberInfoMapper.selectMember(id);
        if(memberInfoVO != null){
            return memberInfoVO;
        }else{
            throw new InvalidDataException("조회 실패");
        }
    }


    public MemberInfoVO selectIdUsingNameEmailBirthday(MemberInfoVO memberInfoVO) throws InvalidDataException{
        ValidChecker validChecker = new ValidChecker();
        String Keys = "name;email;birthday";
        HashMap<String, Object> values = new HashMap<>();
        values.put("name",memberInfoVO.getName());
        values.put("email",memberInfoVO.getEmail());
        values.put("birthday",memberInfoVO.getBirthday());
        if(!validChecker.validcheck(Keys,values)){
            throw new InvalidDataException("필수 입력 값을 다시 확인 하십시오.");
        }
        MemberInfoVO id = memberInfoMapper.selectIdUsingNameEmailBirthday(memberInfoVO);
        if(id != null){
            return id;
        }else{
            throw new InvalidDataException("조회 실패");
        }
    }

    public MemberInfoVO FindPassword(MemberInfoVO memberInfoVO) throws InvalidDataException {
        ValidChecker validChecker = new ValidChecker();
        String Keys = "id;name;email;birthday";
        HashMap<String, Object> values = new HashMap<>();
        values.put("id", memberInfoVO.getId());
        values.put("name", memberInfoVO.getName());
        values.put("email", memberInfoVO.getEmail());
        values.put("birthday", memberInfoVO.getBirthday());

        if (!validChecker.validcheck(Keys, values)) {
            throw new InvalidDataException("필수 입력 값을 다시 확인 하십시오.");
        }

        String newPw = RandomPassWordGenerator();
        String encodedString = base64encoder(newPw);
        memberInfoVO.setPassword(encodedString);

        int result = memberInfoMapper.updatePassword(memberInfoVO);

        if (result != 1) {
            throw new InvalidDataException("변경실패");
        }
        MemberInfoVO forReturn = new MemberInfoVO();
        forReturn.setPassword(newPw);
        forReturn.setEmail(memberInfoVO.getEmail());
        return  forReturn;
    }

    public String RandomPassWordGenerator(){
        Random rand = new Random();
        StringBuffer sb = new StringBuffer();
        for(int i = 0; i < 10; i ++) {
            int index = rand.nextInt(3);
            switch(index) {
                case 0:
                    sb.append((char)(rand.nextInt(26) + 97));
                    break;
                case 1:
                    sb.append((char)(rand.nextInt(26) + 65));
                    break;
                case 2:
                    sb.append(rand.nextInt(10));
                    break;
            }
        }
        return sb.toString();
    }
}
