<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOrder.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
  <script>
	  $(document).ready(function(){
		  $(".nav-tabs a").click(function(){
		    $(this).tab('show');
		  });
		  $('.nav-tabs a').on('shown.bs.tab', function(event){
		    var x = $(event.target).text();         // active tab
		    var y = $(event.relatedTarget).text();  // previous tab
		  });
		});
  
	  // 결제하기
    function order() {
		  var paymentCard = document.getElementById("paymentCard").value;
    	var payMethodCard = document.getElementById("payMethodCard").value;
		  var paymentBank = document.getElementById("paymentBank").value;
    	var payMethodBank = document.getElementById("payMethodBank").value;
    	if(paymentCard == "" && paymentBank == "") {
    		alert("결제방식과 결제번호를 입력하세요.");
    		return false;
    	}
    	if(paymentCard != "" && payMethodCard == "") {
    		alert("카드번호를 입력하세요.");
    		document.getElementById("payMethodCard").focus();
    		return false;
    	}
    	else if(paymentBank != "" && payMethodBank == "") {
    		alert("입금자명을 입력하세요.");
    		return false;
    	}
    	var ans = confirm("결제 하시겠습니까?");
    	if(ans) {
    		if(paymentCard != "" && payMethodCard != "") {
    			document.getElementById("payment").value = "C"+paymentCard;
    			document.getElementById("payMethod").value = payMethodCard;
    		}
    		else {
    			document.getElementById("payment").value = "B"+paymentBank;
    			document.getElementById("payMethod").value = payMethodBank;
    		}
	    	myform.action = "${ctp}/dbShop/payment";
	    	myform.submit();
    	}
    }
	  
	  
	  function order2(){
		  var paymentCard = document.getElementById("paymentCard").value;
	    	var payMethodCard = document.getElementById("payMethodCard").value;
			  var paymentBank = document.getElementById("paymentBank").value;
	    	var payMethodBank = document.getElementById("payMethodBank").value;
	    	if(paymentCard == "" && paymentBank == "") {
	    		alert("결제방식과 결제번호를 입력하세요.");
	    		return false;
	    	}
	    	if(paymentCard != "" && payMethodCard == "") {
	    		alert("카드번호를 입력하세요.");
	    		document.getElementById("payMethodCard").focus();
	    		return false;
	    	}
	    	else if(paymentBank != "" && payMethodBank == "") {
	    		alert("입금자명을 입력하세요.");
	    		return false;
	    	}
	    	var ans = confirm("결제 하시겠습니까?");
	    	if(ans) {
	    		if(paymentCard != "" && payMethodCard != "") {
	    			document.getElementById("payment").value = "C"+paymentCard;
	    			document.getElementById("payMethod").value = payMethodCard;
	    		}
	    		else {
	    			document.getElementById("payment").value = "B"+paymentBank;
	    			document.getElementById("payMethod").value = payMethodBank;
	    		}
		    	myform.action = "${ctp}/dbShop/payment2";
		    	myform.submit();
	    	}
		  
	  }
	  
	  function pointUsing(){
		  let usePoint = document.getElementById("point").value;
		  let myPoint = ${memberVO.point};
		  if(usePoint > myPoint){
			  alert("보유한 포인트를 초과해서 사용할 수 없습니다.");
			  return false;
		  }
		  
		  let tempTotal = document.getElementById("temp1").value;
		  let bs = document.getElementById("bs1").value;
		  let realPrice = (Number(tempTotal)+Number(bs)) - Number(usePoint);
		  //alert("realPrice : " + realPrice);
		  $("#temp2").text(realPrice);
		  let str = "<div id='pp'>포인트 사용 (-" + usePoint + ")point " + "<input type='button' value='사용취소' onclick='cancelPoint()' class='btn btn-outline-dark btn-sm' /></div>";
		  $("#spendPoint").append(str);
		  document.getElementById("orderTotalPrice").value=realPrice;
		  document.getElementById("usingPoint").value=usePoint;
	  }
	  
	  function cancelPoint(){
		  $("#pp").remove();
		  let usePoint = document.getElementById("point").value;
		  let tempTotal = document.getElementById("temp1").value;
		  let bs = document.getElementById("bs1").value;
		  let realPrice = Number(tempTotal) + Number(bs);
		  $("#temp2").text(realPrice);
		  document.getElementById("orderTotalPrice").value=realPrice;
		  document.getElementById("usingPoint").value=0;
	  }
  </script>
  <style>
    td, th {padding: 5px}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
<div class="text-left">장바구니 > <b>결제</b> > 완료</div>
<p><br/></p>
<form name="myform" method="post">
  <table class="table table-borderless text-center">
    <tr class="table-dark text-dark">
      <th colspan="2">배송 정보</th>
    </tr>
    <tr>
		  <th width="30%" class="text-center">구매자 성명</th>
		  <td><input type="text" name="buyer_name" value="${memberVO.name}" readonly class="form-control"/></td>
		</tr>
    <tr>
		  <th>메일</th>
		  <td><input type="text" name="buyer_email" value="${memberVO.email}" class="form-control"/></td>
		</tr>
    <tr>
		  <th>전화번호</th>
		  <td><input type="text" name="buyer_tel" value="${memberVO.tel}" class="form-control"/></td>
		</tr>
    <tr>
		  <th>주소</th>
		  <c:set var="addr" value="${fn:split(memberVO.address,'/')}"/>
		  <td class="text-left">
		    <input type="text" name="buyer_postcode" value="${addr[0]}"/><br/>
		    <input type="text" name="buyer_addr" value="${addr[1]} ${addr[2]} ${addr[3]}" class="form-control"/>
		  </td>
		</tr>
    <tr>
		  <th>배송시 요청사항</th>
		  <td><!-- <input type="text" name="message" class="form-control" placeholder="배송시요청사항을 기록하세요"/> -->
		    <select name="message" class="form-control">
		      <option>부재중일시 경비실에 맡겨주세요.</option>
		      <option>빠른 배송부탁합니다.</option>
		      <option>부재중 현관문 앞에 놓아주세요.</option>
		      <option>부재중 전달해주지 마세요.</option>
		    </select>
		    <hr/>
		  </td>
		</tr>
	</table>
	<p><br/></p>
	
<!-- 상품/옵션 내역 -->	
	<table class="table-borderless text-center table-hover" style="margin:auto; width:100%">
	  <tr class="table-dark text-dark">
	    <th style="width:30%">상품 </th>
	    <th>옵션 정보</th>
	    <th>금액</th>
	  </tr>
	  <!-- 주문서 목록출력 -->
	  <c:forEach var="vo" items="${sOrderVOS}">  <!-- 세션에 담아놓은 sOrderVos의 품목내역들을 화면에 각각 보여주는 작업처리 -->
	    <tr align="center" style="width:20%">
	      <td><img src="${ctp}/dbShop/product/${vo.thumbImg}" width="70px"/></td>
	      <td align="left">
	        <div class="text-left ml-4">
	          <span font-weight:bold;"><b>${vo.productName}</b></span><br/>
	       	<span class="badge badge-dark">옵션</span> : ${vo.optionName} / ${vo.optionNum}개 / ${vo.optionPrice}원 
	        <div>
	      </td>
	      <td>
	        <b>
	        <c:set var="opPrice" value="${vo.optionNum*vo.optionPrice}" />
	        <fmt:formatNumber value="${opPrice}" pattern='#,###원'/></b><br/><br/>
	      </td>
	    </tr>
	  </c:forEach>
	</table>
	<hr/>
	<p><br/></p>
	
	<!--  결제 정보 --> 
	
	<!-- 포인트 사용  -->
	<table class="table-borderless text-center table-hover" style="margin:auto; width:100%">
	  <tr class="table-dark text-dark mb-2">
	  	 <th colspan="2">할인 / 제휴</th>
	  </tr>
	  <tr>
	  	<td>내 포인트 : ${memberVO.point} point </td>
	  	<td class="text-right">
		  	<input type="number" value="0" name="point" id="point"/>
				<input type="button" value="포인트사용" name="pointUse" id="pointUse" onclick="pointUsing()" class="btn btn-outline-dark" />
	  	</td>
	  </tr>
	</table>
	<p><br/></p>
	
	<table style="margin:auto; width:100%" class="text-right" style="background-color:#eee;">
		<tr class="table-dark text-dark mb-2">
	  	<th colspan="2" class="text-center">결제</th>
	  </tr>
	  <c:set var="tempTotal" value="${orderTotal}" />
	  <c:set var="tempbs" value="${sOrderVOS[0].baesong}" />
	  <input type="hidden" value="${tempTotal}" id="temp1" />
	  <input type="hidden" value="${tempbs}" id="bs1" />
	  <tr>
	  	<td style="width:80%">상품 금액 ${orderTotal}</td>
	  	<td><fmt:formatNumber value="${tempTotal}" pattern='#,###원'/></td>
	  </tr>
	  <tr>
	  	<td>배송비</td>
	  	<td><fmt:formatNumber value="${sOrderVOS[0].baesong}" pattern='#,###원'/></td>
	  	<hr/>
	  </tr>
	  <tr>
	  	<td colspan="2"><span id="spendPoint"></span></td>
	  </tr>
	  <tr>
	  	<td><b>총 결제금액</b></td>
	  	<td><font size="4" color="orange"><b><span id="temp2">${tempTotal + tempbs}</span></b></font>원</td>
	  </tr>
	  <hr/>
  </table>
		
	  <!-- Nav tabs -->
		<ul class="nav nav-tabs mt-4" role="tablist">
      <li class="nav-item"><a class="nav-link active form-control" data-toggle="tab" href="#card">카드결제</a></li>
	    <li class="nav-item"><a class="nav-link form-control" data-toggle="tab" href="#bank">무통장입금</a></li>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div id="card" class="container tab-pane active"><br>
	      <p>카드사 선택
	        <select name="paymentCard" id="paymentCard">
	          <option value="">카드사 선택</option>
	          <option>국민카드</option>
	          <option>현대카드</option>
	          <option>신한카드</option>
	          <option>농협카드</option>
	          <option>BC카드</option>
	          <option>롯데카드</option>
	          <option>삼성카드</option>
	          <option>LG카드</option>
	        </select>
	      </p>
				<p>카드번호  <input type="text" name="payMethodCard" id="payMethodCard"/></p>
				<hr/>
			  <button type="button" class="btn btn-secondary form-control mt-4 p-3 pb-5" onClick="order()"><b><font size="4">결제하기</font></b></button> &nbsp;
	    </div>
	    <div id="bank" class="container tab-pane fade"><br>
	      <p>은행 선택
	        <select name="paymentBank" id="paymentBank">
	          <option value="">은행선택</option>
	          <option value="국민은행">국민(111-111-111)</option>
	          <option value="신한은행">신한(222-222-222)</option>
	          <option value="우리은행">우리(333-333-333)</option>
	          <option value="농협">농협(444-444-444)</option>
	          <option value="신협">신협(555-555-555)</option>
	        </select>
	      </p>
				<p>입금자명  <input type="text" name="payMethodBank" id="payMethodBank"/></p>
				<hr/>
			  <button type="button" class="btn btn-secondary form-control mt-4 p-3 pb-5" onClick="order2()"><b><font size="4">결제하기</font></b></button> &nbsp;
	    </div>
	  </div>
		<hr/>
		
		<div align="center">
		</div>
		<input type="hidden" name="orderVos" value="${orderVos}"/>
	  <input type="hidden" name="orderIdx" value="${orderIdx}"/>  							<!-- 주문번호 -->
	  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice" value="${orderTotalPrice}"/>	<!-- 최종 구매(결제)금액 -->
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="payment" id="payment"/>			<!-- 결재종류 : 카드/계좌이체 등. -->
	  <input type="hidden" name="payMethod" id="payMethod"/>	<!-- 결재방법중에서 카드번호/계좌번호 등. -->
	  <input type="hidden" name="amount" id="amount" value="100" />	<!-- 결재방법중에서 카드번호/계좌번호 등. -->
	  <input type="hidden" name="usingPoint" id="usingPoint" />	<!-- 포인트 사용금액 -->
	  
	  <input type="hidden" name="name" value="${memberVO.name}"/>	<!-- 결재창으로 넘겨줄 모델명 -->
	  <%-- <input type="hidden" name="amount" value="${orderTotalPrice}"/> --%>	<!-- 결재창으로 넘겨줄 결제금액(실제금액이라 여기선 테스트로) -->
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>