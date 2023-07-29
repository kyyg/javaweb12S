<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardUpdate.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<link rel="stylesheet" href="${ctp}/font/font.css">
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
  <script>
    'use strict';
    
    function fCheck() {
    	let title = myform.title.value;
    	let content = myform.content.value;
    	
    	if(title.trim() == "") {
    		alert("게시글 제목을 입력하세요");
    		myform.title.focus();
    	}
    	/* 
    	else if(content.trim() == "") {
    		alert("게시글 내용을 입력하세요"); 
    		myform.content.focus();
    	}
    	 */
    	else {
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="menu" id="menu">
	<div class="text-center card-hover" id="accordion">
  <h5 class="text-white">관리자 페이지</h5>
  <hr/>
  <p><a href="${ctp}/" target="_top" class="text-white">홈페이지로 이동</a></p>
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
        <a href="${ctp}/admin/adminOrder" target="adminContent">전체주문 조회</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminCancelOrder" target="adminContent">취소/환불 조회</a>
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
        <a href="${ctp}/dbShop/dbProduct" target="adminContent">상품 등록/관리</a>
      </div>
     <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbCategory" target="adminContent">카테고리 등록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbShopList" target="adminContent">상품등록 조회</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbOption" target="adminContent">상품옵션 등록/관리</a>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse4">
        게시판 관리
      </a>
    </div>
    <div id="collapse4" class="collapse" data-parent="#accordion">	
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminNoticeList" target="adminContent">공지 게시판</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminQnaList" target="adminContent">문의 게시판</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminBoardList" target="adminContent">이벤트 후기 게시판</a>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse10">
        리뷰 관리
      </a>
    </div>
    <div id="collapse10" class="collapse" data-parent="#accordion">	
      <div class="card-body m-2 p-1">
         <a href="${ctp}/admin/adminReviewList" target="adminContent">일반 리뷰 관리</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminReportReviewList" target="adminContent">신고 리뷰 관리</a>
      </div>
    </div>
  </div>
  
  
  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse12">
        제휴 문의
      </a>
    </div>
    <div id="collapse12" class="collapse" data-parent="#accordion">	
      <div class="card-body m-2 p-1">
         <a href="${ctp}/admin/adminContactList" target="adminContent">제휴 문의 목록</a>
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
    
  
   <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse11">
        파일 관리
      </a>
    </div>
    <div id="collapse11" class="collapse" data-parent="#accordion">	
      <div class="card-body m-2 p-1">
         <a href="${ctp}/admin/fileList" target="adminContent">파일 관리</a>
      </div>
    </div>
  </div>
</div>
</div>
<div class="container">
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th>작성자</th>
        <td>${sNickName}</td>
      </tr>
      <tr>
        <th>제목</th>
        <td><input type="text" name="title" id="title" value="${vo.title}" autofocus required class="form-control"></td>
      </tr>
      <tr>
        <th></th>
        <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
     		<script>
     		CKEDITOR.replace("content",{
     			height:480,
     			filebrowserUploadUrl:"${ctp}/imageUpload", /* 파일(이미지) 업로드 경로 */
     			uploadUrl : "${ctp}/imageUpload" /* 여러개의 그림파일을 드래그&드롭해서 올리기 */
     		});
     		</script>
      </tr>
		  <tr>
        <th>상단 고정여부</th>
        <td>
          <input type="radio" name="fixed" value="on"/>고정 &nbsp;
        </td>
      </tr>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="수정" onclick="fCheck()" class="btn btn-outline-dark"/> &nbsp;
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/admin/adminNoticeList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-dark"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="nickName" value="${sNickName}"/>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
  </form>
</div>
<p><br/></p>
</body>
</html>