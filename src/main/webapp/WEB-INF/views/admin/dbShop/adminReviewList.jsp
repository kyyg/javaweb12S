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
  
 	function imagesClick(idx){
		$("#demo"+idx).slideDown(500);
	}
	
	function imagesUp(idx){
		$("#demo"+idx).slideUp(500);
	}
	
	// 선택한 것만 삭제하기
	function idxDelete(){
 		let ans = confirm("선택하신 리뷰를 삭제하시겠습니까?");
  if(!ans){
      location.reload();
      return false;
  }  
  let idxs = "";
  let checkIdxs = document.getElementsByName("idxChecked");

  for (let i = 0; i < checkIdxs.length; i++) {
	  if (checkIdxs[i].checked) {
	    idxs += checkIdxs[i].value + "/";
	  }
	}
      
  let query = {
  	idxs   : idxs
  }
    $.ajax({
    type : "post",
    url : "${ctp}/admin/reviewDelete",
    data : query,
    success : function(res){
        if(res == "1"){
         alert("리뷰가 삭제 되었습니다.")
         location.reload();
        }
        else{
        	alert("삭제에 실패했습니다.");
        	location.reload();
        }
    },
    error : function(){
     alert("전송 오류");
    }
  })  
	}
	
	// 베스트 리뷰 변경
	function bestReviewChange(idx,mid,productName){
 		let ans = confirm("선택하신 리뷰를 베스트 리뷰로 등록하시겠습니까?");
	  if(!ans){
	      location.reload();
	      return false;
	  }  
	  	      
	  let query = {
	  	idx   : idx,
	  	mid : mid,
	  	productName : productName
	  }
	    $.ajax({
	    type : "post",
	    url : "${ctp}/admin/bestReviewChange",
	    data : query,
	    success : function(res){
	        if(res == "1"){
	         alert("베스트 리뷰가 등록되었습니다.")
	         location.reload();
	        }
	        else{
	        	alert("등록에 실패했습니다.");
	        	location.reload();
	        }
	    },
	    error : function(){
	     alert("전송 오류");
	    }
	  })  
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
	<hr/><h3 class="text-center"> 리뷰 관리</h3><hr/>
	 <!-- 리뷰 항목 -->
	<div class="text-right mb-2" style="width:1100px;">
	</div>
 	 	<table class="table-borderless" style="width:1100px; margin:0 auto;">
		<div class="">
			<input type="button" value="리뷰 삭제" onclick="idxDelete()" class="btn btn-outline-dark"/>
		</div>
	 		<tr><td colspan="4" class="p-0 m-0 mt-2 pt-3 pb-3 mb-3" style="border-bottom :solid 1px lightgray"></td></tr>
 		<c:forEach var="vo" items="${vos}">
	 		<tr class="text-dark" style="background-color:#fff;">
	 			<td>
		 			<input type="checkbox" name="idxChecked" id="idxChecked" value="${vo.idx}" class="ml-5 mt-5"/>
		 			<input type="button" id="bestReview" onclick="bestReviewChange('${vo.idx}','${vo.mid}','${vo.productName}')"  value="베스트 리뷰 선정" class="btn btn-outline-info btn-sm" />
		 		</td>
	 			<td style="width:20%"; class="text-center">
	 				<img src="${ctp}/images/mu.jpg" class="w3-circle" alt="mu" style="width:70px">
	 			</td>
	 			<td colspan="1" class="text-left pt-3 pb-2" style="width:60%";>
	 				<b>
		 				<c:if test="${vo.score == 1}">💙🤍🤍🤍🤍<br/></c:if>
		 				<c:if test="${vo.score == 2}">💙💙🤍🤍🤍<br/></c:if>
		 				<c:if test="${vo.score == 3}">💙💙💙🤍🤍<br/></c:if>
		 				<c:if test="${vo.score == 4}">💙💙💙💙🤍<br/></c:if>
		 				<c:if test="${vo.score == 5}">💙💙💙💙💙<br/></c:if>
	 				</b>
	 				<b>${vo.mid}</b> &nbsp;&nbsp; <font color="brown"> ${fn:substring(vo.WDate,0,10)}</font><br/>
	 				<span class="badge badge-light mr-2 mb-2">옵션</span><font size="2">${vo.productName}</font><br/>
	 				<b>${vo.title}</b><br/>
	 				${vo.content}
				<td class="mt-3 mb-3" style="width:20%";>	
 					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
 						<img src="${ctp}/review/${fSNames[0]}" width="100px" class="w3-round" onclick="imagesClick('${vo.idx}')" /><br/>
 				</td>
 			</tr>
		 	</div>
	 	<tr><td colspan="4" class="m-0 p-0 text-center"><div id="demo${vo.idx}"  style="display:none">
	 		<c:forEach var="fSName" items="${fSNames}" varStatus="st">
 				<img src="${ctp}/review/${fSName}" width="200px" height="200"/>
 			</c:forEach>
 			<br/>
 			<input type="button" value="이미지 접기" onclick="imagesUp('${vo.idx}')" class="btn btn-outline-dark btn-sm text-right mt-3"/>
 			<tr><td colspan="4" class="p-0 m-0 mt-2 pt-3" style="border-bottom :solid 1px lightgray"></td></tr>
	 	</div></td></tr>
 		</c:forEach>
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