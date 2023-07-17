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
  // part선택시 해당 part만 불러오기
  function partCheck() {
  	let part = partForm.part.value;
  	location.href = "${ctp}/board/boardList?part="+part;
  }
  
  
  if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/board/boardList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
  
  function pageCheck() {
  	let pageSize = document.getElementById("pageSize").value;
  	location.href = "${ctp}/board/boardList?pag=${pageVO.pag}&pageSize="+pageSize;
  }
  
  function searchCheck() {
  	let searchString = $("#searchString").val();
  	
  	if(searchString.trim() == "") {
  		alert("찾고자하는 검색어를 입력하세요!");
  		searchForm.searchString.focus();
  	}
  	else {
  		searchForm.submit();
  	}
  }
  
  function changeAnswer(e){
 	  let ans = confirm("선택한 문의의 답변상태를 변경하시겠습니까?");
 	  	if(!ans) {
 	  		location.reload();
 	  		return false;
 	  	}
 		let answer = e.value.split("/");
  	
  	$.ajax({
  		type : "post",
  		url : "${ctp}/admin/adminBoardAnswerChange",
  		data : {
  			answer : answer[0],
  			idx : 	 answer[1]
  			},
  		success : function(res){
  			if(res == "1") {
  				alert("답변 상태가 변경되었습니다.");
  				location.reload();
  			}
  			else{
  				alert("답변 상태가 변경 실패.");
  				location.reload();
  			}
  		},
  		error:function(){
  			location.reload();		
  		}
  	});
  }
  
//다중삭제
	function idxDelete(){
		let ans = confirm("선택하신 상품을 삭제하시겠습니까?");
		if(!ans){
			location.reload();
	  		return false;
		} 
		
		let idxs="";
		let flag="";
		let checkIdxs = document.getElementsByName("idxChecked");
		for (let i = 0; i < checkIdxs.length; i++) {
  	  if (checkIdxs[i].checked) {
  	    idxs += checkIdxs[i].value + "/";
  	  }
  	}
		
 		$.ajax({
      type : "post",
      url : "${ctp}/admin/boardDelete",
      data : {
      	idxs : idxs
      },
      success : function(){
       alert("삭제 되었습니다.");
       location.reload();
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

<h2 class="text-center">문의 게시판</h2>
  <table class="table table-borderless">
      <tr>
      <td style="width:20%" class="text-left">
        <form name="partForm">
          <select name="part" onchange="partCheck()" class="form-contorl">
            <option ${pageVO.part=="전체" ? "selected" : ""}>전체</option>
            <option ${pageVO.part=="상품" ? "selected" : ""}>상품</option>
            <option ${pageVO.part=="배송" ? "selected" : ""}>배송</option>
            <option ${pageVO.part=="취소" ? "selected" : ""}>취소</option>
            <option ${pageVO.part=="환불" ? "selected" : ""}>환불</option>
            <option ${pageVO.part=="기타" ? "selected" : ""}>기타</option>
          </select>
        </form>
      </td>
      <td class="text-right">
        <!-- 한페이지 분량처리 -->
        <select name="pageSize" id="pageSize" onchange="pageCheck()">
          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
          <option <c:if test="${pageVO.pageSize == 5}">selected</c:if>>5</option>
          <option <c:if test="${pageVO.pageSize == 10}">selected</c:if>>10</option>
          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
          <option <c:if test="${pageVO.pageSize == 20}">selected</c:if>>20</option>
        </select> 건
      </td>
    </tr>
  </table>
 <input type="button" value="선택삭제" class="btn btn-outline-dark btn-sm ml-3" onclick="idxDelete()" />
  <table class="table table-hover text-center">
    <tr>
      <th></th>
      <th></th>
      <th>분류</th>
      <th>제목</th>
      <th>작성자</th>
      <th>작성날짜</th>
      <th>조회수</th>
      <th>답변여부</th>
    </tr>
	<c:forEach var="vo" items="${vos}" varStatus="st">
    <c:if test="${vo.fixed == 'on'}">
     <tr  class="table-dark text-dark">
     	 <td></td>
       <td><span class="badge badge-danger">공지</span></td>
       <td></td>
       <td class="text-left">
         <a href="${ctp}/board/boardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"><b>${vo.title}</b></a>
       </td>
       <td>${vo.nickName}</td>
       <td>
         <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
         <c:if test="${vo.hour_diff <= 24}">
           ${vo.day_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,16)}
         </c:if>
       </td>
       <td>${vo.readNum}</td>
       <td></td>
	     </tr>
	   </c:if>
	 </c:forEach>
   <c:forEach var="vo" items="${vos}" varStatus="st">
	    <c:if test="${vo.fixed != 'on'}">
  	  <c:set var="curScrStartNo" value="${vo.idx}" />
	     <tr>
	     	 <td><input type="checkbox" name="idxChecked" id="idxChecked" value="${vo.idx}"/></td>
	       <td>${curScrStartNo}</td>
	       <td>${vo.part}</td>
	       <td class="text-left">
	         <a href="${ctp}/admin/adminBoardContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}">${vo.title}</a>
	       </td>
	       <td>
	         <c:forEach var="i" begin="0" end="${fn:length(vo.mid)-1}">
	         <c:if test="${i > 2}">${fn:replace(fn:substring(vo.mid,i,i+1),fn:substring(vo.mid,i,i+1),'*')}</c:if>
	         <c:if test="${i < 2}">${fn:substring(vo.mid,i,i+1)}</c:if>
	         </c:forEach>
	       </td> 
	       <td>
	         <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.WDate,0,10)}</c:if>
	         <c:if test="${vo.hour_diff <= 24}">
	           ${vo.day_diff == 0 ? fn:substring(vo.WDate,11,19) : fn:substring(vo.WDate,0,16)}
	         </c:if>
	       </td>
	       <td>${vo.readNum}</td>
	       <td>
	       	<select name="answer" id="answer" onchange="changeAnswer(this)">
	       		<option value="미답변/${vo.idx}" ${vo.answer=="미답변" ? "selected" : ""}><font color="red">미답변</font></option>
	       		<option value="답변완료/${vo.idx}" ${vo.answer=="답변완료" ? "selected" : ""}>답변완료</option>
	       	</select>
	       
	       
	       </td>
		     </tr>
		    </c:if>
	  </c:forEach>
    <tr><td colspan="8" class="m-0 p-0"></td></tr>
  </table>
  
  
  <!-- 블록 페이징 처리 -->
  <div class="text-center m-4">
	  <ul class="pagination justify-content-center pagination-sm">
	    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=1">첫페이지</a></li></c:if>
	    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">이전블록</a></li></c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li></c:if>
	    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/board/boardList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">마지막페이지</a></li></c:if>
	  </ul>
  </div>

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