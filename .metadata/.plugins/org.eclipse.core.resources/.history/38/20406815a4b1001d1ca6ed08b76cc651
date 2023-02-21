package com.example.dao2;

import com.example.dto.MemberDto;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("memberDao")
public interface MemberDao {

    public List<MemberDto> memberList(MemberDto param);
    public MemberDto memberDetail(String memberId);
    public int memberDupCheck(String memberId);
    public int memberInsert(MemberDto param);
    public int memberUpdate(MemberDto param);
    public int memberDelete(MemberDto param);
}
