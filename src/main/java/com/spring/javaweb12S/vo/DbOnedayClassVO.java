package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class DbOnedayClassVO {

	private int idx;
	private String mid;
	private String className;
	private String store;
	private String WDate;
	private int memberNum;
	
	private String classTemp;
	private String qrCodeName; // 생성된 QR코드 파일이름
	
}
