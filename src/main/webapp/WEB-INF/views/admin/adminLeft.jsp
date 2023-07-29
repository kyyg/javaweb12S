<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>adminLeft.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body style="background-color:#476cd9; font-size:0.8em;">
<p><br/></p>
<div class="w3-animate-right">
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
<p><br/></p>
</body>
</html>