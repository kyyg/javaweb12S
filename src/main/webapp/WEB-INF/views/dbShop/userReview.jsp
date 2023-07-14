<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <title>userReview.jsp</title>
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
	<hr/><h3 class="text-center">내 리뷰글 관리</h3><hr/>
	 <!-- 리뷰 항목 -->
	<section id="target-section3" class="text-center">
	<div class="text-right mb-2" style="width:1000px;">
	</div>
 	<table class="table-borderless" style="width:1000px;">
 		<c:forEach var="vo" items="${VOS}">
	 		<tr><td colspan="3" style="border-bottom:1px solid lightgray"></td></tr>
	 		<tr class="text-dark" style="background-color:#eee;">
	 			<td style="width:20%; height:25%" class="text-center">
	 			<img src="${ctp}/images/mu.jpg" class="w3-circle" alt="mu" style="width:50px">
	 			</td>
	 			<td colspan="2" class="text-left">
	 				<font color="red"><b>
		 				<c:if test="${vo.score == 1}">★☆☆☆☆<br/></c:if>
		 				<c:if test="${vo.score == 2}">★★☆☆☆<br/></c:if>
		 				<c:if test="${vo.score == 3}">★★★☆☆<br/></c:if>
		 				<c:if test="${vo.score == 4}">★★★★☆<br/></c:if>
		 				<c:if test="${vo.score == 5}">★★★★★<br/></c:if>
	 				</b></font>
	 				${vo.mid} / ${fn:substring(vo.WDate,0,10)}<br/>
	 				<span class="badge badge-light mr-2">옵션</span><font size="2">${vo.productName}</font>
	 			</td>
	 		</tr>
	 		<tr><td colspan="3" style="border-bottom:1px solid lightgray"></td></tr>
	 		<tr>
	 			<td></td>
 				<td class="text-left">${vo.title}</td>
 			</tr>
 			<tr><td></td><td colspan="2" style="border-bottom:1px solid lightgray"></td></tr>
 			<tr>
 				<td></td>
 				<td class="text-left">
 					${vo.content}
 				</td>
 				<td>	
 					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
 					<c:forEach var="fSName" items="${fSNames}" varStatus="st">
 						<img src="${ctp}/review/${fSName}" width="100px" /><br/>
 					</c:forEach>
 				</td>
 			</tr>
 			<tr><td colspan="3" class="pb-5"></td></tr>
 			<tr><td colspan="3" style="border-bottom:1px solid lightgray"></td></tr>
 			<tr><td colspan="3" class="pb-5"></td></tr>
 		</c:forEach>
 	</table>
	</section>
</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>