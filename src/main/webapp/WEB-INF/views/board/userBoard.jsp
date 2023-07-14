<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>dbUserBoard.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  </style>
  <script>
    'use strict';
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<hr/>
	<h3 class="text-center">내 문의글 관리</h3>
	<hr/>
	 <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th></th>
      <th>분류</th>
      <th style="width:40%">제목</th>
      <th>작성자</th>
      <th>작성날짜</th>
      <th>조회수</th>
      <th>답변여부</th>
    </tr>
   <c:forEach var="vo" items="${VOS}" varStatus="st">
  	  <c:set var="curScrStartNo" value="${st.count}" />
	     <tr>
	       <td>${curScrStartNo}</td>
	       <td>${vo.part}</td>
	       <td class="text-center">
		       	<a href="${ctp}/board/userBoardContent?idx=${vo.idx}">${vo.title}</b></a>
	       </td>
	       <td>
	         ${vo.mid}
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
	  </c:forEach>
    <tr><td colspan="8" class="m-0 p-0"></td></tr>
  </table>
</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>