
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Blank</title>

     <!-- Custom fonts for this template-->
    <link href="../resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="../resources/https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="../resources/css/sb-admin-2.min.css" rel="stylesheet">


</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">
<jsp:include page="/WEB-INF/views/include/sidebar.jsp" />
       

<style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
    function midSearch() {
      let mid = myform.mid.value;
      if(mid.trim() == "") {
    	  alert("아이디를 입력하세요!");
    	  myform.mid.focus();
      }
      else {
    	  myform.submit();
      }
    }
    
    
    // 회원정보 상세보기
    function memberView(mid,nickName,name,tel,address,email,userDel,point,strLevel,visitCnt,startDate,lastDate,todayCnt) {
    	let telArr = tel.split('-');
    	if(telArr[1].trim()=="" || telArr[2].trim()=="") tel = "없음";
    	address = address.replace(/\//g, ' ');
    	$("#myModal").on("show.bs.modal", function(e){
    		$(".modal-header #mid").html(mid);
    		$(".modal-body #name").html(name);
    		$(".modal-body #nickName").html(nickName);
    		$(".modal-body #tel").html(tel);
    		$(".modal-body #email").html(email);
    		$(".modal-body #address").html(address);
    		$(".modal-body #userDel").html(userDel);
    		$(".modal-body #point").html(point);
    		$(".modal-body #todayCnt").html(todayCnt);
    		$(".modal-body #visitCnt").html(visitCnt);
    		$(".modal-body #startDate").html(startDate);
    		$(".modal-body #lastDate").html(lastDate);
    	});
    }
  </script>
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
                <!-- Topbar Navbar -->
                <ul class="navbar-nav ml-auto">
            </nav>
            <!-- End of Topbar -->


            <!-- Main Content -->
            
            
            <div id="content">
<div class="container-fluid">
  <h2 class="text-center">
    <c:if test="${empty mid}">전체 회원 리스트</c:if>
    <c:if test="${!empty mid}"><font color='blue'><b>${mid}</b></font> 회원 리스트(총<font color='red'>${pageVO.totRecCnt}</font>건)</c:if>
  </h2>
  <br/>
  <form name="myform">
  	<table class="table table-borderless m-0 p-0">
  	  <tr>
  	    <td style="width:60%"><button type="button" onclick="location.href='${ctp}/admin/adminMemberList';" class="btn btn-primary">전체보기</button></td>
  	    <td style="width:40%">
  	      <div class="input-group">
		  	    <input type="text" name="mid" class="form-control mr-1" autofocus />&nbsp;
		  	    <div class="input-group-append">
		  	    	<input type="button" value="아이디 검색" onclick="midSearch();" class="btn btn-success form-control" />
		  	    </div>
	  	    </div>
  	  	</td>
  	  </tr>
  	</table>
  </form>
  
  <table class="table table-hover text-center">
    <tr class="table-dark text-dark">
      <th>번호</th>
      <th>아이디</th>
      <th>이름</th>
      <th>닉네임</th>
      <th>전화번호</th>
      <th>주소</th>
      <th>이메일</th>
      <th>포인트</th>
      <th>레벨</th>
      <th>가입일자</th>
      <th>최종방문일</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${curScrStartNo}</td>
        <c:if test="${vo.level == 0}"><c:set var="strLevel" value="관리자"/></c:if>
        <c:if test="${vo.level == 1}"><c:set var="strLevel" value="운영자"/></c:if>
        <c:if test="${vo.level == 2}"><c:set var="strLevel" value="우수회원"/></c:if>
        <c:if test="${vo.level == 3}"><c:set var="strLevel" value="정회원"/></c:if>
        <c:if test="${vo.level == 4}"><c:set var="strLevel" value="준회원"/></c:if>
        <td><a href="#" onclick="memberView('${vo.mid}','${vo.nickName}','${vo.name}','${vo.tel}','${vo.address}','${vo.email}','${vo.userDel}','${vo.point}','${strLevel}','${vo.visitCnt}','${fn:substring(vo.startDate,0,10)}','${fn:substring(vo.lastDate,0,10)}','${vo.todayCnt}')" data-toggle="modal" data-target="#myModal">${vo.mid}</a></td>
        <td>${vo.nickName}</td>
        <td>${vo.name}<c:if test="${sLevel == 0 && vo.userInfor == '비공개'}"><font color='red'>(비공개)</font></c:if></td>
        <td>${vo.tel}</td>
        <td>${fn:replace(vo.address,'/','')}</td>
        <td>${vo.email}</td>
        <td>${vo.point}</td>
        <td>${vo.level}</td>
        <td>${vo.startDate}</td>
        <td>${vo.lastDate}</td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
    </c:forEach>
    <tr><td colspan="5" class="m-0 p-0"></td></tr>
  </table>
</div>
<br/>
<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pageVO.pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=1">첫페이지</a></li>
    </c:if>
    <c:if test="${pageVO.curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(pageVO.curBlock)*pageVO.blockSize + 1}" end="${(pageVO.curBlock)*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${i}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${i}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li>
    </c:if>
    <c:if test="${pageVO.pag < pageVO.totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/member/memberList?mid=${mid}&pag=${pageVO.totPage}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
<!-- 블록 페이지 끝 -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

<!-- The Modal('회원 아이디' 클릭시 회원의 상세정보를 모달창에 출력한다. -->
<div class="modal fade" id="myModal" style="width:690px;">
  <div class="modal-dialog">
    <div class="modal-content" style="width:600px;">
    
      <!-- Modal Header -->
      <div class="modal-header" style="width:600px;">
        <h4 class="modal-title text-center">회원 상세정보</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body" style="width:600px;height:400px;overflow:auto;">
        <table class="table table-bordered" style="font-size:10pt">
          <tr>
          	<th>성명</th><td id="name"></td><th>닉네임</th><td id="nickName"></td>
          </tr>
          <tr>
          	<th>전화번호</th><td id="tel"></td><th>전자우편</th><td id="email"></td>
	        </tr>
          <tr>
          	<th>주소</th><td colspan="3" id="address"></td>
	        </tr>
          <tr>
          	<th>탈퇴여부</th><td id="userDel"></td><th>포인트</th><td id="point"></td>
	        </tr>
          <tr>
          	<th>오늘방문횟수</th><td id="todayCnt"></td><th>총 방문횟수</th><td id="visitCnt"></td>
	        </tr>
          <tr>
          	<th>최초가입일</th><td id="startDate"></td><th>최종방문일</th><td id="lastDate"></td>
	        </tr>
        </table>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer" style="width:600px;">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>

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