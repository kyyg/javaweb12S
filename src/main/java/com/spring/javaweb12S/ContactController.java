package com.spring.javaweb12S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb12S.pagination.PageProcess;
import com.spring.javaweb12S.service.ContactService;
import com.spring.javaweb12S.vo.ContactReplyVO;
import com.spring.javaweb12S.vo.ContactVO;

@Controller
@RequestMapping("/contact")
public class ContactController {

	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	ContactService contactService;
	
	@RequestMapping(value = "/contactList", method = RequestMethod.GET)
	public String contactListGet(Model model,HttpSession session) {
		
		String mid = (String) session.getAttribute("sMid");
		List<ContactVO> vos = contactService.setContactList(mid);
		
		model.addAttribute("vos",vos);
		return "contact/contactList";
	}

	@RequestMapping(value = "/contactInput", method = RequestMethod.GET)
	public String contactInputGet() {
		return "contact/contactInput";
	}
	
	@RequestMapping(value = "/contactInput", method = RequestMethod.POST)
	public String contactInputPost(MultipartHttpServletRequest file, ContactVO vo) {
		int res = contactService.setContactInput(file, vo);
		
		if(res == 1) {
			return "redirect:/message/contactInputOk";
		}
		else return "redirect:/message/contactInputNo";
	}
	
	// 제휴 문의 상세보기
	@RequestMapping(value = "/contactContent", method = RequestMethod.GET)
	public String contactContentGet(int idx, Model model) {
		ContactVO vo = contactService.getContactContent(idx);
		
		// 해당 문의글의 답변글 가져오기
		//ContactReplyVO reVO = contactService.getContactReply(idx);
		
		model.addAttribute("vo", vo);
		//model.addAttribute("reVO", reVO);
		
		return "contact/contactContent";
	}
	
	

}