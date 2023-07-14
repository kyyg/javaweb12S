package com.spring.javaweb12S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb12S.dao.AdminDAO;
import com.spring.javaweb12S.vo.KakaoAddressVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public KakaoAddressVO getKakaoAddressName(String address) {
		return adminDAO.getKakaoAddressName(address);
	}

	@Override
	public void setKakaoAddressInput(String address, double latitude, double longitude) {
		adminDAO.setKakaoAddressInput(address,latitude,longitude);
	}

	@Override
	public void setKakaoAddressDelete(String address) {
		adminDAO.setKakaoAddressDelete(address);
	}

	@Override
	public List<KakaoAddressVO> getKakaoAddressList() {
		return adminDAO.getKakaoAddressList();
	}
	
}
