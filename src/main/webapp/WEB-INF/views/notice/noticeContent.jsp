<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>noticeContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';

    // 게시글 삭제처리
    function noticeDelete() {
    	let ans = confirm("현 게시글을 삭제하시겠습니까?");
    	if(ans) location.href="${ctp}/notice/noticeDelete?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&nickName=${vo.nickName}";
    }
  
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <br/>
  <table class="table table-borderless" style="width:800px; margin:0 auto;">
  	<tr>
  		<td colspan="3" class="text-left" style="border-bottom:5px solid #c9c2bc; background-color:#eee;"><font size="4"><b>${vo.title}</b></font></td>
  	</tr>
  	<tr style="border-bottom:2px solid #c9c2bc;">
  		<td style="width:20%" class="text-left"><b>${vo.nickName}</b></td>
  		<td style="width:50%" class="text-left">${fn:substring(vo.WDate,0,fn:length(vo.WDate)-2)}</td>
  		<td style="width:30%" class="text-right">조회&nbsp;${vo.readNum}</td>
  	</tr>
  	<tr  style="border-bottom:5px solid #c9c2bc;">
  		<td colspan="3">${fn:replace(vo.content, newLine, "<br/>")}</td>
  	</tr>
    <tr>
      <td colspan="3" class="text-right">
        <input type="button" value="목록으로" onclick="location.href='${ctp}/notice/noticeList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-dark"/>
        &nbsp;
      	<c:if test="${sMid == vo.mid || sLevel == 0}">
        	<input type="button" value="수정하기" onclick="location.href='${ctp}/notice/noticeUpdate?idx=${vo.idx}&pag=${pag}&pageSize=${pageSize}';" class="btn btn-outline-dark"/> &nbsp;
        	<input type="button" value="삭제하기" onclick="noticeDelete()" class="btn btn-outline-dark"/>
      	</c:if>
      </td>
    </tr>
  </table>
  
  <c:if test="${flag != 'search' && flag != 'searchMember'}">
	  <!-- 이전글/ 다음글 처리 -->
	 <table class="table table-borderless" style="width:800px; margin:0 auto;">
	    <tr>
	      <td>
	        <c:if test="${!empty pnVos[1]}">
	          ☝ <a href="${ctp}/notice/noticeContent?idx=${pnVos[1].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[1].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx < pnVos[0].idx}">
	        	☝ <a href="${ctp}/notice/noticeContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">다음글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	        <c:if test="${vo.idx > pnVos[0].idx}">
	        	👇 <a href="${ctp}/notice/noticeContent?idx=${pnVos[0].idx}&pag=${pag}&pageSize=${pageSize}">이전글 : ${pnVos[0].title}</a><br/>
	        </c:if>
	      </td>
	    </tr>
	  </table>
  </c:if>
  
 
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>