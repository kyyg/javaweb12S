<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>orderChildWin.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  </style>
  <script>
    'use strict';
    
    function orderConfirm(){
		 let ans = confirm("선택하신 상품을 구매확정 처리 하시겠습니까?");
      if(!ans){
        return false;
      }  
    	
   	 let idxs = "";
     let checkIdxs = document.getElementsByName("idxChecked");

     for(let i = 0; i < checkIdxs.length; i++) {
	   	 if(checkIdxs[i].checked) {
	   	    idxs += checkIdxs[i].value + "/";
	   	 }
   	 } 	

     $.ajax({
         type : "post",
         url  : "${ctp}/dbShop/orderConfirm",
         data : {idxs : idxs},
         success:function() {
        	 window.opener.location.reload();
        	 window.close();
         },
         error : function() {
         	alert("전송오류!");
         }
       });
     }
    
/*     function orderConfirm(){
		 let ans = confirm("선택하신 상품을 구매확정 처리 하시겠습니까?");
      if(!ans){
        return false;
      }  
    	
   	 let idxs = "";
     let checkIdxs = document.getElementsByName("idxChecked");

     for(let i = 0; i < checkIdxs.length; i++) {
	   	 if(checkIdxs[i].checked) {
	   	    idxs += checkIdxs[i].value + "/";
	   	 }
   	 } 	
     location.href="${ctp}/dbShop/orderConfirm?idxs="+idxs;
     location.href=window.close(); 
    } */
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>구매확정을 선택하실 상품을 체크해주세요.</h2>
	<p>주문번호 : ${vos[0].orderIdx}</p>
	<p>주문일자 : ${vos[0].orderDate}</p>
	<table class="table table-bordered text-center">
	  <tr class="table-dark text-dark">
	    <th></th>
	    <th>번호</th>
	    <th>상품명</th>
	    <th>금액</th>
	    <th>주문상태</th>
	  </tr>
	  <c:forEach var="vo" items="${vos}" varStatus="st">
	  	<c:if test="${vo.status == '배송중' || vo.status == '배송완료'}">
	    <tr>
		  	<td><input type="checkbox" value="${vo.baesongIdx}" name="idxChecked" id="idxChecked" /></td>
	      <td>${st.count}</td>
	      <td>${vo.productName}</td>
	      <td>${vo.totalPrice}</td>
	      <td>${vo.status}</td>
	    </tr>
	    </c:if>
	  	<c:if test="${vo.status != '배송중' && vo.status != '배송완료'}"></c:if>
	  </c:forEach>
	  <tr>
	    <td colspan="4" class="text-center">
	      <input type="button" value="구매확정" onclick="orderConfirm()" class="btn btn-danger"/>
	      <input type="button" value="창닫기" onclick="window.close()" class="btn btn-danger"/>
	    </td>
	  </tr>
	</table>
</div>
<p><br/></p>
</body>
</html>