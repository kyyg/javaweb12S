package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class DbOptionVO {
	private int idx;
	private int productIdx;
	private String optionName;
	private int optionPrice;
	private int optionStock;
	
	private String productName;
}
