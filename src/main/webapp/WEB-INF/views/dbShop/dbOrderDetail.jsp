<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="$${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>dbOrderDetail.jsp.jsp</title>
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
		<table class="table table-bordered mb-5">
			<tr class="text-center">
				<th colspan="2 m-0 p-0" style="background-color:#eee">고객 정보</th>
			</tr>
			<tr>
				<th style="width:20%">아이디</th>
				<td style="width:80%"><span id="mid" name="mid">${mid}</span></td>
			</tr>
			<tr>
				<th>받는 분 성함</th>
				<td>${vo.name}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${vo.tel}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${vo.address}</td>
			</tr>
			<tr>
				<th>배송메세지</th>
				<td>${vo.message}</td>
			</tr>
		</table>

		<table class="table table-bordered">
			<tr>
				<td colspan="3" class="text-center" style="background-color:#eee"><b>주문 상품 정보</b></td>
			</tr>
			<tr><td class="p-0 m-0"></td></tr>
			<c:forEach var="orderVO" items="${vos}">
				<tr>
				<td colspan="2" style="width:80%">
					제품 : ${orderVO.productName}
					<div id="optionName" name="optionName">옵션 : ${orderVO.optionName}</div>
					<div id="optionPrice" name="optionPrice">금액 : ${orderVO.optionPrice}</div>
					<div id="optionNum" name="optionNum">수량 : ${orderVO.optionNum}</div>
					<div id="status" name="status">주문상태 : ${orderVO.status}</div>
				</td>
				</tr>
				<tr><td class="p-0 m-0"></td></tr>
			</c:forEach>
		</table>
		
				<table class="table table-bordered mb-5">
			<tr class="text-center">
				<th colspan="2 m-0 p-0" style="background-color:#eee">결제 정보</th>
			</tr>
			<tr>
				<th style="width:20%">결제방식</th>
				<td style="width:80%">${vo.payment}</td>
			</tr>
			<tr>
				<th>카드/무통장입급 번호</th>
				<td>${vo.payMethod}</td>
			</tr>
						<tr>
				<c:if test="${vo.usingPoint != 0}">
					<td colspan="2" class="text-right">포인트 사용 금액 : ${vo.usingPoint}point</td>
				</c:if>
				<c:if test="${vo.usingPoint == 0}"></c:if>
			</tr>
			<tr>
				<td class="text-center" style="background-color:#eee; width:20%" ><b>최종 결제 금액</b></td>
				<td colspan="2" class="text-right mr-5"><font size="4px">${vo.orderTotalPrice}원</font></td>
			</tr>
		</table>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>