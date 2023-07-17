package com.spring.javaweb12S.service;

import java.util.List;

import com.spring.javaweb12S.vo.DbOnedayClassVO;
import com.spring.javaweb12S.vo.KakaoAddressVO;

public interface AdminService {

	public KakaoAddressVO getKakaoAddressName(String address);

	void setKakaoAddressInput(String store_name, double lat, double lng, String detail_address,String rode_address,String store_tel);

	void setKakaoAddressDelete(String address);

	public List<KakaoAddressVO> getKakaoAddressList();

	public void setReviewDelete(int idx);

	public void setBoardDelete(int idx);

	public void setNoticeDelete(int idx);

	public List<DbOnedayClassVO> getAllOnedayClassList();

	public void setOnedayClassDelete(int idx);

}
