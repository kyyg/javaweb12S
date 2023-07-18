<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbProduct.jsp(상품등록)</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<style>
    th {
      text-align: center;
      background-color: #eee;
    }
    
    		#menu {
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 225px;
		  height: 1000px;
		  background-color: #476cd9;
		}
  </style>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
    'use strict';
    
    // 상품 등록하기전에 체크후 전송...
    function fCheck() {
    	let categoryMainCode = myform.categoryMainCode.value;
    	let categoryMiddleCode = myform.categoryMiddleCode.value;
    	let productName = myform.productName.value;
			let mainPrice = myform.mainPrice.value;
			let detail = myform.detail.value;
			let file = myform.file.value;	
			let ext = file.substring(file.lastIndexOf(".")+1);
			let uExt = ext.toUpperCase();
			let regExpPrice = /^[0-9|_]*$/;
			
			if(product == "") {
				alert("상품명(모델명)을 입력하세요!");
				return false;
			}
			else if(file == "") {
				alert("상품 메인 이미지를 등록하세요");
				return false;
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(mainPrice == "" || !regExpPrice.test(mainPrice)) {
				alert("상품금액은 숫자로 입력하세요.");
				return false;
			}
			else if(detail == "") {
				alert("상품의 초기 설명을 입력하세요");
				return false;
			}
			else if(document.getElementById("file").value != "") {
				var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
				var fileSize = document.getElementById("file").files[0].size;
				if(fileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요");
					return false;
				}
				else {
					myform.submit();
				}
			}
    }
    

  </script>
</head>
<body>
<br/>
<div class="menu" id="menu">
	<div class="text-center card-hover" id="accordion">
  <h5 class="text-white"><a href="${ctp}/admin/index">관리자</a></h5>
  <hr/>
  <p><a href="${ctp}/" target="_top" class="text-white">메인화면으로</a></p>
	<br/>

  <div class="card">
    <div class="card-header bg-blue m-0 p-2" >
      <a class="card-link" data-toggle="collapse" href="#collapse1">
        회원 관리
      </a>
    </div>
    <div id="collapse1" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminMemberList" target="adminContent">회원 리스트</a>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse2">
        주문 관리
      </a>
    </div>
    <div id="collapse2" class="collapse" data-parent="#accordion">	
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminOrder" target="adminContent">전체 주문목록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminCancelOrder" target="adminContent">취소/환불 목록</a>
      </div>
    </div>
  </div>
  
    <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse3">
        상품관리
      </a>
    </div>
    <div id="collapse3" class="collapse" data-parent="#accordion">	
     <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbCategory" target="adminContent">상품분류등록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbProduct" target="adminContent">상품등록관리</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbShopList" target="adminContent">상품등록조회</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbOption" target="adminContent">옵션등록관리</a>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse4">
        게시판 관리
      </a>
    </div>
    <div id="collapse4" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminNoticeList" target="adminContent">공지 게시판</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminBoardList" target="adminContent">문의 게시판</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminReviewList" target="adminContent">리뷰 게시판</a>
      </div>
    </div>
  </div>
  
  
  
  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse5">
        오프라인매장 관리
      </a>
    </div>
    <div id="collapse5" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/kakaomap/storeRegistration" target="adminContent">매장 등록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/kakaomap/kakaoStoreList" target="adminContent">매장 확인/삭제</a>
      </div>
    </div>
  </div>
</div>
</div>
<div class="container">
  <div id="product">
    <h3>상품 수정</h3>
    <form name="myform" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="categoryMainCode">대분류</label>
        <select id="categoryMainCode" name="categoryMainCode" class="form-control" onchange="categoryMainChange()">
         	<option value="${vo.categoryMainCode}">${vo.categoryMainCode}</option>
        </select>
      </div>
      <div class="form-group">
        <label for="categoryMiddleCode">중분류</label>
        <select id="categoryMiddleCode" name="categoryMiddleCode" class="form-control">
          <option value="${vo.categoryMiddleCode}">${vo.categoryMiddleCode}</option>
        </select>
      </div>
      <div class="form-group">
        <label for="productName">상품명</label>
        <input type="text" name="productName" id="productName" value="${vo.productName}" class="form-control" placeholder="상품 모델명을 입력하세요" required />
      </div>
      <div class="form-group">
        <label for="file">메인이미지</label>
        <input type="file" name="file" id="file" class="form-control-file border" accept=".jpg,.gif,.png,.jpeg" required />
        (업로드 가능파일:jpg, jpeg, gif, png)
        <div><img src="${ctp}/dbShop/product/${vo.FSName}" width="100px"/></div>
      </div>
      <div class="form-group">
      	<label for="mainPrice">상품기본가격</label>
      	<input type="text" name="mainPrice" id="mainPrice" value="${vo.mainPrice}" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="detail">상품 디테일,태그(슬래시 넣어서 여러개 추가 가능)</label>
      	<input type="text" name="detail" id="detail" value="${vo.detail}" class="form-control" required />
      </div>
      <div class="form-group">
      	<label for="content">상품상세설명</label>
      	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea>
      </div>
      <div>
				

      
      </div>
      <script>
		    CKEDITOR.replace("content",{
		    	uploadUrl:"${ctp}/dbShop/imageUpload",
		    	filebrowserUploadUrl: "${ctp}/dbShop/imageUpload",
		    	height:460
		    });
		  </script>
		  <input type="button" value="상품 수정" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
    </form>
  </div>
</div>
<p><br/></p>
</body>
</html>