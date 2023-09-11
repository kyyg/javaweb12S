package com.spring.javaweb12S;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb12S.common.JavawebProvide;
import com.spring.javaweb12S.pagination.PageProcess;
import com.spring.javaweb12S.pagination.PageVO;
import com.spring.javaweb12S.service.AdminService;
import com.spring.javaweb12S.service.BoardService;
import com.spring.javaweb12S.service.ContactService;
import com.spring.javaweb12S.service.DbShopService;
import com.spring.javaweb12S.service.MemberService;
import com.spring.javaweb12S.service.NoticeService;
import com.spring.javaweb12S.service.QnaService;
import com.spring.javaweb12S.vo.BoardReplyVO;
import com.spring.javaweb12S.vo.BoardVO;
import com.spring.javaweb12S.vo.ChartVO;
import com.spring.javaweb12S.vo.ContactReplyVO;
import com.spring.javaweb12S.vo.ContactVO;
import com.spring.javaweb12S.vo.DbBaesongVO;
import com.spring.javaweb12S.vo.DbOnedayClassVO;
import com.spring.javaweb12S.vo.DbOptionVO;
import com.spring.javaweb12S.vo.DbOrderCancelVO;
import com.spring.javaweb12S.vo.DbOrderVO;
import com.spring.javaweb12S.vo.DbReviewVO;
import com.spring.javaweb12S.vo.GoodVO;
import com.spring.javaweb12S.vo.KakaoAddressVO;
import com.spring.javaweb12S.vo.MemberVO;
import com.spring.javaweb12S.vo.NoticeVO;
import com.spring.javaweb12S.vo.QnaVO;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	DbShopService dbShopService;
	
	@Autowired
	ContactService contactService;
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	PageProcess pageProcess;
	
  @Autowired
  JavawebProvide javawebProvide;
	
	
	@RequestMapping(value = "/adminMain", method = RequestMethod.GET)
	public String adminMain() {
		return "admin/adminMain";
	}
		
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String indexGet(Model model) {

		List<ChartVO> vos = adminService.getChart1();
		model.addAttribute("chart1VOS",vos);
		List<ChartVO> vos1 = adminService.getChart2();
		model.addAttribute("chart2VOS",vos1);
		List<ChartVO> vos2 = adminService.getChart3();
		model.addAttribute("chart3VOS",vos2);
		
		List<DbBaesongVO> order4VOS = adminService.getOrder4(); 
		List<DbOrderCancelVO> cancelorder4VOS = adminService.getCancelOrder4(); 
		List<BoardVO> baord4VOS = adminService.getBoard4(); 
		List<DbOnedayClassVO> class4VOS = adminService.getclass4(); 
		
		model.addAttribute("order4VOS",order4VOS);
		model.addAttribute("cancelorder4VOS",cancelorder4VOS);
		model.addAttribute("baord4VOS",baord4VOS);
		model.addAttribute("class4VOS",class4VOS);
		
		int weekOrder = adminService.getWeekOrder();
		int weekCancel = adminService.getWeekCancel();
		int weekBoard = adminService.getWeekBoard();
		int weekClass = adminService.getWeekClass();
		
		model.addAttribute("weekOrder",weekOrder);
		model.addAttribute("weekCancel",weekCancel);
		model.addAttribute("weekBoard",weekBoard);
		model.addAttribute("weekClass",weekClass);
		
		List<DbOptionVO> optionVOS = adminService.getAllOptionList(); 
		model.addAttribute("optionVOS",optionVOS);
		model.addAttribute("optionVOSsize",optionVOS.size());
		
		return "admin/index";
	}
	
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginGet() {
		return "admin/login";
	}
	
	@RequestMapping(value = "/cards", method = RequestMethod.GET)
	public String cardsGet() {
		return "admin/cards";
	}
	
	@RequestMapping(value = "/adminLeft", method = RequestMethod.GET)
	public String adminLeft() {
		return "admin/adminLeft";
	}
	
	@RequestMapping(value = "/adminContent", method = RequestMethod.GET)
	public String adminContent() {
		return "admin/adminContent";
	}
	
	
	@RequestMapping(value = "/adminMemberList", method = RequestMethod.GET)
	public String adminMemberListGet(MemberVO vo, Model model,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required = false) int pageSize) {
		
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "member", "", mid);
		List<MemberVO> vos = memberService.getMemberList(pageVO.getStartIndexNo(), pageSize, mid);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		model.addAttribute("mid", mid);
		return "admin/adminMember/adminMemberList";
	}
	
	@RequestMapping(value = "/adminNoticeList", method = RequestMethod.GET)
	public String adminNoticeListGet(MemberVO vo, Model model,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required=false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", "", "");
		
		List<NoticeVO> vos = noticeService.getNoticeList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/adminBoard/adminNoticeList";
	}
	
	@RequestMapping(value = "/adminNoticeInput", method = RequestMethod.GET)
	public String noticeInputGet() {
		return "admin/adminBoard/adminNoticeInput";
	}
	
	@RequestMapping(value = "/adminNoticeInput", method = RequestMethod.POST)
	public String noticeInputPost(NoticeVO vo) {
		
		noticeService.imgCheck(vo.getContent());
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
		int res = noticeService.setNoticeInput(vo);
		if(res == 1) return "redirect:/message/noticeInputOk";
		else return "redirect:/message/noticeInputNo";
	}


	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/adminNoticeContent", method = RequestMethod.GET)
	public String noticeContentGet(HttpSession session,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "notice" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			noticeService.setNoticeReadNum(idx);	
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		NoticeVO vo = noticeService.getNoticeContent(idx);
		
		ArrayList<NoticeVO> pnVos = noticeService.getPrevNext(idx);
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
			
		return "admin/adminBoard/adminNoticeContent";
	}
	
	@RequestMapping(value = "/adminNoticeDelete", method = RequestMethod.GET)
	public String noticeDeleteGet(HttpSession session, HttpServletRequest request,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			@RequestParam(name="nickName", defaultValue = "", required=false) String nickName
			) {
		NoticeVO vo = noticeService.getNoticeContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(vo.getContent());
		
		int res = noticeService.setNoticeDelete(idx);
		
		if(res == 1) return "redirect:/message/adminNoticeDeleteOk";
		else return "redirect:/message/adminNoticeDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	

	@RequestMapping(value = "/adminNoticeUpdate", method = RequestMethod.GET)
	public String noticeUpdateGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize
		) {
		
		NoticeVO vo = noticeService.getNoticeContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgCheckUpdate(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "admin/adminBoard/adminNoticeUpdate";
	}
	
	
	@RequestMapping(value = "/adminNoticeUpdate", method = RequestMethod.POST)
	public String noticeUpdatePost(NoticeVO vo,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		
		NoticeVO origVO = noticeService.getNoticeContent(vo.getIdx());
		
		
		if(!origVO.getContent().equals(vo.getContent())) {
			
			if(origVO.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(origVO.getContent());
			vo.setContent(vo.getContent().replace("/data/notice/", "/data/ckeditor/"));
			noticeService.imgCheck(vo.getContent());
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
		}
		
		int res = noticeService.setNoticeUpdate(vo);
		
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		if(res == 1) {
			return "redirect:/message/adminNoticeUpdateOk";
		}
		else {
			return "redirect:/message/adminNoticeUpdateNo";
		}
	}
	
	
	
	
	@RequestMapping(value = "/adminBoardList", method = RequestMethod.GET)
	public String boardListGet(
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required=false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required=false) String part,
			Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", part, "");
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageSize, part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/adminBoard/adminBoardList";
	}
	
	@RequestMapping(value = "/adminBoardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "admin/adminBoard/adminBoardInput";
	}
	
	
	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/adminBoardContent", method = RequestMethod.GET)
	public String boardContentGet(HttpSession session,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "board" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			boardService.setBoardReadNum(idx);	// 조회수 1증가하기
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		BoardVO vo = boardService.getBoardContent(idx);
		
		ArrayList<BoardVO> pnVos = boardService.getPrevNext(idx);
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		
		ArrayList<String> goodIdx = (ArrayList) session.getAttribute("sGoodIdx");
		if(goodIdx == null) {
			goodIdx = new ArrayList<String>();
		}
		String imsiGoodIdx = "boardGood" + idx;
		if(goodIdx.contains(imsiGoodIdx)) {
			session.setAttribute("sSw", "1");		
		}
		else {
			session.setAttribute("sSw", "0");
		}
		
		
		String mid = (String) session.getAttribute("sMid");
		GoodVO goodVo = boardService.getBoardGoodCheck(idx, "board", mid);
		model.addAttribute("goodVo", goodVo);
		
		List<BoardReplyVO> replyVOS = boardService.setBoardReply(idx);
		model.addAttribute("replyVOS", replyVOS);
		
		return "admin/adminBoard/adminBoardContent";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminBoardGoodDBCheck", method=RequestMethod.POST)
	public void boardGoodDBCheckPost(GoodVO goodVo) {
		if(goodVo.getIdx() == 0) {
			boardService.setGoodDBInput(goodVo);
			boardService.setGoodUpdate(goodVo.getPartIdx(), 1);
		}
		else {
			boardService.setGoodDBDelete(goodVo.getIdx());
			boardService.setGoodUpdate(goodVo.getPartIdx(), -1);
		}
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/adminBoardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(HttpSession session, HttpServletRequest request,int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize) {
		
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent());
		
		int res = boardService.setBoardDelete(idx);
		
		if(res == 1) return "redirect:/message/adminBoardDeleteOk";
		else return "redirect:/message/adminBoardDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	

	@ResponseBody
	@RequestMapping(value = "/adminBoardAnswerChange", method = RequestMethod.POST)
	public String adminBoardAnswerChangePost(
			@RequestParam(name="openSw", defaultValue = "", required=false) String openSw,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx) {
		boardService.setAdminBoardAnswerChange(openSw, idx);
		return "1";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/adminBoardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReplyVO replyVO) {
		String strGroupId = boardService.getMaxGroupId(replyVO.getBoardIdx());
		if(strGroupId != null) replyVO.setGroupId(Integer.parseInt(strGroupId)+1);
		else replyVO.setGroupId(0);
		replyVO.setLevel(0);
		
		boardService.setBoardReplyInput(replyVO);
		
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminBoardReplyInput2", method = RequestMethod.POST)
	public String boardReplyInput2Post(BoardReplyVO replyVO) {
		replyVO.setLevel(replyVO.getLevel()+1);
		boardService.setBoardReplyInput(replyVO);
		
		return "1";
	}


	@ResponseBody
	@RequestMapping(value = "/adminBoardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(
			@RequestParam(name="replyIdx", defaultValue = "0", required=false) int replyIdx,
			@RequestParam(name="level", defaultValue = "0", required=false) int level) {
		BoardReplyVO replyVO = boardService.getBoardReplyIdx(replyIdx);
		boardService.setBoardReplyDelete(replyVO.getIdx(), replyVO.getLevel(), replyVO.getGroupId(), replyVO.getBoardIdx());
		
		return "1";
	}

	@ResponseBody
	@RequestMapping(value = "/adminBoardReplyUpdate", method = RequestMethod.POST)
	public String boardReplyUpdatePost(
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="content", defaultValue = "", required=false) String content,
			@RequestParam(name="hostIp", defaultValue = "", required=false) String hostIp) {
		boardService.setBoardReplyUpdate(idx,content,hostIp);
		
		return "1";
	}

	
	@RequestMapping(value="/adminOrder", method=RequestMethod.GET)
	public String adminOrderGet(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="20", required=false) int pageSize,
			String conditionOrderStatus,String startJumun, String endJumun
			) {

		String mid = (String) session.getAttribute("sMid"); 
		int level = (int) session.getAttribute("sLevel");
		if(level == 0) mid = "전체";
		
		PageVO pageVO = pageProcess.totRecCnt10(pag, pageSize, "dbMyOrder", mid, "");
		
		List<DbBaesongVO> vos = dbShopService.getMyOrderList(pageVO.getStartIndexNo(), pageSize, mid,startJumun,endJumun,conditionOrderStatus);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("conditionOrderStatus",conditionOrderStatus);
		
		return "admin/dbShop/adminOrder";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/orderStatusChange", method = RequestMethod.POST)
	public String orderStatusChangePost(int idx, String status) {
		dbShopService.setOrderStatusChange(idx,status);
		return "";
	}
	
	@ResponseBody
	@RequestMapping(value="/adminShippingConfirm", method=RequestMethod.POST)
	public String adminShippingConfirmPost(String optionName, int productIdx, int optionNum,int idx) {
		
		dbShopService.setAdminShippingMinus(optionName,productIdx,optionNum);
		dbShopService.setOrderStatusChange(idx, "배송중");
		
		return "admin/dbShop/adminOrder";
	}
	
	@RequestMapping(value="/adminCancelOrder", method=RequestMethod.GET)
	public String adminCancelOrderGet(DbOrderCancelVO vo,Model model) {

		List<DbOrderCancelVO> vos = dbShopService.getAdminCancelOrder();
		
		model.addAttribute("vos",vos);
		return "admin/dbShop/adminCancelOrder";
	}
	
	@ResponseBody
	@RequestMapping(value="/adminCancelOrderChange", method=RequestMethod.POST)
	public String adminCancelOrderChangePost(String status, String idxs) {
		
		String[] idx = idxs.split("/");
		
		for(int i=0; i<idx.length; i++) {
			DbOrderVO vo = dbShopService.getOrdersOne(Integer.parseInt(idx[i]));
			
			dbShopService.setAdminShippingPlus(vo.getProductIdx(), vo.getOptionName(), vo.getOptionNum()); // 옵션DB재고 수량 다시 복원
			dbShopService.setOrderStatusChange(Integer.parseInt(idx[i]), status); // orderDB에 있는 상태 바꾸고 
			dbShopService.setCancelStatusChange(Integer.parseInt(idx[i]), status); // cancel DB에 있는 상태 바꾸공
		}
		return "admin/dbShop/adminCancelOrder";
	}
	
	@RequestMapping(value = "/kakaomap/storeRegistration", method = RequestMethod.GET)
	public String storeRegistrationGet(Model model,
			@RequestParam(name="address", defaultValue = "그라운드시소", required=false) String address) {
		model.addAttribute("address", address);
		return "admin/kakaomap/storeRegistration";
	}
	
	@ResponseBody
	@RequestMapping(value = "/kakaomap/kakaoRegistration", method = RequestMethod.POST)
	public String storeRegistrationPost(String store_name, double lat, double lng, String detail_address,String rode_address,String store_tel) {
		adminService.setKakaoAddressInput(store_name,lat,lng,detail_address,rode_address,store_tel);
		return "1";
	}
	
	@RequestMapping(value = "/kakaomap/kakaoStoreList", method = RequestMethod.GET)
	public String storeListGet(Model model,
			@RequestParam(name="store_name", defaultValue = "그린 아트 스튜디오", required=false) String store_name) {
		KakaoAddressVO vo = adminService.getKakaoAddressName(store_name);
		List<KakaoAddressVO> vos = adminService.getKakaoAddressList();
		
		model.addAttribute("vo", vo);
		model.addAttribute("vos", vos);
		model.addAttribute("store_name", store_name);
		
		return "admin/kakaomap/kakaoStoreList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/kakaomap/kakaoAddressDelete", method = RequestMethod.POST)
	public String kakaoAddressDeletePost(String address) {
		adminService.setKakaoAddressDelete(address);
		return "";
	}
	
	@RequestMapping(value = "/adminReviewList", method = RequestMethod.GET)
	public String adminReviewListGet(Model model) {
		List<DbReviewVO> vos = dbShopService.getAllReviewList();
		model.addAttribute("vos",vos);
		return "admin/dbShop/adminReviewList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
	public String reviewDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			adminService.setReviewDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/boardDelete", method = RequestMethod.POST)
	public String boardDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			adminService.setBoardDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/noticeDelete", method = RequestMethod.POST)
	public String noticeDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			adminService.setNoticeDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	@ResponseBody
	@RequestMapping(value = "/onedayClassDelete", method = RequestMethod.POST)
	public String onedayClassDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			adminService.setOnedayClassDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	@RequestMapping(value = "/adminOnedayClass", method = RequestMethod.GET)
	public String adminOnedayClassGet(Model model) {
		List<DbOnedayClassVO> vos = adminService.getAllOnedayClassList();
		model.addAttribute("vos",vos);
		return "admin/dbShop/adminOnedayClass";
	}
	
	@RequestMapping(value = "/adminOptionNew", method = RequestMethod.GET)
	public String adminOptionNewGet(Model model, int idx) {
		int productIdx = idx;
		List<DbOptionVO> vos = dbShopService.getOptionList(productIdx);
		model.addAttribute("vos",vos);
		System.out.println("adminOptionNew : " + vos);
		return "admin/dbShop/adminOptionNew";
	}
	
	@ResponseBody
	@RequestMapping(value = "/optionUpdate", method = RequestMethod.POST)
	public String optionUpdatePost(int idx, String optionName, int optionPrice, int optionStock) {
		dbShopService.setOptionUpdate(idx,optionName,optionPrice,optionStock);
		return "1";
	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "/bestReviewChange", method = RequestMethod.POST)
	public String bestReviewChangePost(Model model,int idx,String mid, String productName) {
		
		String productIdx = productName;
		adminService.setBestReview(idx, "OK"); // 베스트 리뷰 상태  변경
		dbShopService.setGetPoint(productIdx, 1000, mid, "베스트리뷰 선정"); // 해당 회원 포인트1000 db에 내역 저장
		dbShopService.setMemberPlusPoint(mid, 1000); // 해당 회원 멤버 포인트 지급
		return "1";
	}
	
	@RequestMapping(value = "/adminContactList", method = RequestMethod.GET)
	public String adminContactListGet(Model model,
			@RequestParam(name="part", defaultValue = "전체", required=false) String part
			) {
		List<ContactVO> vos = adminService.getAllContactList(part);
		model.addAttribute("vos",vos);
		model.addAttribute("part",part);
		System.out.println("vos : " + vos);
		System.out.println("part : "+ part);
		return "admin/contact/adminContactList";
	}
	
	@RequestMapping(value = "/adminContactReply", method = RequestMethod.GET)
	public String adminContactReplyGet(int idx, Model model) {
		ContactVO vo = contactService.getContactContent(idx);
		
		ContactReplyVO reVO = contactService.getContactReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		
		return "admin/contact/adminContactReply";
	}
	
	
	@RequestMapping(value = "/adminContactReplyInput", method = RequestMethod.POST)
	public String adminContactReplyInputPost(ContactReplyVO vo) {
		 adminService.getContactReply(vo);
		 adminService.setAdminContactPartChange(vo.getContactIdx());
		return "1";
	}
	
	@RequestMapping(value = "/adminContactReplyUpdate", method = RequestMethod.POST)
	public String adminContactReplyUpdatePost(int reIdx,String reContent) {
		adminService.setAdminContactReplyUpdate(reIdx,reContent);
		return "1";
	}


	@RequestMapping(value = "/adminCancleNew", method = RequestMethod.GET)
	public String adminCancleNewGet(int idx, Model model) {
		DbOrderCancelVO vo = adminService.getOrderCancelOne(idx);
		model.addAttribute("vo", vo);
		return "admin/dbShop/adminCancleNew";
	}
	
	@ResponseBody
	@RequestMapping(value = "/adminOrderCancelNO", method = RequestMethod.POST)
	public String adminOrderCancelNOPost(int idx, int cancelIdx, String reason1, String reason2) {
		adminService.setOrderCancelNo(idx,"승인 불가", reason1,reason2);
		adminService.setOrderCancelNo2(cancelIdx,"승인 불가");
		return "1";
	}
	
	
	@RequestMapping(value = "/adminReportReviewList", method = RequestMethod.GET)
	public String adminReportReviewListGet(Model model) {
		List<DbReviewVO> vos = adminService.getReportReview();
		model.addAttribute("vos", vos);
		return "admin/dbShop/adminReportReviewList";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/reviewRestore", method = RequestMethod.POST)
	public String reviewRestorePost(String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			adminService.setReportreviewRestore(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	
	@RequestMapping(value = "/adminQnaList", method = RequestMethod.GET)
	public String adminQnaListGet(  		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "20", required = false) int pageSize,
			Model model) {
  	PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
		List<QnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		return "admin/adminBoard/adminQnaList";
	}
	
	@RequestMapping(value = "/adminQnaContent", method = RequestMethod.GET)
	public String adminQnaContentGet(int idx,Model model) {
		QnaVO vo =  qnaService.getQnaContent(idx);
		model.addAttribute("vo", vo);
		return "admin/adminBoard/adminQnaContent";
	}
	
	@RequestMapping(value = "/adminQnaContent", method = RequestMethod.POST)
  public String adminQnaContentPost(QnaVO vo, HttpSession session) {
  	if(vo.getContent().indexOf("src=\"/") != -1) {
  		javawebProvide.imgCheck(vo.getContent(), "qna");	
  		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/qna/"));
  	}
  	

  	int level = (int) session.getAttribute("sLevel");
  	
  	int newIdx = qnaService.getMaxIdx() + 1;
  	vo.setIdx(newIdx);

  	String qnaIdx = "";
  	if(newIdx < 10) qnaIdx = "0"+ newIdx + "_2";
  	else qnaIdx = newIdx + "_2";
  	
  	if(vo.getQnaSw().equals("a")) {  
  		qnaIdx = vo.getQnaIdx().split("_")[0]+"_1";
  		if(level == 0) vo.setTitle(vo.getTitle().replace("(Re)", "<font color='red'>(Re)</font>"));
  	}
  	vo.setQnaIdx(qnaIdx);
  	
  	qnaService.qnaInputOk(vo);
  	
  	return "redirect:/message/qnaInputOk2";
	}
	
	
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/fileList", method = RequestMethod.GET)
	public String fileListGet(HttpServletRequest request, Model model) {
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		
		String[] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		
		return "admin/fileList";
	}
	
	
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/fileSelectDelete", method = RequestMethod.POST)
	public String fileSelectDeleteGet(HttpServletRequest request, String delItems) {
		// System.out.println("delItems : " + delItems);
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		delItems = delItems.substring(0, delItems.length()-1);
		
		String[] fileNames = delItems.split("/");
		
		for(String fileName : fileNames) {
			String realPathFile = realPath + fileName;
			new File(realPathFile).delete();
		}
		
		return "1";
	}
	
	
	
	
}
