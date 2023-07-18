package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class ChartVO {

	// 도넛 차트(상품별 판매액)
	private String productName; 
	private int proTotalSum; 
	
	
	// 바 차트(3개월간 매출액/취소액)
	private String salesMonth; 
	private int salesMonthPrice; 
	
	private String cancelMonth; 
	private int cancelMonthPrice; 
	
	
}
