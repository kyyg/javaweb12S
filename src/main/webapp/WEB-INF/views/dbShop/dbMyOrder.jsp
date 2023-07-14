<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbMyOrder.jsp(회원 주문확인)</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script>
    // 배송지 정보보기
    function nWin(orderIdx) {
    	var url = "${ctp}/dbShop/dbOrderBaesong?orderIdx="+orderIdx;
    	window.open(url,"dbOrderBaesong","width=400px,height=450px");
    }
    
    $(document).ready(function() {
    	// 주문 상태별 조회 : 전체/결제완료/배송중~~
    	$("#orderStatus").change(function() {
	    	var orderStatus = $(this).val();
	    	location.href="${ctp}/dbShop/orderStatus?orderStatus="+orderStatus+"&pag=${pageVO.pag}";
    	});
    });
    
    // 날짜별 주문 조건 조회(오늘/일주일이내/보름이내~~)
    function orderCondition(conditionDate) {
    	location.href="${ctp}/dbShop/orderCondition?conditionDate="+conditionDate+"&pag=${pageVO.pag}";
    }
    
    // 날찌기간에 따른 조건검색
    function myOrderStatus() {
    	var startDateJumun = new Date(document.getElementById("startJumun").value);
    	var endDateJumun = new Date(document.getElementById("endJumun").value);
    	var conditionOrderStatus = document.getElementById("conditionOrderStatus").value;
    	
    	if((startDateJumun - endDateJumun) > 0) {
    		alert("주문일자를 확인하세요!");
    		return false;
    	}
    	
    	startJumun = moment(startDateJumun).format("YYYY-MM-DD");
    	endJumun = moment(endDateJumun).format("YYYY-MM-DD");
    	location.href="${ctp}/dbShop/dbMyOrder?startJumun="+startJumun+"&endJumun="+endJumun+"&conditionOrderStatus="+conditionOrderStatus;
    }
    

    function orderCondition(e) {
   	  let today = new Date();
   	  today.setDate(today.getDate() - e); // e일 전 날짜로 설정
   	  let year = today.getFullYear();
   	  let month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고, 2자리 숫자로 표현
   	  let day = String(today.getDate()).padStart(2, '0'); // 2자리 숫자로 표현
   	  let startJumun = year + '-' + month + '-' + day;
   	  
	   	 let today2 = new Date(); // 오늘 날짜 가져오기
	     let year2 = today2.getFullYear();
	     let month2 = ('0' + (today2.getMonth() + 1)).slice(-2);
	     let day2 = ('0' + today2.getDate()).slice(-2);
	     let endJumun = year2 + '-' + month2 + '-' + day2;
	     
     	location.href="${ctp}/dbShop/dbMyOrder?startJumun="+startJumun+"&endJumun="+endJumun;
   	}
    
    
    function reset() {
   	  window.location.reload();
   	}
    
    function orderNewWin(orderIdx,totalPrice) {
        let url = "${ctp}/dbShop/orderChildWin?totalPrice="+totalPrice+"&orderIdx="+orderIdx;
        let winName = "winName";
        let winWidth = 800;
        let winHeight = 500;
        let x = (screen.width/2) - (winWidth/2);
        let y = (screen.height/2) - (winHeight/2);
        let opt="width="+winWidth+", height="+winHeight+", left="+x+", top="+y;
        window.open(url,winName,opt);
    }
    
    function orderCancel(idx) {
        let url = "${ctp}/dbShop/orderCancelChild?idx="+idx;
        let winName = "winName";
        let winWidth = 800;
        let winHeight = 400;
        let x = (screen.width/2) - (winWidth/2);
        let y = (screen.height/2) - (winHeight/2);
        let opt="width="+winWidth+", height="+winHeight+", left="+x+", top="+y;
        window.open(url,winName,opt);
    }
    
    function reviewCheck(idx){
    	    	
    	location.href="${ctp}/dbShop/dbReviewForm?idx="+idx;
    }
    
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<c:set var="conditionOrderStatus" value="${conditionOrderStatus}"/>
<c:set var="orderStatus" value="${orderStatus}"/>
<%-- <c:if test="${orderStatus eq ''}"><c:set var="orderStatus" value="전체"/></c:if> --%>
<p><br/></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
  <c:set var="condition" value="전체 조회"/>
  <c:if test="${conditionDate=='1'}"><c:set var="condition" value="오늘날짜조회"/></c:if>
  <c:if test="${conditionDate=='7'}"><c:set var="condition" value="일주일 이내 조회"/></c:if>
  <c:if test="${conditionDate=='15'}"><c:set var="condition" value="보름 이내 조회"/></c:if>
  <c:if test="${conditionDate=='30'}"><c:set var="condition" value="한달 이내 조회"/></c:if>
  <c:if test="${conditionDate=='90'}"><c:set var="condition" value="석달 이내 조회"/></c:if>
  <hr/> 
  <h3 class="text-center">주문 목록</h3>
  <hr/>
  <table class="table table-borderless">
    <tr>
      <td style="text-align:left;"> 
        <input type="button" class="btn btn-outline-dark btn-sm" value="전체보기" onclick="location.href='${ctp}/dbShop/dbMyOrder';"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="오늘" onclick="orderCondition(0)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="일주일" onclick="orderCondition(7)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="보름" onclick="orderCondition(15)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="1개월" onclick="orderCondition(30)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="3개월" onclick="orderCondition(90)"/>
        <input type="button" class="btn btn-outline-dark btn-sm" value="12개월" onclick="orderCondition(365)"/>
      </td>
      <td></td>
    </tr>
	    <tr>
	      <td style="text-align:left;">
	<%--         <c:if test="${startJumun == null}">
	          <c:set var="startJumun" value="<%=new java.util.Date() %>"/>
		        <c:set var="startJumun"><fmt:formatDate value="${startJumun}" pattern="yyyy-MM-dd"/></c:set>
	        </c:if>
	        <c:if test="${endJumun == null}">
	          <c:set var="endJumun" value="<%=new java.util.Date() %>"/>
		        <c:set var="endJumun"><fmt:formatDate value="${endJumun}" pattern="yyyy-MM-dd"/></c:set>
	        </c:if> --%>
	        <input type="date" name="startJumun" id="startJumun" value="${startJumun}"/>~<input type="date" name="endJumun" id="endJumun" value="${endJumun}"/>
	        <select name="conditionOrderStatus" id="conditionOrderStatus">
	          <option value="전체" ${conditionOrderStatus == '전체' ? 'selected' : ''}>전체</option>
	          <option value="결제완료" ${conditionOrderStatus == '입금전' ? 'selected' : ''}>입금전</option>
	          <option value="결제완료" ${conditionOrderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
	          <option value="배송중"  ${conditionOrderStatus == '배송중' ? 'selected' : ''}>배송중</option>
	          <option value="배송완료"  ${conditionOrderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
	          <option value="구매확정"  ${conditionOrderStatus == '구매확정' ? 'selected' : ''}>구매확정</option>
	          <option value="반품"  ${conditionOrderStatus == '반품' ? 'selected' : ''}>반품</option>
	          <option value="환불"  ${conditionOrderStatus == '환불' ? 'selected' : ''}>환불</option>
	        </select>
	        <input type="button" class="btn btn-outline-dark btn-sm" value="조회하기" onclick="myOrderStatus()"/>
	      </td>
	    </tr>
	    <tr>
	    	<td>3개월간의 주문내역입니다.</td>
	    </tr>
  </table>
  <table class="table table-hover table-borderless">
    <tr style="text-align:center;background-color:#ccc;">
      <th>주문번호</th>
      <th>주문일시</th>
      <th>이미지</th>
      <th>상품</th>
      <th>금액</th>
      <th>주문상태</th>
      <th>취소/환불/리뷰</th>
    </tr>
    <c:set var="orderIdx" value="0" />
    <c:forEach var="vo" items="${vos}">
      <tr>
        <td style="text-align:center;">
        <c:if test = "${vo.orderIdx != orderIdx}">
        	<a href="${ctp}/dbShop/dbOrderDetail?orderIdx=${vo.orderIdx}">${vo.orderIdx}</a>
        </c:if>
        <c:if test = "${vo.orderIdx == orderIdx}"></c:if>
	      <c:set var="orderIdx" value="${vo.orderIdx}" />
        </td>
        <td style="text-align:center;">
         <c:if test = "${vo.orderDate != orderDate}">
        	${fn:substring(vo.orderDate,0,10)}
        </c:if>
        <c:if test = "${vo.orderDate == orderDate}"></c:if>
	      <c:set var="orderDate" value="${vo.orderDate}" />
        </td>
        <td style="text-align:center;"><img src="${ctp}/data/dbShop/product/${vo.thumbImg}" class="thumb" width="50px"/></td>
        <td align="left">
	        <span style="color:orange;font-weight:bold;">${vo.productName}</span> &nbsp; &nbsp;<br/> <%-- <fmt:formatNumber value="${vo.mainPrice}"/>원<br/> --%>
	            ${vo.optionName} / <fmt:formatNumber value="${vo.optionPrice}"/>원 / ${vo.optionNum}개<br/>
	      <td><fmt:formatNumber value="${vo.totalPrice}"/>원</td>
	      <td><font color="brown">${vo.status}</font><br/></td>
	      <td>
	      <c:if test="${vo.status == '배송완료'}">
	      	<input type="button" value="구매확정" class="btn btn-outline-dark btn-sm" onclick="orderNewWin('${vo.orderIdx}','${vo.totalPrice}')"/>
	      	<input type="button" value="반품/환불" class="btn btn-outline-danger btn-sm" onclick="orderCancel('${vo.idx}')" />
	      </c:if>
	      <c:if test="${vo.status != '배송완료'}"></c:if>
	      <c:if test="${vo.status == '구매확정'}">
	      	<c:if test="${vo.reviewConfirm == 'NO'}">
	      		<input type="button" value="리뷰작성" class="btn btn-outline-info btn-sm" onclick="reviewCheck('${vo.idx}')" />
	      	</c:if>
	      	<c:if test="${vo.reviewConfirm != 'NO'}"></c:if>
	      </c:if>
	      <c:if test="${vo.status != '구매확정'}"></c:if>
				</td>
      </tr>
      <tr><td colspan="7" class="p-0 m-0"></td></tr>
    </c:forEach>
  <tr><td colspan="7" class="p-0 m-0"></td></tr>
  </table>
  <hr/>
  <!-- 블록 페이징처리 시작(BS4 스타일적용) -->
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${pageVO.totPage == 0}"><p style="text-align:center"><b>-</b></p></c:if>
			<c:if test="${pageVO.totPage != 0}">
			  <c:if test="${pageVO.pag != 1}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=1&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${pageVO.curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
			    <c:if test="${i == pageVO.pag && i <= pageVO.totPage}">
			      <li class="page-item active"><a href='${ctp}/dbShop/dbMyOrder?pag=${i}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pageVO.pag && i <= pageVO.totPage}">
			      <li class="page-item"><a href='${ctp}/dbShop/dbMyOrder?pag=${i}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pageVO.pag != pageVO.totPage}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${pageVO.totPage}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
	<!-- 블록 페이징처리 끝 -->
<p><br/></p>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>