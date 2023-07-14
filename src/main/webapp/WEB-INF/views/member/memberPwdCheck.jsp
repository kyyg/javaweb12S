<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberPwdCheck.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<hr/>
<div class="container">
  <h3 class="text-center">회원정보 수정</h3>
  <h6 class="text-center">회원정보 수정을 위해 비밀번호 입력해주세요.</h6>
  <hr/>
  <form name="myform" method="post" >
  	<div style="width:500px; text-align:center; margin: 0 auto;" >
	    <table class="table table-borderless mt-5">
	      <tr class="mt-5">
	        <th>비밀번호</th>
	        <td><input type="password" name="pwd" id="pwd" class="form-control" required autofocus /></td>
	      </tr>
	      <tr>
	        <td colspan="2" class="text-center mt-5">
	          <input type="submit" value="입력" class="btn btn-outline-dark form-control mb-2" />
	          <input type="button" value="회원 페이지로" onclick="location.href='${ctp}/member/memberMain';" class="btn btn-outline-dark form-control" />
	        </td>
	      </tr>
	    </table>
		 </div>
  <input type="hidden" name="mid" value="${sMid}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>