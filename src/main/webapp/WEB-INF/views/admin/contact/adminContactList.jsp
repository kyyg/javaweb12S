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
		<!-- 날짜를 시간으로 계산해서 돌려주기위한 monent.js 외부라이브러리를 사용하고 있다.  -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>
	<style>
		td {text-align:center;}
	</style>
	<script>
		$(document).ready(function() {
			var wDate = document.getElementsByClassName('wDate');
			for(var i=0; i<wDate.length; i++) {		// 여러개의 날짜를 숫자로 변환하는부분이 있다면 그 클래스 갯수만큼 돌린다.
				var fromNow = moment(wDate[i].value).fromNow();		// 해당클래스의 value값을 넘겨주면 시간으로 계산해도 돌려준다.
			    document.getElementsByClassName('inputDate')[i].innerText = fromNow;	// 담아온 시간을 inputDate클래스에 뿌려준다.
			}
		});
	
		function categoryCheck() {
			let part = categoryForm.part.value;
			location.href="${ctp}/admin/adminContactList?part="+part;
		}
	</script>
	<style>
	  th {text-align:center}
	</style>
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

	<div class="container">
	<h3>제휴 문의</h3>
	<p><br/></p>
	<form name="categoryForm" style="width:200px;" onchange="categoryCheck()">
		<select class="form-control" name="part" style="margin-left: 50px;">
	    <option value="전체" <c:if test="${part=='전체'}">selected</c:if>>전체문의글</option>
	    <option value="답변대기중" <c:if test="${part=='답변대기중'}">selected</c:if>>답변대기중</option>
	    <option value="답변완료" <c:if test="${part=='답변완료'}">selected</c:if>>답변완료</option>
		</select>
	</form>
  <br/>
	<table class="table table-hover">
		<tr class="table-dark text-dark"> 
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성날짜</th>
			<th>답변상태</th>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>${st.count}</td>
				<td class="text-left"><a href="${ctp}/admin/adminContactReply?idx=${vo.idx}&part=${part}" class="title-decoration-none">[${vo.part}] ${vo.title}</a></td>
				<td>${vo.mid}</td>
				<td>
					${fn:substring(vo.WDate,0,10)}
				</td>
				<td>
					<c:if test="${vo.reply=='답변대기중'}">
						<span class="badge badge-pill badge-secondary">${vo.reply}</span>						
					</c:if>
					<c:if test="${vo.reply=='답변완료'}">
						<span class="badge badge-pill badge-danger">${vo.reply}</span>						
					</c:if>
				</td>
			</tr>
		</c:forEach>
		<tr><td colspan="5" class="p-0 m-0"></td></tr>
	</table>
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