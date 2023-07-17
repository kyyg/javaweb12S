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
  <script>
  'use strict';
  
  // 대분류 등록하기
  function categoryMainCheck() {
  	let categoryMainCode = categoryMainForm.categoryMainCode.value.toUpperCase();
  	let categoryMainName = categoryMainForm.categoryMainName.value;
  	if(categoryMainCode.trim() == "" || categoryMainName.trim() == "") {
  		alert("대분류명(코드)를 입력하세요");
  		categoryMainForm.categoryMainName.focus();
  		return false;
  	}
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/dbShop/categoryMainInput",
  		data : {
  			categoryMainCode : categoryMainCode,
  			categoryMainName : categoryMainName
  		},
  		success:function(res) {
  			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
  			else {
  				alert("대분류가 등록되었습니다.");
  				location.reload();
  			}
  		},
			error: function() {
				alert("전송오류!");
			}
  	});
  }
  
  // 중분류 등록하기
  function categoryMiddleCheck() {
  	let categoryMainCode = categoryMiddleForm.categoryMainCode.value;
  	let categoryMiddleCode = categoryMiddleForm.categoryMiddleCode.value;
  	let categoryMiddleName = categoryMiddleForm.categoryMiddleName.value;
  	if(categoryMainCode.trim() == "" || categoryMiddleCode.trim() == "" || categoryMiddleName.trim() == "") {
  		alert("대분류명(코드)를 입력하세요");
  		categoryMiddleForm.categoryMiddleName.focus();
  		return false;
  	}
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/dbShop/categoryMiddleInput",
  		data : {
  			categoryMainCode : categoryMainCode,
  			categoryMiddleCode : categoryMiddleCode,
  			categoryMiddleName : categoryMiddleName
  		},
  		success:function(res) {
  			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
  			else {
  				alert("중분류가 등록되었습니다.");
  				location.reload();
  			}
  		},
			error: function() {
				alert("전송오류!");
			}
  	});
  }
  
  // 소분류 입력창에서 대분류 선택시에 중분류 자동 조회하기
  function categoryMainChange() {
  	let categoryMainCode = categorySubForm.categoryMainCode.value;
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/dbShop/categoryMiddleName",
  		data : {categoryMainCode : categoryMainCode},
  		success:function(vos) {
  			let str = '';
  			str += '<option value="">중분류선택</option>'
  			for(let i=0; i<vos.length; i++) {
  				str += '<option value="'+vos[i].categoryMiddleCode+'">'+vos[i].categoryMiddleName+'</option>';
  			}
  			$("#categoryMiddleCode").html(str);
  		},
  		error : function() {
  			alert("전송오류!");
  		}
  	});
  }
  
  // 소분류 등록하기
  function categorySubCheck() {
  	let categoryMainCode = categorySubForm.categoryMainCode.value;
  	let categoryMiddleCode = categorySubForm.categoryMiddleCode.value;
  	let categorySubCode = categorySubForm.categorySubCode.value;
  	let categorySubName = categorySubForm.categorySubName.value;
  	if(categoryMainCode.trim() == "" || categoryMiddleCode.trim() == "" || categorySubCode.trim() == "" || categorySubName.trim() == "") {
  		alert("소분류명(코드)를 입력하세요");
  		categorySubForm.categorySubName.focus();
  		return false;
  	}
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/dbShop/categorySubInput",
  		data : {
  			categoryMainCode : categoryMainCode,
  			categoryMiddleCode : categoryMiddleCode,
  			categorySubCode : categorySubCode,
  			categorySubName : categorySubName
  		},
  		success:function(res) {
  			if(res == "0") alert("같은 상품이 등록되어 있습니다.\n확인하시고 다시 입력하세요");
  			else {
  				alert("소분류가 등록되었습니다.");
  				location.reload();
  			}
  		},
			error: function() {
				alert("전송오류!");
			}
  	});
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
     <h2>상품 카테고리(대/중) 등록하기</h2>
  <hr/>
  <form name="categoryMainForm">
    <h4><b>대분류</b></h4>
    대분류코드
    <input type="text" name="categoryMainCode" size="2"/> &nbsp;
    대분류명
    <input type="text" name="categoryMainName" size="8"/> &nbsp;
    <input type="button" value="대분류등록" onclick="categoryMainCheck()" class="btn btn-success btn-sm" />
    <table class="table table-hover m-3">
      <tr class="table-dark text-dark text-center">
        <th>대분류 코드</th>
        <th>대분류 명</th>
        <th>삭제</th>
      </tr>
      <c:forEach var="mainVO" items="${mainVOS}">
        <tr class="text-center">
          <td>${mainVO.categoryMainCode}</td>
          <td>${mainVO.categoryMainName}</td>
          <td><input type="button" value="삭제" onclick="categoryMainDelete('${mainVO.categoryMainCode}')" class="btn btn-danger btn-sm"/></td>
        </tr>
      </c:forEach>
      <tr><td colspan="3" class="m-0 p-0"></td></tr>
    </table>
  </form>
  <hr/><br/>
  <form name="categoryMiddleForm">
    <h4><b>중분류</b></h4>
    대분류선택
    <select name="categoryMainCode">
      <option value="대분류명"></option>
      <c:forEach var="mainVO" items="${mainVOS}">
        <option value="${mainVO.categoryMainCode}">${mainVO.categoryMainName}</option>
      </c:forEach>
    </select> &nbsp;
    중분류코드
    <input type="text" name="categoryMiddleCode" size="2" maxlength="2"/>, &nbsp;
    중분류명
    <input type="text" name="categoryMiddleName" size="8"/> &nbsp;
    <input type="button" value="중분류등록" onclick="categoryMiddleCheck()" class="btn btn-success btn-sm" />
    <table class="table table-hover m-3">
      <tr class="table-dark text-dark text-center">
        <th>대분류명</th>
        <th>중분류코드</th>
        <th>중분류명</th>
        <th>삭제</th>
      </tr>
      <c:forEach var="middleVO" items="${middleVOS}">
        <tr class="text-center">
          <td>${middleVO.categoryMainName}(${middleVO.categoryMainCode})</td>
          <td>${middleVO.categoryMiddleCode}</td>
          <td>${middleVO.categoryMiddleName}</td>
          <td><input type="button" value="삭제" onclick="categoryMiddleDelete('${middleVO.categoryMiddleCode}')" class="btn btn-danger btn-sm"/></td>
        </tr>
      </c:forEach>
      <tr><td colspan="4" class="m-0 p-0"></td></tr>
    </table>
  </form>
  <hr/><br/> 
</div>
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