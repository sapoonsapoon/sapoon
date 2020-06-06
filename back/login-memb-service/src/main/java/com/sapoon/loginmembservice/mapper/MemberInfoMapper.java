package com.sapoon.loginmembservice.mapper;

import com.sapoon.loginmembservice.vo.MemberInfoVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberInfoMapper {
    String selectId(String id);
    int insertMember(MemberInfoVO memberInfoVO);
}
