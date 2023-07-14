package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class BoardVO {
	private int idx;
	private String mid;
	private String nickName;
	private String title;
	private String email;
	private String content;
	private int readNum;
	private String openSw;
	private String wDate;
	private int good;
	private String fixed;
	private String part;
	private String pwd;
	private String answer;
	
	private int day_diff;		// 날짜 차이 계산 필드(1일차이 계산)
	private int hour_diff;	// 날짜 차이 계산 필드(24시간차이 계산)
	
	// 이전글/다음글을 위한 변수 설정
	private int preIdx;
	private int nextIdx;
	private String preTitle;
	private String nextTitle;
	
	private int replyCount;		// 댓글의 개수를 저장하기위한필드
	
}
