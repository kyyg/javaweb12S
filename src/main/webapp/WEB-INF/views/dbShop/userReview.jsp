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
    
   	function imagesClick(idx){
		$("#demo"+idx).slideDown(500);
	}
	
	function imagesUp(idx){
		$("#demo"+idx).slideUp(500);
	}
	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<hr/><h3 class="text-center">내 리뷰글 관리</h3><hr/>
	 <!-- 리뷰 항목 -->
	<div class="text-right mb-2" style="width:1000px;">
	</div>
 	 	<table class="table-borderless" style="width:1000px; margin:0 auto;">
 		<tr><td colspan="3" class="p-0 m-0 mt-2 pt-3 pb-3 mb-3" style="border-bottom :solid 1px lightgray"></td></tr>
 		<c:forEach var="vo" items="${VOS}">
	 		<tr class="text-dark" style="background-color:#fff;">
	 			<td style="width:20%"; class="text-center">
	 				<img src="${ctp}/images/mu.jpg" class="w3-circle" alt="mu" style="width:70px">
	 			</td>
	 			<td colspan="1" class="text-left pt-3 pb-2" style="width:60%";>
	 				<b>
		 				<c:if test="${vo.score == 1}">💙🤍🤍🤍🤍<br/></c:if>
		 				<c:if test="${vo.score == 2}">💙💙🤍🤍🤍<br/></c:if>
		 				<c:if test="${vo.score == 3}">💙💙💙🤍🤍<br/></c:if>
		 				<c:if test="${vo.score == 4}">💙💙💙💙🤍<br/></c:if>
		 				<c:if test="${vo.score == 5}">💙💙💙💙💙<br/></c:if>
	 				</b>
	 				<b>${vo.mid}</b> &nbsp;&nbsp; <font color="brown"> ${fn:substring(vo.WDate,0,10)}</font><br/>
	 				<span class="badge badge-light mr-2 mb-2">옵션</span><font size="2">${vo.productName}</font><br/>
	 				<b>${vo.title}</b><br/>
	 				${vo.content}
				<td class="mt-3 mb-3" style="width:20%";>	
 					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
 						<img src="${ctp}/review/${fSNames[0]}" width="100px" class="w3-round" onclick="imagesClick('${vo.idx}')" /><br/>
 				</td>
 			</tr>
		 	</div>
	 	<tr><td colspan="3" class="m-0 p-0 text-center"><div id="demo${vo.idx}"  style="display:none">
	 		<c:forEach var="fSName" items="${fSNames}" varStatus="st">
 				<img src="${ctp}/review/${fSName}" width="200px" height="200"/>
 			</c:forEach>
 			<br/>
 			<input type="button" value="이미지 접기" onclick="imagesUp('${vo.idx}')" class="btn btn-outline-dark btn-sm text-right mt-3"/>
 			<tr><td colspan="3" class="p-0 m-0 mt-2 pt-3" style="border-bottom :solid 1px lightgray"></td></tr>
	 	</div></td></tr>
 		</c:forEach>
 	</table>
</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>