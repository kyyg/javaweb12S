package com.spring.javaweb12S;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb12S.common.JavawebProvide;
import com.spring.javaweb12S.dao.DbShopDAO;
import com.spring.javaweb12S.pagination.PageProcess;
import com.spring.javaweb12S.pagination.PageVO;
import com.spring.javaweb12S.service.BoardService;
import com.spring.javaweb12S.service.DbShopService;
import com.spring.javaweb12S.service.MemberService;
import com.spring.javaweb12S.vo.CategoryMainVO;
import com.spring.javaweb12S.vo.DbBaesongVO;
import com.spring.javaweb12S.vo.DbCartVO;
import com.spring.javaweb12S.vo.DbOnedayClassVO;
import com.spring.javaweb12S.vo.DbOptionVO;
import com.spring.javaweb12S.vo.DbOrderCancelVO;
import com.spring.javaweb12S.vo.DbOrderVO;
import com.spring.javaweb12S.vo.DbPayMentVO;
import com.spring.javaweb12S.vo.DbPointVO;
import com.spring.javaweb12S.vo.DbProductVO;
import com.spring.javaweb12S.vo.DbReviewVO;
import com.spring.javaweb12S.vo.MemberVO;
import com.spring.javaweb12S.vo.ReportReviewVO;
import com.spring.javaweb12S.vo.WishVO;

@Controller
@RequestMapping("/dbShop")
public class DbShopController {

	@Autowired
	DbShopService dbShopService;

	@Autowired
	PageProcess pageProcess;

	@Autowired
	MemberService memberService;

	@Autowired
	BoardService boardService;

	/* 아래로 관리자에서의 처리부분들 */
	
	// 관리자 상품 옵션 새창보기
	@RequestMapping(value = "/eventNew", method = RequestMethod.GET)
	public String eventNewGet() {
		return "dbShop/eventNew";
	}
	

	// 대/중 분류 폼 보기
	@RequestMapping(value = "/dbCategory", method = RequestMethod.GET)
	public String dbCategoryGet(Model model) {
		List<DbProductVO> mainVOS = dbShopService.getCategoryMain(); // 대분류리스트
		List<DbProductVO> middleVOS = dbShopService.getCategoryMiddle();// 중분류리스트
		model.addAttribute("mainVOS", mainVOS);
		model.addAttribute("middleVOS", middleVOS);

		return "admin/dbShop/dbCategory";
	}

	// 대분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categoryMainInput", method = RequestMethod.POST)
	public String categoryMainInputPost(DbProductVO vo) {
		// 기존에 같은 대분류명이 있는지 체크?
		DbProductVO productVO = dbShopService.getCategoryMainOne(vo.getCategoryMainCode(), vo.getCategoryMainName());

		if (productVO != null)
			return "0";
		dbShopService.setCategoryMainInput(vo); // 대분류항목 저장
		return "1";
	}

	// 대분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categoryMainDelete", method = RequestMethod.POST)
	public String categoryMainDeleteGet(DbProductVO vo) {
		// 현재 대분류가 속해있는 하위항목이 있는지를 체크한다.
		DbProductVO middleVO = dbShopService.getCategoryMiddleOne(vo);

		if (middleVO != null)
			return "0";
		dbShopService.setCategoryMainDelete(vo.getCategoryMainCode()); // 대분류항목 삭제

		return "1";
	}

	// 중분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleInput", method = RequestMethod.POST)
	public String categoryMiddleInputPost(DbProductVO vo) {
		// 기존에 같은 중분류명이 있는지 체크?
		DbProductVO productVO = dbShopService.getCategoryMiddleOne(vo);

		if (productVO != null)
			return "0";
		dbShopService.setCategoryMiddleInput(vo); // 중분류항목 저장
		return "1";
	}

	// 대분류 선택시 중분류명 가져오기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleName", method = RequestMethod.POST)
	public List<DbProductVO> categoryMiddleNamePost(String categoryMainCode) {
//		List<DbProductVO> mainVOS = dbShopService.getCategoryMiddleName(categoryMainCode);
//		return mainVOS;
		return dbShopService.getCategoryMiddleName(categoryMainCode);
	}

	// 중분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/categoryMiddleDelete", method = RequestMethod.POST)
	public String categoryMiddleDeleteGet(DbProductVO vo) {
		// 현재 중분류가 속해있는 하위항목이 있는지를 체크한다.
		DbProductVO subVO = dbShopService.getCategorySubOne(vo);

		if (subVO != null)
			return "0";
		dbShopService.setCategoryMiddleDelete(vo.getCategoryMiddleCode()); // 소분류항목 삭제

		return "1";
	}

	// 상품 등록을 위한 등록폼 보여주기
	@RequestMapping(value = "/dbProduct", method = RequestMethod.GET)
	public String dbProducGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain();
		model.addAttribute("mainVos", mainVos);
		return "admin/dbShop/dbProduct";
	}

	// 상품명(모델명) 가져오기
	@ResponseBody
	@RequestMapping(value = "/categoryProductName", method = RequestMethod.POST)
	public List<DbProductVO> categoryProductNamePost(String categoryMainCode, String categoryMiddleCode) {
		return dbShopService.getCategoryProductName(categoryMainCode, categoryMiddleCode);
	}

	// 관리자 상품등록시에 ckeditor에 그림을 올린다면 dbShop폴더에 저장되고, 저장된 파일을 브라우저 textarea상자에 보여준다.
	@ResponseBody
	@RequestMapping("/imageUpload")
	public void imageUploadGet(HttpServletRequest request, HttpServletResponse response,
			@RequestParam MultipartFile upload) throws Exception {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");

		String originalFilename = upload.getOriginalFilename();

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		originalFilename = sdf.format(date) + "_" + originalFilename;

		byte[] bytes = upload.getBytes();

		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/dbShop/");
		OutputStream outStr = new FileOutputStream(new File(uploadPath + originalFilename));
		outStr.write(bytes);

		PrintWriter out = response.getWriter();
		String fileUrl = request.getContextPath() + "/data/dbShop/" + originalFilename;
		out.println("{\"originalFilename\":\"" + originalFilename + "\",\"uploaded\":1,\"url\":\"" + fileUrl + "\"}");

		out.flush();
		outStr.close();
	}

	// 상품 등록을 위한 등록시키기
	@RequestMapping(value = "/dbProduct", method = RequestMethod.POST)
	public String dbProducPost(MultipartFile file, MultipartHttpServletRequest file2, DbProductVO vo) {
		// 이미지파일 업로드시에 ckeditor폴더에서 product폴더로 복사작업처리....(dbShop폴더에서 'dbShop/product'로)
		dbShopService.imgCheckProductInput(file,file2, vo);
		//System.out.println("file : " + file + "/ file2 : " + file2);
		return "redirect:/message/dbProductInputOk";
	}
	
	// 상품 수정 폼
	@RequestMapping(value = "/productModify", method = RequestMethod.GET)
	public String productModifyGet(Model model, int idx) {

		// 수정창으로 이동시에는 먼저 원본파일에 그림파일이 있다면, 현재폴더(notice)의 그림파일들을 ckeditor폴더로 복사시켜둔다.
		DbProductVO vo = dbShopService.getDbShopProduct(idx);

		model.addAttribute("vo", vo);
		return "admin/dbShop/productModify";
	}
	
	//상품 수정 하기
	@RequestMapping(value = "/productModify", method = RequestMethod.POST)
	public String productModifyPost(DbProductVO vo, MultipartFile file) {
		int res = dbShopService.productModifyOk(file, vo);
		if(res==1) {
			return "redirect:/message/productModifyOk";
		}
		return "redirect:/message/productModifyNo";
	}
	
	
	// 등록된 상품 모두 보여주기(관리자화면에서 보여주는 처리부분이다.) - 상품의 대분류도 함께 출력시켜준다.
	@RequestMapping(value = "/dbShopList", method = RequestMethod.GET)
	public String dbShopListGet(Model model,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "20", required = false) int pageSize,
			@RequestParam(name = "sort", defaultValue = "신상품순", required = false) String sort,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString) {

		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", part, searchString);

		// 대/중분류명을 가져온다.
		List<DbProductVO> middleTitleVOS = dbShopService.getMiddleTitle();
		List<DbProductVO> mainTitleVOS = dbShopService.getMainTitle();
		model.addAttribute("mainTitleVOS", mainTitleVOS);
		model.addAttribute("middleTitleVOS", middleTitleVOS);
		model.addAttribute("part", part);
		model.addAttribute("sort", sort);

		// 전체 상품리스트 가져오기
		List<DbProductVO> productVOS = dbShopService.getDbShopList(pageVO.getStartIndexNo(), pageSize, part, sort,
				searchString);
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchString", searchString);
		model.addAttribute("vosSize", productVOS.size());

		return "admin/dbShop/dbShopList";
	}

	// 관리자에서 진열된 상품을 클릭하였을경우에 해당 상품의 상세내역 보여주기
	@RequestMapping(value = "/dbShopContent", method = RequestMethod.GET)
	public String dbShopContentGet(Model model, int idx) {
		DbProductVO productVO = dbShopService.getDbShopProduct(idx); // 1건의 상품 정보를 불러온다.
		List<DbOptionVO> optionVOS = dbShopService.getDbShopOption(idx); // 해당 상품의 모든 옵션 정보를 가져온다.
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);

		return "admin/dbShop/dbShopContent";
	}

	// 옵션 등록창 보여주기(관리자 왼쪽메뉴에서 선택시 처리)
	@RequestMapping(value = "/dbOption", method = RequestMethod.GET)
	public String dbOptionGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain();
		model.addAttribute("mainVos", mainVos);

		return "admin/dbShop/dbOption";
	}

	// 옵션 등록창 보여주기(관리자 상품상세보기에서 호출시 처리)
	@RequestMapping(value = "/dbOption2", method = RequestMethod.GET)
	public String dbOption2Get(Model model, String productName) {
		DbProductVO vo = dbShopService.getProductInfor(productName);
		List<DbOptionVO> optionVOS = dbShopService.getOptionList(vo.getIdx());
		model.addAttribute("vo", vo);
		model.addAttribute("optionVOS", optionVOS);

		return "admin/dbShop/dbOption2";
	}

	// 옵션 등록후 다시 옵션 등록창 보여주기(옵션을 1개씩 등록할때는 사용하면 편리하나, 여러개를 동적폼으로 만들었을때는 aJax를 사용하지
	// 못한다.
	@ResponseBody
	@RequestMapping(value = "/dbOption2Input", method = RequestMethod.POST)
	public String dbOption2InputGet(DbOptionVO vo) {
		dbShopService.setDbOptionInput(vo);
		return "";
	}

	// 옵션 등록창에서, 상품을 선택하면 선택된 상품의 상세설명을 가져와서 뿌리기
	@ResponseBody
	@RequestMapping(value = "/getProductInfor", method = RequestMethod.POST)
	public DbProductVO getProductInforPost(String productName) {
		return dbShopService.getProductInfor(productName);
	}

	// 옵션등록창에서 '옵셔보기'버튼클릭시에 해당 제품의 모든 옵션을 보여주기
	@ResponseBody
	@RequestMapping(value = "/getOptionList", method = RequestMethod.POST)
	public List<DbOptionVO> getOptionListPost(int productIdx) {
		return dbShopService.getOptionList(productIdx);
	}

	// 옵션 기록사항들을 등록하기
	@RequestMapping(value = "/dbOption", method = RequestMethod.POST)
	public String dbOptionPost(Model model, DbOptionVO vo, String[] optionName, int[] optionPrice, int[] optionStock,
			@RequestParam(name = "flag", defaultValue = "", required = false) String flag) {

		for (int i = 0; i < optionName.length; i++) {

			int optionCnt = dbShopService.getOptionSame(vo.getProductIdx(), optionName[i]);
			if (optionCnt != 0)
				continue;

			// 동일한 옵션이 없으면 vo에 set시킨후 옵션테이블에 등록시킨다.
			vo.setProductIdx(vo.getProductIdx());
			vo.setOptionName(optionName[i]);
			vo.setOptionPrice(optionPrice[i]);
			vo.setOptionPrice(optionStock[i]);

			dbShopService.setDbOptionInput(vo);
		}
		if (!flag.equals("option2"))
			return "redirect:/message/dbOptionInputOk";
		else {
			model.addAttribute("temp", vo.getProductName());
			return "redirect:/message/dbOptionInput2Ok";
		}
	}

	// 옵션 등록창에서 옵션리스트를 확인후 필요없는 옵션항목을 삭제처리..
	@ResponseBody
	@RequestMapping(value = "/optionDelete", method = RequestMethod.POST)
	public String optionDeletePost(int idx) {
		dbShopService.setOptionDelete(idx);
		return "";
	}

	@ResponseBody
	@RequestMapping(value = "/productStatusChange", method = RequestMethod.POST)
	public String productStatusChangePost(int idx, String productStatus) {
		dbShopService.productStatusChange(idx, productStatus);

		return "";
	}



	
	// ---------------------------------------------------------------------------

	/* 아래로 사용자(고객)에서의 처리부분들~~~~ */

	// 등록된 상품 보여주기(사용자(고객)화면에서 보여주기)
	@RequestMapping(value = "/dbProductList", method = RequestMethod.GET)
	public String dbProductListGet(@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "9", required = false) int pageSize,
			@RequestParam(name = "sort", defaultValue = "신상품순", required = false) String sort,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString, Model model) {

		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", part, searchString);

		// 대/중분류명을 가져온다.
		List<DbProductVO> middleTitleVOS = dbShopService.getMiddleTitle();
		List<DbProductVO> mainTitleVOS = dbShopService.getMainTitle();
		model.addAttribute("mainTitleVOS", mainTitleVOS);
		model.addAttribute("middleTitleVOS", middleTitleVOS);
		model.addAttribute("part", part);
		model.addAttribute("sort", sort);

		// 전체 상품리스트 가져오기
		List<DbProductVO> productVOS = dbShopService.getDbShopList(pageVO.getStartIndexNo(), pageSize, part, sort, searchString);
		System.out.println("productVOS : " + productVOS);
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchString", searchString);
		model.addAttribute("vosSize", productVOS.size());

		// 등록된지 10일 이내인 상품들 가져오기
		List<DbProductVO> newVOS = dbShopService.getNewProductName();
		model.addAttribute("newVOS", newVOS);
		return "dbShop/dbProductList";
	}

	// 진열된 상품클릭시 해당상품의 상세정보 보여주기(사용자(고객)화면에서 보여주기)
	@RequestMapping(value = "/dbProductContent", method = RequestMethod.GET)
	public String dbProductContentGet(int idx, Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");

		DbProductVO productVO = dbShopService.getDbShopProduct(idx); // 상품의 상세정보 불러오기
		List<DbOptionVO> optionVOS = dbShopService.getDbShopOption(idx); // 옵션의 모든 정보 불러오기
		CategoryMainVO mainVO = dbShopService.getProductContentCate(productVO.getCategoryMainCode());
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		model.addAttribute("mainVO", mainVO); 

		
		// 최근 본 상품
		// 세션에 떠 있는것을 잡아오자
		session.setAttribute("sProductFSName", productVO.getFSName());
		session.setAttribute("sProductIdx", String.valueOf(productVO.getIdx())); // Integer를 String으로 변환하여 저장

		List<String> proList2 = (List<String>) session.getAttribute("proList2");
		if (proList2 == null) {
		    proList2 = new ArrayList<>();
		    session.setAttribute("proList2", proList2);
		}

		// 이 부분은 페이지를 클릭할 때마다 실행되며, proList2에 값을 추가하고 최대 4개의 값을 유지합니다.
		String sProductFSName = (String) session.getAttribute("sProductFSName");
		String sProductIdx = (String) session.getAttribute("sProductIdx");
		String imageIdx = sProductFSName + "/" + sProductIdx;
		proList2.add(imageIdx);

		// proList2에 4개 이상의 값이 저장되었다면, 가장 오래된 값을 지우고 최대 4개의 값만 유지합니다.
		if (proList2.size() > 4) {
		    proList2.remove(0);
		}
		
		// productVO의 idx에 달린 리뷰들을 가져오자
		List<DbReviewVO> reviewVOS = dbShopService.getProductReview(productVO.getIdx());
		model.addAttribute("reviewVOS", reviewVOS);

		// DB에서 현재 게시글에 '좋아요'가 체크되어있는지를 알아오자.
		WishVO wishVO = dbShopService.getwishCheck(productVO.getIdx(), mid);
		model.addAttribute("wishVO", wishVO);
		return "dbShop/dbProductContent";
	}
	
	

	// 상품상세정보보기창에서 장바구니 / 주문하기 각각 처리
	@RequestMapping(value = "/dbProductContent", method = RequestMethod.POST)
	public String dbProductContentPost(DbCartVO vo, HttpSession session, String flag, Model model,
			@RequestParam(name = "baesong", defaultValue = "0", required = false) int baesong,
			@RequestParam(name = "totalPrice", defaultValue = "0", required = false) int totalPrice,
			@RequestParam(name = "orderTotalPrice", defaultValue = "0", required = false) int orderTotalPrice,
			@RequestParam(name = "orderTotal", defaultValue = "0", required = false) int orderTotal) {
		String mid = (String) session.getAttribute("sMid");

		if (!flag.equals("order")) { // 플래그가 오더가 아니면 장바구니 처리
			DbCartVO existVO = dbShopService.getDbCartProductOptionSearch(vo.getProductName(), vo.getOptionName(), mid); // 장바구니
																																																										// 중복검사
			if (existVO != null) { // 있으면 업데이트
				int optionNum = Integer.parseInt(existVO.getOptionNum());
				optionNum += 1;
				vo.setOptionNum(Integer.toString(optionNum));
				int optionPrice = Integer.parseInt(existVO.getOptionPrice());
				optionPrice = optionPrice * optionNum;
				vo.setOptionPrice(Integer.toString(optionPrice));
				dbShopService.dbShopCartUpdate(vo);
			} else { // 없으면 장바구니에 새로 추가
				String[] voOptionIdxs = vo.getOptionIdx().split(",");
				String[] voOptionNames = vo.getOptionName().split(",");
				String[] voOptionPrices = vo.getOptionPrice().split(",");
				String[] voOptionNums = vo.getOptionNum().split(",");
				for (int i = 0; i < voOptionNames.length; i++) {
					vo.setMid(mid);
					vo.setProductIdx(vo.getProductIdx());
					vo.setProductName(vo.getProductName());
					vo.setMainPrice(vo.getMainPrice());
					vo.setThumbImg(vo.getThumbImg());

					vo.setOptionIdx(voOptionIdxs[i]);
					vo.setOptionName(voOptionNames[i]);
					vo.setOptionPrice(voOptionPrices[i]);
					vo.setOptionNum(voOptionNums[i]);
					dbShopService.dbShopCartInput(vo);
				}
			}
		} else {
			// 상품상세화면에서 바로 주문하기

			// 주문한 상품에 대하여 '고유번호'를 만들어준다.
			// 고유주문번호(idx) = 기존에 존재하는 주문테이블의 고유번호 + 1
			DbOrderVO maxIdx = dbShopService.getOrderMaxIdx();
			int idx = 1;
			if (maxIdx != null)
				idx = maxIdx.getMaxIdx() + 1;

			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			String orderIdx = sdf.format(today) + idx;

			List<DbOrderVO> orderVOS = new ArrayList<DbOrderVO>();

			// String[] voOptionIdxs = vo.getOptionIdx().split(",");
			String[] voOptionNames = vo.getOptionName().split(",");
			String[] voOptionPrices = vo.getOptionPrice().split(",");
			String[] voOptionNums = vo.getOptionNum().split(",");
			for (int i = 0; i < voOptionNames.length; i++) {
				DbOrderVO orderVO = new DbOrderVO();
				orderVO.setMid(mid);
				orderVO.setProductIdx(vo.getProductIdx());
				orderVO.setProductName(vo.getProductName());
				orderVO.setMainPrice(vo.getMainPrice());
				orderVO.setThumbImg(vo.getThumbImg());

				orderVO.setTotalPrice(Integer.parseInt(voOptionNums[i]) * Integer.parseInt(voOptionPrices[i]));
				orderVO.setOptionName(voOptionNames[i]);
				orderVO.setOptionPrice(voOptionPrices[i]);
				orderVO.setOptionNum(voOptionNums[i]);

				orderVO.setBaesong(baesong);
				orderVO.setOrderIdx(orderIdx); // 관리자가 만들어준 '주문고유번호'를 저장

				orderVOS.add(orderVO);
			}
			// 담아서 세션으로 넘겨서 order로 보내보자
			session.setAttribute("sOrderVOS", orderVOS);
			System.out.println("orderVOS: " + orderVOS);
			MemberVO memberVO = memberService.getMemberIdCheck(mid);
			model.addAttribute("memberVO", memberVO);
			model.addAttribute("orderVO", vo);
			model.addAttribute("mid", mid);
			model.addAttribute("totalPrice", vo.getTotalPrice());
			model.addAttribute("orderTotalPrice", orderTotalPrice);
			model.addAttribute("orderTotal", orderTotal);
			model.addAttribute("baesong", baesong);

			return "dbShop/dbOrder";
		}
		return "redirect:/message/cartInputOk";
	}

	// 장바구니 수량 변경
	@ResponseBody
	@RequestMapping(value = "/dbCartNumChange", method = RequestMethod.POST)
	public String dbCartNumChangePost(int idx, int num) {
		dbShopService.dbCartNumChange(idx, num);
		return "1";
	}

	// 장바구니에 담겨있는 모든 상품들의 내역을 보여주기-주문 전단계(장바구니는 DB에 들어있는 자료를 바로 불러와서 처리하면 된다.)
	@RequestMapping(value = "/dbCartList", method = RequestMethod.GET)
	public String dbCartGet(HttpSession session, DbCartVO vo, Model model) {
		String mid = (String) session.getAttribute("sMid");
		List<DbCartVO> vos = dbShopService.getDbCartList(mid);

		if (vos.size() == 0) {
			return "redirect:/message/cartEmpty";
		}

		model.addAttribute("cartListVOS", vos);
		return "dbShop/dbCartList";
	}

	// 장바구니안에서 삭제시키고자 할 품목을 '구매취소'버튼 눌렀을때 처리
	@ResponseBody
	@RequestMapping(value = "/dbCartDelete", method = RequestMethod.POST)
	public String dbCartDeletePost(int idx) {
		dbShopService.dbCartDelete(idx);
		return "1";
	}

	// 장바구니안에서 삭제시키고자 할 품목을 여러개 선택하고 삭제를 눌렀을때
	@ResponseBody
	@RequestMapping(value = "/cartDelete2", method = RequestMethod.POST)
	public String dbCcartDelete2Post(String idxs) {

		String[] idx = idxs.split("/");

		for (int i = 0; i < idx.length; i++) {
			dbShopService.dbCartDelete(Integer.parseInt(idx[i]));
		}
		return "1";
	}

	@Transactional
	// 장바구니에서 구매(트랜잭션 걸어놔서 오류나도 다같이 캔슬)
	@RequestMapping(value = "/dbCartList", method = RequestMethod.POST)
	public String dbCartOrderPost(HttpServletRequest request, HttpSession session, DbCartVO vo, Model model,
			@RequestParam(name = "baesong", defaultValue = "0", required = false) int baesong,
			@RequestParam(name = "totalPrice", defaultValue = "0", required = false) int totalPrice,
			@RequestParam(name = "orderTotalPrice", defaultValue = "0", required = false) int orderTotalPrice,
			@RequestParam(name = "orderTotal", defaultValue = "0", required = false) int orderTotal, String idxs) {
		String mid = (String) session.getAttribute("sMid");

		// 주문한 상품에 대하여 '고유번호'를 만들어준다.
		// 고유주문번호(idx) = 기존에 존재하는 주문테이블의 고유번호 + 1
		DbOrderVO maxIdx = dbShopService.getOrderMaxIdx();
		int idx = 1;
		if (maxIdx != null)
			idx = maxIdx.getMaxIdx() + 1;

		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;

		// 장바구니에서 구매를 위해 선택한 idx들을 잘라서 for문 돌린다.
		String[] selectCartIdxs = idxs.split("/");

		DbCartVO cartVO = new DbCartVO();
		List<DbOrderVO> orderVOS = new ArrayList<DbOrderVO>();

		for (String strIdx : selectCartIdxs) {
			cartVO = dbShopService.getCartIdx(Integer.parseInt(strIdx)); // 가져온 idx들을 토대로 장바구니에서 목록 꺼내온다
			DbOrderVO orderVO = new DbOrderVO();
			orderVO.setProductIdx(cartVO.getProductIdx());
			orderVO.setProductName(cartVO.getProductName());
			orderVO.setMainPrice(cartVO.getMainPrice());
			orderVO.setThumbImg(cartVO.getThumbImg());
			orderVO.setOptionName(cartVO.getOptionName());
			orderVO.setOptionPrice(cartVO.getOptionPrice());
			orderVO.setOptionNum(cartVO.getOptionNum());
			orderVO.setTotalPrice(Integer.parseInt(cartVO.getOptionNum()) * Integer.parseInt(cartVO.getOptionPrice()));
			orderVO.setCartIdx(cartVO.getIdx());
			orderVO.setBaesong(baesong);

			orderVO.setOrderIdx(orderIdx); // 관리자가 만들어준 '주문고유번호'를 저장
			orderVO.setMid(mid); // 로그인한 아이디를 저장한다.

			orderVOS.add(orderVO);
		}
		session.setAttribute("sOrderVOS", orderVOS);

		// 배송처리를 위한 현재 로그인한 아이디에 해당하는 고객의 정보를 member테이블에서 가져온다.
		MemberVO memberVO = memberService.getMemberIdCheck(mid);
		model.addAttribute("memberVO", memberVO);
		// model.addAttribute("orderVO",vo);
		model.addAttribute("mid", mid);
		model.addAttribute("orderTotalPrice", orderTotalPrice);
		model.addAttribute("orderTotal", orderTotal);
		return "dbShop/dbOrder";
	}

	// 결제시스템(결제창 호출하기) - API이용
	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String paymentPost(DbOrderVO orderVo, DbPayMentVO payMentVO, DbBaesongVO baesongVO, HttpSession session,
			Model model) {
		model.addAttribute("payMentVO", payMentVO);

		session.setAttribute("sPayMentVO", payMentVO);
		session.setAttribute("sBaesongVO", baesongVO);

		return "dbShop/paymentOk";
	}

	@Transactional
	// 결제2 (아임포트api사용하지 않고 결제)
	@RequestMapping(value = "/payment2", method = RequestMethod.POST)
	public String payment2Post(DbOrderVO orderVo, DbPayMentVO payMentVO, DbBaesongVO baesongVO, HttpSession session,
			Model model) {
		model.addAttribute("payMentVO", payMentVO);
		List<DbOrderVO> orderVOS = (List<DbOrderVO>) session.getAttribute("sOrderVOS");
		// DbPayMentVO payMentVO2 = (DbPayMentVO) session.getAttribute("sPayMentVO");
		// DbBaesongVO baesongVO2 = (DbBaesongVO) session.getAttribute("sBaesongVO");

		for (DbOrderVO vo : orderVOS) {
			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8))); // 주문테이블에 고유번호를 셋팅한다.
			vo.setOrderIdx(vo.getOrderIdx()); // 주문번호를 주문테이블의 주문번호필드에 지정처리한다.
			vo.setMid(vo.getMid());

			dbShopService.setDbOrder(vo); // 주문내용을 주문테이블(dbOrder)에 저장.
			dbShopService.setDbCartDeleteAll(vo.getCartIdx()); // 주문이 완료되었기에 장바구니(dbCart)테이블에서 주문한 내역을 삭체처리한다.

		}
		baesongVO.setOIdx(orderVOS.get(0).getIdx());
		baesongVO.setOrderIdx(orderVOS.get(0).getOrderIdx());
		baesongVO.setAddress(payMentVO.getBuyer_addr());
		baesongVO.setTel(payMentVO.getBuyer_tel());
		System.out.println("baesongVo : " + baesongVO);

		dbShopService.setDbBaesong(baesongVO); // 배송내용을 배송테이블(dbBaesong)에 저장
		// 포인트 사용시 포인트 차감 및 포인트 페이지에 기재
		dbShopService.setMemberMinusPoint(baesongVO.getMid(), baesongVO.getUsingPoint()); // 멤버 포인트 차감
		dbShopService.setUsingPoint(baesongVO.getMid(), baesongVO.getUsingPoint(),baesongVO.getOrderIdx(),"주문 시 사용"); // 포인트 페이지에 차감 기재

		return "redirect:/message/payment2Ok";
	}

//결제시스템 연습하기(결제창 호출후 결재 완료후에 처리하는 부분)
	// 주문 완료후 주문내역을 '주문테이블(dbOrder)에 저장
	// 주문이 완료되었기에 주문된 물품은 장바구니(dbCartList)에서 내역을 삭제처리한다.
	// 사용한 세션은 제거시킨다.
	// 작업처리후 오늘 구매한 상품들의 정보(구매품목,결제내역,배송지)들을 model에 담아서 확인창으로 넘겨준다.
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/paymentResult", method = RequestMethod.GET)
	public String paymentResultGet(HttpSession session, DbPayMentVO receivePayMentVO, Model model) {
		// 주문내역 dbOrder/dbBaesong 테이블에 저장하기(앞에서 저장했던 세션에서 가져왔다.)
		List<DbOrderVO> orderVOS = (List<DbOrderVO>) session.getAttribute("sOrderVOS");
		DbPayMentVO payMentVO = (DbPayMentVO) session.getAttribute("sPayMentVO");
		DbBaesongVO baesongVO = (DbBaesongVO) session.getAttribute("sBaesongVO");

//		사용된 세션은 반환한다.
//		session.removeAttribute("sOrderVOS");  // 마지막 결재처리후에 결재결과창에서 확인하고 있기에 지우면 안됨
		session.removeAttribute("sBaesongVO");

		for (DbOrderVO vo : orderVOS) {
			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8))); // 주문테이블에 고유번호를 셋팅한다.
			vo.setOrderIdx(vo.getOrderIdx()); // 주문번호를 주문테이블의 주문번호필드에 지정처리한다.
			vo.setMid(vo.getMid());

			dbShopService.setDbOrder(vo); // 주문내용을 주문테이블(dbOrder)에 저장.
			dbShopService.setDbCartDeleteAll(vo.getCartIdx()); // 주문이 완료되었기에 장바구니(dbCart)테이블에서 주문한 내역을 삭체처리한다.

		}
		// 주문된 정보를 배송테이블에 담기위한 처리(기존 baesongVO에 담기지 않은 내역들을 담아주고 있다.)
		baesongVO.setOIdx(orderVOS.get(0).getIdx());
		baesongVO.setOrderIdx(orderVOS.get(0).getOrderIdx());
		baesongVO.setAddress(payMentVO.getBuyer_addr());
		baesongVO.setTel(payMentVO.getBuyer_tel());

		dbShopService.setDbBaesong(baesongVO); // 배송내용을 배송테이블(dbBaesong)에 저장
		// 포인트 사용시 포인트 차감 및 포인트 페이지에 기재
		//dbShopService.setMemberMinusPoint(baesongVO.getMid(), baesongVO.getUsingPoint()); // 멤버 포인트 차감
		//dbShopService.setUsingPoint(baesongVO.getMid(), baesongVO.getUsingPoint(),baesongVO.getOrderIdx(),"주문 시 사용"); // 포인트 페이지에 차감 기재


		payMentVO.setImp_uid(receivePayMentVO.getImp_uid());
		payMentVO.setMerchant_uid(receivePayMentVO.getMerchant_uid());
		payMentVO.setPaid_amount(receivePayMentVO.getPaid_amount());
		payMentVO.setApply_num(receivePayMentVO.getApply_num());

		// 오늘 주문에 들어간 정보들을 확인해주기위해 다시 session에 담아서 넘겨주고 있다.
		session.setAttribute("sPayMentVO", payMentVO);
		session.setAttribute("orderTotalPrice", baesongVO.getOrderTotalPrice());

		return "redirect:/message/paymentResultOk";
	}

	// 결재완료된 정보 보여주기
	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value = "/paymentResultOk", method = RequestMethod.GET)
	public String paymentResultOkGet(HttpSession session, Model model) {
		List<DbOrderVO> orderVOS = (List<DbOrderVO>) session.getAttribute("sOrderVOS");
		model.addAttribute("orderVOS", orderVOS);
		session.removeAttribute("sOrderVOS");
		return "dbShop/paymentResult";
	}

//현재 로그인 사용자가 주문내역 조회하기 폼 보여주기
	@RequestMapping(value = "/dbMyOrder", method = RequestMethod.GET)
	public String dbMyOrderGet(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "20", required = false) int pageSize,
			// @RequestParam(name="conditionOrderStatus", defaultValue="전체", required=false)
			// String conditionOrderStatus,
			// @RequestParam(name="startJumun", defaultValue="", required=false) String
			// startJumun,
			// @RequestParam(name="endJumun", defaultValue="", required=false) String
			// endJumun
			String conditionOrderStatus, String startJumun, String endJumun) {

		String mid = (String) session.getAttribute("sMid");
		int level = (int) session.getAttribute("sLevel");
		if (level == 0)
			mid = "전체";

		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "dbMyOrder", mid, "");

		// 오늘 구매한 내역을 초기화면에 보여준다.
		List<DbBaesongVO> vos = dbShopService.getMyOrderList(pageVO.getStartIndexNo(), pageSize, mid, startJumun, endJumun,
				conditionOrderStatus);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("conditionOrderStatus", conditionOrderStatus);

		return "dbShop/dbMyOrder";
	}

	// 위시리스트~ 누르면 db에 저장 / 또 한번 누르면 삭제.
	@ResponseBody
	@RequestMapping(value = "/wishCheck", method = RequestMethod.POST)
	public void wishDBCheckPost(WishVO wishVO) {
		if (wishVO.getIdx() == 0) {
			dbShopService.setWishDBInput(wishVO);
		} else {
			dbShopService.setWishDBDelete(wishVO.getIdx());
		}
	}

	// 위시리스트 페이지 보여주기
	@RequestMapping(value = "/dbWishList", method = RequestMethod.GET)
	public String wishListGet(HttpSession session, Model model, WishVO wishVO) {
		String mid = (String) session.getAttribute("sMid");
		List<WishVO> vos = dbShopService.getWishList(mid);

		// 저장 날짜로부터 3개월(90일)이 초과된 위시리스트 자동 삭제하기
		List<WishVO> idxVOS = dbShopService.getThreeMonthExceedWishIdx(mid);
		if (idxVOS != null) {
			for (WishVO vo : idxVOS) {
				dbShopService.setWishDBDelete(vo.getIdx());
			}
		}
		model.addAttribute("vos", vos);
		return "dbShop/dbWishList";
	}

	// 위시리스트 삭제
	@ResponseBody
	@RequestMapping(value = "/wishDelete", method = RequestMethod.POST)
	public void wishDeletePost(int idx) {
		dbShopService.setWishDBDelete(idx);
	}

	// 위시리스트 다중삭제
	@ResponseBody
	@RequestMapping(value = "/wishDelete2", method = RequestMethod.POST)
	public void wishDelete2Post(String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			dbShopService.setWishDBDelete(Integer.parseInt(idxMulti[i]));
		}
	}

	// 주문내역 상세보기
	@RequestMapping(value = "/dbOrderDetail", method = RequestMethod.GET)
	public String dbOrderDetailGet(HttpSession session, Model model, String orderIdx) {

		String mid = (String) session.getAttribute("sMid");
		DbBaesongVO vo = dbShopService.getOrderOne(orderIdx, mid); // 배송에 있는 주문 한건
		List<DbBaesongVO> vos = dbShopService.getOrders(orderIdx, mid); // 배송-오더에 있는 옵션 여러건

		model.addAttribute("vo", vo);
		model.addAttribute("vos", vos);
		model.addAttribute("mid", mid);
		return "dbShop/dbOrderDetail";
	}

	// 구매확정 선택하기 새창폼
	@RequestMapping(value = "/orderChildWin", method = RequestMethod.GET)
	public String orderChildWinGet(HttpSession session, Model model, String orderIdx) {

		String mid = (String) session.getAttribute("sMid");
		List<DbBaesongVO> vos = dbShopService.getOrders(orderIdx, mid);

		model.addAttribute("vos", vos);
		model.addAttribute("mid", mid);
		return "dbShop/orderChildWin";
	}

	// 구매확정 페이지에서 구매확정 버튼 클릭(상품구매 포인트 지급 / order 상태 '구매확정'으로 변경)
	@ResponseBody
	@RequestMapping(value = "/orderConfirm", method = RequestMethod.POST)
	public String orderConfirmGet(HttpSession session, Model model, String idxs) {

		String mid = (String) session.getAttribute("sMid");
		String[] idx = idxs.split("/");

		for (int i = 0; i < idx.length; i++) {
			// idx로 건별 order항목을 한가지씩 가져온다.
			DbOrderVO vo = dbShopService.getOrdersOne(Integer.parseInt(idx[i]));

			// 확정 상품별 포인트 지급(1%)
			int point = (int) (vo.getTotalPrice() * 0.01);
			dbShopService.setGetPoint(vo.getProductName(), point, mid, "상품구매"); // 포인트 db에 내역 저장
			dbShopService.setMemberPlusPoint(mid, point); // 멤버 포인트 지급
			dbShopService.setOrderStatusChange(Integer.parseInt(idx[i]), "구매확정"); // 구매확정 처리
		}
		return "1";
	}

	
	// 반품 / 환불 신청 새창폼
	@RequestMapping(value = "/orderCancelChild", method = RequestMethod.GET)
	public String orderCancelChildGet(HttpSession session, Model model, int idx) {

		DbOrderVO vo = dbShopService.getOrdersOne(idx); // 오더에 있는 idx 한건!

		model.addAttribute("vo", vo);
		return "dbShop/orderCancelChild";
	}

	// 반품 / 환불 신청 저장
	@RequestMapping(value = "/orderCancelChild", method = RequestMethod.POST)
	public String orderCancelChildPost(DbOrderCancelVO vo) {
		// 취소 db에 저장
		dbShopService.setOrderCancel(vo);
		// db 저장 후 order에 있는 status 상태를 각각 변경처리
		if (vo.getCancelStatus().equals("반품요청"))
			dbShopService.setOrderStatusChange(vo.getCancelIdx(), "반품요청");
		else if (vo.getCancelStatus().equals("환불요청"))
			dbShopService.setOrderStatusChange(vo.getCancelIdx(), "환불요청");

		return "dbShop/orderCancelOk";
	}

	// 포인트 페이지 폼
	@RequestMapping(value = "/dbPoint", method = RequestMethod.GET)
	public String dbPointGet(HttpSession session, Model model) {

		String mid = (String) session.getAttribute("sMid");
		List<DbPointVO> vos = dbShopService.getDbPoint(mid);

		model.addAttribute("vos", vos);
		return "dbShop/dbPoint";
	}

	// 리뷰 폼
	@RequestMapping(value = "/dbReviewForm", method = RequestMethod.GET)
	public String dbReviewFormGet(Model model, int idx) {

		DbOrderVO vo = dbShopService.getOrdersOne(idx);

		model.addAttribute("vo", vo);
		return "dbShop/dbReviewForm";
	}

	// 리뷰 등록
	@RequestMapping(value = "/dbReviewForm", method = RequestMethod.POST)
	public String dbReviewFormPost(DbReviewVO vo, MultipartHttpServletRequest file, int idx) {
		int res = dbShopService.setReviewInput(vo, file);

		if (res == 1) {
			dbShopService.setOrderReviewChange(idx, "OK"); // 리뷰가 등록되면 order의 리뷰컨펌을 바꿔서 리뷰등록이 뜨지 않도록 해줘야한다.
			dbShopService.setGetPoint(vo.getProductName(), 500, vo.getMid(), "리뷰작성"); // 포인트 db에 내역 저장
			dbShopService.setMemberPlusPoint(vo.getMid(), 500); // 리뷰 포인트 500점 지급
			return "redirect:/message/reviewInputOk";
		} else
			return "redirect:/message/reviewInputNo";
	}

	// 유저 마이페이지 리뷰글 관리 게시판 폼
	@RequestMapping(value = "/userReview", method = RequestMethod.GET)
	public String dbUserReviewGet(Model model, HttpSession session) {

		String mid = (String) session.getAttribute("sMid");

		List<DbReviewVO> VOS = dbShopService.getUserReivew(mid);
		model.addAttribute("VOS", VOS);

		return "dbShop/userReview";
	}
	
	// 원데이클래스 신청폼(3개월 간 구매액이 10만원 이상인 회원만 신청가능)
	@RequestMapping(value = "/dbOnedayClass", method = RequestMethod.GET)
	public String dbOnedayClassGet(Model model) {
		List<MemberVO> vos = dbShopService.getClassValidMember();
		model.addAttribute("vos",vos); // 이벤트 해당 회원 아이디들
		return "dbShop/dbOnedayClass";
	}
	
	// 원데이클래스 회원 이벤트 신청
	@ResponseBody
	@RequestMapping(value = "/dbOnedayClassApplication", method = RequestMethod.POST)
	public String dbOnedayClassInputPost(String mid, String className, String store, String wDate, int memberNum) {
		
		// QR코드 빼고 이벤트 신청내역을 저장시킨다.
		dbShopService.setOnedayClassApplication(mid, className, store, wDate, memberNum);
		return "1";
	}
	
	
	// 원데이클래스 관리자가 이벤트 당첨처리(QR)
	@ResponseBody
	@RequestMapping(value = "/onedayClassConfirm", method = RequestMethod.POST)
	public String onedayClassConfirmPost(Model model, HttpServletRequest request, int idx,
			String mid, String className, String store, String wDate, int memberNum,String classTemp
			) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		String qrCodeName = dbShopService.onedayClassInput(idx, mid, className, store, wDate, memberNum,classTemp, realPath); // 이미지 만들기
		
		return "1";
	}
	

	// 원데이클래스 회원별 예약한 목록
	@RequestMapping(value = "/dbMyOnedayClass", method = RequestMethod.GET)
	public String dbMyOnedayClassGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		 List<DbOnedayClassVO> vos =  dbShopService.getMyOnedayClass(mid);
		 model.addAttribute("vos",vos);
		return "dbShop/dbMyOnedayClass";
	}
	
	// 원데이클래스 회원별 예약한 목록에서 큐알코드 새창으로 크게 보기
	@RequestMapping(value = "/qrCodeWin", method = RequestMethod.GET)
	public String qrCodeWinGet(Model model, HttpSession session, int idx) {
		String mid = (String) session.getAttribute("sMid");
		DbOnedayClassVO vo = dbShopService.getOnedayClassOne(idx);
		model.addAttribute("vo",vo);
		return "dbShop/dbQrCodeNew";
	}
	
	
	
	//회원 리뷰 다중 삭제
	@ResponseBody
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
	public String reviewDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			dbShopService.setReviewDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	// 배송전 회원 결제 취소
	@ResponseBody
	@RequestMapping(value = "/userOrderCancel", method = RequestMethod.POST)
	public String userOrderCancelPost(Model model, int idx, int productIdx, String optionName, int optionNum) {
		// order 주문취소로 바꾸고
		dbShopService.setOrderStatusChange(idx, "결제취소");
		// 옵션의 개수를 다시 증가시켜준다.
		dbShopService.setOptionStockPlus(productIdx,optionName,optionNum);
		return "1";
	}
	
	
	// 회원 환불,반품 불가능 사유 새창
	@RequestMapping(value = "/orderCancelReason", method = RequestMethod.GET)
	public String orderCancelReasonGet(int idx, Model model) {
		DbOrderCancelVO vo = dbShopService.getOrderCancelsOne(idx);
		model.addAttribute("vo", vo);
		return "dbShop/orderCancelReason";
	}
	
	
	// 리뷰 신고 새창
	@RequestMapping(value = "/reviewReportChild", method = RequestMethod.GET)
	public String reviewReportChildGet(int idx, Model model) {
		DbReviewVO vo = dbShopService.getReviewOne(idx);
		model.addAttribute("vo", vo);
		return "dbShop/reviewReportChild";
	}
	
	// 리뷰 신고 새창 신고 제출
	@ResponseBody
	@RequestMapping(value = "/reviewReportChild", method = RequestMethod.POST)
	public String reviewReportChildPost(ReportReviewVO vo, Model model) {
		// 같은 리뷰를 여러번 신고할수 없다.
		ReportReviewVO rpVO = dbShopService.getExistReportReview(vo.getIdx(), vo.getMid());
		if(rpVO != null) {
			return "0";
		} 
		// 신고 테이블에 넣고
		dbShopService.setReportReview(vo);
		// 리뷰 테이블의 리포트넘을 증가시킨다.
		dbShopService.setReportReviewNum(vo.getIdx());
		return "1";
	}
	
	
	
	
}
