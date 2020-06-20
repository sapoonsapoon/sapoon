package com.sapoon.loginmembservice.mapper;

import com.sapoon.loginmembservice.vo.MemberInfoVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberInfoMapper {
    String selectId(String id);
    int insertMember(MemberInfoVO memberInfoVO);
    int updatePassword(MemberInfoVO memberInfoVO);
    int updateInfo(MemberInfoVO memberInfoVO);
    MemberInfoVO selectMember(String id);
    MemberInfoVO selectIdUsingNameEmailBirthday(MemberInfoVO memberInfoVO);
    int selectMemberUsingIdPassword(MemberInfoVO memberInfoVO);
    int selectForFindPassword(MemberInfoVO memberInfoVO);
}
