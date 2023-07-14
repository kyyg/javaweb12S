package com.spring.javaweb12S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb12S.vo.KakaoAddressVO;

public interface AdminDAO {

	public KakaoAddressVO getKakaoAddressName(String address);

	public void setKakaoAddressDelete(String address);

	public void setKakaoAddressInput(@Param("address") String address, @Param("latitude")double latitude, @Param("longitude")double longitude);

	public List<KakaoAddressVO> getKakaoAddressList();

}
