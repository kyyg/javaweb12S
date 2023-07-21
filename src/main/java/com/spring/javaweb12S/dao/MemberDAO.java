package com.spring.javaweb12S.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb12S.vo.MemberVO;

public interface MemberDAO {

	public MemberVO getMemberIdCheck(@Param("mid") String mid);

	public MemberVO getMemberNickCheck(@Param("nickName") String nickName);

	public int setMemberJoinOk(@Param("vo") MemberVO vo);

	public void setMemberVisitProcess(@Param("vo") MemberVO vo);
	
	public ArrayList<MemberVO> getMemberList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid);

	public void setMemberPwdUpdate(@Param("mid") String mid, @Param("pwd") String pwd);

	public void setMemberUpdateOk(@Param("vo") MemberVO vo);

	public void setMemberDeleteOk(@Param("mid") String mid);

	public int totRecCnt(@Param("mid") String mid);
	
	public MemberVO getEmailSearch(@Param("email") String email);
	
	public MemberVO getMemberNickNameEmailCheck(@Param("nickName") String nickName, @Param("email") String email);

	public void setKakaoMemberInputOk(@Param("mid") String mid, @Param("pwd") String pwd, @Param("nickName") String nickName, @Param("email") String email);

	public void setMemberUserDelCheck(@Param("mid") String mid);


}
