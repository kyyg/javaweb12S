package com.spring.javaweb12S.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaweb12S.vo.NoticeVO;

public interface NoticeService {

	public List<NoticeVO> getNoticeList(int startIndexNo, int pageSize);

	public int setNoticeInput(NoticeVO vo);

	public void imgCheck(String content);

	public NoticeVO getNoticeContent(int idx);

	public void setNoticeReadNum(int idx);

	public ArrayList<NoticeVO> getPrevNext(int idx);

	public List<NoticeVO> getNoticeListSearch(int startIndexNo, int pageSize, String search, String searchString);

	public void imgDelete(String content);

	public int setNoticeDelete(int idx);

	public void imgCheckUpdate(String content);

	public int setNoticeUpdate(NoticeVO vo);

	public String getMaxGroupId(int NoticeIdx);

}
