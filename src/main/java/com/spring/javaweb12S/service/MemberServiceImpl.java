package com.spring.javaweb12S.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb12S.common.JavawebProvide;
import com.spring.javaweb12S.dao.MemberDAO;
import com.spring.javaweb12S.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	

	@Override
	public MemberVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public MemberVO getMemberNickCheck(String nickName) {
		return memberDAO.getMemberNickCheck(nickName);
	}

	@Override
	public int setMemberJoinOk(MemberVO vo) {
		int res = 0;
				
			memberDAO.setMemberJoinOk(vo);
			res = 1;
		
		return res;
	}

	@Override
	public void setMemberVisitProcess(MemberVO vo) {
		memberDAO.setMemberVisitProcess(vo);
	}

	@Override
	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, String mid) {
		return memberDAO.getMemberList(startIndexNo, pageSize, mid);
	}

	@Override
	public void setMemberPwdUpdate(String mid, String pwd) {
		memberDAO.setMemberPwdUpdate(mid, pwd);
	}

	@Override
	public void setMemberUpdateOk(MemberVO vo) {
		memberDAO.setMemberUpdateOk(vo);
	}

	@Override
	public void setMemberDeleteOk(String mid) {
		memberDAO.setMemberDeleteOk(mid);
	}
	

	@Override
	public MemberVO getEmailSearch(String email) {
		return memberDAO.getEmailSearch(email);
	}

	@Override
	public MemberVO getMemberNickNameEmailCheck(String nickName, String email) {
		return memberDAO.getMemberNickNameEmailCheck(nickName, email);
	}

	@Override
	public void setKakaoMemberInputOk(String mid, String pwd, String nickName, String email) {
		memberDAO.setKakaoMemberInputOk(mid, pwd, nickName, email);
	}

	@Override
	public void setMemberUserDelCheck(String mid) {
		memberDAO.setMemberUserDelCheck(mid);
	}
	
	
}
