package com.spring.javaweb12S.service;

import java.util.List;

import com.spring.javaweb12S.vo.BoardVO;
import com.spring.javaweb12S.vo.ChartVO;
import com.spring.javaweb12S.vo.ContactReplyVO;
import com.spring.javaweb12S.vo.ContactVO;
import com.spring.javaweb12S.vo.DbBaesongVO;
import com.spring.javaweb12S.vo.DbOnedayClassVO;
import com.spring.javaweb12S.vo.DbOptionVO;
import com.spring.javaweb12S.vo.DbOrderCancelVO;
import com.spring.javaweb12S.vo.DbProductVO;
import com.spring.javaweb12S.vo.DbReviewVO;
import com.spring.javaweb12S.vo.EventVO;
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

	public List<ChartVO> getChart1();

	public List<ChartVO> getChart2();

	public List<ChartVO> getChart3();

	public List<DbBaesongVO> getOrder4();

	public List<DbOrderCancelVO> getCancelOrder4();

	public List<BoardVO> getBoard4();

	public List<DbOnedayClassVO> getclass4();

	public int getWeekOrder();

	public int getWeekCancel();

	public int getWeekBoard();

	public int getWeekClass();

	public List<DbProductVO> getNewProduct();

	public List<DbProductVO> getNewProduct3();

	public void setBestReview(int idx, String bestReview);

	public EventVO getEventToday(EventVO vo);

	public void setEventInput(EventVO vo);

	public List<EventVO> getEventList(String mid);

	public List<ContactVO> getAllContactList(String part);

	public void getContactReply(ContactReplyVO vo);

	public void setAdminContactPartChange(int contactIdx);

	public void setAdminContactReplyUpdate(int reIdx,String reContent);

	public void setOrderCancelNo(int idx, String cancelStatus, String reason1, String reason2);

	public void setOrderCancelNo2(int cancelIdx, String orderStatus);

	public DbOrderCancelVO getOrderCancelOne(int idx);

	public List<DbOptionVO> getAllOptionList();

	public List<DbReviewVO> getReportReview();

	public void setReportreviewRestore(int idx);

}
