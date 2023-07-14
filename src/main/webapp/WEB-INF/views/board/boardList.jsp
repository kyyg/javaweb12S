<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    'use strict';
    
    // part선택시 해당 part만 불러오기
    function partCheck() {
    	let part = partForm.part.value;
    	location.href = "${ctp}/board/boardList?part="+part;
    }
    
    
    if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/board/boardList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
    
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/board/boardList?pag=${pageVO.pag}&pageSize="+pageSize;
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
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">문의 게시판</h2>
  <table class="table table-borderless">
      <tr>
      <td style="width:20%" class="text-left">
        <form name="partForm">문의 분류
          <select name="part" onchange="partCheck()" class="form-contorl">
            <option ${pageVO.part=="전체" ? "selected" : ""}>전체</option>
            <option ${pageVO.part=="상품" ? "selected" : ""}>상품</option>
            <option ${pageVO.part=="배송" ? "selected" : ""}>배송</option>
            <option ${pageVO.part=="취소" ? "selected" : ""}>취소</option>
            <option ${pageVO.part=="환불" ? "selected" : ""}>환불</option>
            <option ${pageVO.part=="기타" ? "selected" : ""}>기타</option>
          </select>
        </form>
      </td>
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
      <th>분류</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성날짜</th>
      <th>조회수</th>
      <th>답변여부</th>
    </tr>
	<c:forEach var="vo" items="${vos}" varStatus="st">
    <c:if test="${vo.fixed == 'on'}">
     <tr  class="table-dark text-dark">
       <td><span class="badge badge-danger">공지</span></td>
       <td></td>
       <td class="text-left">
         <a href="${ctp}/board/boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><b>${vo.title}</b></a>
       </td>
       <td>${vo.nickName}</td>
       <td>
         <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
         <c:if test="${vo.hour_diff <= 24}">
           ${vo.day_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,16)}
         </c:if>
       </td>
       <td>${vo.readNum}</td>
       <td></td>
	     </tr>
	   </c:if>
	 </c:forEach>
   <c:forEach var="vo" items="${vos}" varStatus="st">
	    <c:if test="${vo.fixed != 'on'}">
  	  <c:set var="curScrStartNo" value="${vo.idx}" />
	     <tr>
	       <td>${curScrStartNo}</td>
	       <td>${vo.part}</td>
	       <td class="text-left">
			      <c:if test="${vo.openSw == 'OK' || sLevel == 0 || sMid == vo.mid}">
		       	<a href="${ctp}/board/boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}</b></a>
		       </c:if>
		       <c:if test="${vo.openSw != 'OK' && sLevel != 0 && sMid != vo.mid}">
		       	${vo.title} <span class="badge badge-secondary">비공개</span>
		       </c:if>
	       </td>
	       <td>
	         <c:forEach var="i" begin="0" end="${fn:length(vo.mid)-1}">
	         <c:if test="${i > 2}">${fn:replace(fn:substring(vo.mid,i,i+1),fn:substring(vo.mid,i,i+1),'*')}</c:if>
	         <c:if test="${i < 2}">${fn:substring(vo.mid,i,i+1)}</c:if>
	         </c:forEach>
	       </td> 
	       <td>
	         <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
	         <c:if test="${vo.hour_diff <= 24}">
	           ${vo.day_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,16)}
	         </c:if>
	       </td>
	       <td>${vo.readNum}</td>
	       <td>${vo.answer}</td>
		     </tr>
		    </c:if>
	  </c:forEach>
    <tr><td colspan="8" class="m-0 p-0"></td></tr>
  </table>
  <div class="text-right"><c:if test="${sLevel < 3}"><a href="${ctp}/board/boardInput" class="btn btn-outline-dark btn-sm">문의 작성</a></c:if></div>
  
  
  <!-- 블록 페이징 처리 -->
  <div class="text-center m-4">
	  <ul class="pagination justify-content-center pagination-sm">
	    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=1">첫페이지</a></li></c:if>
	    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">이전블록</a></li></c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li></c:if>
	    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">마지막페이지</a></li></c:if>
	  </ul>
  </div>
  
  <!-- 검색기 처리 -->
  <div class="container text-center">
    <form name="searchForm" method="get" action="${ctp}/board/boardSearch">
      <b>검색 : </b>
      <select name="search">
        <option value="title" selected>글제목</option>
        <option value="nickName">글쓴이</option>
        <option value="content">글내용</option>
      </select>
      <input type="text" name="searchString" id="searchString"/>
      <input type="button" value="검색" onclick="searchCheck()" class="btn btn-secondary btn-sm"/>
      <input type="hidden" name="pag" value="${pageVO.pag}"/>
      <input type="hidden" name="pageSize" value="${pageVO.pageSize}"/>
    </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>