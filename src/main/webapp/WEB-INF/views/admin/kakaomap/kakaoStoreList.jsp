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
<div class="container">
	<hr/>
	<div>
	  <form name="myform">
	    <select name="store_name" id="store_name">
	    <h3 class="text-center">등록된 매장 검색 / 삭제</h3>
	      <option value="">매장 선택</option>
	      <c:forEach var="aVO" items="${vos}">
 	        <option value="${aVO.store_name}" <c:if test="${aVO.store_name == vo.store_name}">selected</c:if>>${aVO.store_name}</option>
	      </c:forEach>
	    </select>
	    <input type="button" value="매장 검색" onclick="addressSearch()"/>
	    <input type="button" value="매장 삭제" onclick="addressDelete()"/>
	  </form>
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