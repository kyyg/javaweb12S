<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>contactContent.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<script>
		'use strict';
		
		function updateCheck() {
			let ans = confirm("수정하시겠습니까?");
			if(!ans) return false;
			else location.href="${ctp}/contact/contactUpdate?idx=${vo.idx}";
		}
		
		function deleteCheck() {
			let ans = confirm("삭제하시겠습니까?");
			if(!ans) return false;
			location.href="${ctp}/contact/contactDelete?idx=${vo.idx}&fSName=${vo.FSName}";
		}
	</script>
	<style>
	  th {
	    background-color: #ccc;
	    text-align:center;
	    width: 15%;
	  }
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">

	<table class="table table-borderless pb-0">
		<tr>
			<td colspan="2">
				<div style="align:right" class="text-right">
					<c:if test="${empty reVO.reContent}">
						<span><input type="button" value="수정" onclick="updateCheck()" class="btn btn-outline-dark"/></span>
						<span><input type="button" value="삭제" onclick="deleteCheck()" class="btn btn-outline-dark"/></span>
					</c:if>
				</div>
			</td>
		</tr>
	</table>
	<table class="table table-bordered">
		<tr>
			<th>제목</th>
			<td colspan="3">[${vo.part}] ${vo.title}</td>
		</tr>
		<tr>
			<th>상태</th>
			<td colspan="3">
				<c:if test="${vo.reply=='답변대기중'}">
					<span class="badge badge-pill badge-secondary">${vo.reply}</span>						
				</c:if>
				<c:if test="${vo.reply=='답변완료'}">
					<span class="badge badge-pill badge-danger">${vo.reply}</span>						
				</c:if>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${fn:substring(vo.WDate,0,10)}</td>
		</tr>
		<tr>
			<td colspan="4" style="height:200px">
	      <p>${fn:replace(vo.content,newLine,"<br/>")}</p>
			</td>
		</tr>
		<tr>
		 <th>첨부파일</th>
		 <td>
        <c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
        <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
        <c:forEach var="fName" items="${fNames}" varStatus="st">
          <a href="${ctp}/contact/${fSNames[st.index]}" download="${fName}">${fName}</a><br/>
        </c:forEach>
      </td>
		</tr>
	</table>
	
	<!-- 관리자가 답변을 달았을때는 현재글을 수정/삭제 처리 못하도록 하고 있다. -->
 	<div style="text-align: right" class="row">
		<span class="col"></span>
		<input type="button" value="목록으로" onclick="location.href='${ctp}/contact/contactList';" class="btn btn-outline-dark col form-control"/>
		<span class="col"></span>
	</div>
	
	<hr/>
	<!-- 관리자가 답변을 달았을때 보여주는 구역 -->
	<c:if test="${!empty reVO.reContent}">
		<form name="replyForm">
			<label for="reContent">관리자 답변</label>
			<textarea name="reContent" rows="5"  id="reContent" readonly="readonly" class="form-control">${reVO.reContent}</textarea>
		</form>
	</c:if>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>