<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>orderCancelReason.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  </style>
  
  <script>
    'use strict';
    
    function closeNew(){
   	 window.close();
   }
    
    function qnaGo(){
    	window.close(); // 새 창 닫기
    	window.opener.location.href = "${ctp}/qna/qnaList"; // 부모 창에서 페이지 이동
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container text-center">
	<h3>환불/반품 불가 사유</h3>
	
	<table class="table table-bordered">
		<tr>
			<td style="background-color:#eee; width:25%">처리 상태</td>
			<td>${vo.reason1}</td>
		</tr>
		<tr>
			<td style="background-color:#eee">상세 취소 사유</td>
			<td>${vo.reason2}</td>
		</tr>
		<tr>
			<td colspan="2" style="height:100px;"> 
				위 사유로 환불/반품 처리가 거절되었습니다.<br/>
				상담이 더 필요하신 경우 문의게시판에 작성하여 주시길 바랍니다. <br/>
			</td>
		</tr>
	</table>
	<div class="text-center">
		<input type="button" value="문의 게시판" class="btn btn-outline-dark" onclick="qnaGo()" />
		<input type="button" value="닫기" class="btn btn-outline-dark" onclick="closeNew()" />
	</div>
</div>
<p><br/></p>
</body>
</html>