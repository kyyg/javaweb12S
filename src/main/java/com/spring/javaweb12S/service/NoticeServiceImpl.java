package com.spring.javaweb12S.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaweb12S.dao.NoticeDAO;
import com.spring.javaweb12S.vo.NoticeVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	NoticeDAO NoticeDAO;

	@Override
	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize) {
		return NoticeDAO.getNoticeList(startIndexNo, pageSize);
	}

	@Override
	public int setNoticeInput(NoticeVO vo) {
		return NoticeDAO.setNoticeInput(vo);
	}

	@Override
	public void imgCheck(String content) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javaweb12S/data/ckeditor/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javaweb12S/data/notice/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/Notice/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 31;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "ckeditor/" + imgFile;
			String copyFilePath = realPath + "notice/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 Notice폴더위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	// 파일을 복사처리...
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
		try {
			FileInputStream  fis = new FileInputStream(new File(origFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			int cnt = 0;
			while((cnt = fis.read(bytes)) != -1) {
				fos.write(bytes, 0, cnt);
			}
			fos.flush();
			fos.close();
			fis.close();		
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public NoticeVO getNoticeContent(int idx) {
		return NoticeDAO.getNoticeContent(idx);
	}

	@Override
	public void setNoticeReadNum(int idx) {
		NoticeDAO.setNoticeReadNum(idx);
	}

	@Override
	public ArrayList<NoticeVO> getPrevNext(int idx) {
		return NoticeDAO.getPrevNext(idx);
	}

	@Override
	public List<NoticeVO> getNoticeListSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return NoticeDAO.getNoticeListSearch(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public void imgDelete(String content) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javaweb12S/data/notice/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/Notice/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 29;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));	// 그림파일명만 꺼내오기
			
			String origFilePath = realPath + "notice/" + imgFile;
			
			fileDelete(origFilePath);	// 'Notice'폴더의 그림을 삭제처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	// 실제로 서버의 파일을 삭제처리한다.
	private void fileDelete(String origFilePath) {
		File delFile = new File(origFilePath);
		if(delFile.exists()) delFile.delete();
	}

	@Override
	public int setNoticeDelete(int idx) {
		return NoticeDAO.setNoticeDelete(idx);
	}

	@Override
	public void imgCheckUpdate(String content) {
		//             0         1         2         3         4
		//             01234567890123456789012345678901234567890
		// <img alt="" src="/javawebS/data/Notice/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		// <img alt="" src="/javawebS/data/ckeditor/230616141341_sanfran.jpg" style="height:300px; width:400px" /></p><p><img alt="" src="/javawebS/data/ckeditor/230616141353_paris.jpg" style="height:300px; width:400px" /></p>
		
		// content안에 그림파일이 존재한다면 그림을 /data/Notice/폴더로 복사처리한다. 없으면 돌려보낸다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 26;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String origFilePath = realPath + "Notice/" + imgFile;
			String copyFilePath = realPath + "ckeditor/" + imgFile;
			
			fileCopyCheck(origFilePath, copyFilePath);	// ckeditor폴더의 그림파일을 Notice폴더위치로 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}

	@Override
	public int setNoticeUpdate(NoticeVO vo) {
		return NoticeDAO.setNoticeUpdate(vo);
	}

	@Override
	public String getMaxGroupId(int noticeIdx) {
		return NoticeDAO.getMaxGroupId(noticeIdx);
	}

}
