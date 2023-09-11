package com.spring.javaweb12S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb12S.common.JavawebProvide;
import com.spring.javaweb12S.pagination.PageProcess;
import com.spring.javaweb12S.pagination.PageVO;
import com.spring.javaweb12S.service.QnaService;
import com.spring.javaweb12S.vo.QnaVO;

@Controller
@RequestMapping("/qna")
public class QnaController {
  String msgFlag = "";
  
  @Autowired
  QnaService qnaService;
  
  @Autowired
  PageProcess pageProcess;
  
  @Autowired
  JavawebProvide javawebProvide;
	
  @RequestMapping(value = "/qnaList", method = RequestMethod.GET)
  public String qnaListGet(
  		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize,
			Model model) {
  	PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
		List<QnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
  	return "qna/qnaList";
  }
  
  @RequestMapping(value = "/qnaInput", method = RequestMethod.GET)
  public String qnaListGet(String qnaSw, HttpSession session, Model model) {
  	String mid = (String) session.getAttribute("sMid");
  	String email = qnaService.getEmail(mid);
  	
  	model.addAttribute("qnaSw", qnaSw);
  	model.addAttribute("email", email);
  	
  	return "qna/qnaInput";
  }
  

  @RequestMapping(value = "/qnaInput", method = RequestMethod.POST)
  public String qnaListPost(QnaVO vo, HttpSession session) {
  	if(vo.getContent().indexOf("src=\"/") != -1) {
  		javawebProvide.imgCheck(vo.getContent(), "qna");	
  		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/qna/"));
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
  	
  	return "redirect:/message/qnaInputOk";
  }
  

  @RequestMapping(value = "/qnaContent", method = RequestMethod.GET)
  public String qnaListGet(int idx, String title, int pag, HttpSession session, Model model) {
  	String mid = (String) session.getAttribute("sMid");
  	String email = qnaService.getEmail(mid);
  	
  	QnaVO vo = qnaService.getQnaContent(idx);
  	model.addAttribute("email", email);
  	model.addAttribute("title", title);
  	model.addAttribute("pag", pag);
  	model.addAttribute("vo", vo);
  	
  	return "qna/qnaContent";
  }
  

  @RequestMapping(value = "/qnaUpdate", method = RequestMethod.GET)
  public String qnaUpdateGet(Model model, int idx) {
  	QnaVO vo = qnaService.getQnaContent(idx);
  	
  	if(vo.getContent().indexOf("src=\"/") != -1) {
   		javawebProvide.imgCheck2(vo.getContent(), "qna");	
   	}
  	
  	model.addAttribute("vo", vo);
  	return "qna/qnaUpdate";
  }
  
  @RequestMapping(value = "/qnaUpdate", method = RequestMethod.POST)
  public String qnaUpdatePost(Model model, HttpSession session, QnaVO vo) {
   	if(vo.getContent().indexOf("src=\"/") != -1) {
   		javawebProvide.imgCheck(vo.getContent(), "qna");

   		vo.setContent(vo.getContent().replace("/data/ckeditor/qna/", "/data/ckeditor/"));
   		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/qna/"));
   	}
  	
  	qnaService.setQnaContentUpdate(vo);
  	return "redirect:/message/qnaUpdateOk";
  }
  

  @RequestMapping(value = "/qnaDelete", method = RequestMethod.GET)
  public String qnaDeleteGet(int idx) {
  	QnaVO vo = qnaService.getQnaContent(idx);

   	if(vo.getContent().indexOf("src=\"/") != -1) {
   		javawebProvide.imgDelete(vo.getContent(), "qna");	
   	}
   	
   	List<QnaVO> qnaCheckVO = qnaService.getQnaIdxCheck(vo.getQnaIdx().split("_")[0]);
   	
   	if(vo.getQnaSw().equals("a") || (vo.getQnaSw().equals("q") && qnaCheckVO.size() == 1)) qnaService.setQnaDelete(idx);
   	else qnaService.setQnaCheckUpdate(idx, "<font size='2' color='#ccc'>현재 삭제된 글입니다.</font>");
  	
  	return "redirect:/message/qnaDelete";
  }
  
}
