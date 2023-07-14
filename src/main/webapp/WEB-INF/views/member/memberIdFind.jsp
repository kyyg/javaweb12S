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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2>아이디 찾기</h2>
  <p>이메일주소를 입력해주세요.</p>
  <form method="post">
  	<table class="table table-bordered">
  		<tr>
  			<th>이메일주소</th>
  			<td><input type="text" name="email" id="email" class="form-control" autofocus required/></td>
  		</tr>
  		<tr>
  			<td colspan="2" class="text-center">
  				<input type="submit" value="아이디 찾기" class="btn btn-outline-dark" />
  				<input type="reset" value="다시 입력" class="btn btn-outline-dark" />
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