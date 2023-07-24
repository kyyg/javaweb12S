package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class DbReviewVO {

	private int idx;
	private int productIdx;
	private String productName;
	private String mid;
	private String title;
	private String content;
	private String fSName;
	private int score;
	private String wDate;
	private String bestReview;
	private String blockReview;
	private int reportNum;
	
	
	private int reviewIdx;
	private String reportMemo1; 
	private String reportMemo2; 
	private String reportDate; 
	
}
