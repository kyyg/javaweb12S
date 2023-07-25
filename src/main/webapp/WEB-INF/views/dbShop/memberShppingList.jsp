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

   function shippingDelete(idx){
	  let ans = confirm("배송지를 삭제 하시겠습니까?");
  	if(!ans) {
  		location.reload();
  		return false;
  	}
		$.ajax({
			type : "post",
			url : "${ctp}/dbShop/shippingDelete",
			data : {idx : idx},
			success:function(){
		    alert("삭제 되었습니다.");
				location.reload();
			},
			error:function(){
				alert("전송오류");					
			}
		});  	
   }
   
   // 배송지 수정
   function shippingModify(idx){
    let url = "${ctp}/dbShop/memberShippingModify?idx="+idx;
    let winName = "winName";
    let winWidth = 600;
    let winHeight = 570;
    let x = (screen.width/2) - (winWidth/2);
    let y = (screen.height/2) - (winHeight/2);
    let opt="width="+winWidth+", height="+winHeight+", left="+x+", top="+y;
    window.open(url,winName,opt); 
   }
    
	  // 배송지 추가
	  function shippingAddNew(){
	    let url = "${ctp}/dbShop/userShppingAdd";
	    let winName = "winName";
	    let winWidth = 600;
	    let winHeight = 570;
	    let x = (screen.width/2) - (winWidth/2);
	    let y = (screen.height/2) - (winHeight/2);
	    let opt="width="+winWidth+", height="+winHeight+", left="+x+", top="+y;
	    window.open(url,winName,opt); 
	  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
	<hr/>
	<div class="text-center"><h3>배송지목록</h3></div>
	<hr/>
	<c:if test="${!empty vos}">
  <table class="table table-bordered text-center" style="margin: 0 auto; width:1200px">
  	<tr>
  		<th style="width:15%">배송지명</th>
  		<th style="width:10%">이름</th>
  		<th style="width:15%">전화번호</th>
  		<th style="width:15%">이메일</th>
  		<th style="width:45%">주소</th>
  		<th></th>
  	</tr>
	<c:forEach var="vo" items="${vos}">
  	<tr>
  		<td><span id="shippingName">${vo.shippingName}</span></td>
  		<td><span id="name">${vo.name}</span></td>
  		<td><span id="email">${vo.email}</span></td>
  		<td><span id="tel">${vo.tel}</span></td>
	  	 <td class="text-left">
			  	<c:set var="address" value="${fn:split(vo.address,'/')}"/>
		      <c:set var="postcode" value="${address[0]}"/>
		      <c:set var="roadAddress" value="${address[1]}"/>
		      <c:set var="detailAddress" value="${address[2]}"/>
		      <c:set var="extraAddress" value="${address[3]}"/>
			    <div class="form-group">
	      <div class="input-group mb-1">${roadAddress}${detailAddress}${extraAddress} (${postcode})</div>
			 </td>
			 <td>
			 	<input type="button" value="수정" onclick="shippingModify('${vo.idx}')" class="btn btn-outline-dark btn-sm" />
			 	<input type="button" value="삭제" onclick="shippingDelete('${vo.idx}')" class="btn btn-outline-dark btn-sm" />
			 </td>
  		</tr>
		<tr><td colspan="5" class="m-0 p-0"></td></tr>
	</c:forEach>
	</table>
	</c:if>
	<c:if test="${empty vos}">
	배송목록이 없습니다.
	</c:if>
</div>
<div class="text-right" style="width:1500px"><input type="button" value="배송지 추가" onclick="shippingAddNew()" class="btn btn-outline-dark btn-sm" /></div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>