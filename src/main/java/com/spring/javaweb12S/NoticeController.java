package com.spring.javaweb12S;

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

import com.spring.javaweb12S.pagination.PageProcess;
import com.spring.javaweb12S.pagination.PageVO;
import com.spring.javaweb12S.service.AdminService;
import com.spring.javaweb12S.service.NoticeService;
import com.spring.javaweb12S.vo.KakaoAddressVO;
import com.spring.javaweb12S.vo.NoticeVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/noticeList", method = RequestMethod.GET)
	public String noticeListGet(
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required=false) int pageSize,
			Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", "", "");
		
		List<NoticeVO> vos = noticeService.getNoticeList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "notice/noticeList";
	}
	
	@RequestMapping(value = "/noticeInput", method = RequestMethod.GET)
	public String noticeInputGet() {
		return "notice/noticeInput";
	}
	
	@RequestMapping(value = "/noticeInput", method = RequestMethod.POST)
	public String noticeInputPost(NoticeVO vo) {
		noticeService.imgCheck(vo.getContent());

		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/notice/"));
		int res = noticeService.setNoticeInput(vo);
		
		if(res == 1) return "redirect:/message/noticeInputOk";
		else return "redirect:/message/noticeInputNo";
	}


	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/noticeContent", method = RequestMethod.GET)
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
			
		return "notice/noticeContent";
	}
	
	
	

	@RequestMapping(value = "/noticeSearch", method = RequestMethod.GET)
	public String noticeSearchGet(String search, String searchString,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			Model model) {		// search = search+"/"+searchString
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "notice", search, searchString);
		
		List<NoticeVO> vos = noticeService.getNoticeListSearch(pageVO.getStartIndexNo(), pageSize, search, searchString);
		
		String searchTitle = "";
		if(pageVO.getSearch().equals("title")) searchTitle = "글제목";
		else if(pageVO.getSearch().equals("name")) searchTitle = "글쓴이";
		else searchTitle = "글내용";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		// model.addAttribute("searchCount", vos.size());
		
		return "notice/noticeSearch";
		
	}
	

	@RequestMapping(value = "/noticeDelete", method = RequestMethod.GET)
	public String noticeDeleteGet(HttpSession session, HttpServletRequest request,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required=false) int pageSize,
			@RequestParam(name="nickName", defaultValue = "", required=false) String nickName
			) {
		NoticeVO vo = noticeService.getNoticeContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) noticeService.imgDelete(vo.getContent());
		
		int res = noticeService.setNoticeDelete(idx);
		
		if(res == 1) return "redirect:/message/noticeDeleteOk";
		else return "redirect:/message/noticeDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	

	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.GET)
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
		
		return "notice/noticeUpdate";
	}
	

	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.POST)
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
			return "redirect:/message/noticeUpdateOk";
		}
		else {
			return "redirect:/message/noticeUpdateNo";
		}
	}
	


	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String aboutGet() {
		return "notice/about";
	}
	
	

	@RequestMapping(value = "/offlineStore", method = RequestMethod.GET)
	public String offlineStoreGet(Model model,
			@RequestParam(name="store_name", defaultValue = "그린 아트 스튜디오", required=false) String store_name) {
		
		KakaoAddressVO vo = adminService.getKakaoAddressName(store_name);
		List<KakaoAddressVO> vos = adminService.getKakaoAddressList();
		
		model.addAttribute("vo", vo);
		model.addAttribute("vos", vos);
		model.addAttribute("store_name", store_name);
		return "notice/offlineStore";
	}
	
	
	
	
	
	
	

}
