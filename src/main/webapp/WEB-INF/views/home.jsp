<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>별이 빛나는 밤</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
	</style>
	<script>
	'use strict'
	
	// 새창띄우기
	window.addEventListener("DOMContentLoaded", function() {
		let eventCheck = '${event}';
		if(eventCheck !== '새창고만해'){
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
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>