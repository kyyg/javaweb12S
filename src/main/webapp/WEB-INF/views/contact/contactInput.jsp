<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>inquiryInput.jsp</title>
	<%@ include file="/WEB-INF/views/include/bs4.jsp" %>
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
	<form name="myForm" method="post" enctype="multipart/form-data">
		<h2 style="font-weight: 600" class="text-center">제휴 문의</h2>
		<br/>
		<table class="table table-bordered">
			<tr> 
				<th>제목</th>
				<td><input type="text" name="title" class="form-control" maxlength="100" placeholder="제목을 입력하세요." autofocus /></td>
			</tr>
			<tr> 
				<th>분류</th>
				<td>
					<select name="part" class="form-control" style="width: 200px;">
						<option value="">선택해주세요.</option>
						<option value="상품 입점">상품 입점</option>
						<option value="원데이클래스 제휴">원데이클래스 제휴</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr> 
				<th>내용</th>
				<td>
					<textarea name="content" rows="10" class="form-control"></textarea>
				</td>
			</tr>
			<tr> 
				<th></th>
				<td>
					<input type="file" name="file" id="file" multiple /><br/><br/>
				</td>
			</tr>
			<tr>
			  <td colspan='2' class="text-center">
			    <input type="button" value="문의 등록" onclick="fCheck()" class="btn btn-secondary w-25"/> &nbsp;
			    <input type="button" value="목록으로" onclick="location.href='${ctp}/contact/contactList?pag=${pageVo.pag}';" class="btn btn-secondary w-25"/>
			  </td>
			</tr>
		</table>
		<p><br/></p>
		<input type="hidden" name="mid" value="${sMid}"/>
	</form>
</div>
<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>