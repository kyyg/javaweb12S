<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>userShppingList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  th{
  background-color: #eee;
  }
  </style>
  <script>
    'use strict';
    function selectSp(name,email,tel,roadAddress,detailAddress,extraAddress,postcode) {
   	  let address = roadAddress + " " + detailAddress + " " + extraAddress;
   	  
   	   if (window.opener) {
   	    window.opener.document.getElementById("buyer_name").value = name;
   	    window.opener.document.getElementById("buyer_email").value = email;
   	    window.opener.document.getElementById("buyer_tel").value = tel;
   	    window.opener.document.getElementById("buyer_addr").value = address;
   	    window.opener.document.getElementById("buyer_postcode").value = postcode;
   	  } 
   	  window.close();
   	}
    
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<div class="text-center"><h4>배송지목록</h4></div>
	<c:if test="${!empty vos}">
  <table class="table table-bordered text-center" style="margin: 0 auto; width:700px; background-color:#c9aea2">
  	<tr style="background-color:#c9aea2">
  		<th style="width:20%">배송지명</td>
  		<th style="width:20%">이름</td>
  		<th style="width:20%">전화번호</td>
  		<th style="width:20%">이메일</td>
  		<th style="width:20%"></td>
  	</tr>
	<c:forEach var="vo" items="${vos}">
  	<tr>
  		<td><span id="shippingName">${vo.shippingName}</span></td>
  		<td><span id="name">${vo.name}</span></td>
  		<td><span id="email">${vo.email}</span></td>
  		<td colspan="2"><span id="tel">${vo.tel}</span></td>
  	</tr>
 		<tr>
		  <th>주소</th>
		  <td colspan="3" class="text-left">
		  	<c:set var="address" value="${fn:split(vo.address,'/')}"/>
	      <c:set var="postcode" value="${address[0]}"/>
	      <c:set var="roadAddress" value="${address[1]}"/>
	      <c:set var="detailAddress" value="${address[2]}"/>
	      <c:set var="extraAddress" value="${address[3]}"/>
		    <div class="form-group">
      <div class="input-group mb-1">${roadAddress}${detailAddress}${extraAddress} (${postcode})</div>
      <input type="hidden" name="roadAddress" id="roadAddress" value="${roadAddress}" />
      <input type="hidden" name="detailAddress" id="detailAddress" value="${detailAddress}" />
      <input type="hidden" name="extraAddress" id="extraAddress" value="${extraAddress}" />
      <input type="hidden" name="postcode" id="postcode" value="${postcode}" />
		 </td>
		 <td><input type="button" value="선택" onclick="selectSp('${vo.name}','${vo.email}','${vo.tel}','${roadAddress}','${detailAddress}','${extraAddress}','${postcode}')" class="btn btn-outline-dark btn-sm"></td>
		</tr>
		<tr><td colspan="5" class="mt-2 mb-2 pt-2 pb-2"></td></tr>
	</c:forEach>
	</table>
	</c:if>
	<c:if test="${empty vos}">
	배송목록이 없습니다.
	</c:if>
</div>
<p><br/></p>
</body>
</html>