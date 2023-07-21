package com.spring.javaweb12S.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb12S.vo.MemberVO;

public interface MemberService {

	public MemberVO getMemberIdCheck(String mid);

	public MemberVO getMemberNickCheck(String nickName);

	public int setMemberJoinOk(MemberVO vo);

	public void setMemberVisitProcess(MemberVO vo);

	public ArrayList<MemberVO> getMemberList(int startIndexNo, int pageSize, String mid);

	public void setMemberPwdUpdate(String mid, String pwd);

	public void setMemberUpdateOk(MemberVO vo);

	public void setMemberDeleteOk(String mid);
	
	public MemberVO getEmailSearch(String email);

	public MemberVO getMemberNickNameEmailCheck(String nickName, String email);

	public void setKakaoMemberInputOk(String mid, String pwd, String nickName, String email);

	public void setMemberUserDelCheck(String mid);
	

}
