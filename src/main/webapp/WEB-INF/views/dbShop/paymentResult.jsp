<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>paymentResult.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <style>
  
	#orderOk{
		width: 680px;
		height:400px;
		border : solid 1px #bdb0a3;
		border-radius : 10px;
		padding-bottom : 60px;
		background: linear-gradient(to bottom, rgb(255, 255, 255), rgb(229, 221, 214));
		margin-right:10px;
	}
	
  .bbtn{
  background-color:#fff;
  border:0px;
  border-radius: 5px;
  width:200px;
  height : 40px;
  }
	  	
  	
  </style>
  <script>
	  function nWin(orderIdx) {
	  	var url = "${ctp}/dbShop/dbOrderBaesong?orderIdx="+orderIdx;
	  	window.open(url,"dbOrderBaesong","width=350px,height=400px");
	  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
<br/>
<div class="container" style="width:700px; margin:0 auto;">
  <table class="table table-borderless" style="margin:0 auto;">
	  <tr style="margin:0 auto;">
			<td style="width:700px; height:100px;" class="text-center">
				<div id="orderOk" class="mb-5 mt-5 pt-5">
					<div class="text-center mt-5 mb-5"><img src="${ctp}/images/titleLogo.png" width="350px;" /></div>
					<font size="4">고객님의 소중한 주문이 접수되었습니다.</font><br/>
					<br/>
			    <button type="button" onclick="location.href='${ctp}/dbShop/dbProductList';" class="bbtn">메인화면</button>
			    <button type="button" onclick="location.href='${ctp}/dbShop/dbMyOrder';" class="bbtn">주문목록</button>
			  <br/>
				</div>
			</td>
		</tr>
  </table>
  
  <table class="table table-borderless" style="width:700px; margin:0 auto;">
    <tr style="text-align:center;background-color:#ded9d5;">
      <th style="width:15%">주문번호</th>
      <th style="width:30%">상품</th>
      <th style="width:30%">옵션</th>
      <th style="width:15%">금액</th>
    </tr>
    <c:forEach var="vo" items="${orderVOS}">
      <tr>
      	<td class="text-center">
      		${vo.orderIdx}
      	</td>
        <td style="text-align:center;">
          <img src="${ctp}/dbShop/product/${vo.thumbImg}" width="60px"/>
        </td>
        <td>
	        ${vo.productName} <br/>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
		      <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
		      <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	          ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	        </c:forEach> 
        </td>
        <td style="text-align:center;"><br/>
          <p><fmt:formatNumber value="${vo.totalPrice}"/>원</p>
        </td>
      </tr>
    </c:forEach>
  </table>
  <hr/>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>