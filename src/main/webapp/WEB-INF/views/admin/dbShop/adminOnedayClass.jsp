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
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script>
//다중삭제
	function idxDelete(){
		let ans = confirm("선택하신 예약을 삭제하시겠습니까?");
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
  url : "${ctp}/admin/onedayClassDelete",
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
	
	function eventGo(idx,WDate,mid,className,store,memberNum){
		let classTemp = "";
		let wDate = WDate;
		// qr코드내역
		classTemp  = "이벤트 당첨을 축하드립니다.";
		classTemp  = "["+className+"]\n";
		classTemp  += "아이디 : " + mid + ",\n";
		classTemp  += "매장명 : " + store + ",\n";
		classTemp  += "예약날짜 : " + wDate + ",\n";
		classTemp  += "인원수 : " + memberNum + "명\n";
		classTemp  += "반드시 QR코드를 지참하여 오시기 바랍니다.";
				
		let query = {
			idx : idx,
			mid : mid,
			className : className,
			store : store,
			wDate : wDate,
			memberNum : memberNum,
			classTemp : classTemp
		}
		
	$.ajax({
		  type : "post",
		  url : "${ctp}/dbShop/onedayClassConfirm",
		  data : query,
		  success : function(res){
			  if(res == "1"){
			   alert("이벤트 당첨 처리 되었습니다.");
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
    
<div class="containe-fluid mr-2 ml-2">
<hr/>
		<div class="w3-bottombar w3-indigo w3-padding text-center" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">이벤트 예약자 목록 조회(원데이 클래스)</span>
	   </div>
<hr/>
	<table class="table-hover table-borderless text-center" style="width:1600px; margin:0 auto; ">
	 <input type="button" value="선택삭제" class="btn btn-outline-dark btn-sm ml-5 mb-3" onclick="idxDelete()" />
		<tr class="table-primary text-dark pt-2 pb-2">
			<td></td>
			<td>번호</td>
			<td>응모날짜</td>
			<td>예약날짜</td>
			<td>아이디</td>
			<td>클래스명</td>
			<td>매장명</td>
			<td>인원수</td>
			<td>QR코드</td>
			<td>승인</td>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
		<tr>
			<td style="height:100px"><input type="checkbox" name="idxChecked" id="idxChecked" value="${vo.idx}"/></td>
			<td style="height:100px">${st.count}</td>			
			<td style="height:100px">${fn:substring(vo.appDate,0,10)}</td>	
			<td style="height:100px">${fn:substring(vo.WDate,0,10)}</td>			
			<td style="height:100px">${vo.mid}</td>			
			<td style="height:100px">${vo.className}</td>			
			<td style="height:100px">${vo.store}</td>			
			<td style="height:100px">${vo.memberNum}</td>			
			<td style="height:100px">
				<c:if test="${vo.qrCodeName != null}">			
					<img src="${ctp}/qrCode/${vo.qrCodeName}" width="70px" onclick="qrCodeNew('${vo.idx}')"/>
				</c:if>
				<c:if test="${vo.qrCodeName == null}"></c:if>
			</td>
			<td>
				<c:if test="${vo.qrCodeName == null}">
					<input type="button" value="당첨 승인" class="btn btn-outline-dark btn-sm" onclick="eventGo('${vo.idx}','${vo.WDate}','${vo.mid}','${vo.className}','${vo.store}','${vo.memberNum}')" />
				</c:if>
				<c:if test="${vo.qrCodeName != null}"></c:if>
			</td>
		</tr>
		<tr><td class="p-0 m-0"></td></tr>
		</c:forEach>
	</table>

<p><br/></p>
</div>
</div>
</div>

<!-- End of Content Wrapper -->
</div>
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