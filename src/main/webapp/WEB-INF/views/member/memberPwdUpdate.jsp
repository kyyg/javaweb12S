<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberPwdUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }

    .inp{
    item-align : center;
  	border : solid 0px #ccc;
  	width : 400px;
  	height : 60px;
  	background-color:#eee;
  	margin-left : 30px;
  	}
    
    
  </style>
  <script>
    'use strict';
    
    function pwdCheck() {
    	let newPwd = $("#newPwd").val();
    	let rePwd = $("#rePwd").val();
    	
    	if(newPwd == "" || rePwd == "") {
    		alert("새 비밀번호를 입력하세요");
    		$("#newPwd").focus();
    	}
    	else if(newPwd != rePwd) {
    		alert("확인비밀번호가 일치하지 않습니다.");
    		$("#rePwd").focus();
    	}
    	else {
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>

<div class="container" style="width:500px; margin:0 auto;">
  <div class="text-center">
  <font size="5">   	<div class="w3-bottombar w3-sand w3-padding text-center" style="margin-bottom:20px;">
	   		<span style="font-size:23px;">비밀번호 변경</span>
	   </div></font><br/>
  </div>
  
  <form name="myform" method="post">
  	<table class="table table-borderless" style="width:500px; margin:0 auto;">
  		<tr>
  			<td>
  			<input type="password" class="w3-bottombar inp text-center" name="newPwd" id="newPwd" placeholder="새 비밀번호를 입력하세요." required autofocus />
  			</td>
  		</tr>
  		<tr>
  			<td>
  			<input type="password" class="w3-bottombar inp text-center" name="rePwd" id="rePwd" placeholder="위와 같은 번호를 입력하세요." required autofocus />
  			</td>
  		</tr>
  		<tr>
  			<td colspan="2" class="text-center">
  				<input type="button" value="비밀번호 변경" onclick="pwdCheck()" class="btn btn-outline-dark" />
  				<input type="button" value="돌아가기" onclick="location.href='${ctp}/member/memberMain';" class="btn btn-outline-dark" />
  			</td>
  		</tr>
  	</table>  
  </form>
</div>

<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>