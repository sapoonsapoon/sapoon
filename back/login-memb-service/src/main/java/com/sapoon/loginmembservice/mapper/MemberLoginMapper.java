package com.sapoon.loginmembservice.mapper;

import com.sapoon.loginmembservice.vo.MemberInfoVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberLoginMapper {
    int insertBaseLoginInfo(MemberInfoVO memberInfoVO);
    int selectLoginFailCount(MemberInfoVO memberInfoVO);
    void updateWhenFail(MemberInfoVO memberInfoVO);
    void updateWhenSuccess(MemberInfoVO memberInfoVO);
}
