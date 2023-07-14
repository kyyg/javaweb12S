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
  </script>
  <style>
    td, th {padding: 5px}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<h2 class="text-center">주문 / 결제</h2>
	<br/>
	<table class="table-borderless text-center table-hover" style="margin:auto; width:100%">
	  <tr class="table-dark text-dark">
	    <th style="width:20%">상품 </th>
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
		  <%-- <input type="hidden" name="cartIdx" value="${idx}"/> --%>  <!-- 장바구니고유번호를 비롯한 주문된 상품의 정보들은 세션에 담겨있기에 굳이 따로 넘길필요없다. 즉 따로이 입력된 배송지 정보들만 넘긴다. -->
	  </c:forEach>
	</table>

	<p><br/></p>
	<form name="myform" method="post">
	  <table class="table table-borderless text-center">
	    <tr class="table-dark text-dark">
	      <th colspan="2">배송 정보</th>
	    </tr>
	    <tr>
			  <th width="40%">구매자이름</th>
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
			  </td>
			</tr>
	    <tr>
			  <th>처리될 총 결제금액(테스트자료 100원)</th>
			  <%-- <td><input type="text" name="amount" value="${orderTotalPrice}" class="form-control" autofocus /></td> --%>
			  <td><input type="text" name="amount" value="100" class="form-control" autofocus readonly /></td>
			</tr>
		</table>
		<hr/>
		<div class="text-right">
			<input type="number" value="" name="point" id="point" /> 내 포인트 : ${memberVO.point} point 
			<input type="button" value="포인트사용" name="pointUse" id="pointUse" class="btn btn-outline-dark" />
		</div>
		
	<table style="margin:auto; width:100%"><tr><td>
	  <div style="padding:8px; background-color:#eee;text-align:center;">
	    총 결제 금액 : 상품가격(<fmt:formatNumber value="${orderTotal}" pattern='#,###원'/>) +
	                    배송비(<fmt:formatNumber value="${sOrderVOS[0].baesong}" pattern='#,###원'/>) = 
	                    총 <font size="4" color="orange"><b><fmt:formatNumber value="${orderTotalPrice}" pattern='#,###'/></b></font>원
	  </div>
	  </td></tr>
  </table>
		
	  <!-- Nav tabs -->
		<ul class="nav nav-tabs" role="tablist">
      <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#card">카드결제</a></li>
	    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#bank">무통장입금</a></li>
	  </ul>
	
	  <!-- Tab panes -->
	  <div class="tab-content">
	    <div id="card" class="container tab-pane active"><br>
	      <h3>카드결제</h3>
	      <p>
	        <select name="paymentCard" id="paymentCard">
	          <option value="">카드선택</option>
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
				<p>카드번호 : <input type="text" name="payMethodCard" id="payMethodCard"/></p>
			  <button type="button" class="btn btn-outline-danger" onClick="order()">결제하기</button> &nbsp;
	    </div>
	    <div id="bank" class="container tab-pane fade"><br>
	      <h3>무통장입금</h3>
	      <p>
	        <select name="paymentBank" id="paymentBank">
	          <option value="">은행선택</option>
	          <option value="국민은행">국민(111-111-111)</option>
	          <option value="신한은행">신한(222-222-222)</option>
	          <option value="우리은행">우리(333-333-333)</option>
	          <option value="농협">농협(444-444-444)</option>
	          <option value="신협">신협(555-555-555)</option>
	        </select>
	      </p>
				<p>입금자명 : <input type="text" name="payMethodBank" id="payMethodBank"/></p>
			  <button type="button" class="btn btn-outline-info" onClick="order2()">결제하기</button> &nbsp;
	    </div>
	  </div>
		<hr/>
		
		<div align="center">
		</div>
		<input type="hidden" name="orderVos" value="${orderVos}"/>
    <%-- <input type="hidden" name="oIdx" value="${oIdx}"/> --%>  						<!-- 주문테이블 고유번호 -->
	  <input type="hidden" name="orderIdx" value="${orderIdx}"/>  							<!-- 주문번호 -->
	  <input type="hidden" name="orderTotalPrice" value="${orderTotalPrice}"/>	<!-- 최종 구매(결제)금액 -->
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="payment" id="payment"/>			<!-- 결재종류 : 카드/계좌이체 등. -->
	  <input type="hidden" name="payMethod" id="payMethod"/>	<!-- 결재방법중에서 카드번호/계좌번호 등. -->
	  
	  <input type="hidden" name="name" value="${memberVO.name}"/>	<!-- 결재창으로 넘겨줄 모델명 -->
	  <%-- <input type="hidden" name="amount" value="${orderTotalPrice}"/> --%>	<!-- 결재창으로 넘겨줄 결제금액 -->
	</form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>