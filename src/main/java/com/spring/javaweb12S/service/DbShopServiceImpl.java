package com.spring.javaweb12S.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javaweb12S.dao.DbShopDAO;
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
import com.spring.javaweb12S.vo.WishVO;

@Service
public class DbShopServiceImpl implements DbShopService {

	@Autowired
	DbShopDAO dbShopDAO;

	@Override
	public List<DbProductVO> getCategoryMain() {
		return dbShopDAO.getCategoryMain();
	}

	@Override
	public void setCategoryMainInput(DbProductVO vo) {
		dbShopDAO.setCategoryMainInput(vo);
	}

	@Override
	public DbProductVO getCategoryMainOne(String categoryMainCode, String categoryMainName) {
		return dbShopDAO.getCategoryMainOne(categoryMainCode, categoryMainName);
	}

	@Override
	public List<DbProductVO> getCategoryMiddle() {
		return dbShopDAO.getCategoryMiddle();
	}

	@Override
	public DbProductVO getCategoryMiddleOne(DbProductVO vo) {
		return dbShopDAO.getCategoryMiddleOne(vo);
	}

	@Override
	public void setCategoryMiddleInput(DbProductVO vo) {
		dbShopDAO.setCategoryMiddleInput(vo);
	}

	@Override
	public List<DbProductVO> getCategorySub() {
		return dbShopDAO.getCategorySub();
	}

	@Override
	public List<DbProductVO> getCategoryMiddleName(String categoryMainCode) {
		return dbShopDAO.getCategoryMiddleName(categoryMainCode);
	}

	@Override
	public DbProductVO getCategorySubOne(DbProductVO vo) {
		return dbShopDAO.getCategorySubOne(vo);
	}

	@Override
	public void setCategorySubInput(DbProductVO vo) {
		dbShopDAO.setCategorySubInput(vo);
	}

	@Override
	public List<DbProductVO> getCategorySubName(String categoryMainCode, String categoryMiddleCode) {
		return dbShopDAO.getCategorySubName(categoryMainCode, categoryMiddleCode);
	}

	@Override
	public List<DbProductVO> getCategoryProductName(String categoryMainCode, String categoryMiddleCode) {
		return dbShopDAO.getCategoryProductName(categoryMainCode, categoryMiddleCode);
	}

	@Override
	public void imgCheckProductInput(MultipartFile file, MultipartHttpServletRequest mfile, DbProductVO vo) {
		
		// 먼저 기본(메인)그림파일은 'dbShop/product'폴더에 복사 시켜준다.
		try {
			String originalFilename = file.getOriginalFilename();
			if(originalFilename != null && originalFilename != "") {
				// 상품 메인사진을 업로드처리하기위해 중복파일명처리와 업로드처리
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
			  String saveFileName = sdf.format(date) + "_" + originalFilename;
				writeFile(file, saveFileName);	  // 메일 이미지를 서버에 업로드 시켜주는 메소드 호출
				vo.setFSName(saveFileName);				// 서버에 저장된 파일명을 vo에 set시켜준다.
			}
			else {
				return;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 추가 이미지 파일 등록
		try {
			List<MultipartFile> fileList  = mfile.getFiles("file2");
			String sFileNames = "";
			for(MultipartFile fileone : fileList) {
				String oFileName = fileone.getOriginalFilename();
				if(!oFileName.equals("")) {  // 들어온값이 null이면 ㄴㄴ
					String sFileName = saveFileName(oFileName);
					// 파일을 서버에 저장처리
					writeFile(fileone, sFileName);
					
					// 여러개의 파일명을 관리
					sFileNames += sFileName + "/";
				}
			}
			vo.setFSName2(sFileNames);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		

		// ckeditor 처리 부분
		//             0         1         2         3         4         5
		//             012345678901234567890123456789012345678901234567890
		// <img alt="" src="/javaweb12S/data/dbShop/211229124318_4.jpg"
		// <img alt="" src="/javawew12S/data/dbShop/product/211229124318_4.jpg"
		
		// ckeditor을 이용해서 담은 상품의 상세설명내역에 그림이 포함되어 있으면 그림을 dbShop/product폴더로 복사작업처리 시켜준다.
		String content = vo.getContent();
		if(content.indexOf("src=\"/") == -1) return;		// content박스의 내용중 그림이 없으면 돌아간다.
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		// String uploadPath = request.getRealPath("/resources/data/dbShop/");
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/");
		
		int position = 29;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0,nextImg.indexOf("\""));
			String copyFilePath = "";
			String oriFilePath = uploadPath + imgFile;	// 원본 그림이 들어있는 '경로명+파일명'
			
			copyFilePath = uploadPath + "product/" + imgFile;	// 복사가 될 '경로명+파일명'
			
			fileCopyCheck(oriFilePath, copyFilePath);	// 원본그림이 복사될 위치로 복사작업처리하는 메소드
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
		}
		// 이미지 복사작업이 종료되면 실제로 저장된 'dbShop/product'폴더명을 vo에 set시켜줘야 한다.
		vo.setContent(vo.getContent().replace("/data/dbShop/", "/data/dbShop/product/"));

		// 파일 복사작업이 모두 끝나면 vo에 담긴내용을 상품의 내역을 DB에 저장한다.
		// 먼저 productCode를 만들어주기 위해 지금까지 작업된 dbProduct테이블의 idx필드중 최대값을 읽어온다. 없으면 0으로 처리한다.
		int maxIdx = 1;
		DbProductVO maxVo = dbShopDAO.getProductMaxIdx();
		if(maxVo != null) {
			maxIdx = maxVo.getIdx() + 1;
			vo.setIdx(maxIdx);
		}
		vo.setProductCode(vo.getCategoryMainCode()+vo.getCategoryMiddleCode()+maxIdx);
		//System.out.println("vo : " + vo);
		dbShopDAO.setDbProductInput(vo);
	}
	
  // 실제 파일(dbShop폴더)을 'dbShop/product'폴더로 복사처리하는곳
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream  fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 메인 상품 이미지 서버에 저장하기
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/product/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public List<DbProductVO> getMiddleTitle() {
		return dbShopDAO.getMiddleTitle();
	}
	
	@Override
	public List<DbProductVO> getMainTitle() {
		return dbShopDAO.getMainTitle();
	}

	@Override
	public List<DbProductVO> getDbShopList(int startIndexNo, int pageSize, String part, String sort, String searchString) {
		return dbShopDAO.getDbShopList(startIndexNo,pageSize,part, sort,searchString);
	}

	@Override
	public DbProductVO getDbShopProduct(int idx) {
		return dbShopDAO.getDbShopProduct(idx);
	}

	@Override
	public DbProductVO getProductInfor(String productName) {
		return dbShopDAO.getProductInfor(productName);
	}

	@Override
	public List<DbOptionVO> getOptionList(int productIdx) {
		return dbShopDAO.getOptionList(productIdx);
	}

	@Override
	public void setDbOptionInput(DbOptionVO vo) {
		dbShopDAO.setDbOptionInput(vo);
	}

	@Override
	public int getOptionSame(int productIdx, String optionName) {
		return dbShopDAO.getOptionSame(productIdx, optionName);
	}

	@Override
	public void setOptionDelete(int idx) {
		dbShopDAO.setOptionDelete(idx);
	}

	@Override
	public List<DbOptionVO> getDbShopOption(int productIdx) {
		return dbShopDAO.getDbShopOption(productIdx);
	}

	@Override
	public void setCategoryMainDelete(String categoryMainCode) {
		dbShopDAO.setCategoryMainDelete(categoryMainCode);
	}

	@Override
	public void setCategoryMiddleDelete(String categoryMiddleCode) {
		dbShopDAO.setCategoryMiddleDelete(categoryMiddleCode);
	}

	@Override
	public DbProductVO getDbProductOne(String categorySubCode) {
		return dbShopDAO.getDbProductOne(categorySubCode);
	}

	@Override
	public DbCartVO getDbCartProductOptionSearch(String productName, String optionName, String mid) {
		return dbShopDAO.getDbCartProductOptionSearch(productName, optionName, mid);
	}

	@Override
	public void dbShopCartUpdate(DbCartVO vo) {
		dbShopDAO.dbShopCartUpdate(vo);
	}

	@Override
	public void dbShopCartInput(DbCartVO vo) {
		dbShopDAO.dbShopCartInput(vo);
	}

	@Override
	public List<DbCartVO> getDbCartList(String mid) {
		return dbShopDAO.getDbCartList(mid);
	}

	@Override
	public void dbCartDelete(int idx) {
		dbShopDAO.dbCartDelete(idx);
	}

	@Override
	public String dbCartNumChange(int idx, int num) {
		return dbShopDAO.dbCartNumChange(idx, num);
	}

	@Override
	public DbOrderVO getOrderMaxIdx() {
		return dbShopDAO.getOrderMaxIdx();
	}

	@Override
	public DbCartVO getCartIdx(int strIdx) {
		return dbShopDAO.getCartIdx(strIdx);
	}
	
	@Override
	public void setDbOrder(DbOrderVO vo) {
		dbShopDAO.setDbOrder(vo);
	}

	@Override
	public void setDbCartDeleteAll(int idx) {
		dbShopDAO.setDbCartDeleteAll(idx);
	}

	@Override
	public void setDbBaesong(DbBaesongVO baesongVO) {
		dbShopDAO.setDbBaesong(baesongVO);
	}

	@Override
	public List<DbBaesongVO> getMyOrderList(int startIndexNo, int pageSize, String mid,String startJumun, String endJumun, String conditionOrderStatus) {
		return dbShopDAO.getMyOrderList(startIndexNo, pageSize, mid,startJumun,endJumun,conditionOrderStatus);
	}

	
  @Override public int getMemberMainPart(String part, String mid) { return
  	dbShopDAO.getMemberMainPart(part, mid);
  }
  
  @Override public int getMemberMainPay(String mid) { 
  	return dbShopDAO.getMemberMainPay(mid); 
  }

   @Override public WishVO getwishCheck(int productIdx, String mid) {
  	 return dbShopDAO.getwishCheck(productIdx, mid); 
   }
  
  
  @Override public void setWishDBInput(WishVO wishVO) {
  dbShopDAO.setWishDBInput(wishVO); }
  
  @Override public void setWishDBDelete(int idx) {
  dbShopDAO.setWishDBDelete(idx); }

	@Override
	public List<WishVO> getWishList(String mid) {
		return dbShopDAO.getWishList(mid);
	}

	@Override
	public void productStatusChange(int idx, String productStatus) {
		dbShopDAO.productStatusChange(idx, productStatus);
	}

	@Override
	public void setOrderStatusChange(int idx, String status) {
		dbShopDAO.setOrderStatusChange(idx, status);
	}

	@Override
	public List<DbBaesongVO> getMemberMidSearch(String mid) {
		return dbShopDAO.getMemberMidSearch(mid);
	}

	@Override
	public List<DbOrderVO> getMemberMidSearchOrder(String mid) {
		return dbShopDAO.getMemberMidSearchOrder(mid);
	}

	@Override
	public List<WishVO> getThreeMonthExceedWishIdx(String mid) {
		return dbShopDAO.getThreeMonthExceedWishIdx(mid);
	}

	@Override
	public DbBaesongVO getOrderOne(String orderIdx, String mid) {
		return dbShopDAO.getOrderOne(orderIdx, mid);
	}

	@Override
	public List<DbBaesongVO> getOrders(String orderIdx, String mid) {
		return dbShopDAO.getOrders(orderIdx, mid);
	}

	@Override
	public DbOrderVO getOrdersOne( int idx) {
		return dbShopDAO.getOrdersOne(idx);
	}

	@Override
	public void setOrderCancel(DbOrderCancelVO vo) {
		dbShopDAO.setOrderCancel(vo);
	}

	@Override
	public List<DbOrderCancelVO> getAdminCancelOrder() {
		return dbShopDAO.getAdminCancelOrder();
	}

	@Override
	public void setCancelStatusChange(int idx, String status) {
		dbShopDAO.setCancelStatusChange(idx, status);
	}

	@Override
	public List<DbProductVO> getNewProductName() {
		return dbShopDAO.getNewProductName();
	}

	@Override
	public void setAdminShippingMinus(String optionName, int productIdx, int optionNum) {
		dbShopDAO.setAdminShippingMinus(optionName,productIdx, optionNum);
	}

	@Override
	public void setGetPoint(String orderIdx, int point, String mid, String pointMemo) {
		dbShopDAO.setGetPoint(orderIdx, point,mid,pointMemo);
	}

	@Override
	public void setMemberPlusPoint(String mid, int point) {
		dbShopDAO.setMemberPlusPoint(mid,point);
	}

	@Override
	public void setAdminShippingPlus(int productIdx, String optionName, String optionNum) {
		dbShopDAO.setAdminShippingPlus(productIdx, optionName, optionNum);
	}

	@Override
	public List<DbPointVO> getDbPoint(String mid) {
		return dbShopDAO.getDbPoint(mid);
	}

	@Override
	public int setReviewInput(DbReviewVO vo, MultipartHttpServletRequest mfile) {
		int res = 0;
		try {
			List<MultipartFile> fileList = mfile.getFiles("file");
			String sFileNames = "";
			for(MultipartFile file : fileList) {
				String oFileName = file.getOriginalFilename();
				if(!oFileName.equals("")) {  // 들어온값이 null이면 ㄴㄴ
					String sFileName = saveFileName(oFileName);
					// 파일을 서버에 저장처리...
					writeFile2(file, sFileName);
					
					// 여러개의 파일명을 관리...
					sFileNames += sFileName + "/";
				}
			}
			vo.setFSName(sFileNames);
			
			res = dbShopDAO.setReviewInput(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	private void writeFile2(MultipartFile file, String sFileName) throws IOException {
		byte[] data = file.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/review/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		fos.write(data);
		fos.close();
	}

	// 화일명 중복방지를 위한 저장파일명 만들기
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		
		return fileName;
	}

	@Override
	public void setOrderReviewChange(int idx,String reviewStatus) {
		dbShopDAO.setOrderReviewChange(idx,reviewStatus);
	}

	@Override
	public List<DbReviewVO> getProductReview(int idx) {
		return dbShopDAO.getProductReview(idx);
	}

	@Override
	public List<DbReviewVO> getUserReivew(String mid) {
		return dbShopDAO.getUserReivew(mid);
	}

	@Override
	public int productModifyOk(MultipartFile file, DbProductVO vo) {
		
		int res = 0;
		try {
			String oFileName = file.getOriginalFilename();
			if(!oFileName.equals("")) {
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				
				writeFile(file, saveFileName);
				
				vo.setFSName(saveFileName);
				// 기존거 불러와서	새로 온 것과 다르면 기존에 존재하는 파일은 삭제처리한다.
				DbProductVO existVO = dbShopDAO.getDbShopProduct(vo.getIdx());
				System.out.println("existVO : " + existVO);
				if(!vo.getFSName().equals(existVO.getFSName())) {
					HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
					String realPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/product/");
					File dfile = new File(realPath + existVO.getFSName());
					dfile.delete();
				}
				// 기존에 존재하는 파일을 지우고, 새로 업로드시킨 파일명을 set시켜준다.
				vo.setFSName(saveFileName);
			}
			dbShopDAO.productModifyOk(vo);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return res;
	}

	// 원데이클래스 예약 저장, 큐알코드 생성
	@Override
	public String onedayClassInput(int idx, String mid, String className, String store, String wDate, int memberNum, String classTemp, String realPath) {
	// qr코드명은 "" 만들어준다.
			String qrCodeName = "";
			
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				UUID uid = UUID.randomUUID();
				String strUid = uid.toString().substring(0,4);
				qrCodeName = sdf.format(new Date()) + "_" + strUid;
				
				File file = new File(realPath);
				if(!file.exists()) file.mkdirs();
				
				String qrTemp = new String(classTemp.getBytes("UTF-8"), "ISO-8859-1");
				
				// qr코드 만들기
				int qrCodeColor = 0xFF000000; 		// qr코드 전경색(글자색) - 검정
				int qrCodeBackColor = 0xFFFFFFFF; // qr코드 배경색(바탕색) - 흰색
				
				QRCodeWriter qrCodeWriter = new QRCodeWriter();	// QR 코드 객체 생성
				BitMatrix bitMatrix = qrCodeWriter.encode(qrTemp, BarcodeFormat.QR_CODE, 200, 200);
				
				MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
				BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
				
				// ImageIO객체를 이용하면 byte배열단위로 변환없이 바로 파일을 write 시킬 수 있다.
				ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
				
				// 생성된 QR코드의 정보를 DB에 저장한다.
				String QrCodeName = qrCodeName + ".png";
				dbShopDAO.setOnedayClassInput(idx, QrCodeName);
			} catch (IOException e) {
				e.printStackTrace();
			} catch (WriterException e) {
				e.printStackTrace();
			}
			return "";
	}

	@Override
	public List<DbOnedayClassVO> getMyOnedayClass(String mid) {
		return dbShopDAO.getMyOnedayClass(mid);
	}

	@Override
	public List<MemberVO> getClassValidMember() {
		return dbShopDAO.getClassValidMember();
	}

	@Override
	public DbOnedayClassVO getOnedayClassOne(int idx) {
		return dbShopDAO.getOnedayClassOne(idx);
	}

	@Override
	public List<DbReviewVO> getAllReviewList() {
		return dbShopDAO.getAllReviewList();
	}

	@Override
	public void setOptionUpdate(int idx, String optionName, int optionPrice, int optionStock) {
		dbShopDAO.setOptionUpdate(idx, optionName,optionPrice,optionStock);
	}

	@Override
	public void setOnedayClassApplication(String mid, String className, String store, String wDate, int memberNum) {
		dbShopDAO.setOnedayClassApplication(mid, className,store, wDate,memberNum);
	}

	@Override
	public void setMemberMinusPoint(String mid, int usingPoint) {
		dbShopDAO.setMemberMinusPoint( mid, usingPoint);
	}

	@Override
	public void setUsingPoint(String mid, int point, String orderIdx, String pointMemo) {
		dbShopDAO.setUsingPoint(mid, point, orderIdx, pointMemo);
	}

	@Override
	public void setReviewDelete(int idx) {
		dbShopDAO.setReviewDelete(idx);
	}

	@Override
	public void setEventInput(EventVO vo) {
		dbShopDAO.setEventInput(vo);
	}




	 
	 
	
}
