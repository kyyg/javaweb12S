<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>noticeList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/notice/noticeList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
    
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/notice/noticeList?pag=${pageVO.pag}&pageSize="+pageSize;
    }
    
    function searchCheck() {
    	let searchString = $("#searchString").val();
    	
    	if(searchString.trim() == "") {
    		alert("찾고자하는 검색어를 입력하세요!");
    		searchForm.searchString.focus();
    	}
    	else {
    		searchForm.submit();
    	}
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2 class="text-center">공지 게시판</h2>
  <table class="table table-borderless">
    <tr>
      <td><c:if test="${sLevel == 0}"><a href="${ctp}/admin/adminNoticeInput" class="btn btn-outline-dark btn-sm">공지 작성</a></c:if></td>
      <td class="text-right">
        <!-- 한페이지 분량처리 -->
        <select name="pageSize" id="pageSize" onchange="pageCheck()">
          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
          <option <c:if test="${pageVO.pageSize == 5}">selected</c:if>>5</option>
          <option <c:if test="${pageVO.pageSize == 10}">selected</c:if>>10</option>
          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
          <option <c:if test="${pageVO.pageSize == 20}">selected</c:if>>20</option>
        </select> 건
      </td>
    </tr>
  </table>
  
  <table class="table table-hover text-center">
    <tr>
      <th></th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성날짜</th>
      <th>조회수</th>
    </tr>
    
	<c:forEach var="vo" items="${vos}" varStatus="st">
	    <c:if test="${vo.fixed == 'on'}">
	     <tr  class="table-dark text-dark">
	       <td><span class="badge badge-danger">공지</span></td>
	       <td class="text-left">
	         <a href="${ctp}/notice/noticeContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><b>${vo.title}</b></a>
	       </td>
	       <td>${vo.nickName}</td>
	       <td>
	         <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
	         <c:if test="${vo.hour_diff <= 24}">
	           ${vo.day_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,16)}
	         </c:if>
	       </td>
	       <td>${vo.readNum}</td>
		     </tr>
		    </c:if>
	  </c:forEach>
    
   <c:forEach var="vo" items="${vos}" varStatus="st">
	    <c:if test="${vo.fixed != 'on'}">
  	  <c:set var="curScrStartNo" value="${vo.idx}" />
	     <tr>
	       <td>${curScrStartNo}</td>
	       <td class="text-left">
	         <a href="${ctp}/admin/adminNoticeContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}</a>
	       </td>
	       <td>${vo.nickName}</td>
	       <td>
	         <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
	         <c:if test="${vo.hour_diff <= 24}">
	           ${vo.day_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,16)}
	         </c:if>
	       </td>
	       <td>${vo.readNum}</td>
		     </tr>
		    </c:if>
	  </c:forEach>
    
    <tr><td colspan="6" class="m-0 p-0"></td></tr>
  </table>
  
  
  
  <!-- 블록 페이징 처리 -->
  <div class="text-center m-4">
	  <ul class="pagination justify-content-center pagination-sm">
	    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeList?pageSize=${pageVO.pageSize}&pag=1">첫페이지</a></li></c:if>
	    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">이전블록</a></li></c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/notice/noticeList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li></c:if>
	    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/notice/noticeList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">마지막페이지</a></li></c:if>
	  </ul>
  </div>
  
  </div>
<p><br/></p>
</body>
</html>