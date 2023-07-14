<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>dbReviewForm.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  th{
  	text-align: center;
  	background-color : #eee;
  	width : 120px;
  	
  }
  </style>
  <script>
    'use strict';
    
    function fCheck(){
    	let title = $("#title").val();
    	let content = $("#content").val();
    	let score = $("#score").val();
    	let maxSize = 1024 * 1024 * 20;	// 최대 20MByte 허용
    	

    	if(title.trim() == "") {
    		alert("제목을 입력하세요");
    		return false;
    	}
    	else if(content.trim() == "") {
    		alert("내용을 입력하세요");
    		return false;
    	}
    	else if(score == "") {
    		alert("별점을 등록해주세요");
    		return false;
    	}
     	
    	// 파일 사이즈 처리..
    	let fileSize = 0;
    	for(let i=1; i<=3; i++) {
    		let imsiName = 'fName' + i;
    		if(isNaN(document.getElementById(imsiName))) {
    			let fName = document.getElementById(imsiName).value;
    			if(fName != "") {
    				fileSize += document.getElementById(imsiName).files[0].size;
    				let ext = fName.substring(fName.lastIndexOf(".")+1).toUpperCase();
    				if(ext != "JPG" && ext != "GIF" && ext != "PNG") {
    					alert("이미지 파일만 업로드 가능합니다.");
    					return false;
    				}
    			}
    		}
    	} 
    	
    	if(fileSize > maxSize) {
    		alert("업로드할 파일의 최대용량은 20MByte입니다.");
    		return false;
    	}
    	else {
	    	myform.submit();
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<hr/>
<h3 class="text-center">리뷰 작성</h3>
<hr/>
	<form name="myform" method="post" enctype="multipart/form-data">
		<table class="table-borderless" style="width:800px; margin: 0 auto;" >
			<tr>
				<th style="text-align:center">구매 상품</th>
				<td class="ml-2"><span class="ml-2">${vo.productName}</span></td>
			</tr>
			<tr>
				<th style="text-align:center">옵션내역</th>
				<td class="ml-2"><span class="ml-2">${vo.optionName} / ${vo.optionNum}개 / ${vo.totalPrice}원</span></td>
			</tr>
			<tr>
				<th style="text-align:center">구매자</th>
				<td class="ml-2"><span class="ml-2">${vo.mid}</span></td>
			</tr>
			<tr>
				<th style="text-align:center">제목</th>
				<td class="ml-2"><input type="text" name="title" id="title" class="form-control ml-2" /></td>
			</tr>
			<tr>
				<th style="text-align:center">내용</th>
				<td class="ml-2">
					<textarea rows="8" name="content" id="content" class="form-control ml-2"></textarea>
				</td>
			</tr>
			<tr>
				<th style="text-align:center">별점</th>
				<td class="ml-2">
					<select name="score" id="score" class="form-control ml-2">
						<option value="">별점 선택</option>
						<option value="1">★☆☆☆☆</option>
						<option value="2">★★☆☆☆</option>
						<option value="3">★★★☆☆</option>
						<option value="4">★★★★☆</option>
						<option value="5">★★★★★</option>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="ml-2 mt-3"><input type="file" name="file" id="SfName1" multiple class="form-control-file border mb-2 mt-3"></td>
			</tr>
			<tr>
				<td colspan="2" class="ml-2 mt-3"><input type="file" name="file" id="SfName2" multiple class="form-control-file border mb-2"></td>
			</tr>
			<tr>
				<td colspan="2" class="ml-2 mt-3"><input type="file" name="file" id="SfName3" multiple class="form-control-file border mb-2"></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="리뷰 등록" class="btn btn-outline-info form-control mt-3 pt-2 pb-2" onclick="fCheck()" /></td>
			</tr>
			<input type="hidden" name="mid" id="mid" value="${vo.mid}" />
			<input type="hidden" name="orderIdx" id="orderIdx" value="${vo.orderIdx}" />
			<input type="hidden" name="idx" id="idx" value="${vo.idx}" />
			<input type="hidden" name="productName" id="productName" value="${vo.productName}" />
			<input type="hidden" name="productIdx" id="productIdx" value="${vo.productIdx}" />
		</table>
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>