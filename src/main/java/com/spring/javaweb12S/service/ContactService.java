package com.spring.javaweb12S.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javaweb12S.vo.ContactReplyVO;
import com.spring.javaweb12S.vo.ContactVO;

public interface ContactService {

	public int setContactInput(MultipartHttpServletRequest file, ContactVO vo);

	public List<ContactVO> setContactList(String mid);

	public ContactVO getContactContent(int idx);

	public ContactReplyVO getContactReply(int idx);

	public void setContactDelete(int idx, String fSName);

	public void setContactUpdate(MultipartFile file, ContactVO vo);




}
