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
import com.spring.javaweb12S.service.NoticeService;
import com.spring.javaweb12S.vo.NoticeVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;
	
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
	@RequestMapping(value = "/noticeContent", method = RequestMethod.GET)
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
			
		return "notice/noticeContent";
	}
	
	
	
	// 게시글 검색처리
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
	
	// 게시글 삭제하기
	@RequestMapping(value = "/noticeDelete", method = RequestMethod.GET)
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
		
		if(res == 1) return "redirect:/message/noticeDeleteOk";
		else return "redirect:/message/noticeDeleteNo?idx="+idx+"&pag="+pag+"&pageSize="+pageSize;
	}
	
	// 게시글 수정하기 폼 호출
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.GET)
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
		
		return "notice/noticeUpdate";
	}
	
	// 게시글에 변경된 내용을 수정처리하기(그림포함)
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.POST)
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
			return "redirect:/message/noticeUpdateOk";
		}
		else {
			return "redirect:/message/noticeUpdateNo";
		}
	}
	

	// about페이지
	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String aboutGet() {
		return "notice/about";
	}
	
	
	
	

}