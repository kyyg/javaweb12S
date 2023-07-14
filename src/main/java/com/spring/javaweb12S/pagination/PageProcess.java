package com.spring.javaweb12S.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb12S.dao.BoardDAO;
import com.spring.javaweb12S.dao.DbShopDAO;
import com.spring.javaweb12S.dao.MemberDAO;
import com.spring.javaweb12S.dao.NoticeDAO;
import com.spring.javaweb12S.dao.PdsDAO;

@Service
public class PageProcess {

	
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	NoticeDAO noticeDAO;
	
	@Autowired
	PdsDAO pdsDAO;
	
	@Autowired
	DbShopDAO dbShopDAO;
	
	public PageVO totRecCnt(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("board"))	totRecCnt = boardDAO.totRecCnt();
		else if(section.equals("member"))	totRecCnt = memberDAO.totRecCnt(searchString);
		else if(section.equals("notice")) totRecCnt = noticeDAO.totRecCnt();
		else if(section.equals("pds"))	totRecCnt = pdsDAO.totRecCnt(part);
		else if(section.equals("dbMyOrder")) {
			String mid = part;
			totRecCnt = dbShopDAO.totRecCnt(mid);
		}
		else if(section.equals("product")) {
			String productPart = part;
			totRecCnt = dbShopDAO.totRecCnt2(productPart);
		}
		else if(section.equals("review")) {
			String mid = part;
			int proudctIdx = Integer.parseInt(searchString);
			totRecCnt = dbShopDAO.totRecCnt3(mid,proudctIdx);
		}
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(part);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}
	
	
	public PageVO totRecCnt10(int pag, int pageSize, String section, String part, String searchString) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		String search = "";
		
		if(section.equals("dbMyOrder")) {
			String mid = part;
			totRecCnt = dbShopDAO.totRecCnt(mid);
		}
		
		int totPage = (totRecCnt % pageSize)==0 ? totRecCnt /pageSize : (totRecCnt / pageSize) + 1;
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (totPage - 1) / blockSize;
		
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setTotPage(totPage);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setCurBlock(curBlock);
		pageVO.setBlockSize(blockSize);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(part);
		pageVO.setSearch(search);
		pageVO.setSearchString(searchString);
		
		return pageVO;
	}

}
