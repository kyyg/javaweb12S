package com.spring.javaweb12S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb12S.vo.ContactReplyVO;
import com.spring.javaweb12S.vo.ContactVO;

public interface ContactDAO {

 public int setContactInput(@Param("vo") ContactVO vo);

public List<ContactVO> setContactList(@Param("mid") String mid);

public ContactVO getContactContent(@Param("idx") int idx);

public ContactReplyVO getContactReply(@Param("idx") int idx);

public void setContactDelete(@Param("idx") int idx);

public void setContactUpdate(@Param("vo") ContactVO vo);

}
