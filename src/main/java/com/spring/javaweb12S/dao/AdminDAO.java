package com.spring.javaweb12S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb12S.vo.BoardVO;
import com.spring.javaweb12S.vo.ChartVO;
import com.spring.javaweb12S.vo.ContactReplyVO;
import com.spring.javaweb12S.vo.ContactVO;
import com.spring.javaweb12S.vo.DbBaesongVO;
import com.spring.javaweb12S.vo.DbOnedayClassVO;
import com.spring.javaweb12S.vo.DbOptionVO;
import com.spring.javaweb12S.vo.DbOrderCancelVO;
import com.spring.javaweb12S.vo.DbOrderVO;
import com.spring.javaweb12S.vo.DbProductVO;
import com.spring.javaweb12S.vo.DbReviewVO;
import com.spring.javaweb12S.vo.EventVO;
import com.spring.javaweb12S.vo.KakaoAddressVO;
	
public interface AdminDAO {

	public KakaoAddressVO getKakaoAddressName(String address);

	public void setKakaoAddressDelete(String address);

	public void setKakaoAddressInput(@Param("store_name")String store_name, @Param("lat")double lat,@Param("lng") double lng,@Param("detail_address") String detail_address,@Param("rode_address")String rode_address,@Param("store_tel")String store_tel);

	public List<KakaoAddressVO> getKakaoAddressList();

	public void setReviewDelete(@Param("idx") int idx);

	public void setBoardDelete(@Param("idx") int idx);

	public void setNoticeDelete(@Param("idx") int idx);

	public List<DbOnedayClassVO> getAllOnedayClassList();

	public void setOnedayClassDelete(@Param("idx") int idx);

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

	public void setBestReview(@Param("idx") int idx, @Param("bestReview") String bestReview);

	public EventVO getEventToday(@Param("vo") EventVO vo);

	public void setEventInput(@Param("vo") EventVO vo);

	public List<EventVO> getEventList(@Param("mid") String mid);

	public int totRecCntAdmin(String part);

	public List<ContactVO> getAllContactList(@Param("part")String part);

	public void getContactReply(@Param("vo") ContactReplyVO vo);

	public void setAdminContactPartChange(@Param("contactIdx") int contactIdx);

	public void setAdminContactReplyUpdate(@Param("reIdx")int reIdx, @Param("reContent") String reContent);

	public void setOrderCancelNo(@Param("idx")int idx, @Param("cancelStatus")String cancelStatus, @Param("reason1")String reason1,@Param("reason2") String reason2);

	public void setOrderCancelNo2(@Param("cancelIdx")int cancelIdx, @Param("orderStatus")String orderStatus);

	public DbOrderCancelVO getOrderCancelOne(@Param("idx") int idx);

	public List<DbOptionVO> getAllOptionList();

	public List<DbReviewVO> getReportReview();

	public void setReportreviewRestore(@Param("idx") int idx);
	
	

}