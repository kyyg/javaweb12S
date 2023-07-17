package com.spring.javaweb12S.vo;

import lombok.Data;

@Data
public class KakaoAddressVO {


	private double lat;
	private double lng;
	private String store_name;
	private String detail_address;
	private String rode_address;
	private String store_tel;
}
