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
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <style>
  </style>
  <script>
    'use strict';
    
    function optionUpdate(idx){
    	let optionName = $("#optionName"+idx).val();
    	let optionPrice = $("#optionPrice"+idx).val();
    	let optionStock = $("#optionStock"+idx).val();
    	
    //alert("optionName : " + optionName + "/optionPrice : " + optionPrice + "/optionStock : " + optionStock);
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
    			if(res == "1"){
    				alert("수정되었습니다.");
    				location.reload();
    			} 
    		},
    		error:function(){
    			alert("전송오류!");
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
	<hr/>
	<h5 class="text-center">옵션 내역</h5>
	<hr/>
		<c:if test="${!empty vos}">
			<table class="table-borderless">
				<tr class="table-primary text-dark">
					<td style="width:10%"></td>
					<td style="width:30%">옵션명</td>
					<td style="width:20%">옵션가격</td>
					<td style="width:20%">옵션재고</td>
					<td style="width:20%"></td>
				</tr>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr>
						<td style="width:10%">${st.count}</td>
						<td style="width:30%"><input type="text" value="${vo.optionName}" id="optionName${vo.idx}" name="optionName${vo.idx}" /></td>
						<td style="width:20%"><input type="number" value="${vo.optionPrice}" id="optionPrice${vo.idx}" name="optionPrice${vo.idx}" /></td>
						<td style="width:20%"><input type="number" value="${vo.optionStock}" id="optionStock${vo.idx}" name="optionStock${vo.idx}" /></td>
						<td style="width:20%"><input type="button" value="수정" onclick="optionUpdate(${vo.idx})" class="btn btn-outline-dark" /></td>
					</tr>
				</c:forEach>
		</c:if>
		<c:if test="${empty vos}">
			<tr class="text-center">
				<td colspan="5" class="text-center">
				옵션이 존재하지 않습니다.<br/>
				</td>
			</tr>
		</c:if>
	</table>
	<div class="text-center mt-3">
		<input type="button" value="옵션내역 닫기" class="btn btn-outline-danger text-center" onclick="closeNew()"/>
	</div>
</div>
<p><br/></p>
</body>
</html>