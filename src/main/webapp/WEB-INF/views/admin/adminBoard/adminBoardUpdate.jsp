<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boardUpdate.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
    
   		#menu {
	  position: fixed;
	  top: 0;
	  left: 0;
	  width: 225px;
	  height: 1000px;
	  background-color: #476cd9;
	}
  </style>
  <script>
    'use strict';
    
    function fCheck() {
    	let title = myform.title.value;
    	let content = myform.content.value;
    	
    	if(title.trim() == "") {
    		alert("게시글 제목을 입력하세요");
    		myform.title.focus();
    	}
    	/* 
    	else if(content.trim() == "") {
    		alert("게시글 내용을 입력하세요"); 
    		myform.content.focus();
    	}
    	 */
    	else {
    		myform.submit();
    	}
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="menu" id="menu">
	<div class="text-center card-hover" id="accordion">
  <h5 class="text-white"><a href="${ctp}/admin/index">관리자</a></h5>
  <hr/>
  <p><a href="${ctp}/" target="_top" class="text-white">메인화면으로</a></p>
	<br/>

  <div class="card">
    <div class="card-header bg-blue m-0 p-2" >
      <a class="card-link" data-toggle="collapse" href="#collapse1">
        회원 관리
      </a>
    </div>
    <div id="collapse1" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminMemberList" target="adminContent">회원 리스트</a>
      </div>
    </div>
  </div>

  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse2">
        주문 관리
      </a>
    </div>
    <div id="collapse2" class="collapse" data-parent="#accordion">	
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminOrder" target="adminContent">전체 주문목록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminCancelOrder" target="adminContent">취소/환불 목록</a>
      </div>
    </div>
  </div>
  
    <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse3">
        상품관리
      </a>
    </div>
    <div id="collapse3" class="collapse" data-parent="#accordion">	
     <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbCategory" target="adminContent">상품분류등록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbProduct" target="adminContent">상품등록관리</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbShopList" target="adminContent">상품등록조회</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/dbShop/dbOption" target="adminContent">옵션등록관리</a>
      </div>
    </div>
  </div>
  
  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse4">
        게시판 관리
      </a>
    </div>
    <div id="collapse4" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminNoticeList" target="adminContent">공지 게시판</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminBoardList" target="adminContent">문의 게시판</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/adminReviewList" target="adminContent">리뷰 게시판</a>
      </div>
    </div>
  </div>
  
  
  
  <div class="card">
    <div class="card-header bg-white m-0 p-2">
      <a class="card-link" data-toggle="collapse" href="#collapse5">
        오프라인매장 관리
      </a>
    </div>
    <div id="collapse5" class="collapse" data-parent="#accordion">	<!-- 처음부터 메뉴 보이게 하려면?  class="collapse show" -->
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/kakaomap/storeRegistration" target="adminContent">매장 등록</a>
      </div>
      <div class="card-body m-2 p-1">
        <a href="${ctp}/admin/kakaomap/kakaoStoreList" target="adminContent">매장 확인/삭제</a>
      </div>
    </div>
  </div>
</div>
</div>
<div class="container">
  <form name="myform" method="post">
    <table class="table table-bordered">
      <tr>
        <th>글쓴이</th>
        <td>${sNickName}</td>
      </tr>
      <tr>
      	<th>분류</th>
		    <td class="text-left">
			    <select name="part" onchange="partCheck()" class="form-control">
			      <option ${vo.part=="전체" ? "selected" : ""}>전체</option>
			      <option ${vo.part=="상품" ? "selected" : ""}>상품</option>
			      <option ${vo.part=="배송" ? "selected" : ""}>배송</option>
			      <option ${vo.part=="취소" ? "selected" : ""}>취소</option>
			      <option ${vo.part=="환불" ? "selected" : ""}>환불</option>
			      <option ${vo.part=="기타" ? "selected" : ""}>기타</option>
			    </select>
		    </td>
		  </tr>
      <tr>
        <th>글제목</th>
        <td><input type="text" name="title" id="title" value="${vo.title}" placeholder="글제목을 입력하세요" autofocus required class="form-control"></td>
      </tr>
    	<tr>
        <th>이메일</th>
        <td><input type="text" name="email" id="email" value="${vo.email}" class="form-control"/></td>
      </tr>
      <tr>
        <th>글내용</th>
        <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
     		<script>
     		CKEDITOR.replace("content",{
     			height:480,
     			filebrowserUploadUrl:"${ctp}/imageUpload", /* 파일(이미지) 업로드 경로 */
     			uploadUrl : "${ctp}/imageUpload" /* 여러개의 그림파일을 드래그&드롭해서 올리기 */
     		});
     		</script>
      </tr>
      <tr>
        <th>공개여부</th>
        <td>
          <input type="radio" name="openSw" value="OK" checked />공개 &nbsp;
          <input type="radio" name="openSw" value="NO" />비공개
        </td>
      </tr>
       <tr>
      	<th>비밀번호</th>
      	<td><input type="password" name="pwd" id="pwd" class="form-control" required /></td>
      </tr>
      <c:if test="${sLevel == 0}">
      	<tr><td><input type="radio" name="fixed" value="on"/>공지 상단 고정 &nbsp;</td></tr>
      </c:if>
      <tr>
        <td colspan="2" class="text-center">
          <input type="button" value="수정" onclick="fCheck()" class="btn btn-primary"/> &nbsp;
          <input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boardList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-secondary"/>
        </td>
      </tr>
    </table>
    <input type="hidden" name="mid" value="${sMid}"/>
    <input type="hidden" name="nickName" value="${sNickName}"/>
    <input type="hidden" name="pag" value="${pag}"/>
    <input type="hidden" name="pageSize" value="${pageSize}"/>
  </form>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>