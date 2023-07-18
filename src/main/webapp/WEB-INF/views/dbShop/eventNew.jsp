<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>eventNew.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  
  body{
  	background-image : url(${ctp}/images/classBackground.jpg);
  	image-size: 100%
  }
  
  </style>
  <script>
    'use strict';
    
    function eventGo(){
    	window.close(); // 새 창 닫기
    	window.opener.location.href = "${ctp}/dbShop/dbOnedayClass"; // 부모 창에서 페이지 이동
    }
    
    
    function closeNew(){
    	window.close();
    }
    
  </script>
</head>
<body style="background-color:skyblue">
<p><br/></p>
<div class="container">
	<table class="table-borderless text-center" style="width:300px; height:300px;">
		<tr>
			<td><h5 class="text-light">원데이 클래스 이벤트</h5></td>
		</tr>
		<tr style="height:200px" class="text-light">
			<td>
				[이벤트 해당 고객] <br/>
				3개월 간 구매금액 30만원 이상인 고객님<br/>
				이벤트 신청 후 확정문자 발송<br/>
			</td>
		</tr>
		<tr>
			<td>
				<input type="button" value="이벤트 대상 확인하기" onclick="eventGo()" class="btn btn-outline-light"/>
				<input type="button" value="닫기" class="btn btn-outline-light" onclick="closeNew()">		
			</td>
		</tr>
	</table>
</div>
<p><br/></p>
</body>
</html>