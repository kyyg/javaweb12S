package com.spring.javaweb12S.service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb12S.common.JavawebProvide;
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

	//  서버 저장하기
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



	@Override
	public void setContactDelete(int idx, String fSName) {
		// 올려진 사진이 있으면 먼저 지우고 DB의 내용을 삭제처리한다.
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/contact/");
			File deleteFile = new File(realPath + fSName);
			if(deleteFile.exists()) deleteFile.delete();
			
			contactDAO.setContactDelete(idx);
	}



	
		
	
	
	@Override
	public void setContactUpdate(MultipartFile file, ContactVO vo) {
  // 사진을 변경처리 했다면 사진작업 처리후 DB에 갱신작업처리한다.
		try {
			String oFileName = file.getOriginalFilename();
			if(oFileName != null && !oFileName.equals("")) {
				// 기존에 존재하는 파일을 삭제
				HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
				String realPath = request.getSession().getServletContext().getRealPath("/resources/data/contact/");
				File deleteFile = new File(realPath + vo.getFSName());
				if(deleteFile.exists()) deleteFile.delete();
				
				// 새로 업로드되는 파일의 이름을 부여후 저장시키고, vo에 set시킨다.
				UUID uid = UUID.randomUUID();
				String saveFileName = uid + "_" + oFileName;
				JavawebProvide ps = new JavawebProvide();
				ps.writeFile(file, saveFileName,"contact");
				vo.setFName(oFileName);
				vo.setFSName(saveFileName);
			}
			else {
				vo.setFName(vo.getFName());
				vo.setFSName(vo.getFSName());
			}
			contactDAO.setContactUpdate(vo);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}
