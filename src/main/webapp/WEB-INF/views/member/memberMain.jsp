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
    <link rel="stylesheet" href="${ctp}/font/font.css">
  <script src="https://kit.fontawesome.com/607fa85cf6.js" crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
  function memberDelete() {
	  let ans = confirm("회원 탈퇴하시겠습니까?");
	  if(ans) {
		  ans = confirm("탈퇴하시면 1개월간 같은 아이디로 재가입하실수 없습니다.\n탈퇴를 진행 하시겠습니까?");
		  if(ans) location.href = "${ctp}/member/memberDelete";
	  }
  }
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<hr/>
  <table class="table table-bordereless text-center" style="border-radious:10px; height:90%;">
  	<tr>
  		<td class="pb-3 pt-5 text-right pl-5 mb-2" style="width:10%; background-color:#eee">
  			<img src="${ctp}/images/eventStamp.png" width="90px" class="pb-2" />
  		</td>
  		<td class="pb-5 pt-5 text-left" style="width:25%; background-color:#eee">
  			<font size="5" class="pt-2 mt-2">${sMid}님</font><br/>
  			<font size="3">[${sNickName}님]</font>
  		</td>
  		<td class="pb-5 pt-5" style="width:16%"><font size="5" color="#6b5a5a">${part2}</font><br/>결제완료</td>
  		<td class="pb-5 pt-5" style="width:16%"><font size="5" color="#6b5a5a">${part3}</font><br/>배송중</td>
  		<td class="pb-5 pt-5" style="width:16%"><font size="5" color="#6b5a5a">${part4}</font><br/>배송완료</td>
  		<td class="pb-5 pt-5" style="width:16%"><font size="5" color="#6b5a5a">${part5}</font><br/>구매확정</td>
  	</tr>
  	<tr><td colspan="7" class="p-0 m-0"></td></tr>
  </table>
  
  <table class="table-bordered text-center mt-5" style="width:100%; border-radious:10px; background-color:#fff;">
  	<tr>
  		<td class="pb-5 pt-5" style="width:25%; height:150px;"><a href="${ctp}/dbShop/dbMyOrder"><font size="4"><b><img src="${ctp}/images/mm1.jpg" width=50px;><br/>주문내역</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/member/memberPwdCheck"><font size="4"><b><img src="${ctp}/images/mm2.jpg" width=50px;><br/>개인정보수정</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/dbShop/dbMyOnedayClass"><font size="4"><b><img src="${ctp}/images/mm3.jpg" width=50px;><br/>이벤트 참여내역</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/dbShop/dbPoint"><font size="4"><b><img src="${ctp}/images/mm4.jpg" width=50px;><br/>포인트 내역</b></font></a></td>
  	</tr>
  </table>
  <table class="table-bordered text-center" style="width:100%;background-color:#fff;">
  	<tr>
  		<td class="pb-5 pt-5" style="width:25%; height:150px;"><a href="${ctp}/dbShop/dbWishList"><font size="4"><b><img src="${ctp}/images/mm5.jpg" width=50px;><br/>위시리스트</b></font></a></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/dbShop/userReview"><font size="4"><b><img src="${ctp}/images/mm6.jpg" width=50px;><br/>리뷰</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/board/userBoard"><font size="4"><b><img src="${ctp}/images/mm7.jpg" width=50px;><br/>제휴 문의</b></font></a></td>
  		<td class="pb-5 pt-5" style="width:25%"><a href="${ctp}/dbShop/memberShppingList"><font size="4"><b><img src="${ctp}/images/mm8.jpg" width=50px;><br/>배송지 관리</b></font></a></td>
  	</tr>
  </table>
  <div class="text-right"><a href="${ctp}/member/memberPwdUpdate"><font size="2">비밀번호 변경</font></a></div>
  <div class="text-right"><a href="javascript:memberDelete()"><font size="2">회원탈퇴</font></a></div>
  
  <c:if test="${!empty sImsiPwd}">
    <hr/>
    <>
    현재 임시비밀번호를 발급받아 사용중이십니다.<br/>
    개인정보를 확인하시고 비밀번호를 변경해 주세요.<br/>
    <a href="${ctp}/member/memberPwdUpdate" class="btn btn-outline-dark">비밀번호변경</a>
    <hr/>
  </c:if>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>