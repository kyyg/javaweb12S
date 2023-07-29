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
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${ctp}/font/font.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<style>
	
	</style>
  <script>
	  // 전체선택
	  $(function(){
	  	$("#checkAll").click(function(){
	  		if($("#checkAll").prop("checked")) {
		    		$(".chk").prop("checked", true);
	  		}
	  		else {
		    		$(".chk").prop("checked", false);
	  		}
	  	});
	  });
	  
	  
	  // 선택항목 삭제하기(ajax처리하기)
	  function selectDelCheck() {
	  	let ans = confirm("선택된 파일을 전부 삭제 하시겠습니까?");
	  	if(!ans) return false;
	  	let delItems = "";
	  	for(let i=0; i<myform.chk.length; i++) {
	  		if(myform.chk[i].checked == true) delItems += myform.chk[i].value + "/";
	  	}
	  	if(delItems == "") {
	  		alert("한개 이상을 선택후 처리하세요.");
	  		return false;
	  	}
			
	  	$.ajax({
	  		type : "post",
	  		url  : "${ctp}/admin/fileSelectDelete",
	  		data : {delItems : delItems},
	  		success:function(res) {
	  			if(res == "1") {
	  				alert("선택된 파일을 삭제처리 하였습니다.");
	  			  location.reload();
	  			}
	  		},
	  		error  :function() {
	  			alert("전송오류!!");
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

	<p><br/></p>
<div class="container">
	<div class="w3-bottombar w3-indigo w3-padding text-center" style="margin-bottom:20px;">
 		<span style="font-size:23px;">서버 파일 목록</span>
  </div>
  <hr/>
  <p>서버의 파일 경로 : ${ctp}/data/ckeditor/파일명</p>
  <hr/>
  <form name="myform">
	  <table class="table table-hover text-center">
	    <tr>
	      <td colspan="4" class="text-left">
	        <input type="checkbox" id="checkAll" onclick="checkAllCheck()"/>전체선택/해제 &nbsp;&nbsp;
	        <input type="button" value="선택항목삭제" onclick="selectDelCheck()" class="btn btn-outline-danger btn-sm"/>
	      </td>
	    </tr>
	    <tr class="table-dark text-dark">
	      <th></th><th>번호</th><th>파일명</th><th>이미지 파일</th>
	    </tr>
		  <c:forEach var="file" items="${files}" varStatus="st">
		    <tr>
		      <td>
		        <c:if test="${file != 'board'}">
		          <c:if test="${file == 'qna'}"><font color='red'>폴더명</font></c:if>
		          <c:if test="${file != 'qna'}">
		        	  <input type="checkbox" name="chk" class="chk" value="${file}"/>
		        	</c:if>
		        </c:if>
		      </td>
		      <td>${st.count}</td>
		      <td>${file}</td>
		      <td>
		        <c:if test="${file == 'qna'}"><font color='red'>폴더명</font>입니다.</c:if>
		        <c:if test="${file != 'qna'}">
		        	<img src="${ctp}/data/ckeditor/${file}" width="50px"/>
		        </c:if>
		      </td>
		    </tr>
		  </c:forEach>
		  <tr><td colspan="4" class="m-0 p-0"></td></tr>
	  </table>
  </form>
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