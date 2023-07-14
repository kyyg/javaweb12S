<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>orderCancelChild.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  </style>
  <script>
    'use strict';
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<form name="myhome" method="post">
		<h3>반품 / 환불 요청 페이지</h3>
		<table class="table table-bordered">
			<tr class="table-dark text-dark">
				<td>주문번호</td>
				<td>주문상품</td>
				<td>주문옵션/수량/가격</td>
			</tr>
			<tr>
				<td name="orderIdx" id="orderIdx">${vo.orderIdx}</td>
				<td>${vo.productName}</td>
				<td>${vo.optionName} / ${vo.optionNum} / ${vo.optionPrice}</td>
			</tr>
		</table>
		
		<select name="cancelStatus" id="cancelStatus">
			<option>사유를 선택하세요</option>
			<option value="반품요청">반품요청</option>
			<option value="환불요청">환불요청</option>
		</select>
		<textarea row="3" name="cancelMemo" id="cancelMemo" class="form-control mt-3" placeholder="반품/환불 상세 사유를 입력하세요"></textarea>
		<input type="hidden" name="orderIdx" value="${vo.orderIdx}">
		<input type="hidden" name="cancelIdx" value="${vo.idx}">
		<input type="hidden" name="mid" value="${sMid}">
		<input type="submit" value="취소 / 환불 요청" class="form-control btn btn-outline-dark mt-3" />
	</form>
</div>
<p><br/></p>
</body>
</html>