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

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb12S.service.AdminService;
import com.spring.javaweb12S.vo.DbProductVO;

@Controller
public class HomeController {
	
	@Autowired
	AdminService adminService;
	
	@RequestMapping(value = {"/"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		// 메인 owl 케로셀 / 뉴/베스트 상품 3개씩
		List<DbProductVO> newVOS = adminService.getNewProduct();
		List<DbProductVO> newVOS3 = adminService.getNewProduct3();
		model.addAttribute("newVOS",newVOS);
		model.addAttribute("newVOS3",newVOS3);
		
		return "home";
	}
	
	
	
	
	@RequestMapping(value = "/imageUpload")
	public void imageUploadGet(MultipartFile upload, 
			HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		response.setCharacterEncoding("utf-8"); // 한글처리
		response.setContentType("text/html; charset=utf-8");
		
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		String oFileName = upload.getOriginalFilename();
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
		oFileName = sdf.format(date) + "_" + oFileName;
		
		// ckeditor에서 올린(전송)한 파일을 서버 파일시스템에 실제로 저장처리 시켜준다.
		byte[] bytes = upload.getBytes();
		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
		fos.write(bytes);
		
		// 서버 파일시스템에 있는 그림파일을 브라우저 편집화면(textarea)에 보여주는 처리
		PrintWriter out = response.getWriter(); 
		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
		
		out.flush();		
		fos.close();
		
	}
	
}
