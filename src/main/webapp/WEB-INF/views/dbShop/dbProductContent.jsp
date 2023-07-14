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
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <title>dbProductContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
 	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
  	'use strict';
  	
  	$(document).ready(function() {
  	  $('#scrollButton').click(function() {
  	    $('html, body').animate({ scrollTop: 0 }, 'slow');
  	  });
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
   	  
   	  
  </script>
  <style>
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
   border: 1px solid skyblue;
   border-radius: 5px;
   padding: 16px 21px 16px 21px;
   margin : 11px 5px 10px 10px;
   display: inline-block;
   background-color : skyblue;
   color : white;
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
			<img src="${ctp}/dbShop/product/${productVO.FSName}" width="500px" height="500px" "/>
		</div>
		
		<div id="image2" class="mt-2 pl-5">
		<c:set var="FSName2" value="${fn:split(productVO.FSName2,'/')}" />
			<c:if test='${FSName2 != null || FSName2 != ""}'>
				<c:forEach  var="i" begin="0" end="${fn:length(FSName2)-1}">
					<span><img src="${ctp}/dbShop/product/${FSName2[i]}" onmouseover="document.getElementById('image1').innerHTML='<img src=${ctp}/dbShop/product/${FSName2[i]} width=500px; height=500px; />'" onmouseout="document.getElementById('image1').innerHTML='<img src=${ctp}/dbShop/product/${productVO.FSName} width=500px; height=500px; />'"" width="70px" height="70px" /></span>
				</c:forEach>
			</c:if>
		</div>
		
	</div>	
	
<div class="col pr-5">
<table class="table table-borderless">
	<tr>
		<c:if test="${productVO.productStatus == '품절'}">
			<td colspan="2" class="text-right"><h3><b>${productVO.productName}<span class="badge badge-danger ml-1">품절</span></b></h3><hr/></td>
		</c:if>
		<c:if test="${productVO.productStatus != '품절'}">
			<td colspan="2" class="text-right"><h3><b>${productVO.productName}</b></h3><hr/></td>
		</c:if>
	</tr>
	<tr>
		<td>가격</td>
		<td class="text-right"><h3><fmt:formatNumber value="${productVO.mainPrice}"/>원</h3></td>
	</tr>	
	<tr>
		<td></td>
		<c:set var="productDetail" value="${fn:split(productVO.detail,'/')}" />
			<td class="text-right">
				<c:forEach var="i" begin="0" end="${fn:length(productDetail)-1}">
					<span>#${productDetail[i]}</span>
				</c:forEach>
			</td>
	</tr>	
</table>
 
 <!-- 상품주문을 위한 옵션정보 출력 -->
  <div class="form-group">
    <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
      <select size="1" class="form-control" id="selectOption">
        <option value="" disabled selected>상품옵션선택</option>
        	<c:if test="${empty optionVOS}">
        		<option value="0/단일품목/${productVO.mainPrice}">단일품목</option>
        	</c:if>
        	<c:if test="${!empty optionVOS}">
		        <c:forEach var="vo" items="${optionVOS}">
		          <option value="${vo.idx}/${vo.optionName}/${vo.optionPrice}">${vo.optionName}</option>
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
			    <button class="btn btn-secondary pt-3 pb-3 pr-5 pl-5" ">&nbsp;&nbsp;&nbsp;장바구니&nbsp;&nbsp;&nbsp;</button>&nbsp;
			    <button class="btn btn-secondary pt-3 pb-3 pr-5 pl-5" ">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;품절&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>&nbsp;
		  	</c:if>
        <c:if test="${productVO.productStatus != '품절'}">
			    <button class="btn btn-outline-dark pt-3 pb-3 pr-5 pl-5" onclick="cart()">&nbsp;&nbsp;&nbsp;장바구니&nbsp;&nbsp;&nbsp;</button>&nbsp;
			    <button class="btn btn-outline-dark pt-3 pb-3 pr-5 pl-5" onclick="order()">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;주문하기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</button>&nbsp;
		  	</c:if>
		  </div>
		</div>
  </div>
  <br/><br/>
 </div>
 	
 <div class="container-fluid"> 
  <!-- 상품설명/리뷰/배송안내사항 -->
  <hr/>
  <div class="text-center">
  <button class="btn btn-outline-white btn-sm" onclick="scrollToSection1()">상품설명</button> |
  <button class="btn btn-outline-white btn-sm" onclick="scrollToSection3()">리뷰</button> |
  <button class="btn btn-outline-white btn-sm" onclick="scrollToSection2()">배송/교환/반품 안내</button>
  </div>
  <hr/>
  
  <section id="target-section1" style="margin: 0 auto;">
	  <div id="content" class="text-center"><br/>
	    ${productVO.content}
	  </div>
	</section>
</div>
<div class="container">
	<p><br/>
  <section id="target-section2">
	  <div id="content" class="text-center"><br/>
	   <!-- Nav tabs -->
		<ul class="nav nav-tabs" role="tablist">
      <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#guide1"><h6>상품결제정보</h6></a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#guide2"><h6>배송정보</h6></a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#guide3"><h6>교환 및 반품정보</h6></a></li>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div id="guide1" class="container tab-pane active text-left"><br/>
	      <p>
					고액결제의 경우 안전을 위해 카드사에서 확인전화를 드릴 수도 있습니다.</br>
					확인과정에서 도난 카드의 사용이나 타인 명의의 주문등 정상적인 주문이 아니라고 판단될 경우 임의로 주문을 보류 또는 취소할 수 있습니다.<br/>
					무통장 입금은 상품 구매 대금은 PC뱅킹, 인터넷뱅킹, 텔레뱅킹 혹은 가까운 은행에서 직접 입금하시면 됩니다.  <br/>
					주문 시 입력한 입금자명과 실제입금자의 성명이 반드시 일치하여야 하며, 7일 이내로 입금을 하셔야 하며 입금되지 않은 주문은 자동취소 됩니다.<br/>
					품질보증기준: 전자상거래 소비자 보호법에 의거하여 소비자 청약철회 가능한 기준에 따름.<br/>
					구매자가 미성년자일 경우 법정 대리인이 계약에 동의하지 않을 때 구매를 취소할 수 있습니다.<br/>
	      </p>
	      <hr/>
	    </div>
	    <div id="guide2" class="container tab-pane fade text-left"><br>
	      <p>
				배송 방법 : 택배<br/>
				배송 지역 : 전국지역<br/>
				배송 비용 : 2,500원<br/>
				배송 기간 : 2일 ~ 7일<br/>
				대부분 출고 다음날에 바로 도착하며 (주말 제외)<br/>
				지역 택배 기사님들의 일정과 기상상황에 따라 변동이 있을 수 있습니다.<br/>
				기본 배송 준비일은 입고지연 상품 제외, 2~5일 정도가 소요되고 있습니다.<br/>
				5만원 이상 결제시 무료배송 혜택이 추가됩니다.<br/>
	      </p>
	      <hr/>
	    </div>
	    <div id="guide3" class="container tab-pane fade text-left"><br>
	      <p>
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
			*불량상품의 재발송 시 왕복배송비는 [별이 빛나는 날에]에서 부담합니다.<br/>
	      </p>
	    <hr/>
	    </div>
	    
	   </div>
	  </div>
	</section>
	<p><br/></p>
	<p><br/></p>
	<p><br/></p>
	
	<!-- 리뷰 항목 -->
	<section id="target-section3" class="text-center">
	<div class="w3-row w3-border w3-round" style="width:1000px;">
	  <div class="w3-col w3-border s4 w3-light w3-center" style="height:100px"><p>별점 평점</p></div>
	  <div class="w3-col w3-border s4 w3-light w3-center" style="height:100px"><p>별점 많은순 그래프?</p></div>
	  <div class="w3-col w3-border s4 w3-light w3-center" style="height:100px"><p>베스트 후기 포인트 드림여</p></div>
	</div>
	
	<div class="w3-panel w3-border w3-round" style="width:1000px; height:100px; background-color:#eee;">
   악의 적인 리뷰는 조져버리는수가 있 어쩌구저저구<br/>
		상관없는 사진은 삭제해버릴거임<br/>
  </div>
	<div class="text-right mb-2" style="width:1000px;">
		최신등록순 | 평점높은순 | 평점낮은순 <br/>
	</div>
	
 	<table class="table-borderless" style="width:1000px;">
 		<c:forEach var="vo" items="${reviewVOS}">
	 		<tr><td colspan="3" style="border-bottom:1px solid lightgray"></td></tr>
	 		<tr class="text-dark" style="background-color:#eee;">
	 			<td style="width:20%; height:25%" class="text-center">
	 				<img src="${ctp}/images/mu.jpg" class="w3-circle" alt="mu" style="width:50px">
	 			</td>
	 			<td colspan="2" class="text-left">
	 				<font color="red"><b>
		 				<c:if test="${vo.score == 1}">★☆☆☆☆<br/></c:if>
		 				<c:if test="${vo.score == 2}">★★☆☆☆<br/></c:if>
		 				<c:if test="${vo.score == 3}">★★★☆☆<br/></c:if>
		 				<c:if test="${vo.score == 4}">★★★★☆<br/></c:if>
		 				<c:if test="${vo.score == 5}">★★★★★<br/></c:if>
	 				</b></font>
	 				${vo.mid} / ${fn:substring(vo.WDate,0,10)}<br/>
	 				<span class="badge badge-light mr-2">옵션</span><font size="2">${vo.productName}</font>
	 			</td>
	 		</tr>
	 		<tr><td colspan="3" style="border-bottom:1px solid lightgray"></td></tr>
	 		<tr>
	 			<td></td>
 				<td class="text-left">${vo.title}</td>
 			</tr>
 			<tr><td></td><td colspan="2" style="border-bottom:1px solid lightgray"></td></tr>
 			<tr>
 				<td></td>
 				<td class="text-left">
 					${vo.content}
 				</td>
 				<td class="mt-3 mb-3">	
 					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
 					<c:forEach var="fSName" items="${fSNames}" varStatus="st">
 						<img src="${ctp}/review/${fSName}" width="100px" /><br/>
 					</c:forEach>
 				</td>
 			</tr>
 			<tr><td colspan="3" style="border-bottom:1px solid lightgray"></td></tr>
 			<tr><td colspan="3" class="pb-5"></td></tr>
		 	</div>
 		</c:forEach>
 	</table>
	</section>
	<input type="button" class="button-fixed btn btn-outline-dark text-dark" id="scrollButton" value="top" />
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>