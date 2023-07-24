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

  function orderCondition(e) {
 	  let today = new Date();
 	  today.setDate(today.getDate() - e); // e일 전 날짜로 설정
 	  let year = today.getFullYear();
 	  let month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고, 2자리 숫자로 표현
 	  let day = String(today.getDate()).padStart(2, '0'); // 2자리 숫자로 표현
 	  let startJumun = year + '-' + month + '-' + day;
 	  
	   	 let today2 = new Date(); // 오늘 날짜 가져오기
	     let year2 = today2.getFullYear();
	     let month2 = ('0' + (today2.getMonth() + 1)).slice(-2);
	     let day2 = ('0' + today2.getDate()).slice(-2);
	     let endJumun = year2 + '-' + month2 + '-' + day2;
	     
   	location.href="${ctp}/admin/adminOrder?startJumun="+startJumun+"&endJumun="+endJumun;
 	}
  
  
  function reset() {
 	  window.location.reload();
 	}
  
  function orderStatusChange(e){
  	let ans = confirm("주문 상태를 변경하시겠습니까?")
  	if(!ans){
  		location.reload();
  		return false;
  	}
  	let items = e.value.split("/");
  	$.ajax({
  		type : "post",
  		url : "${ctp}/admin/orderStatusChange",
  		data : {
  			status : items[0], 
  			idx : items[1]
  		},
  		success:function(){
  			alert(items);
  			location.reload();
  		},
  		error:function(){
  			alert(items);
  			alert("전송오류");
  		}
  	});
  }
  
  
  function allCheck() {
      for(let i=0; i<myform.idxChecked.length; i++) {
        myform.idxChecked[i].checked = !myform.idxChecked[i].checked;
      }
      onTotal();
    }
  
  function cancelStatusChange(){
   	let ans = confirm("선택한 주문의 상태를 변경하시겠습니까?");
  	if(!ans){
  		location.reload();
  		return false;
  	} 
  	let status = document.getElementById("cancelStatus").value;
    let idxs = "";
    let checkIdxs = document.getElementsByName("idxChecked");

    for (let i = 0; i < checkIdxs.length; i++) {
  	  if (checkIdxs[i].checked) {
  	    idxs += checkIdxs[i].value + "/";
  	  }
   	}
  	//alert("idxs : " + idxs + " === status : " + status);
   	$.ajax({
				type : "post",
				url : "${ctp}/admin/adminCancelOrderChange",
				data : {
					idxs : idxs,
					status : status
				},
				success : function(){
					alert("변경되었습니다.");
					location.reload();
				},
				error:function(){
					alert("전송오류");					
				}
  	}); 
  }
  
  // 반품,환불 불가처리 새창
  function cancelNew(idx){
    let url = "${ctp}/admin/adminCancleNew?idx="+idx;
    let winName = "winName";
    let winWidth = 800;
    let winHeight = 300;
    let x = (screen.width/2) - (winWidth/2);
    let y = (screen.height/2) - (winHeight/2);
    let opt="width="+winWidth+", height="+winHeight+", left="+x+", top="+y;
    window.open(url,winName,opt);
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
    <c:set var="conditionOrderStatus" value="${conditionOrderStatus}"/>
<c:set var="orderStatus" value="${orderStatus}"/>
<p><br/></p>
<div class="containe-fluid mr-2 ml-2">
  <c:set var="condition" value="전체 조회"/>
  <c:if test="${conditionDate=='1'}"><c:set var="condition" value="오늘날짜조회"/></c:if>
  <c:if test="${conditionDate=='7'}"><c:set var="condition" value="일주일 이내 조회"/></c:if>
  <c:if test="${conditionDate=='15'}"><c:set var="condition" value="보름 이내 조회"/></c:if>
  <c:if test="${conditionDate=='30'}"><c:set var="condition" value="한달 이내 조회"/></c:if>
  <c:if test="${conditionDate=='90'}"><c:set var="condition" value="석달 이내 조회"/></c:if>
  <hr/> 
		<div class="w3-bottombar w3-indigo w3-padding text-center" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">주문 반품 / 환불 조회</span>
	   </div>
  <hr/>
  <table>
  	<tr>
  		<td>
  			<select name="cancelStatus" id="cancelStatus" class="ml-2 p-2">
  				<option>반품/환불 일괄처리 선택</option>
  				<option value="반품">반품</option>
  				<option value="환불">환불</option>
  			</select>
  			<input type="button" value="주문상태 변경" class="btn btn-outline-dark" onclick="cancelStatusChange()" />
  		</td>
  	</tr>
  </table>
  <p><br/></p>
  <table class="table table-hover table-bordered">
  	<form name="myform">
	    <tr style="text-align:center;" class="table-primary">
	      <th><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></th>
	      <th>주문번호</th>
	      <th>주문날짜</th>
	      <th>취소요청날짜</th>
	      <th>주문자</th>
	      <th>상품</th>
	      <th>옵션</th>
	    </tr>
	    <c:set var="orderIdx" value="0" />
	    <c:forEach var="vo" items="${vos}">
	      <tr>
	      	<td style="text-align:center;"><input type="checkbox" name="idxChecked" id="idxChecked" value="${vo.cancelIdx}" /></td>
	        <td style="text-align:center;">${vo.orderIdx}</td>
	        <td style="text-align:center;">${fn:substring(vo.orderDate,0,10)}</td>
	        <td style="text-align:center;">${fn:substring(vo.cancelDate,0,10)}</td>
	        <td style="text-align:center;">${vo.mid}</td>
	        <td align="center">${vo.productName}</td>
		      <td>${vo.optionName} / <fmt:formatNumber value="${vo.optionPrice}"/>원 / ${vo.optionNum}개<br/></td>
	      </tr>
	      <tr>
		      <td style="text-align:center;">
		      <c:if test = "${vo.cancelStatus == '반품요청' || vo.cancelStatus == '환불요청'}">
		      <input type="button" value="승인불가" onclick="cancelNew('${vo.idx}')"  class="btn btn-danger"/>
		      </c:if>
		      <c:if test = "${vo.cancelStatus != '반품요청' || vo.cancelStatus != '환불요청'}"></c:if>
		      </td>
		      <td style="text-align:center;">
		      <c:if test="${vo.cancelStatus == '반품요청' || vo.cancelStatus == '환불요청'}">
		      	<font color="red"><b>${vo.cancelStatus}</b></font>
		      </c:if>
		      <c:if test="${vo.cancelStatus != '반품요청' && vo.cancelStatus != '환불요청'}">
		      	<font color="green">처리 완료</font>
		      </c:if>
		      </td>
		      <td colspan="5"> [사유] ${vo.cancelMemo}</td>
		    </tr>
		    <tr><td colspan="7" class="p-0 m-0"></td></tr>
		    <tr><td colspan="7"></td></tr>
	    </c:forEach>
    </form>
  </table>
  <hr/>

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