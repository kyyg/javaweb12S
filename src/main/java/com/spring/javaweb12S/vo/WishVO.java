package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class WishVO {

	private int idx;
	private int productIdx;
	private String productName;
	private String mid;
	private String wDate;
	
	// 위시리스트에 넣을 상품 사진,가격 필드
	private String FSName;
	private String detail;
	private int MainPrice;
	
}
