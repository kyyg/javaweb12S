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
  <script>
    function sChange() {
    	searchForm.searchString.focus();
    }
    
    function sCheck() {
    	var searchString = searchForm.searchString.value;
    	if(searchString == "") {
    		alert("검색어를 입력하세요");
    		searchForm.searchString.focus();
    	}
    	else {
    		searchForm.submit();
    	}
    }
    
    // 비밀번호 처리때 사용하려했는데, 이곳에서는 사용하지 않음.
    function contentCheck(idx, title, pwd) {
    	if(pwd == '') {
    		location.href = "qnaContent?pag=${pageVO.pag}&idx="+idx+"&title="+title;
    	} 
    	else {
    		tempStr = '';
    		tempStr += '비밀번호 : ';
    		tempStr += '<input type="password" name="pwd"/>';
    		tempStr += '<input type="button" value="확인" onclick="movingCheck('+idx+')"/>';
    		tempStr += '<input type="button" value="닫기" onclick="location.reload()"/>';
    		alert("tempStr : " + tempStr);
    		$("#qna"+idx).html(tempStr);
    	}
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

	<div class="container">
  <p><br/></p>
  <form name="tempForm">
		<div class="w3-bottombar w3-indigo w3-padding text-center" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">문의 게시판</span>
	   </div>
	  <table class="table table-hover">
	    <tr class="text-dark text-center" style="background-color:#c9c2bc;">
	      <th>번호</th>
	      <th>제목</th>
	      <th>작성자</th>
	      <th>작성일</th>
	    </tr>
	    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
	    <c:set var="cnt" value="0"/>
	    <c:set var="tempSw" value="0"/>
	    <c:forEach var="vo" items="${vos}">
	      <c:set var="tempPreName" value="${vos[cnt-1].nickName}"/>
	      <c:if test="${cnt != 0}"><c:set var="tempPreQnaIdx" value="${fn:substring(vos[cnt-1].qnaIdx,0,fn:indexOf(vo.qnaIdx,'_'))}"/></c:if>
	      <c:if test="${cnt == 0}"><c:set var="tempPreQnaIdx" value="${fn:substring(vo.qnaIdx,0,fn:indexOf(vo.qnaIdx,'_'))}"/></c:if>
	      <c:set var="tempQnaIdx" value="${fn:substring(vo.qnaIdx,0,fn:indexOf(vo.qnaIdx,'_'))}"/>
		    <tr>
		      <td>${curScrStartNo}</td>
		      <td style="text-align:left;">
		        <c:if test="${vo.qnaSw == 'a'}"> &nbsp;&nbsp; └</c:if>
		        <c:if test="${!empty vo.pwd}"><i class="fas fa-lock"></i></c:if>
		        <c:if test="${vo.pwd == ''}"><a href="${ctp}/admin/adminQnaContent?idx=${vo.idx}&title=${vo.title}">${vo.title}</a></c:if> <!-- 비밀글이 아니면 모두가 볼 수 있다. -->
		        <c:if test="${vo.pwd != '' && (vo.nickName==sNickName || sLevel == 0)}">  <!-- 비밀글이면 '나'와 '관리자'만 볼 수 있다.(질문글은 당연히 본인 확인 가능) -->
		          <a href="${ctp}/admin/adminQnaContent?idx=${vo.idx}&title=${vo.title}">${vo.title}</a>
		          <c:set var="tempName" value="${vo.nickName}"/>
		          <c:set var="tempSw" value="1"/>
		        </c:if>
		        <c:if test="${vo.pwd != '' && tempSw != 1}">
			        <c:if test="${vo.qnaSw == 'a' && tempPreQnaIdx == tempPreQnaIdx && tempName==tempPreName}">  <!--  && (vo.qnaSw=='a' && tempPreQnaIdx==tempQnaIdx)}"> -->  <!-- 비밀글이면서 답글이라면 원본글의 qnaIdx의 앞의 값이 같으면 답글의 qnaIdx앞의값과 같다면 글을 볼수 있게 처리한다. -->
			          <a href="qnaContent?pag=${pageVO.pag}&idx=${vo.idx}&title=${vo.title}">${vo.title}</a>
			          <c:set var="tempSw" value="1"/>
			        </c:if>
			        <c:if test="${fn:split(vo.qnaIdx,'_')[1]=='2' || vo.qnaSw=='a'}">${vo.title}
			        </c:if>
		        </c:if>
		        <c:if test="${vo.diffTime <= 24}"><span class="badge badge-warning ml-1">NEW</span></c:if>
		      </td>
		      <td>${vo.nickName}</td>
		      <td>
		        <c:if test="${vo.diffTime <= 24}">${fn:substring(vo.WDate,11,19)}</c:if>
		        <c:if test="${vo.diffTime > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
		      </td>
		    </tr>
		    <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
		    <c:set var="cnt" value="${cnt+1}"/>
        <c:set var="tempSw" value="0"/>
        <c:set var="tempPreName" value=""/>
	    </c:forEach>
	    <tr><td colspan="4" class="p-0"></td></tr>
	  </table>
  </form>
  <br/>
</div>
  
<!-- 블록페이징처리 시작 -->
<div class="container" style="text-align:center;">
<c:if test="${pageVO.totPage == 0}"><p style="text-align:center"><font color="red"><b>문의가 존재하지 않습니다.</b></font></p></c:if>
<c:if test="${pageVO.totPage != 0}">
  <ul class="pagination justify-content-center">
	  <c:set var="startPageNum" value="${pageVO.pag - (pageVO.pag-1)%pageVO.blockSize}"/>
	  <c:if test="${pageVO.pag != 1}">
	    <li class="page-item"><a href="qnaList?pag=1&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">◁◁</a></li>
	    <li class="page-item"><a href="qnaList?pag=${pageVO.pag-1}&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="0" end="${pageVO.blockSize-1}">
	    <c:if test="${(startPageNum+i) <= pageVO.totPage}">
		  	<c:if test="${pageVO.pag == (startPageNum+i)}">
		  	  <li class="page-item active"><a href="qnaList?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}" class="page-link btn btn-secondary active" style="color:#666"><font color="#fff">${startPageNum+i}</font></a></li>
		  	</c:if>
		  	<c:if test="${pageVO.pag != (startPageNum+i)}">
		  	  <li class="page-item"><a href="qnaList?pag=${startPageNum+i}&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">${startPageNum+i}</a></li>
		  	</c:if>
	  	</c:if>
	  </c:forEach>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	    <li class="page-item"><a href="qnaList?pag=${pageVO.pag+1}&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">▶</a></li>
	    <li class="page-item"><a href="qnaList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link" style="color:#666">▷▷</a></li>
	  </c:if>
  </ul>
</c:if>
</div>
<!-- 블록페이징처리 끝 -->

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