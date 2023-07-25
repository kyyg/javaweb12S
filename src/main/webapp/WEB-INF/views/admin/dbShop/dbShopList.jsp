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
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- Custom styles for this template-->
<link href="../resources/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<style>
	#cate{
	background-color:white;
	color:black;
	padding : 0px 2px 0px 2px;
	font-size : 20px;
	}
	</style>
	<script>
    // part선택시 해당 part만 불러오기
    function partCheck() {
    	let part = partForm.part.value;
    	location.href = "${ctp}/dbShop/dbShopList?part="+part;
    }
    
    
    if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/dbShop/dbShopList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
    
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/dbShop/dbShopList?pag=${pageVO.pag}&pageSize="+pageSize;
    }
	
    $(function(){
	    $("#productStatus").change(function(){
	      let select = $(this).val().split("/");
	      let productStatus = select[0];
	      let idx = select[1];
	      
	      let ans = confirm("상품의 판매 상태를 변경하시겠습니까?");
	      if (!ans) {
          location.reload();
          return false;
	      }
	      
	      $.ajax({
          type: "post",
          url: "${ctp}/dbShop/productStatusChange",
          data: {
	          idx: idx,
	          productStatus: productStatus
          },
          success: function() {
            location.reload();
          },
          error: function() {
            alert("전송 오류");
          }
	      });
	    });
    });

    function productStatusChange(e){
   	  let ans = confirm("상품의 판매 상태를 변경하시겠습니까?");
   	  	if(!ans) {
   	  		location.reload();
   	  		return false;
   	  	}
   		let item = e.value.split("/");
     	
     	$.ajax({
     		type : "post",
     		url : "${ctp}/dbShop/productStatusChange",
     		data : {
     			productStatus : item[0],
     			idx : 	 item[1]
     			},
     		success : function(res){
     				location.reload();
     		},
     		error:function(){
     			alert("전송오류");
     			location.reload();		
     		}
     	});
     }
    
    function optionNew(idx){
        let url = "${ctp}/admin/adminOptionNew?idx="+idx;
        let winName = "winName";
        let winWidth = 1000;
        let winHeight = 500;
        let x = (screen.width/2) - (winWidth/2);
        let y = (screen.height/2) - (winHeight/2);
        let opt="width="+winWidth+", height="+winHeight+", left="+x+", top="+y;
        window.open(url,winName,opt);
    	
    }
    
    function searchProduct(){
   	  let searchString = document.getElementById("searchString").value;
   	  location.href = "${ctp}/dbShop/dbShopList?sort=${sort}&searchString="+searchString;
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
<div class="container-fluid">
  <hr/> 
		<div class="w3-bottombar w3-indigo w3-padding text-center" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">전체상품 목록</span>
	   </div>
  <hr/>
<div class="text-center">
	  <span id="cate"><b><a href="${ctp}/dbShop/dbShopList">전체상품</a></b></span>
	  	<c:forEach var="mainTitle" items="${mainTitleVOS}" varStatus="st">
	  	<span id="cate"><a href="${ctp}/dbShop/dbShopList?part=${mainTitle.categoryMainName}">${mainTitle.categoryMainName}</a></span>
		  <c:if test="${!st.last}"> </c:if>
	 	</c:forEach> 
	  <h3 class="text-center">
	  <c:if test="${part == '전체'}"></c:if>
	  <c:if test="${part != '전체'}">${part}</c:if>
	  </h3>
  </div>
  <hr/>
    	<form name="myform" method="post">
		 		<div class="text-right">
					<input type="text" name="searchString" id="searchString" value="" class="mt-1" size="12"/>
					<a href="javascript:searchProduct()">검색</a>
				</div>
			</form>
    <table class="table table-borderless">
      <tr>
      <td class="text-left">
        <!-- 한페이지 분량처리 -->
        <select name="pageSize" id="pageSize" onchange="pageCheck()">
          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
          <option <c:if test="${pageVO.pageSize == 9}">selected</c:if>>9</option>
          <option <c:if test="${pageVO.pageSize == 12}">selected</c:if>>12</option>
          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
          <option <c:if test="${pageVO.pageSize == 18}">selected</c:if>>18</option>
        </select> 건
      </td>
      <td>
      	<div class="text-right">
			  	<span><a href="${ctp}/dbShop/dbShopList?part=${part}&sort=높은가격순" class="p-2">높은가격순</a></span>|
			  	<span><a href="${ctp}/dbShop/dbShopList?part=${part}&sort=낮은가격순" class="p-2">낮은가격순</a></span>|
			  	<span><a href="${ctp}/dbShop/dbShopList?part=${part}&sort=신상품순" class="p-2">신상품순</a></span>|
			  	<span><a href="${ctp}/dbShop/dbShopList?part=${part}&sort=상품명순" class="p-2">상품명순</a></span>
			  </div>
      </td>
    </tr>
  </table>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
      <table class="table table-borderless table-hover text-center">
      	<tr class="text-dark table-primary">
      		<th>고유번호</th>
      		<th>대분류</th>
      		<th>중분류</th>
      		<th>썸네일</th>
      		<th>상품명</th>
      		<th>상품 가격</th>
      		<th>비고</th>
      		<th>판매상태</th>
      		<th></th>
      	</tr>
		    <c:forEach var="vo" items="${productVOS}">
      	<tr>
      		<td>${vo.idx}</td>
      		<td>${vo.categoryMainCode}</td>
      		<td>${vo.categoryMiddleCode}</td>
      		<td>
      			<a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}">
            	<img src="${ctp}/dbShop/product/${vo.FSName}" width="50px" height="50px"/>
            </a>
            </td>
      		<td>${vo.productName} <span class="badge badge-info" onclick="optionNew('${vo.idx}')">옵션 보기</span></td>
      		<td>${vo.mainPrice}</td>
      		<td>${vo.detail}</td>
      		<td>
      			<select name="productStatus" id="productStatus" onchange="productStatusChange(this)">
      				<option value="판매중/${vo.idx}" ${vo.productStatus == "판매중" ? "selected" : ""} >판매중</option>
      				<option value="판매중지/${vo.idx}" ${vo.productStatus == "판매중지" ? "selected" : ""} >판매중지</option>
      				<option value="품절/${vo.idx}" ${vo.productStatus == "품절" ? "selected" : ""} >품절</option>
      			</select>
      		</td>
      		<td><input type="button" value="상품수정" class="btn btn-outline-dark btn-sm" onclick="location.href='${ctp}/dbShop/productModify?idx=${vo.idx}';"/></td>
      	</tr>
		    </c:forEach>
      </table>
  </div>
</div>

 <!-- 블록 페이징 처리 -->
  <div class="text-center m-4">
	  <ul class="pagination justify-content-center pagination-sm">
	    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=1">첫페이지</a></li></c:if>
	    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">이전블록</a></li></c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li></c:if>
	    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">마지막페이지</a></li></c:if>
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