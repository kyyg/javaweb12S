package com.spring.javaweb12S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

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
import com.spring.javaweb12S.vo.EventVO;
import com.spring.javaweb12S.vo.MemberVO;
import com.spring.javaweb12S.vo.PointSaveVO;
import com.spring.javaweb12S.vo.ReportReviewVO;
import com.spring.javaweb12S.vo.WishVO;

public interface DbShopDAO {

	public List<DbProductVO> getCategoryMain();

	public void setCategoryMainInput(@Param("vo") DbProductVO vo);

	public DbProductVO getCategoryMainOne(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMainName")  String categoryMainName);

	public List<DbProductVO> getCategoryMiddle();

	public DbProductVO getCategoryMiddleOne(@Param("vo") DbProductVO vo);

	public void setCategoryMiddleInput(@Param("vo") DbProductVO vo);

	public List<DbProductVO> getCategorySub();

	public List<DbProductVO> getCategoryMiddleName(@Param("categoryMainCode") String categoryMainCode);

	public DbProductVO getCategorySubOne(@Param("vo") DbProductVO vo);

	public void setCategorySubInput(@Param("vo") DbProductVO vo);

	public List<DbProductVO> getCategorySubName(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMiddleCode") String categoryMiddleCode);

	public List<DbProductVO> getCategoryProductName(@Param("categoryMainCode") String categoryMainCode, @Param("categoryMiddleCode") String categoryMiddleCode);

	public DbProductVO getProductMaxIdx();

	public void setDbProductInput(@Param("vo") DbProductVO vo);

	public List<DbProductVO> getMiddleTitle();
	
	public List<DbProductVO> getMainTitle();

	public List<DbProductVO> getDbShopList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part,@Param("sort") String sort,@Param("searchString") String searchString);

	public DbProductVO getDbShopProduct(@Param("idx") int idx);

	public DbProductVO getProductInfor(@Param("productName") String productName);

	public List<DbOptionVO> getOptionList(@Param("productIdx") int productIdx);

	public void setDbOptionInput(@Param("vo") DbOptionVO vo);

	public int getOptionSame(@Param("productIdx") int productIdx, @Param("optionName") String optionName);

	public void setOptionDelete(@Param("idx") int idx);

	public List<DbOptionVO> getDbShopOption(@Param("productIdx") int productIdx);

	public void setCategoryMainDelete(@Param("categoryMainCode") String categoryMainCode);

	public void setCategoryMiddleDelete(@Param("categoryMiddleCode") String categoryMiddleCode);

	public DbProductVO getDbProductOne(@Param("categorySubCode") String categorySubCode);

	public DbCartVO getDbCartProductOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName, @Param("mid") String mid);

	public void dbShopCartUpdate(@Param("vo") DbCartVO vo);

	public void dbShopCartInput(@Param("vo") DbCartVO vo);

	public List<DbCartVO> getDbCartList(@Param("mid") String mid);

	public void dbCartDelete(@Param("idx") int idx);

	public String dbCartNumChange(@Param("idx")int idx, @Param("num")int num);

	public DbOrderVO getOrderMaxIdx();

	public DbCartVO getCartIdx(@Param("strIdx") int strIdx);
	
	public void setDbOrder(@Param("vo") DbOrderVO vo);

	public void setDbCartDeleteAll(@Param("idx") int idx);

	public void setDbBaesong(@Param("baesongVO") DbBaesongVO baesongVO);

	public List<DbBaesongVO> getMyOrderList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("mid") String mid, @Param("startJumun")String startJumun,@Param("endJumun") String endJumun,@Param("conditionOrderStatus") String conditionOrderStatus);

	public int totRecCnt(String mid);

	public int getMemberMainPart(@Param("part") String part, @Param("mid") String mid);

	public int getMemberMainPay(@Param("mid") String mid);

	public int totRecCnt(@Param("productPart") String productPart, @Param("sort") String sort);

	public int totRecCnt2(@Param("productPart") String productPart);

	public WishVO getwishCheck(@Param("productIdx") int productIdx, @Param("mid") String mid);

	public void setWishDBInput(@Param("wishVO") WishVO wishVO);

	public void setWishDBDelete(@Param("idx") int idx);

	public List<WishVO> getWishList(@Param("mid") String mid);

	public void productStatusChange(@Param("idx") int idx, @Param("productStatus") String productStatus);

	public void setOrderStatusChange(@Param("idx") int idx, @Param("status") String status);

	public List<DbBaesongVO> getMemberMidSearch(@Param("mid") String mid);

	public List<DbOrderVO> getMemberMidSearchOrder(@Param("mid") String mid);

	public List<WishVO> getThreeMonthExceedWishIdx(@Param("mid") String mid);

	public DbBaesongVO getOrderOne(@Param("orderIdx") String orderIdx, @Param("mid")String mid);

	public List<DbBaesongVO> getOrders(@Param("orderIdx")String orderIdx,@Param("mid") String mid);

	public DbOrderVO getOrdersOne(@Param("idx") int idx);

	public void setOrderCancel(@Param("vo") DbOrderCancelVO vo);

	public List<DbOrderCancelVO> getAdminCancelOrder();

	public void setCancelStatusChange(@Param("idx") int idx, @Param("status") String status);

	public List<DbProductVO> getNewProductName();

	public void setAdminShippingMinus(@Param("optionName")String optionName, @Param("productIdx") int productIdx, @Param("optionNum") int optionNum);

	public void setGetPoint(@Param("orderIdx")String orderIdx, @Param("point")int point, @Param("mid")String mid, @Param("pointMemo")String pointMemo);

	public void setMemberPlusPoint(@Param("mid") String mid, @Param("point") int point);

	public void setAdminShippingPlus(@Param("productIdx") int productIdx, @Param("optionName") String optionName, @Param("optionNum") String optionNum);

	public List<DbPointVO> getDbPoint(@Param("mid") String mid);

	public int setReviewInput(@Param("vo") DbReviewVO vo);

	public void setOrderReviewChange(@Param("idx") int idx, @Param("reviewStatus") String reviewStatus);

	public List<DbReviewVO> getProductReview(@Param("idx")  int idx);

	public int totRecCnt3(@Param("mid") String mid,@Param("proudctIdx") int proudctIdx);

	public List<DbReviewVO> getUserReivew(@Param("mid") String mid);

	public int productModifyOk(@Param("vo")DbProductVO vo);

	public void setOnedayClassInput(@Param("idx") int idx, @Param("QrCodeName") String QrCodeName);

	public List<DbOnedayClassVO> getMyOnedayClass(@Param("mid") String mid);

	public List<MemberVO> getClassValidMember();

	public DbOnedayClassVO getOnedayClassOne(@Param("idx") int idx);

	public List<DbReviewVO> getAllReviewList();

	public void setOptionUpdate(@Param("idx")int idx, @Param("optionName")String optionName, @Param("optionPrice")int optionPrice, @Param("optionStock")int optionStock);

	public void setOnedayClassApplication(@Param("mid")String mid, @Param("className")String className, @Param("store")String store, @Param("wDate")String wDate, @Param("memberNum")int memberNum);

	public void setMemberMinusPoint(@Param("mid") String mid, @Param("usingPoint") int usingPoint);

	public void setUsingPoint(@Param("mid") String mid, @Param("point") int point, @Param("orderIdx") String orderIdx, @Param("pointMemo") String pointMemo);

	public void setReviewDelete(@Param("idx") int idx);

	public void setEventInput(@Param("vo") EventVO vo);

	public int getEventNum(@Param("mid") String mid);

	public PointSaveVO getPointSave(@Param("mid") String mid, @Param("pointMemo")String pointMemo);

	public void setPointSave(@Param("mid") String mid, @Param("pointMemo") String pointMemo, @Param("point") int point);

	public void setOptionStockPlus(@Param("productIdx") int productIdx, @Param("optionName") String optionName,@Param("optionNum") int optionNum);

	public DbOrderCancelVO getOrderCancelsOne(@Param("idx") int idx);

	public CategoryMainVO getProductContentCate(@Param("categoryMainCode") String categoryMainCode);

	public DbReviewVO getReviewOne(@Param("idx") int idx);

	public void setReportReview(@Param("vo") ReportReviewVO vo);

	public void setReportReviewNum(@Param("idx") int idx);

	public ReportReviewVO getExistReportReview(@Param("reviewIdx")int reviewIdx,@Param("mid") String mid);


	


	
	

}
