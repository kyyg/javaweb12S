<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>orderCancelChild.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  </style>
  <script>
    'use strict';
    function closeChild(){
     window.opener.location.reload();
   	 window.close();
    }
    
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<div class="text-center">
		<h3>반품/환불 신청이 완료 되었습니다.</h3>
		<input type="button" value="닫기" class="btn btn-outline-dark forn-control mt-5" onclick="closeChild()" />
	</div>
</div>
<p><br/></p>
</body>
</html>