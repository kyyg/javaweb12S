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
<link rel="stylesheet" href="${ctp}/font/font.css">
<!-- Custom styles for this template-->
<link href="../resources/css/sb-admin-2.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

  <style>
    td {text-align: center;}
    th {background-color: #eee;}
  </style>
  <script>
  'use strict';
  
  function answerCheck() {
  	let tempStr = '<br/>';
  	tempStr += '<div class="text-center mb-5"><font size="3">답변 작성</font></div>';
  	tempStr += '<table class="table">';
  	tempStr += '<tr>';
		tempStr += '    <th class="text-center">글쓴이</th>';
			tempStr += '  <td><input type="text" name="nickName" value="${sNickName}" readonly class="form-control"/></td>';
			tempStr += '</tr>';
  	tempStr += '<tr>';
  	tempStr += '  <th class="text-center">답변글제목</th>';
  	/* tempStr += '  <td><input type="text" name="title" value="(Re) ${vo.title}" size="60" required class="form-control"/></td>'; */
  	tempStr += '  <td class="text-left">(Re) ${vo.title}</td>';
  	tempStr += '</tr>';
  	tempStr += '<tr>';
  	tempStr += '<th class="text-center">이메일</th>';
  	tempStr += '  <td><input type="text" name="email" value="${email}" size="60" class="form-control" required/></td>';
  	tempStr += '  </tr>';
  	tempStr += '<tr>';
  	tempStr += '  <th class="text-center">글내용</th>';
  	tempStr += '  <td><textarea rows="6" name="content" required class="form-control"></textarea></td>';
  	tempStr += '</tr>';
  	tempStr += '<tr>';
  	tempStr += '<th class="text-center">비밀번호</th>';
  	tempStr += '  <td class="text-left">';
  	tempStr += '    <input type="checkbox" name="pwdCheck" id="pwdCheck" <c:if test="${!empty vo.pwd}">checked</c:if>/>';
  	tempStr += '		<label for="pwdCheck">비밀글로 등록</label> <font size="1"></font>';
		tempStr += '    <input type="hidden" name="pwd" id="pwd" value="1234"/>';  // 이곳에서는 사용하지 않았음. 별 의미기 없기에...
		tempStr += '  </td>';
		tempStr += '</tr>';
  	tempStr += '<tr>';
  	tempStr += '  <td colspan="2" style="text-align:center">';
  	tempStr += '    <input type="button" value="답글올리기" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;';
  	tempStr += '    <input type="button" value="취소" onclick="location.reload();" class="btn btn-secondary"/> &nbsp;';
  	tempStr += '  </td>';
  	tempStr += '</tr>';
  	tempStr += '</table>';
  	tempStr += '<input type="hidden" name="qnaSw" value="a"/>';
  	tempStr += '<input type="hidden" name="qnaIdx" value="${vo.qnaIdx}"/>';
  	tempStr += '<input type="hidden" name="title" value="(Re) ${vo.title}"/>';
			$("#reply").html(tempStr);
  }
  
  function fCheck() {
  	var nickName = myform.nickName.value;
  	var title = myform.title.value;
  	var pwdCheck = document.getElementById("pwdCheck");
  	var pwd = myform.pwd.value;
  	var content = myform.content.value;
  	
  	if(nickName=="") {
  		alert("글올린이 닉네임을 입력하세요");
  		myform.nickName.focus();
  	}
  	else if(title=="") {
  		alert("글제목을 입력하세요");
  		myform.title.focus();
  	}
  	else if(content=="") {
  		alert("글내용을 입력하세요");
  		myform.content.focus();
  	}
  	else {
  		if($("#pwdCheck").is(":checked")) myform.pwd.value = '1234';
  		else myform.pwd.value = "";
  		myform.submit();
  	}
  }
  
  function delCheck() {
  	let ans = "현재 글을 삭제하시겠습니까?";
  	if(!ans) return false;
  	
  	location.href = "${ctp}/qna/qnaDelete?idx=${vo.idx}";
  }
  </script>
  <style>
    td {text-align: center};
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
  <p><br/></p>
  <br/>
  <table class="table table-borderless" style="width:1100px; margin:0 auto;">
  	<tr>
  		<td colspan="3" class="text-left" style="border-bottom:5px solid #c9c2bc; background-color:#eee;"><font size="4"><b>${vo.title}</b></font></td>
  	</tr>
  	<tr style="border-bottom:2px solid #c9c2bc;">
  		<td style="width:20%" class="text-left"><b>${vo.nickName}</b></td>
  		<td style="width:50%" class="text-left">${fn:substring(vo.WDate,0,fn:length(vo.WDate)-2)}</td>
  		<td style="width:30%" class="text-right">${vo.email}</td>
  	</tr>
    <c:if test="${vo.qnaSw == 'a'}">
	    <tr>
	      <th class="text-center">원본글제목</th>
	      <td colspan="3" style="text-align:left;">${title}</td>
	    </tr>
    </c:if>
  	<tr style="border-bottom:5px solid #c9c2bc;">
  		<td colspan="3">${fn:replace(vo.content, newLine, "<br/>")}</td>
  	</tr>
    <tr>
      <td colspan="4" style="text-align:center;">
        <c:if test="${vo.qnaSw == 'q'}">
        <c:if test="${sLevel == 0}">
          <input type="button" value="답변하기" onclick="answerCheck()" class="btn btn-outline-secondary"/> &nbsp;
				</c:if>        
        <c:if test="${sLevel != 0}"></c:if>        
        </c:if>
        
        <c:if test="${sNickName eq vo.nickName}">
          <c:if test="${vo.qnaSw == 'q'}">
	        	<input type="button" value="수정" onclick="location.href='${ctp}/qna/qnaUpdate?idx=${vo.idx}';" class="btn btn-secondary"/> &nbsp;
	        </c:if>
	        <input type="button" value="삭제" onclick="delCheck(${vo.idx})" class="btn btn-secondary"/> &nbsp;
        </c:if>
        <input type="button" value="목록으로" onclick="location.href='${ctp}/admin/adminQnaList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/>
      </td>
    </tr>
  </table>
  <form name="myform" method="post" action="${ctp}/admin/adminQnaContent">
    <div id="reply"></div>
	  <input type="hidden" name="pag" value="${pag}"/>
	  <input type="hidden" name="pageSize" value="${pageSize}"/>
	  <input type="hidden" name="idx" value="${vo.idx}"/>
	  <input type="hidden" name="mid" value="${vo.mid}"/>
  </form>
  <p></p>
</div>
<p><br/></p>

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