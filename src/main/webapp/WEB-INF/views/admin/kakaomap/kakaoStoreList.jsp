<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>kakaoEx2.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  	<style>
		#menu {
		  position: fixed;
		  top: 0;
		  left: 0;
		  width: 225px;
		  height: 1000px;
		  background-color: #476cd9;
		}
	</style>
  <script>
   function addressSearch() {
   	var store_name = myform.store_name.value;
   	if(store_name == "") {
   		alert("검색할 지점을 선택하세요");
   		return false;
   	}
   	myform.submit();
   }
   
   function addressDelete() {
   	var store_name = myform.store_name.value;
   	if(store_name == "") {
   		alert("삭제할 지점을 선택하세요");
   		return false;
   	}
   	var ans = confirm("선택하신 지역명을 DB에서 삭제하시겠습니까?");
   	if(!ans) return false;
   	
   	$.ajax({
   		type  : "post",
   		url   : "${ctp}/admin/kakaomap/kakaoAddressDelete",
   		data  : {store_name : store_name},
   		success:function() {
   			alert("DB에 저장된 지역명이 삭제되었습니다.");
   			location.href = "${ctp}/admin/kakaomap/kakaoStoreList";
   		},
   		error : function() {
   			alert("전송오류!");
   		}
   	});
   }
  </script>
</head>
<body>
<p><br/></p>
<div class="menu" id="menu">
	<div class="text-center card-hover" id="accordion">
  <h5 class="text-white"><a href="${ctp}/admin/index">관리자</a></h5>
  <hr/>
  <p><a href="${ctp}/" target="_top" class="text-white">메인화면으로</a></p>
	<br/>

  <div class="card">
    <div class="card-header bg-blue m-0 p-2" >
      <a class="card-link" data-toggle="collapse" href="#collapse1">
        회원 관리
      </a>
    </div>
    <div id="collapse1" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminMemberList" target="adminContent">회원 리스트</a>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse2">
        주문 관리
      </a>
    </div>
    <div id="collapse2" class="collapse" data-parent="#accordion">	
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminOrder" target="adminContent">전체 주문목록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminCancelOrder" target="adminContent">취소/환불 목록</a>
      </div>
    </div>
  </div>
  
    <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse3">
        상품관리
      </a>
    </div>
    <div id="collapse3" class="collapse" data-parent="#accordion">	
     <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbCategory" target="adminContent">상품분류등록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbProduct" target="adminContent">상품등록관리</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbShopList" target="adminContent">상품등록조회</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbOption" target="adminContent">옵션등록관리</a>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse4">
        게시판 관리
      </a>
    </div>
    <div id="collapse4" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminNoticeList" target="adminContent">공지 게시판</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminBoardList" target="adminContent">문의 게시판</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminReviewList" target="adminContent">리뷰 게시판</a>
      </div>
    </div>
  </div>
  
  
  
  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse5">
        오프라인매장 관리
      </a>
    </div>
    <div id="collapse5" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/kakaomap/storeRegistration" target="adminContent">매장 등록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/kakaomap/kakaoStoreList" target="adminContent">매장 확인/삭제</a>
      </div>
    </div>
  </div>
</div>
</div>
<div class="container">
	<hr/>
	<div>
		<div class="w3-bottombar w3-indigo w3-padding" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">오프라인 매장 검색 / 삭제</span>
	   </div>
	  <form name="myform">
	    <select name="store_name" id="store_name">
	      <option value="">매장 선택</option>
	      <c:forEach var="aVO" items="${vos}">
 	        <option value="${aVO.store_name}" <c:if test="${aVO.store_name == vo.store_name}">selected</c:if>>${aVO.store_name}</option>
	      </c:forEach>
	    </select>
	    <input type="button" value="매장 검색" onclick="addressSearch()"/>
	    <input type="button" value="매장 삭제" onclick="addressDelete()"/>
	  </form>
	</div>
	<div class="text-dark">
		매장명 : ${vo.store_name} <br/>
		매장주소(도로명) : ${vo.rode_address} ${vo.detail_address} <br/>
		매장 전화번호 : ${vo.store_tel}
	</div>
	<hr/>
	<div id="map" style="width:100%;height:500px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=158c673636c9a17a27b67c95f2c6be5c"></script>
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(${vo.lat}, ${vo.lng}), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(${vo.lat}, ${vo.lng}); 
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
	// marker.setMap(null);    
	</script>
	<hr/>
<p><br/></p>
</body>
</html>