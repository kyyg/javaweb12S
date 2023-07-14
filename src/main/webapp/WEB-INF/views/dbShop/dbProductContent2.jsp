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
  <title>dbProductContent.jsp(상품정보 상세보기)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
  	'use strict';
  	
  	let idxArray = new Array();		/* 배열의 개수 지정없이 동적배열로 설정하고있다. */
    
  	// 옵션박스에서, 옵션항목을 선택하였을때 처리하는 함수
    $(function(){
    	$("#selectOption").change(function(){
    		let selectOption = $(this).val();
    		let idx = selectOption.substring(0,selectOption.indexOf(":"));					// 현재 옵션의 고유번호
    		let optionName = selectOption.substring(selectOption.indexOf(":")+1,selectOption.indexOf("_"));	// 옵션명
    		let optionPrice = selectOption.substring(selectOption.indexOf("_")+1);	// 옵션가격
    		let commaPrice = numberWithCommas(optionPrice);			// 콤마붙인 가격
    		
    		// 선택박스의 내용을 한개라도 선택하게된다면 선택된 옵션의 '고유번호/옵션명/콤마붙인가격'을 화면에 출력처리해준다.
    		if($("#orderBox"+idx).length == 0 && selectOption != "") {		// 옵션이 하나라도 있으면 처리하게 된다.
    		  idxArray[idx] = idx;
    		  
	    		let str = '';
	    		str += '<div class="orderBox row" id="orderBox'+idx+'"><div class="col">'+optionName+'</div>';
	    		str += '<input type="number" class="text-center numBox" id="numBox'+idx+'" name="optionNum" onchange="numChange('+idx+')" value="1" min="1" max="10"/> &nbsp;';
	    		str += '<input type="text" id="imsiPrice'+idx+'" class="price" value="'+commaPrice+'" readonly />';
	    		str += '<input type="hidden" id="price'+idx+'" value="'+optionPrice+'"/> &nbsp;';			/* 변동되는 가격을 재계산하기위해 price+idx 아이디를 사용하고 있다. */
	    		str += '<input type="button" class="btn btn-outline-dark btn-sm" onclick="remove('+idx+')" value="삭제"/>';
	    		
	    		str += '<input type="hidden" name="statePrice" id="statePrice'+idx+'" value="'+optionPrice+'"/>';		/* 현재상태에서의 변경된 상품(옵션)의 가격이다. */
	    		str += '<input type="hidden" name="optionIdx" value="'+idx+'"/>';
	    		str += '<input type="hidden" name="optionName" value="'+optionName+'"/>';
	    		str += '<input type="hidden" name="optionPrice" value="'+optionPrice+'"/>';
	    		str += '</div>';
	    		$("#orders").append(str);
	    		onTotal();
    	  }
    	  else {
    		  alert("이미 선택한 옵션입니다.");
    	  }
    	});
    });
    
    // 등록(추가)시킨 옵션 상품 삭제하기
    function remove(idx) {
  	  $("div").remove("#orderBox"+idx);
  	  
  	  // 옵션내역이 1개라도 있으면 가격을 재계산하고, 없으면 reload한다.
  	  // if(document.getElementsByTagName('optionNum')[0].hasAttribute('type')) onTotal();
  	  // if(document.getElementsByTagName('optionNum')) onTotal();
  	  // if(document.getElementsByName('optionNum')) onTotal();
  	  if($(".price").length) onTotal();
  	  else location.reload();
    }
    
    // 상품의 총 금액 (재)계산하기
    function onTotal() {
  	  let total = 0;
  	  for(let i=0; i<idxArray.length; i++) {
  		  if($("#orderBox"+idxArray[i]).length != 0) {
  		  	total +=  parseInt(document.getElementById("price"+idxArray[i]).value);
  		  	document.getElementById("totalPriceResult").value = total;
  		  }
  	  }
  	  document.getElementById("totalPrice").value = numberWithCommas(total);
    }
    
    // 수량 변경시 처리하는 함수
    function numChange(idx) {
    	let price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;
    	document.getElementById("imsiPrice"+idx).value = numberWithCommas(price);
    	document.getElementById("price"+idx).value = price;
    	onTotal();
    }
    
    // 장바구니 호출시 수행함수
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
    .orderBox  {
      border:0px;
      width:100%;
      padding:10px;
      margin-left:1px;
      background-color:#eee;
    }
    .numBox {
   	 width:40px;
   	 border : 0px;
    
    }
    .price  {
      width:160px;
      background-color:#eee;
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
    border: 1px solid pink;
    border-radius: 5px;
    padding: 16px 21px 16px 21px;
    margin : 11px 5px 10px 10px;
    display: inline-block;
    background-color : pink;
    color : white;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
 <div class="row mt-4">
	<div class="col pl-5 mt-3 text-right">
		<img src="${ctp}/dbShop/product/${productVO.FSName}" width="100%"/>
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
		<td>작가</td>
		<td class="text-right">${productVO.detail}</td>
	</tr>	
</table>
 
 <!-- 상품주문을 위한 옵션정보 출력 -->
  <div class="form-group">
    <form name="optionForm">  <!-- 옵션의 정보를 보여주기위한 form -->
      <select size="1" class="form-control" id="selectOption">
        <option value="" disabled selected>상품옵션선택</option>
        <option value="0:기본품목_${productVO.mainPrice}">기본품목</option>
        <c:forEach var="vo" items="${optionVOS}">
          <option value="${vo.idx}:${vo.optionName}_${vo.optionPrice}">${vo.optionName}</option>
        </c:forEach>
      </select>
    </form>
  </div>
  <br/>
  <div>
	  <form name="myform" method="post">  <!-- 실제 상품의 정보를 넘겨주기 위한 form -->
	    <input type="hidden" name="mid" value="${sMid}"/>
	    <input type="hidden" name="productIdx" value="${productVO.idx}"/>
	    <input type="hidden" name="productName" value="${productVO.productName}"/>
	    <input type="hidden" name="mainPrice" value="${productVO.mainPrice}"/>
	    <input type="hidden" name="thumbImg" value="${productVO.FSName}"/>
	    <input type="hidden" name="totalPrice" id="totalPriceResult"/>
	    <input type="hidden" name="flag" id="flag"/>
	    <div id="orders"></div>
	  </form>
  </div>
		  <!-- 상품의 총가격(옵션포함가격) 출력처리 -->
		  <div>
		    <hr/>
		    <span class="text-right"><font size="4" color="black">총 결제금액</font></span>
		    <span class="text-right">
		    	<!-- 아래의 id와 class이름인 totalPrice는 출력용으로 보여주기위해서만 사용한것으로 값의 전송시와는 관계가 없다. -->
	        <b><input type="text" class="totalPrice text-right" id="totalPrice" value="<fmt:formatNumber value='0'/>" readonly /></b>
		    </span>
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
  <!-- 상품 상세설명 보여주기 -->
  <hr/>
  <div class="text-center">
  <button class="btn btn-outline-white btn-sm" onclick="scrollToSection1()">상품설명</button> |
  <button class="btn btn-outline-white btn-sm" onclick="scrollToSection2()">리뷰</button> |
  <button class="btn btn-outline-white btn-sm" onclick="scrollToSection3()">배송/교환/반품 안내</button>
  </div>
  <hr/>
  
  <section id="target-section1">
	  <div id="content" class="text-center"><br/>
	    ${productVO.content}
	  </div>
	</section>
	<p><br/>
  <section id="target-section3">
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
	    </div>
	    <div id="guide3" class="container tab-pane fade text-left"><br>
	      <p>
			[교환/반품 안내]<br/>
			물품 수령 후(택배 도착일자 기준) 7일 이내에 [MY PAGE]-[ORDER LIST] 에서 직접 접수 또는 '실시간 문의'로 접수해 주세요.<br/>
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
			*불량상품의 재발송 시 왕복배송비는 더뮤지엄이 부담합니다.<br/>
	      </p>
	    </div>
	    
	   </div>
	  </div>
	</section>
	 <section id="target-section2">
  ==============================================================
	  리뷰
	</section>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>