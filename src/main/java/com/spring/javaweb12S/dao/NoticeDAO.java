package com.spring.javaweb12S.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb12S.vo.NoticeVO;

public interface NoticeDAO {

	public int totRecCnt();

	public List<NoticeVO> getNoticeList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int setNoticeInput(@Param("vo") NoticeVO vo);

	public NoticeVO getNoticeContent(@Param("idx") int idx);

	public void setNoticeReadNum(@Param("idx") int idx);

	public ArrayList<NoticeVO> getPrevNext(@Param("idx") int idx);

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public List<NoticeVO> getNoticeListSearch(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("search") String search, @Param("searchString") String searchString);

	public int setNoticeDelete(@Param("idx") int idx);

	public int setNoticeUpdate(@Param("vo") NoticeVO vo);


	public String getMaxGroupId(@Param("NoticeIdx") int NoticeIdx);


}
