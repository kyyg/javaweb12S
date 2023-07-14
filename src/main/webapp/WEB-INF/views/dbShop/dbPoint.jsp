<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>dbPoint.jsp</title>
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
  <h3 class="text-center">포인트 내역</h3>
  <hr/>
  <table class="table table-borderless table-hover text-center">
  	<tr class="table-dark text-dark">
  		<th>날짜</th>
  		<th>내역</th>
  		<th>적립 포인트</th>
  		<th>사용 포인트</th>
  	</tr>
  	<c:forEach var="vo" items="${vos}">
  		<tr>
				<td style="width:20%">${fn:substring(vo.WDate,0,10)}</td>  		
				<td>[${vo.orderIdx}] 건에 대한 ${vo.pointMemo}</td>  		
				<td>
					<c:if test="${vo.getPoint != 0}">+${vo.getPoint}point</c:if>
					<c:if test="${vo.getPoint == 0}"></c:if>
				</td>  	
				<td>
					<c:if test="${vo.usePoint != 0}">-${vo.usePoint}point</c:if>
					<c:if test="${vo.usePoint == 0}"></c:if>
				</td>  		
  		</tr>
  	</c:forEach>
  </table>
	
	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>