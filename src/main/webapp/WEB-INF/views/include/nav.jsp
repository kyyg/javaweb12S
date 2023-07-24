<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
  int level = session.getAttribute("sLevel")==null ? 99 : (int) session.getAttribute("sLevel");
  pageContext.setAttribute("level", level);
%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

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
			<a class="nav-link" href="${ctp}/admin/index" style="color: white; background-color: black;">ADMIN</a>
			<a class="nav-link" href="${ctp}/admin/adminMain"></a>
    </c:if>
		</li>
  <c:if test="${level <= 4}">
	  <li class="nav-item dropdown">
			<a class="nav-link" href="${ctp}/dbShop/dbCartList"><font color="black">CART</font></a>
		</li>
	  <li class="nav-item dropdown">
    <c:if test="${sLevel == 1 || sLevel == 0 }">
			<a class="nav-link" href="${ctp}/member/memberMain"><font color="black">MY PAGE</font></a>
    </c:if>
		</li>
	 </c:if>
	 
	  <li class="nav-item">
        <c:if test="${level > 4}"><a class="nav-link" href="${ctp}/member/memberLogin"><font color="black">Login</font></a></c:if>
        <c:if test="${level <= 4}"><a class="nav-link" href="${ctp}/member/memberLogout"><font color="black">Logout</font></a></c:if>
    </li>  
    <li class="nav-item">
      <c:if test="${level > 4}"><a class="nav-link" href="${ctp}/member/memberJoin"><font color="black">Join</font></a></c:if>
    </li>  
	</ul>
</nav>
  	

	<div class="text-center text-dark ml-4" class="title">
		<h1><a href="${ctp}/" style="decoration:none;" class=text-center><b><i>Our<br/>Starry<br/>Night</a></i></b></h1>
	</div>

  <p></br></p>
  	<!-- 메인메뉴 -->
<span>
<nav id="mainnav" class="navbar-light bg-white">
  <ul class="nav justify-content-center">
	 <li class="nav-item dropdown">
	    <div class="nav-link dropbtn mr-5" ><a href="${ctp}/notice/about">ABOUT</a></div>
	  </li>
	   <li class="nav-item dropdown">
	    <div class="nav-link dropbtn ml-4 mr-5 text-center">&nbsp;<a href="${ctp}/dbShop/dbProductList">STORE</a></div>
	    <div class="dropdown-menu dropdown-content">
	      <a class="dropdown-item text-center" href="${ctp}/dbShop/dbProductList?part=디지털">디지털</a>
		    <a class="dropdown-item text-center" href="${ctp}/dbShop/dbProductList?part=프레임">프레임</a>
		    <a class="dropdown-item text-center" href="${ctp}/dbShop/dbProductList?part=리빙">리빙</a>
		    <a class="dropdown-item text-center" href="${ctp}/dbShop/dbProductList?part=북">책</a>
	   </div>
	  </li>
	  <li class="nav-item dropdown">
	    <div class="nav-link dropbtn ml-3 mr-5">&nbsp;&nbsp;EVENT</div>
	    <div class="dropdown-menu dropdown-content">
	      <a class="dropdown-item text-center" href="${ctp}/schedule/schedule">출석이벤트</a>
	      <a class="dropdown-item text-center" href="${ctp}/dbShop/dbOnedayClass">원데이클래스</a>
	      <a class="dropdown-item text-center" href="${ctp}/board/boardList">후기 게시판</a>
	   </div>
	   </li>
	  <li class="nav-item dropdown">
	    <div class="nav-link dropbtn ml-3">SERVICE</div>
	    <div class="dropdown-menu dropdown-content">
	      <a class="dropdown-item text-center" href="${ctp}/notice/noticeList">공지 게시판</a>
	      <a class="dropdown-item text-center" href="${ctp}/qna/qnaList">문의 게시판</a>
	      <a class="dropdown-item text-center" href="${ctp}/admin/offlineStore">오프라인 매장</a>
	      <a class="dropdown-item text-center" href="${ctp}/contact/contactList">제휴 문의</a>
	   </div>
	   </li>
	</ul>
</nav>
</span>

