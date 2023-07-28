<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberIdFind.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <style>
  
    .inp{
    item-align : center;
  	border : solid 0px #ccc;
  	width : 400px;
  	height : 60px;
  	background-color:#eee;
  	margin-left : 30px;
  }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container" style="width:500px; margin:0 auto;">
  <div class="text-center">
  <font size="5">   	<div class="w3-bottombar w3-sand w3-padding text-center" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">아이디 찾기</span>
	   </div></font><br/>
  
  
  <font size="2">이메일주소를 입력하시면 아이디를 찾을 수 있습니다.</font>
  </div>
  
  <form method="post">
  	<table class="table table-borderless" style="width:500px; margin:0 auto;">
  		<tr>
  			<td>
  			<input type="text" class="w3-bottombar inp text-center" name="email" id="email" placeholder="이메일을 입력하세요." required autofocus />
  			</td>
  		</tr>
  		<tr>
  			<td colspan="2" class="text-center">
  				<input type="submit" value="아이디 찾기" class="btn btn-outline-dark" />
  				<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberLogin';" class="btn btn-outline-dark" />
  			</td>
  		</tr>
  	</table>  
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>