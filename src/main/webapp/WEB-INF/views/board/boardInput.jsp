<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardInput.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
    
    function fCheck() {
    	let title = myform.title.value;
    	let content = myform.content.value;
    	let pwd = myform.pwd.value;
    	
    	if(title.trim() == "") {
    		alert("게시글 제목을 입력하세요");
    		myform.title.focus();
    	}
    	else if(pwd.trim() == "") {
    		alert("비밀번호를 입력하세요"); 
    		myform.pwd.focus();
    	}
    	else {
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <form name="myform" method="post">
    <table class="table table-bordered">
     <tr>
        <th>작성자</th>
        <td>${sNickName}</td>
      </tr>
    	<tr>
    		<th>분류</th>
    		<td>
    			<select name="part" class="form-control">
    				<option value="">분류를 선택해주세요.</option>
    				<option value="원데이클래스">원데이클래스</option>
    				<option value="전시회">전시회</option>
    				<option value="기타">기타</option>
    			</select>
    		</td>
    	</tr>
      <tr>
        <th>제목</th>
        <td><input type="text" name="title" id="title" placeholder="글제목을 입력하세요" autofocus required class="form-control"></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td><input type="text" name="email" id="email" placeholder="이메일을 입력하세요" class="form-control"/></td>
      </tr>
      <tr>
        <th></th>
        <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required></textarea></td>
     		<script>
     		CKEDITOR.replace("content",{
     			height:480,
     			filebrowserUploadUrl:"${ctp}/imageUpload", /* 파일(이미지) 업로드 경로 */
     			uploadUrl : "${ctp}/imageUpload" /* 여러개의 그림파일을 드래그&드롭해서 올리기 */
     		});
     		</script>
      </tr>
      <tr>
      	<th>비밀번호</th>
      	<td><input type="password" name="pwd" id="pwd" class="form-control" required/></td>
      </tr>
      <c:if test="${sLevel == 0}">
      	<tr><td><input type="radio" name="fixed" value="on"/>공지 상단 고정 &nbsp;</td></tr>
      </c:if>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="등록" onclick="fCheck()" class="btn btn-outline-dark"/> &nbsp;
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList';" class="btn btn-outline-dark"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="nickName" value="${sNickName}"/>
    <input type="hidden" name="openSw" value="OK"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>