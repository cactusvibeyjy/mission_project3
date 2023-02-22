package com.example.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.MemberDto;
import com.example.service.MemberService;

@Controller
@RequestMapping("/member/")
public class MemberController {

    @Resource(name = "memberService") MemberService memberService;

    // 목록
    @RequestMapping(value = "/list.json",method = RequestMethod.POST)
    @ResponseBody
    public List<MemberDto> memberList(MemberDto param) throws Exception {
        return memberService.memberList(param);
    }

    // 상세
    @RequestMapping(value = "/detail.json",method = RequestMethod.POST)
    @ResponseBody
    public MemberDto memberDetail(MemberDto param) throws Exception {
        return memberService.memberDetail(param.getMemberId());
    }

    // 상세
    @RequestMapping(value = "/dupCheck.json",method = RequestMethod.POST)
    @ResponseBody
    public int memberDupCheck(MemberDto param) throws Exception {
    	return memberService.memberDupCheck(param.getMemberId());
    }

    // 등록
    @RequestMapping(value = "/insert.json",method = RequestMethod.POST)
    @ResponseBody
    public int memberInsert(@RequestBody List<MemberDto> params) throws Exception {
        return memberService.memberInsert(params);
    }

    // 수정
    @RequestMapping(value = "/update.json",method = RequestMethod.POST)
    @ResponseBody
    public int memberUpdate(@RequestBody List<MemberDto> params) throws Exception {
        return memberService.memberUpdate(params);
    }

    // 삭제
    @RequestMapping(value = "/delete.json",method = RequestMethod.POST)
    @ResponseBody
    public int memberDelete(@RequestBody MemberDto param) throws Exception {
        return memberService.memberDelete(param);
    }


}
