<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title></title>

 <!-- Custom fonts for this template-->
<link href="../resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link
    href="../resources/https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet">
<link rel="stylesheet" href="${ctp}/font/font.css">
<!-- Custom styles for this template-->
<link href="../resources/css/sb-admin-2.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
	<script>
		/*
		$(document).ready(function() {
			$('#insertBtn').hide(); 
			
			$('#updateBtn').click(function(){
				$('#insertBtn').show(); 
				$('#updateBtn').hide(); 
				$('#reContent').removeAttr('readonly');				
			});
		});
		*/
		function contactReply() {
			var contactIdx = "${vo.idx}";
			var reContent = replyForm.reContent.value;
			if(reContent == "") {
				alert("답변을 입력하세요!");
				replyForm.reContent.focus();
				return false;
			}
			var query = {
					contactIdx : contactIdx,
					reContent : reContent
			}
			$.ajax({
				url : "${ctp}/admin/adminContactReplyInput",
				type : "post",
				data : query,
				success : function(res) {
					if(res == "1"){
					alert("답변이 등록되었습니다.");
					location.reload();
					}
				}
			});
		}
		
		// 답변글 삭제하기
		function deleteReplyCheck() {
			var ans = confirm("답변글을 삭제하시겠습니까?");
			if(!ans) return false;
			
			//var idx = ${vo.idx};
			var reIdx = '${reVO.reIdx}';
			var contactIdx = '${reVO.contactIdx}';
			var query = {
					//idx : idx,
					reIdx : reIdx,
					contactIdx : contactIdx
			}
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/adminContactReplyDelete",
				
				data : query,
				success:function() {
					alert("삭제 되었습니다.");
					location.reload();
				}
			});
		}
		
		// 답변글 수정폼 호출하기(replySw값을 1을 보내어서 그 값이 1이면 textarea창의 readonly속성을 풀어준다.)
		 
/* 		function updateReplyCheck() {
			location.href = "${ctp}/admin/adminContactReply?idx=${vo.idx}&replySw=U";
		} */
		 
		
		// 답변글 수정하기
		function updateReplyCheck() {
			var reIdx = '${reVO.reIdx}';	// 현재글에 달려있는 답변글의 고유번호(수정시에 필요하다)
			var reContent = document.getElementById("reContent").value;
			var query = {
					reIdx : reIdx,
					reContent : reContent
			}
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/adminContactReplyUpdate",
				data : query,
				success:function(res) {
					if(res == "1"){
					alert("수정되었습니다.");
					location.reload();
					}
					// location.reload();	// 수정버튼을 다시 readonly 처리위해서는 location.reload가 아닌, 해당 프로그램을 다시 호출해야한다. 즉, location.href처리한다.
					// location.href = "${ctp}/admin/adInquiryReply?idx=${vo.idx}";
				}
			});
		}
		 
		// 게시글 삭제하기
		function deleteCheck() {
			var ans = confirm("삭제하시겠습니까?");
			if(!ans) return false;
			location.href="${ctp}/admin/adminContactDelete?idx=${vo.idx}&fSName=${vo.FSName}&reIdx=${reVO.reIdx}";
		}
	</script>
	<style>
	  th {background-color: #ccc; text-align:center;}
	</style>
</head>
<body id="page-top">
<!-- Page Wrapper -->
<div id="wrapper">
<jsp:include page="/WEB-INF/views/include/sidebar.jsp" />
</head>
<body>
<p><br/></p>
  <!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
    <!-- Sidebar Toggle (Topbar) -->
    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
        <i class="fa fa-bars"></i>
    </button>
    <h3 class="text-center"></h3>
    <!-- Topbar Navbar -->
</nav>
<!-- End of Topbar -->
<!-- Main Content -->
<div id="content">
	<div class="container">

<table class="table table-borderless" style="width:1100px; margin:0 auto;">
  	<tr>
  		<td colspan="3" class="text-left" style="border-bottom:5px solid #c9c2bc; background-color:#eee;"><font size="4"><b>
  		${vo.title}</b></font>
  		<c:if test="${vo.reply=='답변대기중'}">
					<span class="badge badge-pill badge-secondary">${vo.reply}</span>						
				</c:if>
				<c:if test="${vo.reply=='답변완료'}">
					<span class="badge badge-pill badge-danger">${vo.reply}</span>						
				</c:if>
  		</td>
  	</tr>
  	<tr style="border-bottom:2px solid #c9c2bc;">
  		<td style="width:20%" class="text-left"><b>${vo.mid}</b></td>
  		<td style="width:50%" class="text-right">${fn:substring(vo.WDate,0,fn:length(vo.WDate)-2)}</td>
  	</tr>
  	<tr  style="border-bottom:5px solid #c9c2bc;">
  		<td colspan="2">${fn:replace(vo.content, newLine, "<br/>")}</td>
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
	
	<div style="width:1100px; margin:0 auto;">
		<div style="text-align: right" >
			<c:if test="${sMid==vo.mid || sLevel == 0}">	<!-- 작성글이 자신의 글이거나 관리자라면 삭제처리할수 있다. -->
				<input type="button" value="삭제" onclick="deleteCheck()" class="btn btn-outline-dark btn-sm"/>
			</c:if>
			<input type="button" value="목록으로" onclick="location.href='${ctp}/admin/adminContactList'" class="btn btn-outline-dark btn-sm"/>
		</div>
	</div>
	<hr/>
	<!-- 답변서가 작성되어 있을때 수행하는 곳 -->
	<c:if test="${!empty reVO.reContent}">
		<div style="width:1100px; margin:0 auto;">
		<form name="replyForm">
			<label for="reContent"><h5>답변내용</h5></label>
			<c:if test="${empty sReplySw || sReplySw != '1'}">	<!-- 답변서 작성되어 있고, 수정가능상태는 readonly로 처리후 '수정'버튼 누르면 'readonly'해제후 '수정완료'버튼으로 바꾼다. -->
				<textarea name="reContent" rows="5"  id="reContent" class="form-control bg-light" >${reVO.reContent}</textarea>
				<div style="text-align: right">		<!-- 수정을 위해서는 현재 답변글의 글번호(reIdx)를 넘겨야하지만, 현재는 답변글이 항상 1개이기에 넘기지않아도 알수 있다. -->
					<input type="button" value="수정" id="updateBtn" onclick="updateReplyCheck()" class="btn btn-secondary btn-sm mt-2"/>
					<input type="button" value="삭제" id="deleteBtn" onclick="deleteReplyCheck()" class="btn btn-danger btn-sm mt-2"/>
				</div>
			</c:if>
			<c:if test="${!empty sReplySw && sReplySw == '1'}">
				<textarea name="reContent" rows="5"  id="reContent" class="form-control" >${reVO.reContent}</textarea>
				<div style="text-align: right">
					<input type="button" value="수정완료" id="updateOkBtn" onclick="updateReplyCheckOk()" class="btn btn-secondary btn-sm mt-2"/>
					<input type="button" value="삭제" id="deleteBtn" onclick="deleteReplyCheck()" class="btn btn-secondary btn-sm mt-2"/>
				</div>
			</c:if>
		</form>
		</div>
	</c:if>

	<!-- 답변서가 작성되어 있지 않을때 수행하는 곳 -->
	<c:if test="${empty reVO.reContent}">
		<div style="width:1100px; margin:0 auto;">
		<form name="replyForm">
			<label for="reContent"></label>
			<textarea name="reContent" rows="5" class="form-control" placeholder="답변 작성해주세요."></textarea>
			<div style="text-align: right">
				<input type="button" value="등록" onclick="contactReply()" class="btn btn-outline-dark btn-sm mt-2"/>
			</div>
		</form>
		</div>
	</c:if>

</div>
</div>
<!-- End of Content Wrapper -->
<!-- End of Page Wrapper -->
<!-- Bootstrap core JavaScript-->
<script src="../resources/vendor/jquery/jquery.min.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- Core plugin JavaScript-->
<script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>
<!-- Custom scripts for all pages-->
<script src="../resources/js/sb-admin-2.min.js"></script>
<!-- Page level plugins -->
<script src="../resources/vendor/chart.js/Chart.min.js"></script>
<!-- Page level custom scripts -->
<script src="../resources/js/demo/chart-area-demo.js"></script>
<script src="../resources/js/demo/chart-pie-demo.js"></script>
</body>
</html>