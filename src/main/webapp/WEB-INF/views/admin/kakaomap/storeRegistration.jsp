<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>storeRegistration.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
    function addressSave() {
    	var selectAddress = myform.selectAddress.value;
    	var latitude = myform.latitude.value;
    	var longitude = myform.longitude.value;
    	
    	if(latitude == "" || longitude == "") {
    		alert("저장할 지점을 선택하세요");
    		myform.selectAddress.focus();
    		return false;
    	}
    	
    	var query = {
    			address  : selectAddress,
    			latitude : latitude,
    			longitude: longitude
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/admin/kakaomap/kakaoRegistration",
    		data  : query,
    		success:function(res) {
  			  alert("선택한 지점이 DB에 저장되었습니다.");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	})
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
<div class="w3-main w3-collapse" style="margin-left:10px;margin-top:10px;">
	<div class="w3-row-padding w3-margin-bottom">
	 <!-- Header -->
	 <header style="padding-top:22px">
		<div class="w3-bottombar w3-light-gray w3-padding" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">오프라인 매장 등록</span>
	   </div>
	 </header>
		<div id="map" style="width:1060px;height:500px;position:relative;overflow:hidden;"></div>
		<div id="clickLatlng" style="display:none"></div>
	    <div class="hAddr">
       	 	<span class="title">지도중심기준 행정동 주소정보</span>
        	<span id="centerAddr"></span>
    	</div>
		<div style="margin:20px;">
			<div class="w3-half">
				<div id="searchForm">
					<label><i class="fa-solid fa-location-dot"></i> 등록할 매장 주소를 입력하세요</label><br>
					<div class="input-group">
						<input type="text" class="input w3-padding-16 w3-border form-control" onkeyup="enterkey()" id="inputAddress" placeholder="주소 입력""/>
						<div class="input-group-append">
							<input type="button" value="검색" onclick="search()" class="w3-black"/>
						</div>
					</div>
				</div>
				<div id="inforForm" style="display:none">
					<label><i class="fa-solid fa-arrow-pointer"></i> 지도 위에 표시된 매장 위치를 클릭하세요.</label><br>
					<a type="button" class="w3-btn w3-gray w3-round-large w3-padding-small" href="/javagreenS_ljs/admin/offlineStoreInsert">다시 검색</a>
				</div>
				<form name="offlineStoreInsertForm" method="post" action="${ctp}/admin/kakaomap/storeRegistration">
					<div id="insertForm" style="display:none">
						<div>
							<label><i class="fa-solid fa-location-dot"></i> 매장 이름 : </label>
							<input type="text" class="input w3-padding-16 w3-border form-control" id="store_name" style="width:40%" name="store_name"/>
						</div>
						<div class="mt-2">
							<label><i class="fa-solid fa-location-dot"></i> 상세 주소(도로명) : </label>
							<input type="text" class="input w3-padding-16 w3-border form-control" id="detail_address" style="width:60%" name="detail_address"/>
						</div>
						<label class="mt-2"><i class="fa-solid fa-location-dot"></i>매장 전화번호 : </label>
						<div class="input-group mb-3">
						      <div class="input-group-prepend">
							      <select name="tel1" id="tel1" class="w3-select w3-border">
								    <option value="010" selected>010</option>
								    <option value="02">02</option>
								    <option value="031">031</option>
								    <option value="032">032</option>
								    <option value="041">041</option>
								    <option value="042">042</option>
								    <option value="043">043</option>
							        <option value="051">051</option>
							        <option value="052">052</option>
							        <option value="055">055</option>
							        <option value="061">061</option>
							        <option value="062">062</option>
								  </select>
							 		<span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span> <span>&nbsp; &nbsp;</span>
						      </div>
						      <input type="text" name="tel2" id="tel2" size=8 maxlength=4 class="w3-border"/><span>&nbsp; &nbsp;</span><span style="margin-top:6px">-</span><span>&nbsp; &nbsp;</span>
						      <input type="text" name="tel3" id="tel3" size=8 maxlength=4 class="w3-border"/>&nbsp; &nbsp;
						</div> 
						<div>
						  	<input type="button" class="w3-btn w3-lime w3-round-large w3-padding-small" value="등록" onclick="offlineStoreInsert()">&nbsp; &nbsp;
						</div>
						<input type="hidden" name="lat" id="lat"/>
						<input type="hidden" name="lng" id="lng"/>
						<input type="hidden" name="rode_address" id="rodeAddress"/>
						<input type="hidden" name="store_name" id="store_name"/>
						<input type="hidden" name="address" id="address"/>
						<input type="hidden" name="store_tel" id="store_tel"/>
					</div>
				</form>
				<br>
				<p><br></p>
			</div>
			<div class="w3-half pl-5">
				<div class="mb-2">
					<i class="fa-solid fa-circle-info"></i> 매장 등록<br>
				</div>
				<div>
					1. 매장 주소를 입력한다.<br>
					2. 매장 위치를 지도 상에서 선택한다.<br>
					3. 매장 정보를 입력 후 등록 버튼을 클릭한다.<br>
				</div>
			</div>
		</div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=158c673636c9a17a27b67c95f2c6be5c&libraries=services"></script>
		<script>
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		        level: 1 // 지도의 확대 레벨
		    };
	
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
			
			search('사직대로 109');
					
			// 지도를 클릭한 위치에 표출할 마커입니다
			var marker = new kakao.maps.Marker({ 
			    // 지도 중심좌표에 마커를 생성합니다 
			    position: map.getCenter() 
			}); 
			// 지도에 마커를 표시합니다
			marker.setMap(map);
	
			// 지도에 클릭 이벤트를 등록합니다
			// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
			    
			    // 클릭한 위도, 경도 정보를 가져옵니다 
			    var latlng = mouseEvent.latLng; 
			    
			    // 마커 위치를 클릭한 위치로 옮깁니다
			    marker.setPosition(latlng);
			    
			    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			    message += '경도는 ' + latlng.getLng() + ' 입니다';
			    
			    var resultDiv = document.getElementById('clickLatlng'); 
			    resultDiv.innerHTML = message;
			    
			    $("#lat").val(latlng.getLat());
			    $("#lng").val(latlng.getLng());
			    
			});
			
			function search(addr) {
				if (addr == null || addr == '') {
					addr = $("#inputAddress").val();
					
					$("#searchForm").attr('style', 'display:none');
					$("#inforForm").attr('style', 'display:block');
				}
				
				
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch(addr, function(result, status) {
				
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
				
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				
				         // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new kakao.maps.Marker({
				            map: map,
				            position: coords
				        });
					
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
 				       /*  var infowindow = new kakao.maps.InfoWindow({
				            content: '<div style="width:150px;text-align:center;padding:6px 0;">검색하신 위치입니다.</div>'
				        });
				        infowindow.open(map, marker); */
				        
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				    } 
				});
			}
			
	
			// 주소-좌표 변환 객체를 생성합니다
			var geocoder = new kakao.maps.services.Geocoder();
	
			var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
			    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
			// 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
			searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	
			// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			    searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
			        if (status === kakao.maps.services.Status.OK) {
			            var detailAddr = !!result[0].road_address ? '<div>도로명주소 : ' + result[0].road_address.address_name + '</div>' : '';
			            detailAddr += '<div class="w3-white">지번 주소 : ' + result[0].address.address_name + '</div>';
			            
			            var content = '<div class="bAddr">' +
			                            '<span class="title">주소정보</span>' + 
			                            detailAddr + 
			                        '</div>';
	
			            // 마커를 클릭한 위치에 표시합니다 
			            marker.setPosition(mouseEvent.latLng);
			            marker.setMap(map);
	
			            // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
			            infowindow.setContent(content);
			            infowindow.open(map, marker);
			            
			            $("#rodeAddress").val(result[0].road_address.address_name);
			            $("#address").val(result[0].address.address_name);
			            
			            $("#searchForm").attr('style', 'display:none');
						$("#inforForm").attr('style', 'display:none');
						$("#insertForm").attr('style', 'display:block');
			        }   
			    });
			});
	
			// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
			kakao.maps.event.addListener(map, 'idle', function() {
			    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
			});
	
			function searchAddrFromCoords(coords, callback) {
			    // 좌표로 행정동 주소 정보를 요청합니다
			    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
			}
	
			function searchDetailAddrFromCoords(coords, callback) {
			    // 좌표로 법정동 상세 주소 정보를 요청합니다
			    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
			}
	
			// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
			function displayCenterInfo(result, status) {
			    if (status === kakao.maps.services.Status.OK) {
			        var infoDiv = document.getElementById('centerAddr');
	
			        for(var i = 0; i < result.length; i++) {
			            // 행정동의 region_type 값은 'H' 이므로
			            if (result[i].region_type === 'H') {
			                infoDiv.innerHTML = result[i].address_name;
			                break;
			            }
			        }
			    }    
			}
			
			function offlineStoreInsert() {
				let detail_address = $("#detail_address").val();
				let store_name = $("#store_name").val();
				let rode_address = $("#rodeAddress").val();
				
				let tel1 = $("#tel1").val();
			  let tel2 = $("#tel2").val();
			  let tel3 = $("#tel3").val();
			  let tel = tel1 + "-" + tel2 + "-" + tel3;
		    	
		    	let lat = $("#lat").val();
		    	let lng = $("#lng").val();
		    	
		    	
		    	//offlineStoreInsertForm.submit();
		    	
	    	var query = {
	    			lat  : lat,
	    			lng : lng,
	    			store_name: store_name,
	    			detail_address: detail_address,
	    			rode_address: rode_address,
	    			store_tel: tel
    		}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/admin/kakaomap/kakaoRegistration",
    		data  : query,
    		success:function(res) {
  			  alert("선택한 지점이 DB에 저장되었습니다.");
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	})
		    	
		    	
		    	
			}
			
			function enterkey() {
				if (window.event.keyCode == 13) {
					 search();
			    }
			}
			</script>
  
  
	<hr/>
</div>
<p><br/></p>
</body>
</html>