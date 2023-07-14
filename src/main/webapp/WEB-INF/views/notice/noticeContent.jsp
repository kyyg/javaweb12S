<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>noticeContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';

    // 게시글 삭제처리
    function noticeDelete() {
    	let ans = confirm("현 게시글을 삭제하시겠습니까?");
    	if(ans) location.href="${ctp}/notice/noticeDelete?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&nickName=${vo.nickName}";
    }
  
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">공지 상세내용</h2>
  <br/>
  <table class="table table-borderless m-0 p-0">
  </table>
  <table class="table table-bordered">
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.WDate,0,fn:length(vo.WDate)-2)}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">${vo.title}</td>
    </tr>
    <tr>

      <th>조회수</th>
      <td>${vo.readNum}</td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
    <tr>
      <td colspan="4" class="text-center">
        <c:if test="${flag == 'search'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/notice/noticeSearch?search=${search}&searchString=${searchString}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/></c:if>
        <c:if test="${flag == 'searchMember'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/notice/noticeSearchMember?pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/></c:if>
        <c:if test="${flag != 'search' && flag != 'searchMember'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/notice/noticeList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-primary"/></c:if>
        &nbsp;
      	<c:if test="${sMid == vo.mid || sLevel == 0}">
        	<input type="button" value="수정하기" onclick="location.href='${ctp}/notice/noticeUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning"/> &nbsp;
        	<input type="button" value="삭제하기" onclick="noticeDelete()" class="btn btn-danger"/>
      	</c:if>
      </td>
    </tr>
  </table>
  
  <c:if test="${flag != 'search' && flag != 'searchMember'}">
	  <!-- 이전글/ 다음글 처리 -->
	  <table class="table table-borderless">
	    <tr>
	      <td>
	        <c:if test="${!empty pnVos[1]}">
	          ☝ <a href="${ctp}/notice/noticeContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[1].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx < pnVos[0].idx}">
	        	☝ <a href="${ctp}/notice/noticeContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx > pnVos[0].idx}">
	        	👇 <a href="${ctp}/notice/noticeContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	      </td>
	    </tr>
	  </table>
  </c:if>
  
 
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>