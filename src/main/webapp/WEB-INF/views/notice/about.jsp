<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>about.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  .about1{
  background-image : url(${ctp}/images/classBackground.jpg);
  
  }
  </style>
  <script>
    'use strict';
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="w3-display-container w3-text-white">
<div class="container about1" style="height:800px;" style="margin:0 auto;">
</div>
<p><br/></p>

<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>