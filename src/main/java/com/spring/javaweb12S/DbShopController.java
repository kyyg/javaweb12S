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

import javax.mail.Session;
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
import com.spring.javaweb12S.vo.DbShippingListVO;
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


	@RequestMapping(value = "/dbCategory", method = RequestMethod.GET)
	public String dbCategoryGet(Model model) {
		List<DbProductVO> mainVOS = dbShopService.getCategoryMain(); // 대분류리스트
		List<DbProductVO> middleVOS = dbShopService.getCategoryMiddle();// 중분류리스트
		model.addAttribute("mainVOS", mainVOS);
		model.addAttribute("middleVOS", middleVOS);

		return "admin/dbShop/dbCategory";
	}

	@ResponseBody
	@RequestMapping(value = "/categoryMainInput", method = RequestMethod.POST)
	public String categoryMainInputPost(DbProductVO vo) {
		DbProductVO productVO = dbShopService.getCategoryMainOne(vo.getCategoryMainCode(), vo.getCategoryMainName());
		if (productVO != null)
			return "0";
		dbShopService.setCategoryMainInput(vo);
		return "1";
	}

	@ResponseBody
	@RequestMapping(value = "/categoryMainDelete", method = RequestMethod.POST)
	public String categoryMainDeleteGet(DbProductVO vo) {
		DbProductVO middleVO = dbShopService.getCategoryMiddleOne(vo);

		if (middleVO != null)
			return "0";
		dbShopService.setCategoryMainDelete(vo.getCategoryMainCode()); 

		return "1";
	}

	@ResponseBody
	@RequestMapping(value = "/categoryMiddleInput", method = RequestMethod.POST)
	public String categoryMiddleInputPost(DbProductVO vo) {
		DbProductVO productVO = dbShopService.getCategoryMiddleOne(vo);

		if (productVO != null)
			return "0";
		dbShopService.setCategoryMiddleInput(vo); 
		return "1";
	}

	@ResponseBody
	@RequestMapping(value = "/categoryMiddleName", method = RequestMethod.POST)
	public List<DbProductVO> categoryMiddleNamePost(String categoryMainCode) {
		return dbShopService.getCategoryMiddleName(categoryMainCode);
	}


	@ResponseBody
	@RequestMapping(value = "/categoryMiddleDelete", method = RequestMethod.POST)
	public String categoryMiddleDeleteGet(DbProductVO vo) {

		DbProductVO subVO = dbShopService.getCategorySubOne(vo);

		if (subVO != null)
			return "0";
		dbShopService.setCategoryMiddleDelete(vo.getCategoryMiddleCode()); 
		return "1";
	}

	@RequestMapping(value = "/dbProduct", method = RequestMethod.GET)
	public String dbProducGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain();
		model.addAttribute("mainVos", mainVos);
		return "admin/dbShop/dbProduct";
	}

	@ResponseBody
	@RequestMapping(value = "/categoryProductName", method = RequestMethod.POST)
	public List<DbProductVO> categoryProductNamePost(String categoryMainCode, String categoryMiddleCode) {
		return dbShopService.getCategoryProductName(categoryMainCode, categoryMiddleCode);
	}

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


	@RequestMapping(value = "/dbProduct", method = RequestMethod.POST)
	public String dbProducPost(MultipartFile file, MultipartHttpServletRequest file2, DbProductVO vo) {
		dbShopService.imgCheckProductInput(file,file2, vo);
		return "redirect:/message/dbProductInputOk";
	}
	

	@RequestMapping(value = "/productModify", method = RequestMethod.GET)
	public String productModifyGet(Model model, int idx) {

		DbProductVO vo = dbShopService.getDbShopProduct(idx);

		model.addAttribute("vo", vo);
		return "admin/dbShop/productModify";
	}
	

	@RequestMapping(value = "/productModify", method = RequestMethod.POST)
	public String productModifyPost(DbProductVO vo, MultipartFile file) {
		int res = dbShopService.productModifyOk(file, vo);
		if(res==1) {
			return "redirect:/message/productModifyOk";
		}
		return "redirect:/message/productModifyNo";
	}
	
	

	@RequestMapping(value = "/dbShopList", method = RequestMethod.GET)
	public String dbShopListGet(Model model,
			@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "20", required = false) int pageSize,
			@RequestParam(name = "sort", defaultValue = "신상품순", required = false) String sort,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString) {

		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", part, searchString);

		List<DbProductVO> middleTitleVOS = dbShopService.getMiddleTitle();
		List<DbProductVO> mainTitleVOS = dbShopService.getMainTitle();
		model.addAttribute("mainTitleVOS", mainTitleVOS);
		model.addAttribute("middleTitleVOS", middleTitleVOS);
		model.addAttribute("part", part);
		model.addAttribute("sort", sort);

		List<DbProductVO> productVOS = dbShopService.getDbShopList(pageVO.getStartIndexNo(), pageSize, part, sort,
				searchString);
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchString", searchString);
		model.addAttribute("vosSize", productVOS.size());

		return "admin/dbShop/dbShopList";
	}


	@RequestMapping(value = "/dbShopContent", method = RequestMethod.GET)
	public String dbShopContentGet(Model model, int idx) {
		DbProductVO productVO = dbShopService.getDbShopProduct(idx); 
		List<DbOptionVO> optionVOS = dbShopService.getDbShopOption(idx); 
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);

		return "admin/dbShop/dbShopContent";
	}

	@RequestMapping(value = "/dbOption", method = RequestMethod.GET)
	public String dbOptionGet(Model model) {
		List<DbProductVO> mainVos = dbShopService.getCategoryMain();
		model.addAttribute("mainVos", mainVos);

		return "admin/dbShop/dbOption";
	}

	@RequestMapping(value = "/dbOption2", method = RequestMethod.GET)
	public String dbOption2Get(Model model, String productName) {
		DbProductVO vo = dbShopService.getProductInfor(productName);
		List<DbOptionVO> optionVOS = dbShopService.getOptionList(vo.getIdx());
		model.addAttribute("vo", vo);
		model.addAttribute("optionVOS", optionVOS);

		return "admin/dbShop/dbOption2";
	}

	@ResponseBody
	@RequestMapping(value = "/dbOption2Input", method = RequestMethod.POST)
	public String dbOption2InputGet(DbOptionVO vo) {
		dbShopService.setDbOptionInput(vo);
		return "";
	}

	@ResponseBody
	@RequestMapping(value = "/getProductInfor", method = RequestMethod.POST)
	public DbProductVO getProductInforPost(String productName) {
		return dbShopService.getProductInfor(productName);
	}

	@ResponseBody
	@RequestMapping(value = "/getOptionList", method = RequestMethod.POST)
	public List<DbOptionVO> getOptionListPost(int productIdx) {
		return dbShopService.getOptionList(productIdx);
	}


	@RequestMapping(value = "/dbOption", method = RequestMethod.POST)
	public String dbOptionPost(Model model, DbOptionVO vo, String[] optionName, int[] optionPrice, int[] optionStock,
			@RequestParam(name = "flag", defaultValue = "", required = false) String flag) {

		for (int i = 0; i < optionName.length; i++) {

			int optionCnt = dbShopService.getOptionSame(vo.getProductIdx(), optionName[i]);
			if (optionCnt != 0)
				continue;

			vo.setProductIdx(vo.getProductIdx());
			vo.setOptionName(optionName[i]);
			vo.setOptionPrice(optionPrice[i]);
			vo.setOptionStock(optionStock[i]);

			dbShopService.setDbOptionInput(vo);
		}
		if (!flag.equals("option2"))
			return "redirect:/message/dbOptionInputOk";
		else {
			model.addAttribute("temp", vo.getProductName());
			return "redirect:/message/dbOptionInput2Ok";
		}
	}

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



	@RequestMapping(value = "/dbProductList", method = RequestMethod.GET)
	public String dbProductListGet(@RequestParam(name = "part", defaultValue = "전체", required = false) String part,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "12", required = false) int pageSize,
			@RequestParam(name = "sort", defaultValue = "신상품순", required = false) String sort,
			@RequestParam(name = "searchString", defaultValue = "", required = false) String searchString, Model model) {

		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", part, searchString);


		List<DbProductVO> middleTitleVOS = dbShopService.getMiddleTitle();
		List<DbProductVO> mainTitleVOS = dbShopService.getMainTitle();
		model.addAttribute("mainTitleVOS", mainTitleVOS);
		model.addAttribute("middleTitleVOS", middleTitleVOS);
		model.addAttribute("part", part);
		model.addAttribute("sort", sort);

		List<DbProductVO> productVOS = dbShopService.getDbShopList(pageVO.getStartIndexNo(), pageSize, part, sort, searchString);
		System.out.println("productVOS : " + productVOS);
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchString", searchString);
		model.addAttribute("vosSize", productVOS.size());

		List<DbProductVO> newVOS = dbShopService.getNewProductName();
		model.addAttribute("newVOS", newVOS);
		return "dbShop/dbProductList";
	}

	@RequestMapping(value = "/dbProductContent", method = RequestMethod.GET)
	public String dbProductContentGet(int idx, Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");

		DbProductVO productVO = dbShopService.getDbShopProduct(idx); 
		List<DbOptionVO> optionVOS = dbShopService.getDbShopOption(idx); 
		CategoryMainVO mainVO = dbShopService.getProductContentCate(productVO.getCategoryMainCode());
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		model.addAttribute("mainVO", mainVO); 

		
		// 최근 본 상품
		session.setAttribute("sProductFSName", productVO.getFSName());
		session.setAttribute("sProductIdx", String.valueOf(productVO.getIdx())); 

		List<String> proList2 = (List<String>) session.getAttribute("proList2");
		if (proList2 == null) {
		    proList2 = new ArrayList<>();
		    session.setAttribute("proList2", proList2);
		}

		String sProductFSName = (String) session.getAttribute("sProductFSName");
		String sProductIdx = (String) session.getAttribute("sProductIdx");
		String imageIdx = sProductFSName + "/" + sProductIdx;
		proList2.add(imageIdx);

		if (proList2.size() > 4) {
		    proList2.remove(0);
		}
		
		List<DbReviewVO> reviewVOS = dbShopService.getProductReview(productVO.getIdx());
		model.addAttribute("reviewVOS", reviewVOS);

		WishVO wishVO = dbShopService.getwishCheck(productVO.getIdx(), mid);
		model.addAttribute("wishVO", wishVO);
		return "dbShop/dbProductContent";
	}
	
	

	@RequestMapping(value = "/dbProductContent", method = RequestMethod.POST)
	public String dbProductContentPost(DbCartVO vo, HttpSession session, String flag, Model model,
			@RequestParam(name = "baesong", defaultValue = "0", required = false) int baesong,
			@RequestParam(name = "totalPrice", defaultValue = "0", required = false) int totalPrice,
			@RequestParam(name = "orderTotalPrice", defaultValue = "0", required = false) int orderTotalPrice,
			@RequestParam(name = "orderTotal", defaultValue = "0", required = false) int orderTotal) {
		String mid = (String) session.getAttribute("sMid");

		if (!flag.equals("order")) {
			DbCartVO existVO = dbShopService.getDbCartProductOptionSearch(vo.getProductName(), vo.getOptionName(), mid);
																																																										// 중복검사
			if (existVO != null) { 
				int optionNum = Integer.parseInt(existVO.getOptionNum());
				optionNum += 1;
				vo.setOptionNum(Integer.toString(optionNum));
				int optionPrice = Integer.parseInt(existVO.getOptionPrice());
				optionPrice = optionPrice * optionNum;
				vo.setOptionPrice(Integer.toString(optionPrice));
				dbShopService.dbShopCartUpdate(vo);
			} else {
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
				orderVO.setOrderIdx(orderIdx); 

				orderVOS.add(orderVO);
			}

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

	@ResponseBody
	@RequestMapping(value = "/dbCartNumChange", method = RequestMethod.POST)
	public String dbCartNumChangePost(int idx, int num) {
		dbShopService.dbCartNumChange(idx, num);
		return "1";
	}

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

	@ResponseBody
	@RequestMapping(value = "/dbCartDelete", method = RequestMethod.POST)
	public String dbCartDeletePost(int idx) {
		dbShopService.dbCartDelete(idx);
		return "1";
	}

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
	@RequestMapping(value = "/dbCartList", method = RequestMethod.POST)
	public String dbCartOrderPost(HttpServletRequest request, HttpSession session, DbCartVO vo, Model model,
			@RequestParam(name = "baesong", defaultValue = "0", required = false) int baesong,
			@RequestParam(name = "totalPrice", defaultValue = "0", required = false) int totalPrice,
			@RequestParam(name = "orderTotalPrice", defaultValue = "0", required = false) int orderTotalPrice,
			@RequestParam(name = "orderTotal", defaultValue = "0", required = false) int orderTotal, String idxs) {
		String mid = (String) session.getAttribute("sMid");

		DbOrderVO maxIdx = dbShopService.getOrderMaxIdx();
		int idx = 1;
		if (maxIdx != null)
			idx = maxIdx.getMaxIdx() + 1;

		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String orderIdx = sdf.format(today) + idx;

		String[] selectCartIdxs = idxs.split("/");

		DbCartVO cartVO = new DbCartVO();
		List<DbOrderVO> orderVOS = new ArrayList<DbOrderVO>();

		for (String strIdx : selectCartIdxs) {
			cartVO = dbShopService.getCartIdx(Integer.parseInt(strIdx));
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

			orderVO.setOrderIdx(orderIdx); 
			orderVO.setMid(mid); 
			orderVOS.add(orderVO);
		}
		session.setAttribute("sOrderVOS", orderVOS);

		MemberVO memberVO = memberService.getMemberIdCheck(mid);
		model.addAttribute("memberVO", memberVO);
		// model.addAttribute("orderVO",vo);
		model.addAttribute("mid", mid);
		model.addAttribute("orderTotalPrice", orderTotalPrice);
		model.addAttribute("orderTotal", orderTotal);
		return "dbShop/dbOrder";
	}

	@RequestMapping(value = "/payment", method = RequestMethod.POST)
	public String paymentPost(DbOrderVO orderVo, DbPayMentVO payMentVO, DbBaesongVO baesongVO, HttpSession session,
			Model model) {
		model.addAttribute("payMentVO", payMentVO);

		session.setAttribute("sPayMentVO", payMentVO);
		session.setAttribute("sBaesongVO", baesongVO);

		return "dbShop/paymentOk";
	}

	@Transactional
	@RequestMapping(value = "/payment2", method = RequestMethod.POST)
	public String payment2Post(DbOrderVO orderVo, DbPayMentVO payMentVO, DbBaesongVO baesongVO, HttpSession session,
			Model model) {
		model.addAttribute("payMentVO", payMentVO);
		List<DbOrderVO> orderVOS = (List<DbOrderVO>) session.getAttribute("sOrderVOS");
		// DbPayMentVO payMentVO2 = (DbPayMentVO) session.getAttribute("sPayMentVO");
		// DbBaesongVO baesongVO2 = (DbBaesongVO) session.getAttribute("sBaesongVO");

		for (DbOrderVO vo : orderVOS) {
			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8))); 
			vo.setOrderIdx(vo.getOrderIdx());
			vo.setMid(vo.getMid());

			dbShopService.setDbOrder(vo);
			dbShopService.setDbCartDeleteAll(vo.getCartIdx()); 

		}
		baesongVO.setOIdx(orderVOS.get(0).getIdx());
		baesongVO.setOrderIdx(orderVOS.get(0).getOrderIdx());
		baesongVO.setAddress(payMentVO.getBuyer_addr());
		baesongVO.setTel(payMentVO.getBuyer_tel());
		System.out.println("baesongVo : " + baesongVO);

		dbShopService.setDbBaesong(baesongVO); 

		dbShopService.setMemberMinusPoint(baesongVO.getMid(), baesongVO.getUsingPoint());
		dbShopService.setUsingPoint(baesongVO.getMid(), baesongVO.getUsingPoint(),baesongVO.getOrderIdx(),"주문 시 사용"); 

		return "redirect:/message/paymentResultOk";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/paymentResult", method = RequestMethod.GET)
	public String paymentResultGet(HttpSession session, DbPayMentVO receivePayMentVO, Model model) {
		
		List<DbOrderVO> orderVOS = (List<DbOrderVO>) session.getAttribute("sOrderVOS");
		DbPayMentVO payMentVO = (DbPayMentVO) session.getAttribute("sPayMentVO");
		DbBaesongVO baesongVO = (DbBaesongVO) session.getAttribute("sBaesongVO");
		session.removeAttribute("sBaesongVO");

		for (DbOrderVO vo : orderVOS) {
			vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8))); 
			vo.setOrderIdx(vo.getOrderIdx());
			vo.setMid(vo.getMid());

			dbShopService.setDbOrder(vo); .
			dbShopService.setDbCartDeleteAll(vo.getCartIdx()); 

		}

		baesongVO.setOIdx(orderVOS.get(0).getIdx());
		baesongVO.setOrderIdx(orderVOS.get(0).getOrderIdx());
		baesongVO.setAddress(payMentVO.getBuyer_addr());
		baesongVO.setTel(payMentVO.getBuyer_tel());

		dbShopService.setDbBaesong(baesongVO);
		
		payMentVO.setImp_uid(receivePayMentVO.getImp_uid());
		payMentVO.setMerchant_uid(receivePayMentVO.getMerchant_uid());
		payMentVO.setPaid_amount(receivePayMentVO.getPaid_amount());
		payMentVO.setApply_num(receivePayMentVO.getApply_num());

		session.setAttribute("sPayMentVO", payMentVO);
		session.setAttribute("orderTotalPrice", baesongVO.getOrderTotalPrice());

		return "redirect:/message/paymentResultOk";
	}


	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value = "/paymentResultOk", method = RequestMethod.GET)
	public String paymentResultOkGet(HttpSession session, Model model) {
		List<DbOrderVO> orderVOS = (List<DbOrderVO>) session.getAttribute("sOrderVOS");
		model.addAttribute("orderVOS", orderVOS);
		session.removeAttribute("sOrderVOS");
		return "dbShop/paymentResult";
	}


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

		List<DbBaesongVO> vos = dbShopService.getMyOrderList(pageVO.getStartIndexNo(), pageSize, mid, startJumun, endJumun,
				conditionOrderStatus);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("conditionOrderStatus", conditionOrderStatus);

		return "dbShop/dbMyOrder";
	}

	@ResponseBody
	@RequestMapping(value = "/wishCheck", method = RequestMethod.POST)
	public void wishDBCheckPost(WishVO wishVO) {
		if (wishVO.getIdx() == 0) {
			dbShopService.setWishDBInput(wishVO);
		} else {
			dbShopService.setWishDBDelete(wishVO.getIdx());
		}
	}

	@RequestMapping(value = "/dbWishList", method = RequestMethod.GET)
	public String wishListGet(HttpSession session, Model model, WishVO wishVO) {
		String mid = (String) session.getAttribute("sMid");
		List<WishVO> vos = dbShopService.getWishList(mid);

		List<WishVO> idxVOS = dbShopService.getThreeMonthExceedWishIdx(mid);
		if (idxVOS != null) {
			for (WishVO vo : idxVOS) {
				dbShopService.setWishDBDelete(vo.getIdx());
			}
		}
		model.addAttribute("vos", vos);
		return "dbShop/dbWishList";
	}


	@ResponseBody
	@RequestMapping(value = "/wishDelete", method = RequestMethod.POST)
	public void wishDeletePost(int idx) {
		dbShopService.setWishDBDelete(idx);
	}


	@ResponseBody
	@RequestMapping(value = "/wishDelete2", method = RequestMethod.POST)
	public void wishDelete2Post(String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			dbShopService.setWishDBDelete(Integer.parseInt(idxMulti[i]));
		}
	}


	@RequestMapping(value = "/dbOrderDetail", method = RequestMethod.GET)
	public String dbOrderDetailGet(HttpSession session, Model model, String orderIdx) {

		String mid = (String) session.getAttribute("sMid");
		DbBaesongVO vo = dbShopService.getOrderOne(orderIdx, mid); 
		List<DbBaesongVO> vos = dbShopService.getOrders(orderIdx, mid); 

		model.addAttribute("vo", vo);
		model.addAttribute("vos", vos);
		model.addAttribute("mid", mid);
		return "dbShop/dbOrderDetail";
	}


	@RequestMapping(value = "/orderChildWin", method = RequestMethod.GET)
	public String orderChildWinGet(HttpSession session, Model model, String orderIdx) {

		String mid = (String) session.getAttribute("sMid");
		List<DbBaesongVO> vos = dbShopService.getOrders(orderIdx, mid);

		model.addAttribute("vos", vos);
		model.addAttribute("mid", mid);
		return "dbShop/orderChildWin";
	}

	
	@ResponseBody
	@RequestMapping(value = "/orderConfirm", method = RequestMethod.POST)
	public String orderConfirmGet(HttpSession session, Model model, String idxs) {

		String mid = (String) session.getAttribute("sMid");
		String[] idx = idxs.split("/");

		for (int i = 0; i < idx.length; i++) {
			DbOrderVO vo = dbShopService.getOrdersOne(Integer.parseInt(idx[i]));

			int point = (int) (vo.getTotalPrice() * 0.01);
			dbShopService.setGetPoint(vo.getProductName(), point, mid, "상품구매"); 
			dbShopService.setMemberPlusPoint(mid, point); 
			dbShopService.setOrderStatusChange(Integer.parseInt(idx[i]), "구매확정");
		}
		return "1";
	}

	
	@RequestMapping(value = "/orderCancelChild", method = RequestMethod.GET)
	public String orderCancelChildGet(HttpSession session, Model model, int idx) {

		DbOrderVO vo = dbShopService.getOrdersOne(idx);

		model.addAttribute("vo", vo);
		return "dbShop/orderCancelChild";
	}

	@RequestMapping(value = "/orderCancelChild", method = RequestMethod.POST)
	public String orderCancelChildPost(DbOrderCancelVO vo) {
		dbShopService.setOrderCancel(vo);
		if (vo.getCancelStatus().equals("반품요청"))
			dbShopService.setOrderStatusChange(vo.getCancelIdx(), "반품요청");
		else if (vo.getCancelStatus().equals("환불요청"))
			dbShopService.setOrderStatusChange(vo.getCancelIdx(), "환불요청");

		return "dbShop/orderCancelOk";
	}


	@RequestMapping(value = "/dbPoint", method = RequestMethod.GET)
	public String dbPointGet(HttpSession session, Model model) {

		String mid = (String) session.getAttribute("sMid");
		List<DbPointVO> vos = dbShopService.getDbPoint(mid);

		model.addAttribute("vos", vos);
		return "dbShop/dbPoint";
	}

	@RequestMapping(value = "/dbReviewForm", method = RequestMethod.GET)
	public String dbReviewFormGet(Model model, int idx) {

		DbOrderVO vo = dbShopService.getOrdersOne(idx);

		model.addAttribute("vo", vo);
		return "dbShop/dbReviewForm";
	}


	@RequestMapping(value = "/dbReviewForm", method = RequestMethod.POST)
	public String dbReviewFormPost(DbReviewVO vo, MultipartHttpServletRequest file, int idx) {
		int res = dbShopService.setReviewInput(vo, file);

		if (res == 1) {
			dbShopService.setOrderReviewChange(idx, "OK"); 
			dbShopService.setGetPoint(vo.getProductName(), 500, vo.getMid(), "리뷰작성"); 
			dbShopService.setMemberPlusPoint(vo.getMid(), 500); 
			return "redirect:/message/reviewInputOk";
		} else
			return "redirect:/message/reviewInputNo";
	}

	@RequestMapping(value = "/userReview", method = RequestMethod.GET)
	public String dbUserReviewGet(Model model, HttpSession session) {

		String mid = (String) session.getAttribute("sMid");

		List<DbReviewVO> VOS = dbShopService.getUserReivew(mid);
		model.addAttribute("VOS", VOS);

		return "dbShop/userReview";
	}
	
	@RequestMapping(value = "/dbOnedayClass", method = RequestMethod.GET)
	public String dbOnedayClassGet(Model model) {
		List<MemberVO> vos = dbShopService.getClassValidMember();
		model.addAttribute("vos",vos); 
		return "dbShop/dbOnedayClass";
	}
	
	@ResponseBody
	@RequestMapping(value = "/dbOnedayClassApplication", method = RequestMethod.POST)
	public String dbOnedayClassInputPost(String mid, String className, String store, String wDate, int memberNum) {
		
		dbShopService.setOnedayClassApplication(mid, className, store, wDate, memberNum);
		return "1";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/onedayClassConfirm", method = RequestMethod.POST)
	public String onedayClassConfirmPost(Model model, HttpServletRequest request, int idx,
			String mid, String className, String store, String wDate, int memberNum,String classTemp
			) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		String qrCodeName = dbShopService.onedayClassInput(idx, mid, className, store, wDate, memberNum,classTemp, realPath);
		
		return "1";
	}
	


	@RequestMapping(value = "/dbMyOnedayClass", method = RequestMethod.GET)
	public String dbMyOnedayClassGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		 List<DbOnedayClassVO> vos =  dbShopService.getMyOnedayClass(mid);
		 model.addAttribute("vos",vos);
		return "dbShop/dbMyOnedayClass";
	}
	
	@RequestMapping(value = "/qrCodeWin", method = RequestMethod.GET)
	public String qrCodeWinGet(Model model, HttpSession session, int idx) {
		String mid = (String) session.getAttribute("sMid");
		DbOnedayClassVO vo = dbShopService.getOnedayClassOne(idx);
		model.addAttribute("vo",vo);
		return "dbShop/dbQrCodeNew";
	}
	

	@ResponseBody
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
	public String reviewDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			dbShopService.setReviewDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	

	@ResponseBody
	@RequestMapping(value = "/userOrderCancel", method = RequestMethod.POST)
	public String userOrderCancelPost(Model model, int idx, int productIdx, String optionName, int optionNum) {
		dbShopService.setOrderStatusChange(idx, "결제취소");
		dbShopService.setOptionStockPlus(productIdx,optionName,optionNum);
		return "1";
	}
	
	
	@RequestMapping(value = "/orderCancelReason", method = RequestMethod.GET)
	public String orderCancelReasonGet(int idx, Model model) {
		DbOrderCancelVO vo = dbShopService.getOrderCancelsOne(idx);
		model.addAttribute("vo", vo);
		return "dbShop/orderCancelReason";
	}
	
	
	@RequestMapping(value = "/reviewReportChild", method = RequestMethod.GET)
	public String reviewReportChildGet(int idx, Model model) {
		DbReviewVO vo = dbShopService.getReviewOne(idx);
		model.addAttribute("vo", vo);
		return "dbShop/reviewReportChild";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reviewReportChild", method = RequestMethod.POST)
	public String reviewReportChildPost(ReportReviewVO vo, Model model) {
		ReportReviewVO rpVO = dbShopService.getExistReportReview(vo.getIdx(), vo.getMid());
		if(rpVO != null) {
			return "0";
		} 
		dbShopService.setReportReview(vo);
		dbShopService.setReportReviewNum(vo.getIdx());
		return "1";
	}
	
	
	@RequestMapping(value = "/userShppingList", method = RequestMethod.GET)
	public String userShppingListGet(Model model,HttpSession session) {
		
		String mid = (String) session.getAttribute("sMid");
		List<DbShippingListVO> vos = dbShopService.getUserShippingList(mid);
		
		model.addAttribute("vos", vos);
		return "dbShop/userShppingList";
	}
	
	@RequestMapping(value = "/userShppingAdd", method = RequestMethod.GET)
	public String userShppingAddGet(Model model,HttpSession session) {
		return "dbShop/userShppingAdd";
	}
	
	@ResponseBody
	@RequestMapping(value = "/userShppingAdd", method = RequestMethod.POST)
	public String userShppingAddPost(DbShippingListVO vo, Model model) {
		
		dbShopService.setShippingList(vo);
		return "1";
	}
	
	@RequestMapping(value = "/memberShppingList", method = RequestMethod.GET)
	public String memberShppingListGet(Model model,HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		List<DbShippingListVO> vos = dbShopService.getUserShippingList(mid);
		
		model.addAttribute("vos", vos);
		
		return "dbShop/memberShppingList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/shippingDelete", method = RequestMethod.POST)
	public String shippingDeletePost(int idx) {
		dbShopService.setShippingDelete(idx);
		return "1";
	}
	
	@RequestMapping(value = "/memberShippingModify", method = RequestMethod.GET)
	public String shippingModifyGet(int idx, Model model) {
		 DbShippingListVO vo = dbShopService.getShipping(idx);
		 model.addAttribute("vo",vo);
		 
		return "dbShop/memberShippingModify";
	}
	
	@ResponseBody
	@RequestMapping(value = "/memberShippingModify", method = RequestMethod.POST)
	public String shippingModifyPost(DbShippingListVO vo, Model model) {
		dbShopService.setMemberShippingModify(vo);
		return "1";
	}
	
	
	
	
	
}
