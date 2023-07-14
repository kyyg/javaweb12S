package com.spring.javaweb12S.service;

import java.util.List;

import com.spring.javaweb12S.vo.KakaoAddressVO;

public interface AdminService {

	public KakaoAddressVO getKakaoAddressName(String address);

	void setKakaoAddressInput(String address, double latitude, double longitude);

	void setKakaoAddressDelete(String address);

	public List<KakaoAddressVO> getKakaoAddressList();

}
