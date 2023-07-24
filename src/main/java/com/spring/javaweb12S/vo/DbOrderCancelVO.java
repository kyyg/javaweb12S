package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class DbOrderCancelVO {

	private int idx;
	private String mid;
	private String orderIdx;
	private int cancelIdx;
	private String cancelDate;
	private String cancelMemo;
	private String cancelStatus;
	private String reason1;
	private String reason2;
	
	// 관리자 취소 목록에서 불러오기위한 필드
	private String orderDate;
	private String productName;
	private String optionName;
  private int optionPrice;
  private int optionNum;
	
}
