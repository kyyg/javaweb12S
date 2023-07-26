<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
  pageContext.setAttribute("level", level);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<link rel="stylesheet" href="${ctp}/font/font.css">
<style>

.a{
	text-decoration:none;
}
.nav-item{
position: -webkit-sticky;
z-index:10;
}
#mainnav {
	position: -webkit-sticky;
	position: sticky;
	top : -1px;
	z-index:1;
	height : 70px;
}
nav li {
	margin-top:10px;
	font-size:15pt;
}
.nav {
	font-size:15pt;
}
.carousel-caption {
	margin: 0%;
	left:0%;
}
#homeTitle{
	font-size: 35px;
}
#homeTitle a{
	color : black;
}
#homeTitle a:hover{
	text-decoration:none;
}

.dropdown-content a:hover {background-color: #ddd;}

.dropdown:hover .dropdown-content {display: block;}

.dropdown:hover .dropbtn {
}

.dropdown-content {
	width : 30px;
  background-color: white;
}
.dropdown-content a {
  color: black;
}
.nav-link a{
	text-decoration:none;
  color: black;
}
.nav-link:hover a {
	text-decoration:none;
}

#searchString{
	border-top: 0px;
	border-left : 0px;
	border-right : 0px;
}

</style>


<script>
  function deleteAsk() {
	  let ans = confirm("정말로 탈퇴 하시겠습니까?");
	  if(ans) {
		  let ans2 = confirm("탈퇴후 같은 아이디로 1개월간 재가입하실수 없습니다.\n그래도 탈퇴 하시겠습니까?");
		  if(ans2) location.href="${ctp}/MemberDeleteAsk.mem";
	  }
  }
  
</script>


<nav id="mainnav" class="navbar-light bg-white mr-4">
  <ul class="nav justify-content-end">
	  <li class="nav-item dropdown">
    <c:if test="${sLevel == 0}">
			<a class="nav-link" href="${ctp}/admin/index" style="color: white; background-color: black;">관리자</a>
			<a class="nav-link" href="${ctp}/admin/adminMain"></a>
    </c:if>
		</li>
  <c:if test="${level <= 4}">
	  <li class="nav-item dropdown">
			<a class="nav-link" href="${ctp}/dbShop/dbCartList"><font color="black">장바구니</font></a>
		</li>
	  <li class="nav-item dropdown">
    <c:if test="${sLevel == 1 || sLevel == 0 }">
			<a class="nav-link" href="${ctp}/member/memberMain"><font color="black">마이페이지</font></a>
    </c:if>
		</li>
	 </c:if>
	 
	  <li class="nav-item">
        <c:if test="${level > 4}"><a class="nav-link" href="${ctp}/member/memberLogin"><font color="black">로그인</font></a></c:if>
        <c:if test="${level <= 4}"><a class="nav-link" href="${ctp}/member/memberLogout"><font color="black">로그아웃</font></a></c:if>
    </li>  
    <li class="nav-item">
      <c:if test="${level > 4}"><a class="nav-link" href="${ctp}/member/memberJoin"><font color="black">회원가입</font></a></c:if>
    </li>  
	</ul>
</nav>
  	

	<div class="text-center text-dark ml-4" class="title">
		<a href="${ctp}/"><img src="${ctp}/images/title.jpg" width=500px; /></a>
	</div>

  <p></br></p>
  	<!-- 메인메뉴 -->
<span>
<nav id="mainnav" class="navbar-light bg-white">
  <ul class="nav justify-content-center">
	 <li class="nav-item dropdown">
	    <div class="nav-link dropbtn mr-5" ><a href="${ctp}/notice/about">별,빛</a></div>
	  </li>
	   <li class="nav-item dropdown">
	    <div class="nav-link dropbtn ml-4 mr-5 text-center">&nbsp;&nbsp;<a href="${ctp}/dbShop/dbProductList">상점</a></div>
	    <div class="dropdown-menu dropdown-content">
	      <a class="dropdown-item text-center" href="${ctp}/dbShop/dbProductList?part=디지털">전자기기</a>
		    <a class="dropdown-item text-center" href="${ctp}/dbShop/dbProductList?part=프레임">액자</a>
		    <a class="dropdown-item text-center" href="${ctp}/dbShop/dbProductList?part=리빙">소품</a>
		    <a class="dropdown-item text-center" href="${ctp}/dbShop/dbProductList?part=북">책</a>
	   </div>
	  </li>
	  <li class="nav-item dropdown">
	    <div class="nav-link dropbtn ml-3 mr-5">&nbsp;&nbsp;&nbsp;이벤트</div>
	    <div class="dropdown-menu dropdown-content">
	      <a class="dropdown-item text-center" href="${ctp}/schedule/schedule">출석이벤트</a>
	      <a class="dropdown-item text-center" href="${ctp}/dbShop/dbOnedayClass">원데이클래스</a>
	      <a class="dropdown-item text-center" href="${ctp}/board/boardList">후기 게시판</a>
	   </div>
	   </li>
	  <li class="nav-item dropdown">
	    <div class="nav-link dropbtn ml-3">&nbsp;고객센터</div>
	    <div class="dropdown-menu dropdown-content">
	      <a class="dropdown-item text-center" href="${ctp}/notice/noticeList">공지 게시판</a>
	      <a class="dropdown-item text-center" href="${ctp}/qna/qnaList">문의 게시판</a>
	      <a class="dropdown-item text-center" href="${ctp}/notice/offlineStore">오프라인 매장</a>
	      <a class="dropdown-item text-center" href="${ctp}/contact/contactList">제휴 문의</a>
	   </div>
	   </li>
	</ul>
</nav>
</span>

