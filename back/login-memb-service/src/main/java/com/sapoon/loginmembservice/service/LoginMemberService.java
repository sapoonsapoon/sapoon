package com.sapoon.loginmembservice.service;

import com.sapoon.loginmembservice.common.exception.InvalidDataException;
import com.sapoon.loginmembservice.mapper.MemberInfoHstMapper;
import com.sapoon.loginmembservice.mapper.MemberInfoMapper;
import com.sapoon.loginmembservice.mapper.MemberLoginHstMapper;
import com.sapoon.loginmembservice.mapper.MemberLoginMapper;
import com.sapoon.loginmembservice.util.ValidChecker;
import com.sapoon.loginmembservice.vo.MemberInfoVO;
import org.apache.ibatis.reflection.wrapper.MapWrapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

@Service
public class LoginMemberService {

    Logger logger = LoggerFactory.getLogger(LoginMemberService.class);

    @Autowired
    MemberInfoMapper memberInfoMapper;

    @Autowired
    MemberInfoHstMapper memberInfoHstMapper;

    @Autowired
    MemberLoginMapper memberLoginMapper;

    @Autowired
    MemberLoginHstMapper memberLoginHstMapper;

    @Autowired
    MailService mailService;

    @Autowired
    JwtService jwtService;

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

    /**
     * 아이디 중복 확인
     * @param id
     * @throws InvalidDataException
     */
    public void selectId(String id) throws InvalidDataException{
        String checker = memberInfoMapper.selectId(id);
        if(checker.equals("1")){
            throw new InvalidDataException("이미 등록된 아이디 입니다.");
        }
    }

    /**
     * 회원 가입
     * @param memberInfoVO
     * @throws InvalidDataException
     */
    @Transactional
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
        memberInfoVO.setUpdStatus("00");
        int memberInfoResult = memberInfoMapper.insertMember(memberInfoVO);
        int memberLoginResult = memberLoginMapper.insertBaseLoginInfo(memberInfoVO);
        int memberInfoHstResult = memberInfoHstMapper.insertMemberInfoHst(memberInfoVO);

        if(memberInfoResult != 1 || memberLoginResult != 1 || memberInfoHstResult != 1){
            throw new InvalidDataException("등록실패");
        }
    }

    /**
     * 비밀번호 변경
     * @param memberInfoVO
     * @throws InvalidDataException
     */
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

    /**
     * 회원 정보수정
     * @param memberInfoVO
     * @throws InvalidDataException
     */
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

    /**
     * 회원 정보 조회
     * @param id
     * @return
     * @throws InvalidDataException
     */
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


    /**
     * 아이디 찾기
     * @param memberInfoVO
     * @return
     * @throws InvalidDataException
     */
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

    /**
     *  회원 비밀번호 찾기
     * @param memberInfoVO
     * @return
     * @throws InvalidDataException
     */
    @Transactional
    public void FindPassword(MemberInfoVO memberInfoVO) throws InvalidDataException {
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

        if(memberInfoMapper.selectForFindPassword(memberInfoVO) != 1 ){
            throw new InvalidDataException("일치하는 회원이 없습니다. ");
        }

        String newPw = RandomPassWordGenerator();
        String encodedString = base64encoder(newPw);
        memberInfoVO.setPassword(encodedString);
        memberInfoVO.setUpdStatus("01");

        int memberInfoResult = memberInfoMapper.updatePassword(memberInfoVO);
        if (memberInfoResult != 1) {
            throw new InvalidDataException("변경실패");
        }

        MemberInfoVO ResultMemberInfoVo = new MemberInfoVO();
        ResultMemberInfoVo.setPassword(newPw);
        ResultMemberInfoVo.setName(memberInfoVO.getName());

        mailService.mailSender(memberInfoVO.getEmail(),"SAPOON 재설정 비밀번호 안내",mailService.MakeChangePasswordMsg(ResultMemberInfoVo));

    }

    /**
     * 로그인
     * @param memberInfoVO
     * @return
     * @throws InvalidDataException
     * @throws UnsupportedEncodingException
     */
    public String login(MemberInfoVO memberInfoVO) throws InvalidDataException, UnsupportedEncodingException {
        ValidChecker validChecker = new ValidChecker();
        String Keys = "id;pw;macId";
        HashMap<String, Object> values = new HashMap<>();
        values.put("id", memberInfoVO.getId());
        values.put("pw", memberInfoVO.getPassword());
        values.put("macId", memberInfoVO.getMacId());

        if (!validChecker.validcheck(Keys, values)) {
            throw new InvalidDataException("필수 입력 값을 다시 확인 하십시오.");
        }

        if(!memberInfoMapper.selectId(memberInfoVO.getId()).equals("1")){
            throw new InvalidDataException("아이디, 패스워드를 다시 확인 하십시오.");
        }

        int loginFailCnt = memberLoginMapper.selectLoginFailCount(memberInfoVO);

        if(loginFailCnt>=5){
            throw new InvalidDataException("로그인 시도가 5회 이상 실패했습니다. ");
        }
        memberInfoVO.setPassword(base64encoder(memberInfoVO.getPassword()));
        int result = memberInfoMapper.selectMemberUsingIdPassword(memberInfoVO);
        if(result != 1){
            memberInfoVO.setLoginSuccessYn("N");
            memberLoginHstMapper.insertLoginHst(memberInfoVO);
            memberLoginMapper.updateWhenFail(memberInfoVO);
            throw new InvalidDataException("ID나 PW를 확인하세요.");
        }
        memberInfoVO.setLoginSuccessYn("Y");
        memberLoginHstMapper.insertLoginHst(memberInfoVO);
        memberLoginMapper.updateWhenSuccess(memberInfoVO);
        HashMap<String, Object> data = new HashMap<>();
        data.put("macId", memberInfoVO.getMacId());
        data.put("role", "user");

        String Token = jwtService.create(data);

        logger.info("id : " + memberInfoVO.getId() +" / token : " + Token );
        return Token;
    }

    /**
     * 로그인시 닉네임 찾기
     * @param memberInfoVO
     * @return
     */
    public Map<String, String> selectNickname(MemberInfoVO memberInfoVO){
        Map<String, String> nicknameMap = new HashMap<>();

        nicknameMap.put("nickname",memberInfoMapper.selectNickname(memberInfoVO));

        return nicknameMap;
    }
}
