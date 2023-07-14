<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>title</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<hr/>
  <table class="table table-bordered text-center">
  	<tr>
  		<td>
  			[${vo.nickName}]님 환영합니다. <br/> 
   			회원님의 현재 등급은 <span class="badge badge-warning">${strLevel}</span>입니다. <br/>
   			총 결제 금액(12개월) : 
   			<c:if test="${empty yearPay}" >0원</c:if>
   			<c:if test="${!empty yearPay}" ><fmt:formatNumber value="${yearPay}" pattern='#,###'/></c:if>원
  		</td>
  	</tr>
  </table>
  
  <table class="table table-bordered text-center">
  	<tr>
  		<td>
  			현재 포인트 : ${vo.point} <span class="badge badge-info">Point</span><br/> 
  		</td>
  	</tr>
  </table>
  
  <table class="table table-bordered text-center">
  	<tr>
  		<td class="pb-5 pt-5">입금전 <font size="5" color="orange">${part1}</font></td>
  		<td class="pb-5 pt-5">결제완료 <font size="5" color="orange">${part2}</font></td>
  		<td class="pb-5 pt-5">배송중 <font size="5" color="orange">${part3}</font></td>
  		<td class="pb-5 pt-5">배송완료 <font size="5" color="orange">${part4}</font></td>
  		<td class="pb-5 pt-5">구매확정 <font size="5" color="orange">${part5}</font></td>
  	</tr>
  </table>
  
  <c:if test="${!empty sImsiPwd}">
    <hr/>
    현재 임시비밀번호를 발급받아 사용중이십니다.<br/>
    개인정보를 확인하시고 비밀번호를 변경해 주세요.<br/>
    <a href="${ctp}/member/memberPwdUpdate" class="btn btn-success">비밀번호변경</a>
    <hr/>
  </c:if>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>