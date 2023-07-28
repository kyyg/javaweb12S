<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title></title>

 <!-- Custom fonts for this template-->
<link href="../resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
    href="../resources/https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet">

<!-- Custom styles for this template-->
<link href="../resources/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <style>
      th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  
  <script>
  'use strict';

  // 게시글 삭제처리
  function noticeDelete() {
  	let ans = confirm("현 게시글을 삭제하시겠습니까?");
  	if(ans) location.href="${ctp}/admin/adminNoticeDelete?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&nickName=${vo.nickName}";
  }

  </script>
</head>
<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">
<jsp:include page="/WEB-INF/views/include/sidebar.jsp" />
</head>
<body>
<p><br/></p>
  <!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
    <!-- Sidebar Toggle (Topbar) -->
    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
        <i class="fa fa-bars"></i>
    </button>
    <h3 class="text-center"></h3>
    <!-- Topbar Navbar -->
</nav>
<!-- End of Topbar -->
<!-- Main Content -->
<div id="content">
	<div class="container">
  <br/>
  <table class="table table-borderless m-0 p-0">
  </table>
  <table class="table table-bordered">
    <tr>
      <th>작성자</th>
      <td>${vo.nickName}</td>
      <th>작성날짜</th>
      <td>${fn:substring(vo.WDate,0,fn:length(vo.WDate)-2)}</td>
    </tr>
    <tr>
      <th>제목</th>
      <td colspan="3">${vo.title}</td>
    </tr>
    <tr>

      <th>조회수</th>
      <td>${vo.readNum}</td>
    </tr>
    <tr>
      <th>내용</th>
      <td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
    </tr>
    <tr>
      <td colspan="4" class="text-center">
        <c:if test="${flag == 'search'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/notice/noticeSearch?search=${search}&searchString=${searchString}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-dark"/></c:if>
        <c:if test="${flag == 'searchMember'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/notice/noticeSearchMember?pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-dark"/></c:if>
        <c:if test="${flag != 'search' && flag != 'searchMember'}"><input type="button" value="돌아가기" onclick="location.href='${ctp}/notice/noticeList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-dark"/></c:if>
        &nbsp;
      	<c:if test="${sMid == vo.mid || sLevel == 0}">
        	<input type="button" value="수정하기" onclick="location.href='${ctp}/admin/adminNoticeUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-dark"/> &nbsp;
        	<input type="button" value="삭제하기" onclick="noticeDelete()" class="btn btn-outline-dark"/>
      	</c:if>
      </td>
    </tr>
  </table>
  
  <c:if test="${flag != 'search' && flag != 'searchMember'}">
	  <!-- 이전글/ 다음글 처리 -->
	  <table class="table table-borderless">
	    <tr>
	      <td>
	        <c:if test="${!empty pnVos[1]}">
	          ☝ <a href="${ctp}/notice/noticeContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[1].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx < pnVos[0].idx}">
	        	☝ <a href="${ctp}/notice/noticeContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx > pnVos[0].idx}">
	        	👇 <a href="${ctp}/notice/noticeContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	      </td>
	    </tr>
	  </table>
  </c:if>
</div>
</div>
<!-- End of Content Wrapper -->
<!-- End of Page Wrapper -->
<!-- Bootstrap core JavaScript-->
<script src="../resources/vendor/jquery/jquery.min.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Custom scripts for all pages-->
<script src="../resources/js/sb-admin-2.min.js"></script>
<!-- Page level plugins -->
<script src="../resources/vendor/chart.js/Chart.min.js"></script>
<!-- Page level custom scripts -->
<script src="../resources/js/demo/chart-area-demo.js"></script>
<script src="../resources/js/demo/chart-pie-demo.js"></script>
</body>
</html>