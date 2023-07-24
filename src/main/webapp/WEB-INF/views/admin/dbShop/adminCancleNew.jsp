<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminCancleNew.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  </style>
  <script>
    'use strict';
    
    function fCheck(){
   		let idx = ${vo.idx};
   		let cancelIdx = ${vo.cancelIdx};
   		let reason1 = document.getElementById("reason1").value;
   		let reason2 = document.getElementById("reason2").value;
    	
    	$.ajax({
    		type : "post",
    		url : "${ctp}/admin/adminOrderCancelNO",
    		data : {
    			idx : idx,
    			cancelIdx : cancelIdx,
    			reason1 : reason1,
    			reason2 : reason2
    		},
    		success:function(res){
    			if(res == "1"){
    				alert("처리 되었습니다.");
    				location.reload();
    			} 
    		},
    		error:function(){
    			alert("전송오류가 왜죠?");
    		}
    	});   
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h3>반품/환불 불가 처리</h3>
	<table class="table table-bordered">
		<tr>
			<td>
				주문 정보
			</td>
			<td>
				${vo.orderIdx} / ${vo.mid} <br/> 
<%-- 				${vo.productName}  / ${vo.optionName} / ${vo.optionNum}개 / ${vo.totalPrice}원   --%> 
			</td>
		</tr>
		<tr>
			<td>
				반품/환불 불가 사유
			</td>
			<td>
				<select name="reason1" id="reason1">
					<option>처리기간만료로 인한 처리불가</option>
					<option>상품훼손으로 인한 처리불가</option>
					<option>기타 사유로 인한 처리불가</option>
				</select>
				<input type="text" name="reason2" id="reason2" class="form-control" />
			</td>
		</tr>
		<tr>
			<td colspan="2" class="text-center">
			<input type="button" value="등록" class="btn btn-outline-dark form-contorl" onclick="fCheck()" />
			</td>
		</tr>
	</table>
</div>
<p><br/></p>
</body>
</html>