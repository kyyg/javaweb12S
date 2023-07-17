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

    $(document).ready(function() {
    	// 주문 상태별 조회 : 전체/결제완료/배송중~~
    	$("#orderStatus").change(function() {
	    	var orderStatus = $(this).val();
	    	location.href="${ctp}/dbShop/orderStatus?orderStatus="+orderStatus+"&pag=${pageVO.pag}";
    	});
    });
    
    // 날짜별 주문 조건 조회(오늘/일주일이내/보름이내~~)
    function orderCondition(conditionDate) {
    	location.href="${ctp}/dbShop/orderCondition?conditionDate="+conditionDate+"&pag=${pageVO.pag}";
    }
    
    // 날찌기간에 따른 조건검색
    function myOrderStatus() {
    	var startDateJumun = new Date(document.getElementById("startJumun").value);
    	var endDateJumun = new Date(document.getElementById("endJumun").value);
    	var conditionOrderStatus = document.getElementById("conditionOrderStatus").value;
    	
    	if((startDateJumun - endDateJumun) > 0) {
    		alert("주문일자를 확인하세요!");
    		return false;
    	}
    	
    	startJumun = moment(startDateJumun).format("YYYY-MM-DD");
    	endJumun = moment(endDateJumun).format("YYYY-MM-DD");
    	location.href="${ctp}/admin/adminOrder?startJumun="+startJumun+"&endJumun="+endJumun+"&conditionOrderStatus="+conditionOrderStatus;
    }
    

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
    			//alert(items);
    			location.reload();
    		},
    		error:function(){
    			alert(items);
    			alert("전송오류");
    		}
    	});
    }
    
    function shippingConfirm(productIdx,optionName,optionNum,idx){
    	//alert("productIdx :" + productIdx + "/ optionName : " + optionName + "/optionNum : " + optionNum + "/ idx" + idx);
    	let ans = confirm("배송 상태를 변경하시겠습니까?");
    	if(!ans){
    		location.reload();
    		return false;
    	}
    	$.ajax({
    		type : "post",
    		url : "${ctp}/admin/adminShippingConfirm",
    		data : {
    			idx : idx,
    			productIdx : productIdx,
    			optionName : optionName,
    			optionNum : optionNum
    		},
    		success:function(){
    			alert("배송상태가 변경되었습니다.");
    			location.reload();
    		},
    		error:function(){
    			alert("전송오류");
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
    
<div class="containe-fluid mr-2 ml-2">
  <hr/> 
  <h3 class="text-center">전체 주문 목록</h3>
  <hr/>
  <c:set var="condition" value="전체 조회"/>
  <c:if test="${conditionDate=='1'}"><c:set var="condition" value="오늘날짜조회"/></c:if>
  <c:if test="${conditionDate=='7'}"><c:set var="condition" value="일주일 이내 조회"/></c:if>
  <c:if test="${conditionDate=='15'}"><c:set var="condition" value="보름 이내 조회"/></c:if>
  <c:if test="${conditionDate=='30'}"><c:set var="condition" value="한달 이내 조회"/></c:if>
  <c:if test="${conditionDate=='90'}"><c:set var="condition" value="석달 이내 조회"/></c:if>
  <table class="table table-borderless">
    <tr>
      <td style="text-align:left;"> 
        <input type="button" class="btn btn-outline-dark btn-sm" value="전체보기" onclick="location.href='${ctp}/admin/adminOrder';"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="오늘" onclick="orderCondition(0)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="일주일" onclick="orderCondition(7)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="보름" onclick="orderCondition(15)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="1개월" onclick="orderCondition(30)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="3개월" onclick="orderCondition(90)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="12개월" onclick="orderCondition(365)"/>
      </td>
      <td></td>
    </tr>
	    <tr>
	      <td style="text-align:left;">
	        <c:if test="${startJumun == null}">
	          <c:set var="startJumun" value="<%=new java.util.Date() %>"/>
		        <c:set var="startJumun"><fmt:formatDate value="${startJumun}" pattern="yyyy-MM-dd"/></c:set>
	        </c:if>
	        <c:if test="${endJumun == null}">
	          <c:set var="endJumun" value="<%=new java.util.Date() %>"/>
		        <c:set var="endJumun"><fmt:formatDate value="${endJumun}" pattern="yyyy-MM-dd"/></c:set>
	        </c:if>
	        <input type="date" name="startJumun" id="startJumun" value="${startJumun}"/>~<input type="date" name="endJumun" id="endJumun" value="${endJumun}"/>
	        <select name="conditionOrderStatus" id="conditionOrderStatus">
	          <option value="전체" ${conditionOrderStatus == '전체' ? 'selected' : ''}>전체</option>
	          <option value="결제완료" ${conditionOrderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
	          <option value="배송중"  ${conditionOrderStatus == '배송중' ? 'selected' : ''}>배송중</option>
	          <option value="배송완료"  ${conditionOrderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
	          <option value="구매확정"  ${conditionOrderStatus == '구매확정' ? 'selected' : ''}>구매확정</option>
	          <option value="반품요청"  ${conditionOrderStatus == '반품요청' ? 'selected' : ''}>반품요청</option>
	          <option value="반품요청"  ${conditionOrderStatus == '환불요청' ? 'selected' : ''}>환불요청</option>
	        </select>
	        <input type="button" class="btn btn-outline-dark btn-sm" value="조회하기" onclick="myOrderStatus()"/>
	      </td>
	    </tr>
	    <tr>
	    </tr>
  </table>
  <table class="table table-hover table-borderless">
    <tr style="text-align:center;background-color:#ccc;">
      <th></th>
      <th>주문번호</th>
      <th>주문일시</th>
      <th>주문자</th>
      <th>주문자 성명</th>
      <th>이미지</th>
      <th>상품</th>
      <th>옵션</th>
      <th>금액</th>
      <th>주문상태</th>
      <th>배송처리</th>
    </tr>
    <c:set var="orderIdx" value="0" />
    <c:forEach var="vo" items="${vos}">
      <tr>
      	<td style="text-align:center;"><input type="checkbox" name="idxChecked" id="idxChecked" value="${vo.idx}" class="text-center"/></td>
        <td style="text-align:center;">
        <c:if test = "${vo.orderIdx != orderIdx}">
        	${vo.orderIdx}
        </c:if>
        <c:if test = "${vo.orderIdx == orderIdx}"></c:if>
	      <c:set var="orderIdx" value="${vo.orderIdx}" />
        </td>
        <td style="text-align:center;">${fn:substring(vo.orderDate,0,10)}</td>
        <td style="text-align:center;">${vo.mid}</td>
        <td style="text-align:center;">${vo.name}</td>
        <td style="text-align:center;"><img src="${ctp}/data/dbShop/product/${vo.thumbImg}" class="thumb" width="50px"/></td>
        <td align="center">${vo.productName}</td>
	      <td>${vo.optionName} / <fmt:formatNumber value="${vo.optionPrice}"/>원 / ${vo.optionNum}개<br/></td>      
	      <td><fmt:formatNumber value="${vo.totalPrice}"/>원</td>
	      <td><font color="brown">
	      	<select name="orderStatus" id="orderStatus" onchange="orderStatusChange(this)">
	      		<option value="입금전/${vo.idx}" ${vo.status=="입금전" ? "selected" : ""}>입금전</option>
	      		<option value="결제완료/${vo.idx}" ${vo.status=="결제완료" ? "selected" : ""}>결제완료</option>
	      		<option value="배송중/${vo.idx}" ${vo.status=="배송중" ? "selected" : ""}>배송중</option>
	      		<option value="배송완료/${vo.idx}" ${vo.status=="배송완료" ? "selected" : ""}>배송완료</option>
	      		<option value="구매확정/${vo.idx}" ${vo.status=="구매확정" ? "selected" : ""}>구매확정</option>
	      		<option value="반품요청/${vo.idx}" ${vo.status=="반품요청" ? "selected" : ""}>반품요청</option>
	      		<option value="환불요청/${vo.idx}" ${vo.status=="환불요청" ? "selected" : ""}>환불요청</option>
	      		<option value="반품/${vo.idx}" ${vo.status=="반품" ? "selected" : ""}>반품</option>
	      		<option value="환불/${vo.idx}" ${vo.status=="환불" ? "selected" : ""}>환불</option>
	      	</select>
	      </font><br/></td>
	      <td><input type="button" value="배송처리" onclick="shippingConfirm('${vo.productIdx}','${vo.optionName}','${vo.optionNum}','${vo.idx}')" class="btn btn-outline-dark btn-sm"></td>
      </tr>
   	<tr><td colspan="10" class="p-0 m-0"></td></tr>
    </c:forEach>
   	<tr><td colspan="10" class="p-0 m-0"></td></tr>
  </table>
  <hr/>

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