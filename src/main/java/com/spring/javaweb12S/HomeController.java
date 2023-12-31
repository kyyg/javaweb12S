package com.spring.javaweb12S;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb12S.service.AdminService;
import com.spring.javaweb12S.vo.DbProductVO;

@Controller
public class HomeController {
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = {"/"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model,HttpServletRequest request) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		List<DbProductVO> newVOS = adminService.getNewProduct();
		List<DbProductVO> newVOS3 = adminService.getNewProduct3();
		model.addAttribute("newVOS",newVOS);
		model.addAttribute("newVOS3",newVOS3);
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cEvent")) {
					request.setAttribute("event", cookies[i].getValue());
					break;
				}
			}
		}
		
		return "home";
	}
	
	
	@RequestMapping(value = "/eventCheck", method = RequestMethod.GET)
	public String eventCheckGet(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(name="todayIsDone", defaultValue = "", required=false) String todayIsDone
			) {
		
		if(todayIsDone.equals("on")) {
			Cookie cookie = new Cookie("cEvent", "popUpNo");
			cookie.setMaxAge(60*60*24*1);
			response.addCookie(cookie);
		}
		return "home";
	}
	
	
	@RequestMapping(value = "/eventNew", method = RequestMethod.GET)
	public String eventNewGet(HttpServletRequest request) {

		return "dbShop/eventNew";
	}
	
	
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload, 
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8"); 
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(bytes);
		
		PrintWriter out = response.getWriter(); 
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();		
		fos.close();
	}
	

	@RequestMapping(value = "/webSocket", method = RequestMethod.GET)
	public String webSocketGet(HttpServletRequest req, HttpServletResponse resp, HttpSession session) {
		return "webSocket/webSocket";
	}
	
	
	
}
