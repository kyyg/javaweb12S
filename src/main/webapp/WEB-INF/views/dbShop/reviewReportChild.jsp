<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  </style>
  <script>
    'use strict';
    
   	// 리뷰 신고기능
   	function reportReview(){
   		
   		let idx = ${vo.idx};
   		let mid = '${sMid}';
   		let reportMemo1 = document.getElementById("reportMemo1").value;
   		let reportMemo2 = document.getElementById("reportMemo2").value;
   		
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/dbShop/reviewReportChild",
    		data  : {
    			idx  : idx,
    			mid:mid,
    			reportMemo1:reportMemo1,
    			reportMemo2:reportMemo2
				},
    		success:function(res) {
    			if(res == "1") {
					alert("신고가 완료 되었습니다.");    				
					window.opener.location.reload();
		      window.close();
    			}
    			else if(res == "0") alert("이미 신고한 리뷰입니다.");
    		},
    		error : function() {
    			alert("전송 오류");
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
	<h3>리뷰 신고</h3>
	<table class="table table-bordered">
		<tr>
			<td colspan="2">
			상품명 : ${vo.idx} / ${vo.productName} <br/>
			작성자 : ${vo.mid} <br/>
			제목 : ${vo.title}
			</td>
		</tr>
		<tr>
			<td style="width:25%">신고사유</td>
			<td>
				<select name="reportMemo1" id="reportMemo1">
					<option>욕설/비방</option>
					<option>상품과 상관없음</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>상세사유</td>
			<td><textarea name="reportMemo2" id="reportMemo2" class="form-control" rows="5" placeholder="상세사유를 적어주세요."></textarea></td>
		</tr>
	</table>
	<div class="text-center">
		<input type="button" value="제출" class="btn btn-outline-dark" onclick="reportReview()" />
		<input type="button" value="닫기" class="btn btn-outline-dark" onclick="closeNew()" />
	</div>
	<div class="text-left mt-4">
		무분별한 신고 남용은 제제를 받을 수 있습니다.
	</div>
	
</div>
<p><br/></p>
</body>
</html>