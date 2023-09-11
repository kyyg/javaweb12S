package com.spring.javaweb12S;

import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb12S.pagination.PageProcess;
import com.spring.javaweb12S.pagination.PageVO;
import com.spring.javaweb12S.service.DbShopService;
import com.spring.javaweb12S.service.MemberService;
import com.spring.javaweb12S.vo.DbBaesongVO;
import com.spring.javaweb12S.vo.DbOrderVO;
import com.spring.javaweb12S.vo.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	DbShopService dbShopService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping(value = "/memberLogin", method = RequestMethod.GET)
	public String memberLoginGet(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("mid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	

	@RequestMapping(value="/memberKakaoLogin", method=RequestMethod.GET)
	public String memberKakaoLoginGet(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			String nickName,
			String email) throws MessagingException {
		
		session.setAttribute("sLogin", "kakao");
		MemberVO vo = memberService.getMemberNickNameEmailCheck(nickName, email);
		if(vo == null) {
			String mid = email.substring(0, email.indexOf("@"));
			
			MemberVO vo2 = memberService.getMemberIdCheck(mid);
			if(vo2 != null) return "redirect:/message/midSameSearch";
			
			UUID uid = UUID.randomUUID();
			String pwd = uid.toString().substring(0,8);
			session.setAttribute("sImsiPwd", pwd);	
			pwd = passwordEncoder.encode(pwd);

			mailSend(email, pwd);
		
			memberService.setKakaoMemberInputOk(mid, pwd, nickName, email);

			vo = memberService.getMemberIdCheck(mid);
		}

		if(!vo.getUserDel().equals("NO")) {
			memberService.setMemberUserDelCheck(vo.getMid());
		}
		

		String strLevel = "";
		if(vo.getLevel() == 0) strLevel = "관리자";
		else if(vo.getLevel() == 1) strLevel = "일반회원";

		
		session.setAttribute("sLevel", vo.getLevel());
		session.setAttribute("sStrLevel", strLevel);
		session.setAttribute("sMid", vo.getMid());
		session.setAttribute("sNickName", vo.getNickName());
		
		memberService.setMemberVisitProcess(vo);
		
		return "redirect:/message/memberLoginOk?mid="+vo.getMid();
	}
	
	

	@RequestMapping(value = "/memberLogin", method = RequestMethod.POST)
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="mid", defaultValue = "", required=false) String mid,
			@RequestParam(name="pwd", defaultValue = "", required=false) String pwd,
			@RequestParam(name="idSave", defaultValue = "", required=false) String idSave,
			HttpSession session) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null && vo.getUserDel().equals("NO") && passwordEncoder.matches(pwd, vo.getPwd())) {
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "일반회원";
			
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sNickName", vo.getNickName());
			
			if(idSave.equals("on")) {
				Cookie cookie = new Cookie("cMid", mid);
				cookie.setMaxAge(60*60*24*7);
				response.addCookie(cookie);
			}
			else {
				Cookie[] cookies = request.getCookies();
				for(int i=0; i<cookies.length; i++) {
					if(cookies[i].getName().equals("cMid")) {
						cookies[i].setMaxAge(0);
						response.addCookie(cookies[i]);
						break;
					}
				}
			}
			memberService.setMemberVisitProcess(vo);
			return "redirect:/message/memberLoginOk?mid="+mid;
		}
		else {
			return "redirect:/message/memberLoginNo";
		}
	}
	
	@RequestMapping(value = "/memberLogout", method = RequestMethod.GET)
	public String memberLogoutGet(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		
		session.invalidate();
		
		return "redirect:/message/memberLogout?mid="+mid;
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.GET)
	public String memberJoinGet() {
		return "member/memberJoin";
	}
	
	@RequestMapping(value = "/memberJoin", method = RequestMethod.POST)
	public String memberJoinPost(MultipartFile fName, MemberVO vo) {
		if(memberService.getMemberIdCheck(vo.getMid()) != null) return "redirect:/message/idCheckNo";
		if(memberService.getMemberNickCheck(vo.getNickName()) != null) return "redirect:/message/nickCheckNo";
		
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int res = memberService.setMemberJoinOk(vo);
		
		if(res == 1) return "redirect:/message/memberJoinOk";
		else return "redirect:/message/memberJoinNo";
	}
	

	@ResponseBody
	@RequestMapping(value = "/memberIdCheck", method = RequestMethod.POST)
	public String memberIdCheckPost(String mid) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo != null ) return "1";
		else return "0";
	}
	

	@ResponseBody
	@RequestMapping(value = "/memberNickCheck", method = RequestMethod.POST)
	public String memberNickCheckPost(String nickName) {
		MemberVO vo = memberService.getMemberNickCheck(nickName);
		
		if(vo != null ) return "1";
		else return "0";
	}
	
	
	
	@RequestMapping(value = "/memberMain", method = RequestMethod.GET)
	public String memberMainGet(Model model, HttpSession session,
			@RequestParam(name="part1", defaultValue = "0", required=false) int part1,
			@RequestParam(name="part2", defaultValue = "0", required=false) int part2,
			@RequestParam(name="part3", defaultValue = "0", required=false) int part3,
			@RequestParam(name="part4", defaultValue = "0", required=false) int part4,
			@RequestParam(name="part5", defaultValue = "0", required=false) int part5
			//@RequestParam(name="yearPay", defaultValue = "0", required=false) int yearPay
			) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);


	   List<DbBaesongVO> baesongVOS = dbShopService.getMemberMidSearch(vo.getMid());
	   List<DbOrderVO> orderVOS = dbShopService.getMemberMidSearchOrder(vo.getMid());
	   if(baesongVOS != null || orderVOS != null) {
	  	 //yearPay = dbShopService.getMemberMainPay(vo.getMid());
	  	 part1 = dbShopService.getMemberMainPart("입금전", vo.getMid());
	  	 part2 = dbShopService.getMemberMainPart("결제완료", vo.getMid()); 
	  	 part3 = dbShopService.getMemberMainPart("배송중", vo.getMid()); 
	  	 part4 = dbShopService.getMemberMainPart("배송완료", vo.getMid());
	  	 part5 = dbShopService.getMemberMainPart("구매확정", vo.getMid()); 
	  	 
	   } 
	   else {
	  	 //yearPay = 0;
	  	 part1 = 0;
	  	 part2 = 0;
	  	 part3 = 0;
	  	 part4 = 0;
	  	 part5 = 0;
	   } 
		 //System.out.println(yearPay);
		
		model.addAttribute("vo", vo);
	 // model.addAttribute("yearPay", yearPay);
	  model.addAttribute("part1", part1);
	  model.addAttribute("part2", part2);
	  model.addAttribute("part3", part3);
	  model.addAttribute("part4", part4);
	  model.addAttribute("part5", part5);
	 
		
		return "member/memberMain";
	}
	
	
	
	@RequestMapping(value = "/memberPwdFind", method = RequestMethod.GET)
	public String memberPwdFindGet() {
		return "member/memberPwdFind";
	}
	
	@RequestMapping(value = "/memberPwdFind", method = RequestMethod.POST)
	public String memberPwdFindPost(String mid, String toMail, HttpServletRequest request) throws MessagingException {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null) {
			if(vo.getEmail().equals(toMail)) {
				UUID uid = UUID.randomUUID();
				String pwd = uid.toString().substring(0,8);
				
				HttpSession session = request.getSession();
				session.setAttribute("sImsiPwd", pwd);
				
				memberService.setMemberPwdUpdate(mid, passwordEncoder.encode(pwd));
				
				String content = pwd;
				int res = mailSend(toMail, content);
				
				if(res == 1) return "redirect:/message/memberImsiPwdOk";
				else return "redirect:/message/memberImsiPwdNo";
			}
			else {
				return "redirect:/message/memberEmailCheckNo";
			}
		}
		else {
			return "redirect:/message/memberIdCheckNo";
		}
	}


	private int mailSend(String toMail, String content) throws MessagingException {
		String title = "임시 비밀번호를 발급하였습니다.";
	
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		messageHelper.setTo(toMail);
		messageHelper.setSubject(title);
		messageHelper.setText(content);
		
	
		content = "<br><hr><h3>임시 비밀번호는 <font color='red'>"+content+"</font> 입니다.</h3><hr><br>";
		content += "<p><img src=\"cid:mail.jpg\" width='500px'></p>";
		content += "<p> 바로가기 - <a href='https://49.142.157.251:9090/javaweb12S'>별 헤는 밤, 빛나는 밤</a></p>";
		content += "<hr>";
		messageHelper.setText(content, true);

		mailSender.send(message);
		
		return 1;
	}
	
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.GET)
	public String memberPwdUpdateGet() {
		return "member/memberPwdUpdate";
	}
	
	@RequestMapping(value = "/memberPwdUpdate", method = RequestMethod.POST)
	public String memberPwdUpdatePost(
			@RequestParam(name="newPwd",defaultValue = "", required=false) String newPwd,
			HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		newPwd = passwordEncoder.encode(newPwd);
		
		memberService.setMemberPwdUpdate(mid, newPwd);
		
		if(session.getAttribute("sImsiPwd") != null) session.removeAttribute("sImsiPwd");
		
		return "redirect:/message/memberPwdUpdateOk";
	}
	
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.GET)
	public String memberPwdCheckGet() {
		return "member/memberPwdCheck";
	}
	
	@RequestMapping(value = "/memberPwdCheck", method = RequestMethod.POST)
	public String memberPwdCheckPost(String mid, String pwd, Model model) {
		MemberVO vo = memberService.getMemberIdCheck(mid);
		if(vo != null && passwordEncoder.matches(pwd, vo.getPwd())) {
			model.addAttribute("vo", vo);
			return "member/memberUpdate";
		}
		else {
		  return "redirect:/message/memberPwdCheckNo";
		}
	}
	
	@RequestMapping(value = "/memberUpdate", method = RequestMethod.GET)
	public String memberUpdateGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		MemberVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo", vo);
		
		return "member/memberUpdate";
	}
	
	@RequestMapping(value = "/memberUpdateOk", method = RequestMethod.POST)
	public String memberUpdateOkPost(MemberVO vo, HttpSession session) {
		String nickName = (String) session.getAttribute("sNickName");
		if(memberService.getMemberNickCheck(vo.getNickName()) != null && !nickName.equals(vo.getNickName())) {
			return "redirect:/message/memberNickCheckNo";
		}
		memberService.setMemberUpdateOk(vo);
		return "redirect:/message/memberUpdateOk";

	}
	
	@RequestMapping(value = "/memberDelete", method = RequestMethod.GET)
	public String memberDelete(HttpSession session, Model model) {
		String mid = (String) session.getAttribute("sMid");
		memberService.setMemberDeleteOk(mid);
		
		session.invalidate();
		
		model.addAttribute("mid", mid);
		
		return "redirect:/message/memberDeleteOk";
	}
	
	@RequestMapping(value = "/memberIdFind", method = RequestMethod.GET)
	public String memberIdFindGet() {
		return "member/memberIdFind";
	}
	
	@RequestMapping(value = "/memberIdFind", method = RequestMethod.POST)
	public String memberIdFindPost(String email, Model model ) {
		MemberVO vo = memberService.getEmailSearch(email);
		if(vo != null) {
			model.addAttribute("vo",vo);
			return "member/memberIdFindOk";
		}
		else {
			return "redirect:/message/memberEmailFindNo";
		}
	}
	
		
	
	
}
