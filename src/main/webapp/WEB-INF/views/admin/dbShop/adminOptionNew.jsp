<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminOptionNew.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  </style>
  <script>
    'use strict';
    
    function optionUpdate(idx){
    	let optionName = $("#optionName"+idx).val;
    	let optionPrice = $("#optionPrice"+idx).val;
    	let optionStock = $("#optionStock"+idx).val;
    	
/*    alert("optionName : " + optionName);
    	alert("optionPrice : " + optionPrice);
    	alert("optionStock : " + optionStock); */
     	$.ajax({
    		type : "post",
    		url : "${ctp}/admin/optionUpdate",
    		data : {
    			idx : idx,
    			optionName : optionName,
    			optionPrice : optionPrice,
    			optionStock : optionStock
    		},
    		success:function(res){
    			if(res == "1") alert("수정되었습니다.");
    		},
    		error:function(){
    			alert("전송오류!");
    		}
    	}); 
    	
    	
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<table class="table-borderless">
		<tr class="table-dark text-dark">
			<td>옵션명</td>
			<td>옵션가격</td>
			<td>옵션재고</td>
			<td></td>
		</tr>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td><input type="text" value="${vo.optionName}" id="optionName${vo.idx}" name="optionName" /></td>
				<td><input type="number" value="${vo.optionPrice}" id="optionPrice${vo.idx}" name="optionPrice" /></td>
				<td><input type="number" value="${vo.optionStock}" id="optionStock${vo.idx}" name="optionStock" /></td>
				<td><input type="button" value="수정" onclick="optionUpdate(${vo.idx})" class="btn btn-outline-dark" /></td>
			</tr>
		</c:forEach>
	</table>
	<div class="text-center mt-3">
		<input type="button" value="옵션내역 닫기" class="btn btn-outline-danger text-center" />
	</div>
</div>
<p><br/></p>
</body>
</html>