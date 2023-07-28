<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberIdFindOk</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="width:700px; margin:0 auto;">
   <font size="5" class="text-center">
   	<div class="w3-bottombar w3-sand w3-padding text-center" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">아이디 찾기 결과</span>
	   </div>
   
   </font><br/>
  <table class="table table-bordered text-center">
  	<tr>
  		<td>이메일</td>
  		<td>${vo.email}</td>
  	</tr>
  	<tr>
  		<td>아이디</td>
  		<td>
  		 	<c:forEach var="i" begin="0" end="${fn:length(vo.mid)-1}">
		      <c:if test="${i % 2 != 0}">${fn:replace(fn:substring(vo.mid,i,i+1),fn:substring(vo.mid,i,i+1),'*')}</c:if>
		      <c:if test="${i % 2 == 0}">${fn:substring(vo.mid,i,i+1)}</c:if>
	      </c:forEach>
  		</td>
  	</tr>
  </table>
  <div class="container text-center" style="width:700px; margin:0 auto;">
  <a href="${ctp}/member/memberLogin" class="btn btn-outline-dark text-center">로그인으로</a>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>