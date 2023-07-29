<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>dbOnedayClass.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  </style>
  <script>
    'use strict';
    
    function qrCodeNew(idx){
     let url = "${ctp}/dbShop/qrCodeWin?idx="+idx;
     let winName = "winName";
     let winWidth = 320;
     let winHeight = 320;
     let x = (screen.width/2) - (winWidth/2);
     let y = (screen.height/2) - (winHeight/2);
     let opt="width="+winWidth+", height="+winHeight+", left="+x+", top="+y;
     window.open(url,winName,opt);
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<hr/>
<div class="text-center"><font size="5">이벤트 신청 내역</font></div>
<hr/>
	<table class="table-hover table-borderless text-center" style="width:1000px; margin:0 auto; ">
		<tr class="text-dark" style="background-color:#c9aea2">
			<td>번호</td>
			<td>응모날짜</td>
			<td>예약날짜</td>
			<td>아이디</td>
			<td>클래스명</td>
			<td>매장명</td>
			<td>인원수</td>
			<td>당첨QR코드</td>
		</tr>
		<c:forEach var="vo" items="${vos}" varStatus="st">
		<tr style="height:100px">
			<td style="height:100px">${st.count}</td>			
			<td style="height:100px">${fn:substring(vo.appDate,0,10)}</td>			
			<td style="height:100px">${fn:substring(vo.WDate,0,10)}</td>			
			<td style="height:100px" >${vo.mid}</td>			
			<td style="height:100px">${vo.className}</td>			
			<td style="height:100px">${vo.store}</td>			
			<td style="height:100px">${vo.memberNum}</td>			
			<td style="height:100px">
				<c:if test="${vo.qrCodeName != null}">			
				<img src="${ctp}/qrCode/${vo.qrCodeName}" width="70px" onclick="qrCodeNew('${vo.idx}')"/>
				</c:if>
				<c:if test="${vo.qrCodeName == null}"></c:if>
			</td>
		</tr>
		<tr><td class="p-0 m-0"></td></tr>
		</c:forEach>
	</table>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>