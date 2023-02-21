package com.example.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;
import org.springframework.stereotype.Service;

import com.example.dao2.MemberDao;
import com.example.dto.MemberDto;
import com.example.service.MemberService;

@Service("memberService")
public class MemberServiceImpl implements MemberService{

    @Resource(name = "memberDao") MemberDao memberDao;

    @Override
    public List<MemberDto> memberList(MemberDto param) throws Exception {
        //List<MemberDto> lists = memberDao.memberList(param);
        return memberDao.memberList(param);
    }

    @Override
    public MemberDto memberDetail(String memberId) throws Exception {
        return memberDao.memberDetail(memberId);
    }

    @Override
	public int memberDupCheck(String memberId) throws Exception {
		return memberDao.memberDupCheck(memberId);
	}

    @Override
    public int memberInsert(List<MemberDto> params) throws Exception {
        int saveMambers = 0;

        ObjectMapper mapper = new ObjectMapper();
        List<MemberDto> memberDtos = mapper.convertValue(params, new TypeReference<List<MemberDto>>() { });;

        for(MemberDto memberDto : memberDtos) {
            saveMambers += memberDao.memberInsert(memberDto);
        }

        return saveMambers;
    }

    @Override
    public int memberUpdate(List<MemberDto> params) throws Exception {
        int editMambers = 0;

        ObjectMapper mapper = new ObjectMapper();
        List<MemberDto> memberDtos = mapper.convertValue(params, new TypeReference<List<MemberDto>>() { });;

        for(MemberDto memberDto : memberDtos) {
            editMambers += memberDao.memberUpdate(memberDto);
        }

        return editMambers;
    }

    @Override
    public int memberDelete(MemberDto param) throws Exception {
        return memberDao.memberDelete(param);
    }

}
