package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class MemberVO {
	private int idx;
	private String mid;
	private String pwd;
	private String nickName;
	private String name;
	private String tel;
	private String address;
	private String email;
	private String content;
	private String userInfor;
	private String userDel;
	private int point;
	private int level;
	private int visitCnt;
	private String startDate;
	private String lastDate;
	private int todayCnt;
	
	private int deleteDiff;
	
	private String validMember;
	
}
