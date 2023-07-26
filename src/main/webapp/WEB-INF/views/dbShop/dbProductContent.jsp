<%@page import="org.springframework.http.StreamingHttpOutputMessage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>dbProductContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link rel="stylesheet" href="${ctp}/font/font.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<script src="https://kit.fontawesome.com/fa3667321f.js" crossorigin="anonymous"></script>
 	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
  	'use strict';
  	
  	$(document).ready(function() {
  	  $('#scrollButton').click(function() {
  	    $('html, body').animate({ scrollTop: 0 }, 'slow');
  	  });
  	    $("#imagesPlus").hide(); 
  	});
  	
  	
    let cnt = 1;
  	// 옵션박스에서, 옵션항목을 선택하였을때 처리하는 함수
    $(function(){
    	$("#selectOption").change(function(){
    		let selectOption = $(this).val().split("/");
    		let idx = selectOption[0];					
    		let optionName = selectOption[1];	
    		let optionPrice = selectOption[2];	
    		let commaPrice = numberWithCommas(optionPrice);	
    		let str = '';
    		str += '<div class="orderBox row" id="orderBox'+cnt+'"><div class="col">'+optionName+'</div>';
    		str += '<input type="number" class="text-center numBox" id="numBox'+cnt+'" name="optionNum" onchange="numChange('+cnt+')" value="1" min="1" max="10"/>&nbsp;';
    		str += '<input type="text" id="price1'+cnt+'" class="price" value="'+commaPrice+'" readonly />';
    		str += '<input type="hidden" id="price'+cnt+'" value="'+optionPrice+'"/> &nbsp;';	
    		str += '<input type="button" class="btn btn-outline-dark btn-sm ml-3" onclick="remove('+cnt+')" value="X"/>';
    		
    		str += '<input type="hidden" name="statePrice" id="statePrice'+cnt+'" value="'+optionPrice+'"/>';		/* 계산을 위한 고정값 */
    		str += '<input type="hidden" name="optionIdx" value="'+idx+'"/>';
    		str += '<input type="hidden" name="optionName" value="'+optionName+'"/>';
    		str += '<input type="hidden" name="optionPrice" value="'+optionPrice+'"/>';
    		str += '</div>';
    		$("#orders").append(str);
    		onTotal();
    		cnt++;
    	});
    });
  	
    
    // 등록(추가)시킨 옵션 상품 삭제
    function remove(cnt) {
  	  $("div").remove("#orderBox"+cnt);
  	  if($(".price").length) onTotal();
  	  else location.reload();
    }
    
    // 상품의 총 금액 (재)계산하기
    function onTotal() {
  	  let total = 0;
  	  for(let i=1; i<=cnt; i++) {
  		  if($("#orderBox"+i).length != 0) { // 선택된 옵션이 하나라도 있을 시 계산
  		  	total +=  parseInt(document.getElementById("price"+i).value);
  		  	document.getElementById("totalPriceResult").value = total;  		  	
  		  	document.getElementById("orderTotal").value = total; 
  		  }
  	  }
  	  document.getElementById("totalPrice").value = numberWithCommas(total); // 밑에 찍기만 하는 값
    }
    
    // 수량 변경
    function numChange(idx) {
    	let price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;
    	document.getElementById("price1"+idx).value = numberWithCommas(price);
    	document.getElementById("price"+idx).value = price;
    	onTotal();
    }
    
    // 장바구니 호출
    function cart() {
    	if('${sMid}' == "") {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${ctp}/member/memberLogin";
    	}
    	else if(document.getElementById("totalPrice").value==0) {
    		alert("옵션을 선택해주세요");
    		return false;
    	}
    	else {
    		document.myform.submit();
    	}
    }
    
    // 직접 주문하기
    function order() {
    	let totalPrice = document.getElementById("totalPrice").value;
    	let totalPriceResult = document.getElementById("totalPriceResult").value;
    	
     	if(totalPriceResult>=50000 || totalPriceResult==0){ // 바로 구매시 배송비 계산해서 심어주기
        document.getElementById("baesong").value=0;
      } else {
        document.getElementById("baesong").value=2500;
      }
     	
      let baesong = document.getElementById("baesong").value 
      document.getElementById("orderTotalPrice").value = Number(totalPriceResult) + Number(baesong); // 바로구매시 히든으로 보낼 총토탈값
      
    	if('${sMid}' == "") {
    		alert("로그인 후 이용 가능합니다.");
    		location.href = "${ctp}/member/memberLogin";
    	}
    	else if(totalPrice=="" || totalPrice==0) {
    		alert("옵션을 선택해주세요");
    		return false;
    	}
    	else {
    		document.getElementById("flag").value = "order";
    		document.myform.submit();
    	}
    }
    
    // 천단위마다 콤마를 표시해 주는 함수
    function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
    }
    
    // 상세설명/리뷰/안내사항
    function scrollToSection1() {
   	  const section = document.getElementById('target-section1');
   	  section.scrollIntoView({ behavior: 'smooth' });
    }
    function scrollToSection2() {
   	  const section = document.getElementById('target-section2');
   	  section.scrollIntoView({ behavior: 'smooth' });
    }
    function scrollToSection3() {
   	  const section = document.getElementById('target-section3');
   	  section.scrollIntoView({ behavior: 'smooth' });
    }
   	  
   	// 위시리스트 추가
   	function wishDBCheck(idx){
    	if(idx == "") idx = 0;
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/dbShop/wishCheck",
    		data  : {
    			idx  : idx,
				  productIdx : ${productVO.idx},
				  productName : '${productVO.productName}',
				  mid  : '${sMid}'
				},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류");
    		}
    	});
   	}  
   	  
   	function imagesClick(idx){
			$("#demo"+idx).slideDown(500);
   	}
   	
   	function imagesUp(idx){
   		$("#demo"+idx).slideUp(500);
   	}
   	
 	function reportReview(idx){
    let url = "${ctp}/dbShop/reviewReportChild?idx="+idx;
    let winName = "winName";
    let winWidth = 800;
    let winHeight = 400;
    let x = (screen.width/2) - (winWidth/2);
    let y = (screen.height/2) - (winHeight/2);
    let opt="width="+winWidth+", height="+winHeight+", left="+x+", top="+y;
    window.open(url,winName,opt);
 	}
   	
 	
 	
 	 document.addEventListener("DOMContentLoaded", function () {
 	    // 세션에서 상품 이름을 가져옵니다.
 	    const productName = '<%= session.getAttribute("productName") %>';

 	    // "productList" div에 상품 이름을 출력합니다.
 	    document.getElementById("productList").html = productName;
 	  });
    
 	
  </script>
  <style>

   .w3-custom-button {
    background-color: white;
    padding : 5px 0px 5px 0;
  }
  
 	.button-fixed {
  position: fixed;
  bottom: 20px; /* 원하는 여백 값으로 조정 가능 */
  right: 20px; /* 원하는 여백 값으로 조정 가능 */
	}
 
   .orderBox  {
     border-bottom:1px;
     width:100%;
     padding:10px;
     margin-left:1px;
     background-color:#fff;
   }
   .numBox {
  	 width:40px;
  	 border : 0px;
   
   }
   .price  {
     width:160px;
     background-color:#fff;
     text-align:right;
     font-size:1.2em;
     border:0px;
     outline: none;
   }
   .totalPrice {
     text-align:right;
     margin-right:10px;
     color:#f63;
     font-size:1.5em;
     font-weight: bold;
     border:0px;
     outline: none;
   }
   
   #wish2{
   border: 1px solid #000;
   border-radius: 5px;
   padding: 15px 20px 15px 20px;
   margin : 10px 5px 10px 10px;
   display: inline-block;
   }

   #wish{
   border: 1px solid #e0a494;
   border-radius: 5px;
   padding: 16px 21px 16px 21px;
   margin : 11px 5px 10px 10px;
   display: inline-block;
   background-color : #e0a494;
   color : white;
   }
   
   .prod{
   border : solid 1px #c0c0c2;
   border-radius : 4px;
   padding : 10px 15px 10px 15px;
   }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
 <div class="row mt-4">
 
	<div class="images" id="images">
		<div class="col pl-5 mt-3 text-right" id="image1">
			<img src="${ctp}/dbShop/product/${productVO.FSName}" width=500px; height=500px;/>
		</div>
		
		<div id="image2" class="mt-2 pl-5">
		<span><img src="${ctp}/dbShop/product/${productVO.FSName}" onmouseover="document.getElementById('image1').innerHTML='<img src=${ctp}/dbShop/product/${productVO.FSName} width=500px; height=500px; />'" width="70px" height="70px" /></span>
		<c:set var="FSName2" value="${fn:split(productVO.FSName2,'/')}" />
			<c:if test='${FSName2 != null || FSName2 != ""}'>
				<c:forEach  var="i" begin="0" end="${fn:length(FSName2)-1}">
					<span><img src="${ctp}/dbShop/product/${FSName2[i]}" onmouseover="document.getElementById('image1').innerHTML='<img src=${ctp}/dbShop/product/${FSName2[i]} width=500px; height=500px; />'" width="70px" height="70px" /></span>
				</c:forEach>
			</c:if>
		</div>
		
	</div>	
	
<div class="col pr-5">
<div class="text-left mt-3 mb-2">
<a href="${ctp}/dbShop/dbProductList">홈</a>
&nbsp;>&nbsp; 
<a href='${ctp}/dbShop/dbProductList?part=${mainVO.categoryMainName}'>${mainVO.categoryMainName}</a>
</div>
<div class="prod pb-4">
<table class="table table-borderless">
	<tr>
		<c:if test="${productVO.productStatus == '품절'}">
			<td colspan="2" class="text-right mb-0 pb-0"><h3><b>${productVO.productName}<span class="badge badge-danger ml-1">품절</span></b></h3><hr/></td>
		</c:if>
		<c:if test="${productVO.productStatus != '품절'}">
			<td colspan="2" class="text-right"><h3><b>${productVO.productName}</b></h3><hr/></td>
		</c:if>
	</tr>
	<tr>
		<td colspan="2" class="text-right mt-0 pt-0"><h3><fmt:formatNumber value="${productVO.mainPrice}"/>원</h3></td>
	</tr>	
	<tr>
		<c:set var="productDetail" value="${fn:split(productVO.detail,'/')}" />
			<td colspan="2" class="text-right">
				<c:forEach var="i" begin="0" end="${fn:length(productDetail)-1}">
					<span>#${productDetail[i]}</span>
				</c:forEach>
			</td>
	</tr>	
	<tr>
		<td colspan="2" class="text-right pt-0 pb-0">
			배송비 2,500원 (50,000이상 구매 시 무료배송)
		</td>
	</tr>
	<tr>
		<td colspan="2" class="text-center mb-2">		
			<div class="w3-panel w3-border" style="background-color:#fff;">
			<div class="w3-panel w3-border pt-3 pb-3" style="background-color:#dcdee3;">
  			<span><i class="fas fa-exclamation-circle"> 구매 적립 포인트 ${productVO.mainPrice*0.01} Point</i></span><br/>
				<span><i class="fas fa-exclamation-circle"> 리뷰 작성시 500 Point 추가 적립!</i></span>
	  	</div>
	  	</div>
  	</td>	
	</tr>
		</div>
</table>
 
 <!-- 상품주문을 위한 옵션정보 출력 -->
  <div class="form-group" style="width:95%; margin:0 auto;">
    <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
      <select size="1" class="form-control" id="selectOption">
        <option value="" disabled selected>상품옵션선택</option>
        	<c:if test="${empty optionVOS}">
        		<option value="0/단일품목/${productVO.mainPrice}">단일품목</option>
        	</c:if>
        	<c:if test="${!empty optionVOS}">
		        <c:forEach var="vo" items="${optionVOS}">
		        	<c:if test="${vo.optionStock == 0}">
		         	 <option value="${vo.idx}/${vo.optionName}/${vo.optionPrice}" disabled>${vo.optionName}[품절]</option>
		          </c:if>
		        	<c:if test="${vo.optionStock > 0}">
		         	 <option value="${vo.idx}/${vo.optionName}/${vo.optionPrice}">${vo.optionName}</option>
		          </c:if>
		        </c:forEach>
     	   </c:if>
      </select>
    </form>
  </div>
  <br/>
  <div>
	  <form name="myform" method="post">  <!-- 실제 상품의 정보를 넘겨주는 form -->
	    <input type="hidden" name="mid" value="${sMid}"/>
	    <input type="hidden" name="productIdx" value="${productVO.idx}"/>
	    <input type="hidden" name="productName" value="${productVO.productName}"/>
	    <input type="hidden" name="mainPrice" value="${productVO.mainPrice}"/>
	    <input type="hidden" name="thumbImg" value="${productVO.FSName}"/>
	    <input type="hidden" name="totalPrice" id="totalPriceResult"/>
	    <input type="hidden" name="flag" id="flag"/> <!-- 장바구니인지 바로 구매인지 구분을 위한 flag -->

		  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
	   	<input type="hidden" name="baesong" id="baesong" value="0"/>
		 	<input type="hidden" name="orderTotal" id="orderTotal"/>
		 	

	    <div id="orders"></div>
	  </form>
  </div>
		  <!-- 상품의 총가격(옵션포함가격) 출력처리 -->
		  <div>
		    <hr/>
		    <div class="text-right mr-3">
	        <b><input type="text" class="totalPrice text-right" id="totalPrice" value="<fmt:formatNumber value='0'/>" readonly />원</b>
		    </div>
		  </div>
		  <br/>
		  <!-- 위시리스트/장바구니/주문하기 처리 -->
		  <div class="text-center">
			  <a href="javascript:wishDBCheck(${wishVO.idx})">
          <c:if test="${!empty wishVO}"><font color="red"><span id="wish">❤</span></font></c:if>
          <c:if test="${empty wishVO}"><font color="black"><span id="wish2">❤</span></font></c:if>
        </a>
        <c:if test="${productVO.productStatus == '품절'}">
			    <button class="btn btn-outline-dark pt-3 pb-3" style="width:90px">장바구니</button>&nbsp;
			    <button class="btn btn-outline-dark pt-3 pb-3 pr-5 pl-5" style="width:300px; background-color:#bcc3d2;">품절</button>&nbsp;
		  	</c:if>
        <c:if test="${productVO.productStatus != '품절'}">
			    <button class="btn btn-outline-dark pt-3 pb-3" style="width:90px" onclick="cart()">장바구니</button>&nbsp;
			    <button class="btn btn-outline-light text-dark pt-3 pb-3 pr-5 pl-5" style="width:300px; background-color:#ded9d5;" onclick="order()">바로 결제</button>&nbsp;
		  	</c:if>
		  </div>
		</div>
  </div>
  <br/><br/>
 </div>
 </div>
 	<p><br/></p>
 	<p><br/></p>
 	<p><br/></p>
 <div class="container-fluid"> 
  <!-- 상품설명/리뷰/배송안내사항 -->
  
	<div class="w3-padding text-center" style="margin-bottom:20px; background-color:#ded9d5; width:1050px; margin:0 auto;">
	  <div class="text-center">
	  <button class="btn btn-outline-white btn-sm" onclick="scrollToSection1()"><b>상품설명</b></button> &nbsp;|&nbsp;
	  <button class="btn btn-outline-white btn-sm" onclick="scrollToSection3()"><b>리뷰</b></button> &nbsp;|&nbsp;
	  <button class="btn btn-outline-white btn-sm" onclick="scrollToSection2()"><b>배송/교환/반품 안내</b></button>
	  </div>
	</div>
  
 <section id="target-section1" style="margin: 0 auto;">
  <div id="content" class="text-center" style="margin-top:50px;"><br/>
    ${productVO.content}
  </div>
</section>

</div>
<div class="container" style="width:1100px;">
	<p><br/>
<section id="target-section2">
<div class="w3-padding text-center pl-2 ml-2" style="margin-bottom:20px; background-color:#ded9d5; width:1050px; margin:0 auto;">
  <div class="text-center">배송/교환/반품 안내</div>
</div>
<button onclick="myFunction('Demo1')" class="btn btn-outline-light text-dark w3-block w3-light w3-left-align w3-custom-button pt-3 pb-5 pl-2 ml-2" style="border-bottom:solid 1px #bca6a0; padding:5px 0px 5px 0px; background-color:#white; width:1050px;height:30px;"> &nbsp; 상품 결제 정보</button>
<div id="Demo1" class="w3-container w3-hide">
  <br/>
  고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다.</br>
	확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.<br/>
	무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.  <br/>
	주문 시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.<br/>
	품질보증기준: 전자상거래 소비자 보호법에 의거하여 소비자 청약철회 가능한 기준에 따름.<br/>
	구매자가 미성년자일 경우 법정 대리인이 계약에 동의하지 않을 때 구매를 취소할 수 있습니다.<br/>
	  <br/>
</div>

<button onclick="myFunction('Demo2')" class="btn btn-outline-light text-dark w3-block w3-light w3-left-align w3-custom-button pt-3 pb-5  pl-2 ml-2 " style="border-bottom:solid 1px #bca6a0; padding:5px 0px 5px 0px; background-color:#white; width:1050px;height:30px;"> &nbsp; 배송정보</button><div id="Demo2" class="w3-container w3-hide">
  <br/> <p>
	배송 방법 : 택배<br/>
	배송 지역 : 전국지역<br/>
	배송 비용 : 2,500원<br/>
	배송 기간 : 2일 ~ 7일<br/>
	대부분 출고 다음날에 바로 도착하며 (주말 제외)<br/>
	지역 택배 기사님들의 일정과 기상상황에 따라 변동이 있을 수 있습니다.<br/>
	기본 배송 준비일은 입고지연 상품 제외, 2~5일 정도가 소요되고 있습니다.<br/>
	5만원 이상 결제시 무료배송 혜택이 추가됩니다.<br/>
  </p>
    <br/>
</div>
<button onclick="myFunction('Demo3')" class="btn btn-outline-light text-dark w3-block w3-light w3-left-align w3-custom-button pt-3 pb-5  pl-2 ml-2" style="border-bottom:solid 1px #bca6a0; padding:5px 0px 5px 0px; background-color:#white; width:1050px;height:30px;"> &nbsp; 교환 및 반품정보</button>
<div id="Demo3" class="w3-container w3-hide">
  <br/><p>
	[교환/반품 안내]<br/>
	물품 수령 후(택배 도착일자 기준) 7일 이내에 신청해주세요/<br/>
	사전에 신청해 주신 상품에 한해서만 교환/반품이 가능합니다. <br/>
	<p>
	*패킹하여 보내실 때는 물품 수령시와 동일하게 포장해 주세요.<br/>
	택에 손상이 있는 경우에는 반품과 교환이 모두 불가합니다.<br/>
	성함,주소,전화번호,보내시는 상품,사유등 반품카드 양식에 맞게 적어 보내주셔야 처리가 가능합니다.<br/>
	<br/>
	[교환반품 불가사항]<br/>
	-상품 수령 후 7일 이상 경과된 경우<br/>
	-상품 구매시 교환/환불 불가능이 명시되어 있는경우<br/>
	-사용 흔적(집냄새,향수냄새,체취) / 텍 제거 및 바코드 훼손, 오염이 발견된 상품<br/>
	-라벨, 태그 등 상품의 포장재 또는 구성품이 훼손된 상품<br/>
	*불량상품의 재발송 시 왕복배송비는 본사측에서 부담합니다.<br/>
  </p>
  <br/>
</div>
<script>
function myFunction(id) {
  var x = document.getElementById(id);
  if (x.className.indexOf("w3-show") == -1) {
    x.className += " w3-show";
  } else { 
    x.className = x.className.replace(" w3-show", "");
  }
}
</script>
</section>
	
	<p><br/></p>
	<p><br/></p>
	<p><br/></p>
	
	<!-- 리뷰 항목 -->
	<section id="target-section3" class="text-center">
	  <div class="text-center mb-3"><h1>Review</h1></div>
	</div>
	<div class="pt-4 pb-4" style="width:1050px; height:150px; background-color:#eee; margin:0 auto;">
    <table class="table text-dark text-center">
	    <tr class="table text-dark text-center">
	    	<td>
		    악의 적인 리뷰는 사전 안내 없이 삭제 될 수 있습니다.<br/>
				상품과 관련이 없는 사진의 경우 삭제 될 수 있습니다.<br/>
				베스트 리뷰에 선정된 리뷰에는 1000point가 지급됩니다.<br/>
				<p><br/></p>
				</td>
			</tr>
		</table>
  </div>
 </section>
 

 <c:if test="${empty reviewVOS}"><div class="text-center mb-3">
 
 <div class="w3-padding text-center mt-3 mb-5" style="margin-bottom:20px; background-color:#ded9d5; width:1050px; height:40px; margin:0 auto;"></div>
 작성된 후기가 없습니다. 첫번째 후기를 남겨보세요!</div>
 
 </c:if> 
 <c:forEach var="vo" items="${reviewVOS}">
 <c:if test="${vo.bestReview == 'OK'}">
 	<div class="w3-padding text-center mt-3 mb-5" style="margin-bottom:20px; background-color:#ded9d5; width:1050px; height:40px; margin:0 auto;"></div>
 	<div class="w3-panel w3-border w3-round mt-4" style="width:1050px; margin:0 auto;">
 	<table class="table-borderless mb-5" style="width:1000px; margin:0 auto;">
 		<tr><td colspan="3" class="p-0 m-0 mt-2 pt-3 text-center"><b>BEST REVIEW</b></td></tr>
 		<tr><td colspan="3" class="p-0 m-0 mb-4 pb-3" style="border-bottom :solid 1px lightgray"></td></tr>
	 		<tr class="text-dark" style="background-color:#fff;">
	 			<td style="width:20%"; class="text-center">
	 				<img src="${ctp}/images/mu.jpg" class="w3-circle" alt="mu" style="width:70px">
	 			</td>
	 			<td colspan="1" class="text-left pt-3 pb-2" style="width:60%";>
	 				<b>
		 				<c:if test="${vo.score == 1}">💙🤍🤍🤍🤍 &nbsp;<span class="badge badge-danger">베스트 리뷰에 선정된 리뷰입니다.</span><br/></c:if>
		 				<c:if test="${vo.score == 2}">💙💙🤍🤍🤍 &nbsp;<span class="badge badge-danger">베스트 리뷰에 선정된 리뷰입니다.</span><br/></c:if>
		 				<c:if test="${vo.score == 3}">💙💙💙🤍🤍 &nbsp;<span class="badge badge-danger">베스트 리뷰에 선정된 리뷰입니다.</span><br/></c:if>
		 				<c:if test="${vo.score == 4}">💙💙💙💙🤍 &nbsp;<span class="badge badge-danger">베스트 리뷰에 선정된 리뷰입니다.</span><br/></c:if>
		 				<c:if test="${vo.score == 5}">💙💙💙💙💙 &nbsp;<span class="badge badge-danger">베스트 리뷰에 선정된 리뷰입니다.</span><br/></c:if>
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
	 	<tr><td colspan="3" class="m-0 p-0 text-center"><div id="demo${vo.idx}"  style="display:none">
	 		<c:forEach var="fSName" items="${fSNames}" varStatus="st">
 				<img src="${ctp}/review/${fSName}" width="300px" height="300"/>
 			</c:forEach>
 			<br/>
 			<input type="button" value="이미지 접기" onclick="imagesUp('${vo.idx}')" class="btn btn-outline-dark btn-sm text-right mt-3"/>
 			<tr><td colspan="3" class="p-0 m-0 mt-2 pt-3" style="border-bottom :solid 1px lightgray"></td></tr>
	 	</div></td></tr>
 	</table>
 	</div>
 	</c:if>
 </c:forEach>
 
 <c:forEach var="vo" items="${reviewVOS}">
 <c:if test="${vo.reportNum != 5}">
 <c:if test="${vo.bestReview == 'NO'}">
 	<table class="table-borderless mb-5" style="width:1050px; margin:0 auto;">
 		<tr><td colspan="3" class="p-0 m-0 mt-2 pt-3 pb-3 mb-3" style="border-bottom :solid 1px lightgray"></td></tr>
 		<tr><td colspan="3" class="text-right pr-0 mt-2 pt-2"><input type="button" value="신고" onclick="reportReview('${vo.idx}')" class="btn btn-outline-danger btn-sm" /></td></tr>
	 		<tr class="text-dark" style="background-color:#fff;">
	 			<td style="width:20%"; class="text-center">
	 				<img src="${ctp}/images/member.png" class="w3-circle" alt="mu" style="width:100px">
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
	 	<tr><td colspan="3" class="m-0 p-0 text-center"><div id="demo${vo.idx}"  style="display:none">
	 		<c:forEach var="fSName" items="${fSNames}" varStatus="st">
 				<img src="${ctp}/review/${fSName}" width="300px" height="300"/>
 			</c:forEach>
 			<br/>
 			<input type="button" value="이미지 접기" onclick="imagesUp('${vo.idx}')" class="btn btn-outline-dark btn-sm text-center mt-3"/>
 			<tr><td colspan="3" class="p-0 m-0 mt-2 pt-3" style="border-bottom :solid 1px lightgray"></td></tr>
	 	</div></td></tr>
 	</table>
 	</c:if>
 </c:if>
 <c:if test="${vo.reportNum == 5}">
 <c:if test="${vo.bestReview == 'NO'}">
 	<table class="table-borderless" style="width:1050px; margin:0 auto;">
 		<tr><td colspan="3" class="p-0 m-0 mt-2 pt-3 pb-3 mb-3" style="border-bottom :solid 1px lightgray"></td></tr>
	 		<tr class="text-dark" style="background-color:#fff;">
	 			<td style="width:20%"; class="text-center">
	 				<img src="${ctp}/images/member.png" class="w3-circle" alt="mu" style="width:100px">
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
	 				<b></b><br/>
	 				<font color="red">신고로 숨겨진 리뷰입니다.</font>
				<td class="mt-3 mb-3" style="width:20%";>	
 				</td>
 			</tr>
		 	</div>
	 	<tr><td colspan="3" class="m-0 p-0"><div id="demo${vo.idx}"  style="display:none">
	 		<c:forEach var="fSName" items="${fSNames}" varStatus="st">
 			</c:forEach>
 			<br/>
 			<tr><td colspan="3" class="p-0 m-0 mt-2 pt-3" style="border-bottom :solid 1px lightgray"></td></tr>
	 	</div></td></tr>
 	</table>
 	</c:if>
 
 </c:if>
 </c:forEach>

 

	
	
 <div id="productList" class="text-center pt-2" style="position: fixed; left: 20px; top: 60%; transform: translateY(-50%); width:100px; height:400px; background-color:#eee;">
	<div class="text-center mb-3">
	  <font size="1">[최근 본 상품]</font>
	</div>
	<c:forEach var="item" items="${proList2}">
	  <c:set var="vo" value="${fn:split(item, '/')}" />
	  <div class="mb-3">
	    <a href="${ctp}/dbShop/dbProductContent?idx=${vo[1]}">
	      <img src="${ctp}/dbShop/product/${vo[0]}" width="70px" height="70px"/>
	    </a>
	  </div>
	</c:forEach>
  </div>
	
	<input type="button" class="button-fixed btn btn-outline-dark text-dark" id="scrollButton" value="top" />
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>