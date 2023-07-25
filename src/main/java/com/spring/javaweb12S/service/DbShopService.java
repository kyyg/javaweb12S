package com.spring.javaweb12S.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb12S.vo.CategoryMainVO;
import com.spring.javaweb12S.vo.DbBaesongVO;
import com.spring.javaweb12S.vo.DbCartVO;
import com.spring.javaweb12S.vo.DbOnedayClassVO;
import com.spring.javaweb12S.vo.DbOptionVO;
import com.spring.javaweb12S.vo.DbOrderCancelVO;
import com.spring.javaweb12S.vo.DbOrderVO;
import com.spring.javaweb12S.vo.DbPointVO;
import com.spring.javaweb12S.vo.DbProductVO;
import com.spring.javaweb12S.vo.DbReviewVO;
import com.spring.javaweb12S.vo.DbShippingListVO;
import com.spring.javaweb12S.vo.EventVO;
import com.spring.javaweb12S.vo.MemberVO;
import com.spring.javaweb12S.vo.PointSaveVO;
import com.spring.javaweb12S.vo.ReportReviewVO;
import com.spring.javaweb12S.vo.WishVO;

public interface DbShopService {

	public List<DbProductVO> getCategoryMain();

	public void setCategoryMainInput(DbProductVO vo);

	public DbProductVO getCategoryMainOne(String categoryMainCode, String categoryMainName);

	public List<DbProductVO> getCategoryMiddle();

	public DbProductVO getCategoryMiddleOne(DbProductVO vo);

	public void setCategoryMiddleInput(DbProductVO vo);

	public List<DbProductVO> getCategorySub();

	public List<DbProductVO> getCategoryMiddleName(String categoryMainCode);

	public DbProductVO getCategorySubOne(DbProductVO vo);

	public void setCategorySubInput(DbProductVO vo);

	public List<DbProductVO> getCategorySubName(String categoryMainCode, String categoryMiddleCode);

	public List<DbProductVO> getCategoryProductName(String categoryMainCode, String categoryMiddleCode);

	public void imgCheckProductInput(MultipartFile file,MultipartHttpServletRequest file2, DbProductVO vo);

	public List<DbProductVO> getMiddleTitle();
	
	public List<DbProductVO> getMainTitle();

	public List<DbProductVO> getDbShopList(int startIndexNo, int pageSize, String part, String sort, String searchString);

	public DbProductVO getDbShopProduct(int idx);

	public DbProductVO getProductInfor(String productName);

	public List<DbOptionVO> getOptionList(int productIdx);

	public void setDbOptionInput(DbOptionVO vo);

	public int getOptionSame(int productIdx, String optionName);

	public void setOptionDelete(int idx);

	public List<DbOptionVO> getDbShopOption(int productIdx);

	public void setCategoryMainDelete(String categoryMainCode);

	public void setCategoryMiddleDelete(String categoryMiddleCode);

	public DbProductVO getDbProductOne(String categorySubCode);

	public DbCartVO getDbCartProductOptionSearch(String productName, String optionName, String mid);

	public void dbShopCartUpdate(DbCartVO vo);

	public void dbShopCartInput(DbCartVO vo);

	public List<DbCartVO> getDbCartList(String mid);

	public void dbCartDelete(int idx);

	public String dbCartNumChange(int idx, int num);

	public DbOrderVO getOrderMaxIdx();

	public DbCartVO getCartIdx(int strIdx);
	
	public void setDbOrder(DbOrderVO vo);

	public void setDbCartDeleteAll(int idx);

	public void setDbBaesong(DbBaesongVO baesongVO);

	public List<DbBaesongVO> getMyOrderList(int startIndexNo, int pageSize, String mid, String startJumun, String endJumun, String conditionOrderStatus);

  public int getMemberMainPart(String part, String mid);
  
  public int getMemberMainPay(String mid);

  public WishVO getwishCheck(int productIdx, String mid);
	
  public void setWishDBInput(WishVO wishVO);

	public void setWishDBDelete(int idx);

	public List<WishVO> getWishList(String mid);

	public void productStatusChange(int idx, String productStatus);

	public void setOrderStatusChange(int idx, String status);

	public List<DbBaesongVO> getMemberMidSearch(String mid);

	public List<DbOrderVO> getMemberMidSearchOrder(String mid);

	public List<WishVO> getThreeMonthExceedWishIdx(String mid);

	public DbBaesongVO getOrderOne(String orderIdx, String mid);

	public List<DbBaesongVO> getOrders(String orderIdx, String mid);

	public DbOrderVO getOrdersOne(int idx);

	public void setOrderCancel(DbOrderCancelVO vo);

	public List<DbOrderCancelVO> getAdminCancelOrder();

	public void setCancelStatusChange(int idx, String status);

	public List<DbProductVO> getNewProductName();

	public void setAdminShippingMinus(String optionName, int productIdx, int optionNum);

	public void setGetPoint(String productIdx, int point, String mid, String pointMemo);

	public void setMemberPlusPoint(String mid, int point);

	public void setAdminShippingPlus(int productIdx, String optionName, String optionNum);

	public List<DbPointVO> getDbPoint(String mid);

	public int setReviewInput(DbReviewVO vo, MultipartHttpServletRequest file);

	public void setOrderReviewChange(int idx, String reviewStatus);

	public List<DbReviewVO> getProductReview(int idx);

	public List<DbReviewVO> getUserReivew(String mid);

	public int productModifyOk(MultipartFile file, DbProductVO vo);

	public String onedayClassInput(int idx, String mid, String store, String WDate, String className, int memberNum, String classTemp, String realPath);

	public List<DbOnedayClassVO> getMyOnedayClass(String mid);

	public List<MemberVO> getClassValidMember();

	public DbOnedayClassVO getOnedayClassOne(int idx);

	public List<DbReviewVO> getAllReviewList();

	public void setOptionUpdate(int idx, String optionName, int optionPrice, int optionStock);

	public void setOnedayClassApplication(String mid, String className, String store, String wDate, int memberNum);

	public void setMemberMinusPoint(String mid, int usingPoint);

	public void setUsingPoint(String mid, int point, String orderIdx, String pointMemo);

	public void setReviewDelete(int idx);

	public void setEventInput(EventVO vo);

	public int getEventNum(String mid);

	public PointSaveVO getPointSave(String mid, String pointMemo);

	public void setPointSave(String mid, String pointMemo, int point);

	public void setOptionStockPlus(int productIdx, String optionName, int optionNum);

	public DbOrderCancelVO getOrderCancelsOne(int idx);

	public CategoryMainVO getProductContentCate(String categoryMainCode);

	public DbReviewVO getReviewOne(int idx);

	public void setReportReview(ReportReviewVO vo);

	public void setReportReviewNum(int idx);

	public ReportReviewVO getExistReportReview(int reviewIdx, String mid);

	public List<DbShippingListVO> getUserShippingList(String mid);

	public void setShippingList(DbShippingListVO vo);




	 
	 
}
