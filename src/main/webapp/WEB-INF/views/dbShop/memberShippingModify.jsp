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
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <style>
  </style>
  <script>
    'use strict';
    
    function listAdd(){
    	let mid = '${sMid}';
    	let idx = document.getElementById("idx").value;
    	let shippingName = document.getElementById("shippingName").value;
    	let name = document.getElementById("name").value;
    	let email = document.getElementById("email").value;
    	let tel = document.getElementById("tel").value;
    	
    	let postcode = myform.postcode.value + " ";
    	let roadAddress = myform.roadAddress.value + " ";
    	let detailAddress = myform.detailAddress.value + " ";
    	let extraAddress = myform.extraAddress.value + " ";
  		myform.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress;
  		let address = document.getElementById("address").value;
  		  		
   		$.ajax({
  			type : "post",
  			url : "${ctp}/dbShop/memberShippingModify",
  			data : {
  				idx : idx,
  				shippingName : shippingName,
  				mid : mid,
  				name : name,
  				tel : tel,
  				address : address,
  				email : email,
  			},
  			success : function(){
  				alert("배송지가 수정 되었습니다.");
			   	window.opener.location.reload();
	        window.close();
  			},
  			error:function(){
  				alert("전송오류");
  			}
  		});  
    }
    
    function closeNew(){
    	window.close();
    }
    
   </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<form name="myform" method="post">
  <table class="table table-borderless text-center" style="margin: 0 auto; width:500px">
    <tr class="table-dark text-dark">
      <th colspan="2">배송지 수정</th>
    </tr>
    <tr>
		  <th width="20%" class="text-center">배송지명</th>
		  <td><input type="text" name="shippingName" id="shippingName" value="${vo.shippingName}" class="form-control"/></td>
		</tr>
    <tr>
		  <th width="20%" class="text-center">성명</th>
		  <td><input type="text" name="name" id="name" value="${vo.name}" class="form-control"/></td>
		</tr>
    <tr>
		  <th>메일</th>
		  <td><input type="text" name="email" id="email" value="${vo.email}" class="form-control"/></td>
		</tr>
    <tr>
		  <th>전화번호</th>
		  <td><input type="text" name="tel" id="tel" value="${vo.tel}" class="form-control"/></td>
		</tr>
    <tr>
		  <th>주소</th>
		  <c:set var="address" value="${fn:split(vo.address,'/')}"/>
      <c:set var="postcode" value="${address[0]}"/>
      <c:set var="roadAddress" value="${address[1]}"/>
      <c:set var="detailAddress" value="${address[2]}"/>
      <c:set var="extraAddress" value="${address[3]}"/>
		  <td class="text-left">
		    <div class="form-group">
      <label for="address"></label>
      <div class="input-group mb-1">
        <input type="text" name="postcode" id="sample6_postcode" value="${postcode}" placeholder="우편번호" class="form-control">
        <div class="input-group-append">
          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
        </div>
      </div>
      <input type="text" name="roadAddress" id="sample6_address" size="50" value="${roadAddress}" placeholder="주소" class="form-control mb-1">
      <div class="input-group mb-1">
        <input type="text" name="detailAddress" id="sample6_detailAddress" value="${detailAddress}" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
        <div class="input-group-append">
          <input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" placeholder="참고항목" class="form-control">
        </div>
      </div>
    </div>
		  </td>
		</tr>
		<tr>
			<td colspan="2">
				<input type="hidden" name="idx" id="idx" value="${vo.idx}">
				<input type="hidden" name="mid" id="mid" value="${sMid}">
				<input type="hidden" name="address" id="address">
				<input type="button" value="배송지 수정" onclick="listAdd()" class="btn btn-outline-dark form-control mb-2">
				<input type="button" value="닫기" onclick="closeNew()" class="btn btn-outline-dark form-control">
			</td>
		</tr>
	</table>
	</form>
</div>
<p><br/></p>
</body>
</html>