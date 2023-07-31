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
		// 3D 도넛 차트
		List<ChartVO> vos = adminService.getChart1();
		model.addAttribute("chart1VOS",vos);
		// 바 차트(월별 매출 / 월별 취소)
		List<ChartVO> vos1 = adminService.getChart2();
		model.addAttribute("chart2VOS",vos1);
		List<ChartVO> vos2 = adminService.getChart3();
		model.addAttribute("chart3VOS",vos2);
		
		// 새로운 주문 / 새로운 취소 / 새로운 문의글 / 재고관리 (3건씩)
		List<DbBaesongVO> order4VOS = adminService.getOrder4(); 
		List<DbOrderCancelVO> cancelorder4VOS = adminService.getCancelOrder4(); 
		List<BoardVO> baord4VOS = adminService.getBoard4(); 
		List<DbOnedayClassVO> class4VOS = adminService.getclass4(); 
		
		model.addAttribute("order4VOS",order4VOS);
		model.addAttribute("cancelorder4VOS",cancelorder4VOS);
		model.addAttribute("baord4VOS",baord4VOS);
		model.addAttribute("class4VOS",class4VOS);
		
		// 주간 주문량 / 반품환불 / 문의 / 클래스
		int weekOrder = adminService.getWeekOrder();
		int weekCancel = adminService.getWeekCancel();
		int weekBoard = adminService.getWeekBoard();
		int weekClass = adminService.getWeekClass();
		
		model.addAttribute("weekOrder",weekOrder);
		model.addAttribute("weekCancel",weekCancel);
		model.addAttribute("weekBoard",weekBoard);
		model.addAttribute("weekClass",weekClass);
		
		// 재고현황(10개 미만)
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
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/notice/폴더에 저장시켜준다.
		noticeService.imgCheck(vo.getContent());
		
		// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 notice폴더 경로로 변경한다.(/resources/data/ckeditor/ ===>> /resources/data/notice/)
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));

		// content안의 내용정리가 끝나면 변경된 vo를 DB에 저장시켜준다.
		int res = noticeService.setNoticeInput(vo);
		
		if(res == 1) return "redirect:/message/noticeInputOk";
		else return "redirect:/message/noticeInputNo";
	}

	// 글내용 상세보기
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/adminNoticeContent", method = RequestMethod.GET)
	public String noticeContentGet(HttpSession session,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		// 글 조회수 1씩 증가시키기(조회수 중복방지 - 세션처리('notice+고유번호'를 객체배열에 추가시켜준다.)
		ArrayList<String> contentIdx = (ArrayList) session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String imsiContentIdx = "notice" + idx;
		if(!contentIdx.contains(imsiContentIdx)) {
			noticeService.setNoticeReadNum(idx);	// 조회수 1증가하기
			contentIdx.add(imsiContentIdx);
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		NoticeVO vo = noticeService.getNoticeContent(idx);
		
		// 이전글/다음글 가져오기
		ArrayList<NoticeVO> pnVos = noticeService.getPrevNext(idx);
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
			
		return "admin/adminBoard/adminNoticeContent";
	}
	
//게시글 삭제하기
	@RequestMapping(value = "/adminNoticeDelete", method = RequestMethod.GET)
	public String noticeDeleteGet(HttpSession session, HttpServletRequest request,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			@RequestParam(name="nickName", defaultValue = "", required=false) String nickName
			) {
		// String sNickName = (String) session.getAttribute("sNickName");
		// if(!sNickName.equals(nickName)) return "redirect:/";
		
		// 게시글에 사진이 존재한다면 서버에 있는 사진파일을 먼저 삭제처리한다.
		NoticeVO vo = noticeService.getNoticeContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(vo.getContent());
		
		// DB에서 실제로 존재하는 게시글을 삭제처리한다.
		int res = noticeService.setNoticeDelete(idx);
		
		if(res == 1) return "redirect:/message/adminNoticeDeleteOk";
		else return "redirect:/message/adminNoticeDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	
	// 게시글 수정하기 폼 호출
	@RequestMapping(value = "/adminNoticeUpdate", method = RequestMethod.GET)
	public String noticeUpdateGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize
		) {
		// 수정창으로 이동시에는 먼저 원본파일에 그림파일이 있다면, 현재폴더(notice)의 그림파일들을 ckeditor폴더로 복사시켜둔다.
		NoticeVO vo = noticeService.getNoticeContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgCheckUpdate(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "admin/adminBoard/adminNoticeUpdate";
	}
	
	// 게시글에 변경된 내용을 수정처리하기(그림포함)
	@RequestMapping(value = "/adminNoticeUpdate", method = RequestMethod.POST)
	public String noticeUpdatePost(NoticeVO vo,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		// 수정된 자료가 원본자료와 완전히 동일하다면 수정할 필요가 없기에, 먼저 DB에 저장된 원본자료를 불러와서 비교처리한다.
		NoticeVO origVO = noticeService.getNoticeContent(vo.getIdx());
		
		// content의 내용이 조금이라도 변경된것이 있다면 내용을 수정처리한다.
		if(!origVO.getContent().equals(vo.getContent())) {
			// 실제로 수정하기 버튼을 클릭하게되면, 기존의 notice폴더에 저장된, 현재 content의 그림파일 모두를 삭제 시킨다.
			if(origVO.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(origVO.getContent());
			
			// notice폴더에는 이미 그림파일이 삭제되어 있으므로(ckeditor폴더로 복사해놓았음), vo.getContent()에 있는 그림파일경로 'notice'를 'ckeditor'경로로 변경해줘야한다.
			vo.setContent(vo.getContent().replace("/data/notice/", "/data/ckeditor/"));
			
			// 앞의 작업이 끝나면 파일을 처음 업로드한것과 같은 작업을 처리시켜준다.
			// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/notice/폴더에 저장시켜준다.
			noticeService.imgCheck(vo.getContent());
			
			// 이미지들의 모든 복사작업을 마치면, ckeditor폴더경로를 notice폴더 경로로 변경한다.(/resources/data/ckeditor/ ===>> /resources/data/notice/)
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
		}
		
		// content의 내용과 그림파일까지, 잘 정비된 vo를 DB에 Update시켜준다.
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
	
	
	
//글내용 상세보기
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/adminBoardContent", method = RequestMethod.GET)
	public String boardContentGet(HttpSession session,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {
		// 글 조회수 1씩 증가시키기(조회수 중복방지 - 세션처리('board+고유번호'를 객체배열에 추가시켜준다.)
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
		
		// 이전글/다음글 가져오기
		ArrayList<BoardVO> pnVos = boardService.getPrevNext(idx);
		model.addAttribute("pnVos", pnVos);
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		
		// 해당글에 '좋아요' 버튼을 클릭하였었다면 '좋아요세션'에 아이디를 저장시켜두었기에 찾아서 있다면 sSw값을 1로 보내어 하트색을 빨강색으로 변경유지하게한다.(세션이 끈기면 다시 초기화 된다.)
		ArrayList<String> goodIdx = (ArrayList) session.getAttribute("sGoodIdx");
		if(goodIdx == null) {
			goodIdx = new ArrayList<String>();
		}
		String imsiGoodIdx = "boardGood" + idx;
		if(goodIdx.contains(imsiGoodIdx)) {
			session.setAttribute("sSw", "1");		// 로그인 사용자가 이미 좋아요를 클릭한 게시글이라면 빨강색으로 표시가히위해 sSW에 1을 전송하고 있다.
		}
		else {
			session.setAttribute("sSw", "0");
		}
		
		
		// DB에서 현재 게시글에 '좋아요'가 체크되어있는지를 알아오자.
		String mid = (String) session.getAttribute("sMid");
		GoodVO goodVo = boardService.getBoardGoodCheck(idx, "board", mid);
		model.addAttribute("goodVo", goodVo);
		
		// 댓글 가져오기(replyVOS) : 출력할때 1차정렬이 groupId오름차순, 2차정렬이 idx 오름차순
		List<BoardReplyVO> replyVOS = boardService.setBoardReply(idx);
		model.addAttribute("replyVOS", replyVOS);
		
		return "admin/adminBoard/adminBoardContent";
	}
	
//좋아요~ 토글 처리(DB를 활용한 예제)
	@ResponseBody
	@RequestMapping(value = "/adminBoardGoodDBCheck", method=RequestMethod.POST)
	public void boardGoodDBCheckPost(GoodVO goodVo) {
		// 처음 '좋아요'클릭시는 무조건 레코드를 생성, 그렇지 않으면, 즉 기존에 '좋아요'레코드가 있었다면 '해당레코드를 삭제' 처리한다.
		if(goodVo.getIdx() == 0) {
			boardService.setGoodDBInput(goodVo);
			boardService.setGoodUpdate(goodVo.getPartIdx(), 1);
		}
		else {
			boardService.setGoodDBDelete(goodVo.getIdx());
			boardService.setGoodUpdate(goodVo.getPartIdx(), -1);
		}
	}
	
	
	//문의글 삭제하기
	@ResponseBody
	@RequestMapping(value = "/adminBoardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(HttpSession session, HttpServletRequest request,int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize) {
		
		// 게시글에 사진이 존재한다면 서버에 있는 사진파일을 먼저 삭제처리한다.
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent());
		
		// DB에서 실제로 존재하는 게시글을 삭제처리한다.
		int res = boardService.setBoardDelete(idx);
		
		if(res == 1) return "redirect:/message/adminBoardDeleteOk";
		else return "redirect:/message/adminBoardDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	
	
	// 문의 답변 상태 변경하기
	@ResponseBody
	@RequestMapping(value = "/adminBoardAnswerChange", method = RequestMethod.POST)
	public String adminBoardAnswerChangePost(
			@RequestParam(name="openSw", defaultValue = "", required=false) String openSw,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx) {
		boardService.setAdminBoardAnswerChange(openSw, idx);
		return "1";
	}
	
	
	
	//댓글 달기...
	@ResponseBody
	@RequestMapping(value = "/adminBoardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReplyVO replyVO) {
		// 원본글의 댓글처리
		String strGroupId = boardService.getMaxGroupId(replyVO.getBoardIdx());
		if(strGroupId != null) replyVO.setGroupId(Integer.parseInt(strGroupId)+1);
		else replyVO.setGroupId(0);
		replyVO.setLevel(0);
		
		boardService.setBoardReplyInput(replyVO);
		
		return "1";
	}
	
	// 댓글(대댓글) 저장하기
	@ResponseBody
	@RequestMapping(value = "/adminBoardReplyInput2", method = RequestMethod.POST)
	public String boardReplyInput2Post(BoardReplyVO replyVO) {
		replyVO.setLevel(replyVO.getLevel()+1);
		boardService.setBoardReplyInput(replyVO);
		
		return "1";
	}

	// 댓글 삭제하기
	@ResponseBody
	@RequestMapping(value = "/adminBoardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(
			@RequestParam(name="replyIdx", defaultValue = "0", required=false) int replyIdx,
			@RequestParam(name="level", defaultValue = "0", required=false) int level) {
		BoardReplyVO replyVO = boardService.getBoardReplyIdx(replyIdx);
		boardService.setBoardReplyDelete(replyVO.getIdx(), replyVO.getLevel(), replyVO.getGroupId(), replyVO.getBoardIdx());
		
		return "1";
	}

	// 댓글 수정하기
	@ResponseBody
	@RequestMapping(value = "/adminBoardReplyUpdate", method = RequestMethod.POST)
	public String boardReplyUpdatePost(
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="content", defaultValue = "", required=false) String content,
			@RequestParam(name="hostIp", defaultValue = "", required=false) String hostIp) {
		boardService.setBoardReplyUpdate(idx,content,hostIp);
		
		return "1";
	}

	
	//관리자 주문내역 조회하기 폼 보여주기
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
		
		// 오늘 구매한 내역을 초기화면에 보여준다.
		List<DbBaesongVO> vos = dbShopService.getMyOrderList(pageVO.getStartIndexNo(), pageSize, mid,startJumun,endJumun,conditionOrderStatus);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("conditionOrderStatus",conditionOrderStatus);
		
		return "admin/dbShop/adminOrder";
	}
	
	
	// 관리자 주문 상태 수정
	@ResponseBody
	@RequestMapping(value = "/orderStatusChange", method = RequestMethod.POST)
	public String orderStatusChangePost(int idx, String status) {
		dbShopService.setOrderStatusChange(idx,status);
		return "";
	}
	
	// 배송상태로 바꾸면 재고에서 수량을 빼줘야 한다.
	@ResponseBody
	@RequestMapping(value="/adminShippingConfirm", method=RequestMethod.POST)
	public String adminShippingConfirmPost(String optionName, int productIdx, int optionNum,int idx) {
		
		// 옵션을 찾아내서 수량을 마이너스 해줘야 한다.
		dbShopService.setAdminShippingMinus(optionName,productIdx,optionNum);
		// 배송상태 업뎃(order의 idx로 status 교체)
		dbShopService.setOrderStatusChange(idx, "배송중");
		
		return "admin/dbShop/adminOrder";
	}
	
	//관리자 환불/반품 폼
	@RequestMapping(value="/adminCancelOrder", method=RequestMethod.GET)
	public String adminCancelOrderGet(DbOrderCancelVO vo,Model model) {

		List<DbOrderCancelVO> vos = dbShopService.getAdminCancelOrder();
		
		model.addAttribute("vos",vos);
		return "admin/dbShop/adminCancelOrder";
	}
	
	//관리자 환불/반품 승인 처리 (재고 수량 다시 플러스 해주기)
	@ResponseBody
	@RequestMapping(value="/adminCancelOrderChange", method=RequestMethod.POST)
	public String adminCancelOrderChangePost(String status, String idxs) {
		
		String[] idx = idxs.split("/");
		
		for(int i=0; i<idx.length; i++) {
			// idx별 order vo 가져오기
			DbOrderVO vo = dbShopService.getOrdersOne(Integer.parseInt(idx[i]));
			
			dbShopService.setAdminShippingPlus(vo.getProductIdx(), vo.getOptionName(), vo.getOptionNum()); // 옵션DB재고 수량 다시 복원
			dbShopService.setOrderStatusChange(Integer.parseInt(idx[i]), status); // orderDB에 있는 상태 바꾸고 
			dbShopService.setCancelStatusChange(Integer.parseInt(idx[i]), status); // cancel DB에 있는 상태 바꾸공
		}
		return "admin/dbShop/adminCancelOrder";
	}
	
	// kakaomap Kakao데이터베이스에 들어있는 지명으로 검색하후 내DB에 저장하기
	@RequestMapping(value = "/kakaomap/storeRegistration", method = RequestMethod.GET)
	public String storeRegistrationGet(Model model,
			@RequestParam(name="address", defaultValue = "그라운드시소", required=false) String address) {
		model.addAttribute("address", address);
		return "admin/kakaomap/storeRegistration";
	}
	
	// kakaomap 클릭한 위치에 마커표시하기(DB저장)
	@ResponseBody
	@RequestMapping(value = "/kakaomap/kakaoRegistration", method = RequestMethod.POST)
	public String storeRegistrationPost(String store_name, double lat, double lng, String detail_address,String rode_address,String store_tel) {
		adminService.setKakaoAddressInput(store_name,lat,lng,detail_address,rode_address,store_tel);
		return "1";
	}
	
	// 카카오맵 저장한거 보기, 삭제
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
	
	// kakaomap DB에 저장된 주소 삭제처리
	@ResponseBody
	@RequestMapping(value = "/kakaomap/kakaoAddressDelete", method = RequestMethod.POST)
	public String kakaoAddressDeletePost(String address) {
		adminService.setKakaoAddressDelete(address);
		return "";
	}
	
	// 관리자 리뷰 화면
	@RequestMapping(value = "/adminReviewList", method = RequestMethod.GET)
	public String adminReviewListGet(Model model) {
		List<DbReviewVO> vos = dbShopService.getAllReviewList();
		model.addAttribute("vos",vos);
		return "admin/dbShop/adminReviewList";
	}
	
	// 관리자 리뷰 다중 삭제
	@ResponseBody
	@RequestMapping(value = "/reviewDelete", method = RequestMethod.POST)
	public String reviewDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			adminService.setReviewDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	// 관리자 문의 다중 삭제
	@ResponseBody
	@RequestMapping(value = "/boardDelete", method = RequestMethod.POST)
	public String boardDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			adminService.setBoardDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	// 관리자 문의 다중 삭제
	@ResponseBody
	@RequestMapping(value = "/noticeDelete", method = RequestMethod.POST)
	public String noticeDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			adminService.setNoticeDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	// 관리자 문의 다중 삭제
	@ResponseBody
	@RequestMapping(value = "/onedayClassDelete", method = RequestMethod.POST)
	public String onedayClassDeletePost(Model model, String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			adminService.setOnedayClassDelete(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	// 관리자 원데이클래스 화면
	@RequestMapping(value = "/adminOnedayClass", method = RequestMethod.GET)
	public String adminOnedayClassGet(Model model) {
		List<DbOnedayClassVO> vos = adminService.getAllOnedayClassList();
		model.addAttribute("vos",vos);
		return "admin/dbShop/adminOnedayClass";
	}
	
	// 관리자 상품 옵션 새창보기
	@RequestMapping(value = "/adminOptionNew", method = RequestMethod.GET)
	public String adminOptionNewGet(Model model, int idx) {
		int productIdx = idx;
		List<DbOptionVO> vos = dbShopService.getOptionList(productIdx);
		model.addAttribute("vos",vos);
		System.out.println("adminOptionNew : " + vos);
		return "admin/dbShop/adminOptionNew";
	}
	
	// 관리자 옵션내역 수정
	@ResponseBody
	@RequestMapping(value = "/optionUpdate", method = RequestMethod.POST)
	public String optionUpdatePost(int idx, String optionName, int optionPrice, int optionStock) {
		dbShopService.setOptionUpdate(idx,optionName,optionPrice,optionStock);
		return "1";
	}
	
	
	
	// 베스트 리뷰 등록
	@ResponseBody
	@RequestMapping(value = "/bestReviewChange", method = RequestMethod.POST)
	public String bestReviewChangePost(Model model,int idx,String mid, String productName) {
		
		String productIdx = productName;
		adminService.setBestReview(idx, "OK"); // 베스트 리뷰 상태  변경
		dbShopService.setGetPoint(productIdx, 1000, mid, "베스트리뷰 선정"); // 해당 회원 포인트1000 db에 내역 저장
		dbShopService.setMemberPlusPoint(mid, 1000); // 해당 회원 멤버 포인트 지급
		return "1";
	}
	
	// 관리자 제휴 문의 목록
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
	
	// 관리자 제휴 문의 상세보기
	@RequestMapping(value = "/adminContactReply", method = RequestMethod.GET)
	public String adminContactReplyGet(int idx, Model model) {
		ContactVO vo = contactService.getContactContent(idx);
		
		// 해당 문의글의 답변글 가져오기
		ContactReplyVO reVO = contactService.getContactReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		
		return "admin/contact/adminContactReply";
	}
	
	
	// 관리자 제휴 문의 답변 달기
	@RequestMapping(value = "/adminContactReplyInput", method = RequestMethod.POST)
	public String adminContactReplyInputPost(ContactReplyVO vo) {
		 // 답변등록
		 adminService.getContactReply(vo);
		 // 답변 등록 후 문의글 reply를 답변완료로 변경
		 adminService.setAdminContactPartChange(vo.getContactIdx());
		return "1";
	}
	
	// 관리자 제휴 문의 답변 달기
	@RequestMapping(value = "/adminContactReplyUpdate", method = RequestMethod.POST)
	public String adminContactReplyUpdatePost(int reIdx,String reContent) {
		// 답변수정
		adminService.setAdminContactReplyUpdate(reIdx,reContent);
		return "1";
	}
	
	/*
	 * // 문의 삭제허기워기
	 * 
	 * @RequestMapping(value = "/adminContactDelete", method = RequestMethod.POST)
	 * public String adminContactDeletePost(Model model, int idx, String fSName, int
	 * reIdx, int pag) { adminService.setContactReplyDelete(reIdx); // 관리자가 답변글을
	 * 삭제했을때 처리루틴 inquiryService.setInquiryDelete(idx, fSName); return
	 * "redirect:/message/AdminContactDeleteOk"; }
	 */
	
	
	// 관리자 환불,반품 불가능 처리 새창
	@RequestMapping(value = "/adminCancleNew", method = RequestMethod.GET)
	public String adminCancleNewGet(int idx, Model model) {
		DbOrderCancelVO vo = adminService.getOrderCancelOne(idx);
		model.addAttribute("vo", vo);
		return "admin/dbShop/adminCancleNew";
	}
	
	
	// 관리자 환불,반품 새창에서 처리처리
	@ResponseBody
	@RequestMapping(value = "/adminOrderCancelNO", method = RequestMethod.POST)
	public String adminOrderCancelNOPost(int idx, int cancelIdx, String reason1, String reason2) {
		// 캔슬 db에서 불가처리 해주고
		adminService.setOrderCancelNo(idx,"승인 불가", reason1,reason2);
		// order에도 처리불가로 바꿔야 한다.(사용자)
		adminService.setOrderCancelNo2(cancelIdx,"승인 불가");
		return "1";
	}
	
	
	// 관리자 신고 리뷰 창
	@RequestMapping(value = "/adminReportReviewList", method = RequestMethod.GET)
	public String adminReportReviewListGet(Model model) {
		List<DbReviewVO> vos = adminService.getReportReview();
		model.addAttribute("vos", vos);
		return "admin/dbShop/adminReportReviewList";
	}
	
	
	// 관리자 신고 리뷰 복원처리..
	@ResponseBody
	@RequestMapping(value = "/reviewRestore", method = RequestMethod.POST)
	public String reviewRestorePost(String idxs) {
		String[] idxMulti = idxs.split("/");
		for (int i = 0; i < idxMulti.length; i++) {
			// 신고횟수를 다시 0으로 초기화 해준다.
			adminService.setReportreviewRestore(Integer.parseInt(idxMulti[i]));
		}
		return "1";
	}
	
	
	// 관리자 문의 창
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
	
	// 관리자창 문의 내용
	@RequestMapping(value = "/adminQnaContent", method = RequestMethod.GET)
	public String adminQnaContentGet(int idx,Model model) {
		QnaVO vo =  qnaService.getQnaContent(idx);
		model.addAttribute("vo", vo);
		return "admin/adminBoard/adminQnaContent";
	}
	
	// 관리자창 문의 내용
	@RequestMapping(value = "/adminQnaContent", method = RequestMethod.POST)
  public String adminQnaContentPost(QnaVO vo, HttpSession session) {
		// content에 이미지가 저장되어 있다면, 저장된 이미지만 골라서 /resources/data/qna/폴더에 저장시켜준다.
  	if(vo.getContent().indexOf("src=\"/") != -1) {
  		javawebProvide.imgCheck(vo.getContent(), "qna");	// 이미지를 ckeditor폴더에서 qna폴더로 복사하기
  		
  		// 이미지 복사작업이 끝나면, qna폴더에 실제로 저장된 파일명을 DB에 저장시켜준다.(/resources/data/ckeditor/  ==>> /resources/data/ckeditor/qna/)
  		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/qna/"));
  	}
  	
		// 앞에서 ckeditor의 그림작업이 끝나고 일반작업들을 수행시킨다.
		
  	int level = (int) session.getAttribute("sLevel");
  	
  	// 먼저 idx 설정하기
  	int newIdx = qnaService.getMaxIdx() + 1;
  	vo.setIdx(newIdx);
  	
  	// qnaIdx 설정하기
  	String qnaIdx = "";
  	if(newIdx < 10) qnaIdx = "0"+ newIdx + "_2";
  	else qnaIdx = newIdx + "_2";
  	
  	if(vo.getQnaSw().equals("a")) {  // qnaSw값과 qnaIdx값은 vo에 담겨서 넘어온다. 답변글(a)일 경우만 qnaIdx값을 편집처리한다.
  		qnaIdx = vo.getQnaIdx().split("_")[0]+"_1";
  		if(level == 0) vo.setTitle(vo.getTitle().replace("(Re)", "<font color='red'>(Re)</font>"));
  	}
  	vo.setQnaIdx(qnaIdx);
  	
  	qnaService.qnaInputOk(vo);
  	
  	return "redirect:/message/qnaInputOk2";
	}
	
	
	
	
	//ckeditor폴더의 파일 리스트 보여주기
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/fileList", method = RequestMethod.GET)
	public String fileListGet(HttpServletRequest request, Model model) {
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		
		String[] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		
		return "admin/fileList";
	}
	
	
	//선택된 파일 삭제처리하기
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
