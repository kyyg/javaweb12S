<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
	#nav{
	background-color:black;
	color:white;
	padding : 3px;
	margin : 3px;
	text-decoration:none;
	}
</style>
<div class="w3-container w3-center w3-animate-right">
<div class="container">
  <div class="text-center">
	  <a href="${ctp}/dbShop/dbMyOrder" id="nav">주문내역</a>
	  <a href="${ctp}/dbShop/dbMyOnedayClass" id="nav">원데이클래스 예약내역</a>
	  <a href="${ctp}/member/memberPwdCheck" id="nav">개인정보수정</a>
	  <a href="${ctp}/dbShop/dbPoint" id="nav">포인트 내역</a>
	  <a href="${ctp}/dbShop/dbWishList" id="nav">위시리스트</a>
	  <a href="${ctp}/dbShop/userReview" id="nav">리뷰 관리</a>
	  <a href="${ctp}/board/userBoard" id="nav">문의글 관리</a>
  </div>
</div>
</div>