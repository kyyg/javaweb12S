<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>별 헤는 밤, 빛나는 밤</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="${ctp}/font/font.css">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <style>
  
  	#chatImage {
  position: fixed;
  bottom: 100px; /* 원하는 여백 값으로 조정 가능 */
  right: 30px; /* 원하는 여백 값으로 조정 가능 */
	}
	</style>
	<script>
	'use strict'
	
	// 채팅 띄우기
	function chatNew(){
		let url = "${ctp}/webSocket";
		let winName = "winName";
    let winWidth = 500;
    let winHeight = 600;
    let x = (screen.width/2) - (winWidth/2);
    let y = (screen.height/2) - (winHeight/2);
    let opt="width="+winWidth+", height="+winHeight+", left="+x+", top="+y;
    window.open(url,winName,opt);
	}
	
	// 새창띄우기
	window.addEventListener("DOMContentLoaded", function() {
		let eventCheck = '${event}';
		if(eventCheck !== 'popUpNo'){
	    let url = "${ctp}/eventNew";
	    let winName = "winName";
	    let opt = "width=" + 350 + ", height=" + 400 + ", left=" + 150 + ", top=" + 100;
	    window.open(url, winName, opt);
		}
	});

	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/header_home.jsp" />
<img src="${ctp}/images/mu.jpg" width=100px; height=100px; id="chatImage" class="w3-circle" onclick="chatNew()" />
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>