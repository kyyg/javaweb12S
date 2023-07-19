package com.spring.javaweb12S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb12S.dao.AdminDAO;
import com.spring.javaweb12S.vo.BoardVO;
import com.spring.javaweb12S.vo.ChartVO;
import com.spring.javaweb12S.vo.DbBaesongVO;
import com.spring.javaweb12S.vo.DbOnedayClassVO;
import com.spring.javaweb12S.vo.DbOrderCancelVO;
import com.spring.javaweb12S.vo.DbOrderVO;
import com.spring.javaweb12S.vo.DbProductVO;
import com.spring.javaweb12S.vo.EventVO;
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

	@Override
	public List<DbBaesongVO> getOrder4() {
		return adminDAO.getOrder4();
	}

	@Override
	public List<DbOrderCancelVO> getCancelOrder4() {
		return adminDAO.getCancelOrder4();
	}

	@Override
	public List<BoardVO> getBoard4() {
		return adminDAO.getBoard4();
	}

	@Override
	public List<DbOnedayClassVO> getclass4() {
		return adminDAO.getclass4();
	}

	@Override
	public int getWeekOrder() {
		return adminDAO.getWeekOrder();
	}

	@Override
	public int getWeekCancel() {
		return adminDAO.getWeekCancel();
	}

	@Override
	public int getWeekBoard() {
		return adminDAO.getWeekBoard();
	}

	@Override
	public int getWeekClass() {
		return adminDAO.getWeekClass();
	}

	@Override
	public List<DbProductVO> getNewProduct() {
		return adminDAO.getNewProduct();
	}

	@Override
	public List<DbProductVO> getNewProduct3() {
		return adminDAO.getNewProduct3();
	}

	@Override
	public void setBestReview(int idx, String bestReview) {
		adminDAO.setBestReview(idx, bestReview);
	}

	@Override
	public EventVO getEventToday(EventVO vo) {
		return adminDAO.getEventToday(vo);
	}

	@Override
	public void setEventInput(EventVO vo) {
		adminDAO.setEventInput(vo);
	}

	@Override
	public List<EventVO> getEventList(String mid) {
		return adminDAO.getEventList(mid);
	}
	
	
}
