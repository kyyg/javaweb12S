package com.spring.javaweb12S.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb12S.dao.ContactDAO;
import com.spring.javaweb12S.vo.ContactReplyVO;
import com.spring.javaweb12S.vo.ContactVO;

@Service
public class ContactServiceImpl implements ContactService {

	@Autowired
	ContactDAO contactDAO;

	// 제휴 등록, 파일 처리..
	@Override
	public int setContactInput(MultipartHttpServletRequest mFile, ContactVO vo) {
		int res = 0;
		try {
		List<MultipartFile> fileList = mFile.getFiles("file");
		String oFileNames = "";
		String sFileNames = "";
		for(MultipartFile file : fileList) {
			String oFileName = file.getOriginalFilename();
			String sFileName = saveFileName(oFileName);
			if(!oFileName.equals("")) {
				// 파일을 서버에 저장처리...
				writeFile(file, sFileName);
				// 여러개의 파일명을 관리...
				oFileNames += oFileName + "/";
				sFileNames += sFileName + "/";
			}
		}
		vo.setFName(oFileNames);
		vo.setFSName(sFileNames);
		
		res = contactDAO.setContactInput(vo);
	} catch (IOException e) {
		e.printStackTrace();
	}
	return res;
	}

	
	
	// 화일명 중복방지를 위한 저장파일명 만들기
	private String saveFileName(String oFileName) {
		String fileName = "";
		
		Calendar cal = Calendar.getInstance();
		fileName += cal.get(Calendar.YEAR);
		fileName += cal.get(Calendar.MONTH);
		fileName += cal.get(Calendar.DATE);
		fileName += cal.get(Calendar.HOUR);
		fileName += cal.get(Calendar.MINUTE);
		fileName += cal.get(Calendar.SECOND);
		fileName += cal.get(Calendar.MILLISECOND);
		fileName += "_" + oFileName;
		
		return fileName;
	}

	// 메인 상품 서버 저장하기
	private void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/contact/");
		
		FileOutputStream fos = new FileOutputStream(uploadPath + saveFileName);
		fos.write(data);
		fos.close();
	}


	@Override
	public List<ContactVO> setContactList(String mid) {
		return contactDAO.setContactList(mid);
	}


	@Override
	public ContactVO getContactContent(int idx) {
		return contactDAO.getContactContent(idx);
	}



	@Override
	public ContactReplyVO getContactReply(int idx) {
		return contactDAO.getContactReply(idx);
	}
	
}
