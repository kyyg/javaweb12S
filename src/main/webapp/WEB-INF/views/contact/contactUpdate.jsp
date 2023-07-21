<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>inquiryUpdate.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
    <script type="text/javascript">

 
		function fCheck() {
			var title = myForm.title.value;
			var part = myForm.part.value;
			var content = myForm.content.value;
			
			if(title=="") {
				alert("제목을 입력하세요.");
				myForm.title.focus();
				return false;
			}
			else if(part=="") {
				alert("분류를 선택하세요.");
				return false;
			}
			else if(content=="") {
				alert("내용을 입력하세요.");
				myForm.content.focus();
				return false;
			}
			else {
				myForm.submit();
			}
		}
	</script>
	<style type="text/css">
	  th {
	    background-color: #ddd;
	    text-align: center;
	  }
    .imgs_wrap {
        width: 600px;
        margin-top: 50px;
    }
    .imgs_wrap img {
        max-width: 200px;
    }
  </style>	
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<form name="myForm" method="post" enctype="Multipart/form-data">
		<br/>
		<table class="table table-bordered">
			<tr> 
				<th>제목</th>
				<td><input type="text" name="title" value="${vo.title}" class="form-control" maxlength="100" placeholder="제목을 입력하세요." autofocus /></td>
			</tr>
			<tr> 
				<th>분류</th>
				<td>
					<select name="part" class="form-control" style="width: 200px;">
						<option value="상품 입점" ${vo.part == '상품 입점' ? 'selected' : ''}>상품 입점</option>
						<option value="원데이클래스 제휴"	   ${vo.part == '원데이클래스 제휴' ? 		 'selected' : ''}>원데이클래스 제휴</option>
					</select>
				</td>
			</tr>
			<tr> 
				<th>내용</th>
				<td>
					<textarea name="content" rows="10" class="form-control">${vo.content}</textarea>
				</td>
			</tr>
			<tr> 
				<th>파일첨부</th>
				<td>
					<input type="file" name=file id="file" accept=".zip,.jpg,.gif,.png"/><br/><br/>
					(<font color="red">사진을 변경하시면 기존 사진은 삭제됩니다.</font>)
				</td>
			</tr>
			<tr>
			  <th>첨부된 파일</th>
				 <td>
		        <c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
		        <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
		        <c:forEach var="fName" items="${fNames}" varStatus="st">
		          <a href="${ctp}/contact/${fSNames[st.index]}" download="${fName}">${fName}</a><br/>
		        </c:forEach>
    	  </td>
			</tr>
			<tr>
			  <td colspan='2' class="text-center">
			    <input type="button" value="수정" onclick="fCheck()" class="btn btn-outline-dark w-25"/> &nbsp;
			    <input type="button" value="돌아가기" onclick="location.href='${ctp}/contact/contactList';" class="btn btn-outline-dark w-25"/>
			  </td>
			</tr>
		</table>
		<p><br/></p>
		<input type="hidden" name="idx" value="${vo.idx}"/>
		<input type="hidden" name="pag" value="${pag}"/>
		<input type="hidden" name="fName" value="${vo.FName}"/>
		<input type="hidden" name="fSName" value="${vo.FSName}"/>
	</form>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>