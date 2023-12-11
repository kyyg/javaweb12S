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
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb12S.pagination.PageProcess;
import com.spring.javaweb12S.pagination.PageVO;
import com.spring.javaweb12S.service.BoardService;
import com.spring.javaweb12S.vo.BoardReplyVO;
import com.spring.javaweb12S.vo.BoardVO;
import com.spring.javaweb12S.vo.GoodVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardListGet(
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "15", required=false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required=false) String part,
			Model model) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", part, "");
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageSize, part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "board/boardList";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.GET)
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	@RequestMapping(value = "/boardInput", method = RequestMethod.POST)
	public String boardInputPost(BoardVO vo) {
		boardService.imgCheck(vo.getContent());
	
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));

		int res = boardService.setBoardInput(vo);
		
		if(res == 1) return "redirect:/message/boardInputOk";
		else return "redirect:/message/boardInputNo";
	}

	// 글내용 상세보기
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/boardContent", method = RequestMethod.GET)
	public String boardContentGet(HttpSession session,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required=false) int pageSize,
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
		
		// 이전글/다음글 가져오기
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
		
		return "board/boardContent";
	}


	
	@ResponseBody
	@RequestMapping(value = "/boardGoodDBCheck", method=RequestMethod.POST)
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
	
	
	
	@RequestMapping(value = "/boardSearch", method = RequestMethod.GET)
	public String boardSearchGet(String search, String searchString,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required=false) int pageSize,
			Model model) {		// search = search+"/"+searchString
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "board", search, searchString);
		
		List<BoardVO> vos = boardService.getBoardListSearch(pageVO.getStartIndexNo(), pageSize, search, searchString);
		
		String searchTitle = "";
		if(pageVO.getSearch().equals("title")) searchTitle = "글제목";
		else if(pageVO.getSearch().equals("name")) searchTitle = "글쓴이";
		else searchTitle = "글내용";
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		model.addAttribute("searchTitle", searchTitle);
		// model.addAttribute("searchCount", vos.size());
		
		return "board/boardSearch";
		
	}
	
	
	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(HttpSession session, HttpServletRequest request,int idx,String pwd) {
		
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getPwd().equals(pwd)) {
			if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(vo.getContent());
			
			
			int res = boardService.setBoardDelete(idx);
			
			if(res == 1) return "redirect:/message/boardDeleteOk";
			else return "redirect:/message/boardDeleteNo";
		}
		else return "redirect:/message/boardDeletePwdNo";
	}
	
	
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required=false) int pageSize
		) {
		
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imgCheckUpdate(vo.getContent());
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		return "board/boardUpdate";
	
	}
	
	
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(BoardVO vo,
			@RequestParam(name="pag", defaultValue = "1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required=false) int pageSize,
			Model model) {
		
		BoardVO origVO = boardService.getBoardContent(vo.getIdx());
		
		
		if(!origVO.getContent().equals(vo.getContent())) {
			
			if(origVO.getContent().indexOf("src=\"/") != -1) boardService.imgDelete(origVO.getContent());
			
			vo.setContent(vo.getContent().replace("/data/board/", "/data/ckeditor/"));
			
			boardService.imgCheck(vo.getContent());
			
			
			vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/board/"));
		}
		
		
		int res = boardService.setBoardUpdate(vo);
		
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		if(res == 1) {
			return "redirect:/message/boardUpdateOk";
		}
		else {
			return "redirect:/message/boardUpdateNo";
		}
	}
	

	
	
	
	
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput", method = RequestMethod.POST)
	public String boardReplyInputPost(BoardReplyVO replyVO) {
		
		String strGroupId = boardService.getMaxGroupId(replyVO.getBoardIdx());
		if(strGroupId != null) replyVO.setGroupId(Integer.parseInt(strGroupId)+1);
		else replyVO.setGroupId(0);
		replyVO.setLevel(0);
		
		boardService.setBoardReplyInput(replyVO);
		
		return "1";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/boardReplyInput2", method = RequestMethod.POST)
	public String boardReplyInput2Post(BoardReplyVO replyVO) {
		replyVO.setLevel(replyVO.getLevel()+1);
		boardService.setBoardReplyInput(replyVO);
		
		return "1";
	}

	
	@ResponseBody
	@RequestMapping(value = "/boardReplyDelete", method = RequestMethod.POST)
	public String boardReplyDeletePost(
			@RequestParam(name="replyIdx", defaultValue = "0", required=false) int replyIdx,
			@RequestParam(name="level", defaultValue = "0", required=false) int level) {
		BoardReplyVO replyVO = boardService.getBoardReplyIdx(replyIdx);
		boardService.setBoardReplyDelete(replyVO.getIdx(), replyVO.getLevel(), replyVO.getGroupId(), replyVO.getBoardIdx());
		
		return "1";
	}

	
	@ResponseBody
	@RequestMapping(value = "/boardReplyUpdate", method = RequestMethod.POST)
	public String boardReplyUpdatePost(
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx,
			@RequestParam(name="content", defaultValue = "", required=false) String content,
			@RequestParam(name="hostIp", defaultValue = "", required=false) String hostIp) {
		boardService.setBoardReplyUpdate(idx,content,hostIp);
		
		return "1";
	}

	
  
  @RequestMapping(value="/userBoard", method=RequestMethod.GET)
  public String dbUserBoardGet(Model model,HttpSession session) {
  	
  	String mid = (String) session.getAttribute("sMid");
  	
  	List<BoardVO> VOS = boardService.getUserBoard(mid);
  	model.addAttribute("VOS",VOS);
  	return "board/userBoard";
  }
	
  
  @RequestMapping(value="/userBoardContent", method=RequestMethod.GET)
  public String dbUserBoardContentGet(Model model,HttpSession session,int idx) {
  	
 /
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
 		
 		return "board/userBoardContent";
  }
  
	
	

}
