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
  <table class="table table-bordereless text-center" style="border-radious:10px;">
  	<tr>
  		<td class="pb-5 pt-5" style="width:15%; background-color:#eee">
  			<img src="${ctp}/images/member.png">
  		</td>
  		<td class="pb-5 pt-5 text-left" style="width:25%; background-color:#eee">
  			<font size="5" >${sMid}님</font><br/>
  				총 결제 금액(12개월)<br/>
   			<c:if test="${empty yearPay}" >0원</c:if>
   			<c:if test="${!empty yearPay}" ><fmt:formatNumber value="${yearPay}" pattern='#,###'/></c:if>원
  		</td>
  		<td class="pb-5 pt-5" style="width:12%"><font size="5" color="orange">${part1}</font><br/>입금전</td>
  		<td class="pb-5 pt-5" style="width:12%"><font size="5" color="orange">${part2}</font><br/>결제완료</td>
  		<td class="pb-5 pt-5" style="width:12%"><font size="5" color="orange">${part3}</font><br/>배송중</td>
  		<td class="pb-5 pt-5" style="width:12%"><font size="5" color="orange">${part4}</font><br/>배송완료</td>
  		<td class="pb-5 pt-5" style="width:12%"><font size="5" color="orange">${part5}</font><br/>구매확정</td>
  	</tr>
  </table>
  
  <table class="table-bordered text-center mt-5" style="width:100%; border-radious:10px;background-color:#fff;">
  	<tr>
  		<td class="pb-5 pt-5" style="width:25%; height:150px;"><a href="${ctp}/dbShop/dbMyOrder"><font size="4"><b>주문내역</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/member/memberPwdCheck"><font size="4"><b>개인정보수정</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/dbShop/dbMyOnedayClass"><font size="4"><b>이벤트 참여내역</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/dbShop/dbPoint"><font size="4"><b>포인트 내역</b></font></a></td>
  	</tr>
  </table>
  <table class="table-bordered text-center" style="width:100%;background-color:#fff;">
  	<tr>
  		<td class="pb-5 pt-5" style="width:25%; height:150px;"><a href="${ctp}/dbShop/dbWishList"><font size="4"><b>위시리스트</b></font></a></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/dbShop/userReview"><font size="4"><b>리뷰 관리</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/board/userBoard"><font size="4"><b>문의글 관리</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/board/userBoard"><font size="4"><b>회원탈퇴</b></font></a></td>
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