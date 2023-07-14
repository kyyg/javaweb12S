<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>dbOrderPay.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<div class="container">
<h3 class="text-center pt-5 pb-5">주문/결제</h3>
	<form name="myform" method="post" action="${ctp}/dbShop/dbOrderInputOk">
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
				<td><input type="text" name="name" id="name" value="${memberVO.name}" class="form-control" /></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="tel" id="tel" value="${memberVO.tel}" class="form-control" /></td>
			</tr>
			<tr>
				<th>이메일</th>
				<td><input type="text" name="email" id="email" value="${memberVO.email}" class="form-control" /></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="address" id="address" value="${memberVO.address}" size="70" class="form-control" /></td>
			</tr>
			<tr><td class="p-0 m-0"></td></tr>
		</table>
				
		<c:set var="optionIdx" value="${fn:split(orderVO.optionIdx,',')}" />
		<c:set var="optionName" value="${fn:split(orderVO.optionName,',')}" />
		<c:set var="optionPrice" value="${fn:split(orderVO.optionPrice,',')}" />
		<c:set var="optionNum" value="${fn:split(orderVO.optionNum,',')}" />
		<table class="table">
			<tr>
				<td colspan="2" class="text-center" style="background-color:#eee"><b>주문 상품 정보</b></td>
			</tr>
			<c:forEach var="i" begin="0" end="${fn:length(optionName)-1}">
				<tr>
					<td style="width:20%" class="text-center">
						<img src="${ctp}/dbShop/product/${orderVO.thumbImg}" width="100px">
					</td>
					<td style="width:80%">
						${orderVO.productName} <br/>
						<div id="optionName" name="optionName">옵션 : ${optionName[i]}</div>
						<div id="optionPrice" name="optionPrice">금액 : ${optionPrice[i]}</div>
						<div id="optionNum" name="optionNum">수량 : ${optionNum[i]}</div>
						<input type="hidden" name="optionIdx" id="optionIdx" value="${optionIdx[i]}" />
					</td>
				</tr>
				<tr><td class="p-0 m-0"></td></tr>
			</c:forEach>
			<tr>
				<td class="text-center "style="background-color:#eee"><b>배송비</b></td>
				<td class="text-right">
					<c:if test="${totalPrice >= 50000}">0</c:if>
					<c:if test="${totalPrice < 50000}">2500</c:if>
				</td>
			</tr>
			<tr>
				<td class="text-center" style="background-color:#eee"><b>최종 결제 금액</b></td>
				<td class="text-right mr-5"><font size="4px">${totalPrice}원</font></td>
				<input type="hidden" name="totalPrice" id="totalPrice" value="${totalPrice}" />
			</tr>
		</table>
		<div><input type="submit" class="form-control mb-5" value="결제하기" onclick="order()" style="background-color:#eee"/></div>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>