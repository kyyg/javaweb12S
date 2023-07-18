package com.spring.javaweb12S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb12S.dao.AdminDAO;
import com.spring.javaweb12S.vo.ChartVO;
import com.spring.javaweb12S.vo.DbOnedayClassVO;
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
	public void setKakaoAddressInput(String store_name, double lat, double lng, String detail_address,String rode_address,String store_tel) {
		adminDAO.setKakaoAddressInput(store_name,lat,lng,detail_address,rode_address,store_tel);
	}

	@Override
	public void setKakaoAddressDelete(String address) {
		adminDAO.setKakaoAddressDelete(address);
	}

	@Override
	public List<KakaoAddressVO> getKakaoAddressList() {
		return adminDAO.getKakaoAddressList();
	}

	@Override
	public void setReviewDelete(int idx) {
		adminDAO.setReviewDelete(idx);
	}

	@Override
	public void setBoardDelete(int idx) {
		adminDAO.setBoardDelete(idx);
	}

	@Override
	public void setNoticeDelete(int idx) {
		adminDAO.setNoticeDelete(idx);
	}

	@Override
	public List<DbOnedayClassVO> getAllOnedayClassList() {
		return adminDAO.getAllOnedayClassList();
	}

	@Override
	public void setOnedayClassDelete(int idx) {
		adminDAO.setOnedayClassDelete(idx);
	}

	@Override
	public List<ChartVO> getChart1() {
		return adminDAO.getChart1();
	}

	@Override
	public List<ChartVO> getChart2() {
		return adminDAO.getChart2();
	}

	@Override
	public List<ChartVO> getChart3() {
		return adminDAO.getChart3();
	}
	
	
}
