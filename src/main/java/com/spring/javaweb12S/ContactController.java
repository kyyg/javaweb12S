package com.spring.javaweb12S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
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
	

	@RequestMapping(value = "/contactContent", method = RequestMethod.GET)
	public String contactContentGet(int idx, Model model) {
		ContactVO vo = contactService.getContactContent(idx);
		
		ContactReplyVO reVO = contactService.getContactReply(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("reVO", reVO);
		
		return "contact/contactContent";
	}
	

	@RequestMapping(value = "/contactDelete", method = RequestMethod.GET)
	public String contactDeleteGet(int idx,
			@RequestParam(name="fSName", defaultValue="", required=false) String fSName,Model model) {
			contactService.setContactDelete(idx, fSName);
		
		return "redirect:/message/contactDeleteOk";
	}
	

	@RequestMapping(value = "/contactUpdate", method = RequestMethod.GET)
	public String contactUpdateGet(int idx, Model model) {
		ContactVO vo = contactService.getContactContent(idx);
		model.addAttribute("vo",vo);
		return "contact/contactUpdate";
	}
	
	@RequestMapping(value = "/contactUpdate", method = RequestMethod.POST)
	public String contactUpdatePost(MultipartFile file,  ContactVO vo, Model model) {
		contactService.setContactUpdate(file, vo);
		
		//model.addAttribute("idx",vo.getIdx());
		return "redirect:/message/contactUpdateOk";
	}
	
	
	

}
