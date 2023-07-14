package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class DbProductVO {
	private int idx;
	private String productCode;
	private String productName;
	private String detail;
	private int mainPrice;
	private String fSName;
	private String fSName2;
	private String content;
	private String productStatus;
	private String wDate;
	
	private String categoryMainCode;
	private String categoryMainName;
	private String categoryMiddleCode;
	private String categoryMiddleName;

	private int day_diff;		// 10일 이내 새 상품 표시를 위한 변수
	private int hour_diff;	// 10일 이내 새 상품 표시를 위한 변수

}
