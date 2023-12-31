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
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
    'use strict';
 
    // DB를 활용한 좋아요 토글처리...
    function goodDBCheck(idx) {
    	if(idx == "") idx = 0;
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/admin/adminBoardGoodDBCheck",
    		data  : {
    			idx  : idx,
				  part : 'board',
				  partIdx : ${vo.idx},
				  mid  : '${sMid}'
				},
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송 오류~~");
    		}
    	});
    }
    
    
    // 게시글 삭제처리
    function adminBoardDelete() {
    	let ans = confirm("현 게시글을 삭제하시겠습니까?");
    	if(ans) location.href="${ctp}/admin/adminBoardDelete?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}";
    }
    
       
    // 댓글달기(aJax처리)
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요!");
    		$("#content").focus();
    		return false;
    	}
    	let query = {
    			boardIdx : ${vo.idx},
    			mid      : '${sMid}',
    			nickName : '${sNickName}',
    			content  : content,
    			hostIp   : '${pageContext.request.remoteAddr}'
    	}
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/admin/adminBoardReplyInput",
    		data  : query,
    		success:function(res) {
    			if(res == "1") {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("댓글이 입력 실패~~");
    			}
    		},
    		error : function() {
    			alert("전송 오류!!!");
    		}
    	});
    }
    
    // 댓글삭제
    function replyDelete(idx, level) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : 'post',
        url : '${ctp}/admin/AdminBoardReplyDelete',
        data : {
        	replyIdx : idx,
        	level : level
        },
        success : function(res) {
          if(res == '1') {
           alert('댓글이 삭제되었습니다.');
           location.reload();
          }
          else {
           alert('댓글이 삭제되지 않았습니다.');
          }
        },
        error : function() {
          alert('전송실패~~');
        }
      });
    }
    
    // 대댓글(부모댓글의 댓글, 대댓글의 대대댓글....,) 폼 출력하기
    function insertReply(idx, groupId, level, nickName) {
    	let insReply = '';
    	insReply += '<div class="container">';
    	insReply += '<table class="m-2 p-0" style="width:90%">';
    	insReply += '<tr>';
    	insReply += '<td class="p-0 text-left">';
    	insReply += '<div>';
    	insReply += '답변 댓글 달기: <input type="text" name="nickName" value="${sNickName}" size="6" readonly class="p-0"/>';
    	insReply += '</div>';
    	insReply += '</td><td>';
    	insReply += '<input type="button" value="답글달기" onclick="replyCheck2('+idx+','+groupId+','+level+')" />';
    	insReply += '</td></tr><tr><td colspan="2" class="text-center p-0">';
    	insReply += '<textarea rows="3" class="form-control p-0" name="content" id="content'+idx+'" />';
    	insReply += '@' + nickName + '\n';
    	insReply += '</textarea>';
    	insReply += '</td>';
    	insReply += '</tr>';
    	insReply += '</table>';
    	insReply += '</div>';
    	
    	$("#replyBoxOpenBtn"+idx).hide();
    	$("#replyBoxCloseBtn"+idx).show();
    	$("#replyBox"+idx).slideDown(500);
    	$("#replyBox"+idx).html(insReply);
    }
    
    // 대댓글창 닫기
    function closeReply(idx) {
    	$("#replyBoxOpenBtn"+idx).show();
    	$("#replyBoxCloseBtn"+idx).hide();
    	$("#replyBox"+idx).slideUp(500);
    }
    
    // 대댓글 저장하기
    function replyCheck2(idx, groupId, level) {
    	let boardIdx = '${vo.idx}';
    	let mid = '${sMid}';
    	let nickName = '${sNickName}';
    	let content = $("#content"+idx).val();
    	let hostIp = '${pageContext.request.remoteAddr}';
    	
    	if(content == "") {
    		alert("답변글(대댓글)을 입력하세요!");
    		$("#content"+idx).focus();
    		return false;
    	}
    	
    	let query = {
    			boardIdx : boardIdx,
    			mid      : mid,
    			nickName : nickName,
    			content  : content,
    			hostIp   : hostIp,
    			groupId  : groupId,
    			level    : level
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/board/boardReplyInput2",
    		data : query,
    		success:function() {
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 대댓글 수정 폼 출력하기
    function updateReplyForm(idx, content) {
    	let insReply = '';
    	insReply += '<div class="container">';
    	insReply += '<table class="m-2 p-0" style="width:90%">';
    	insReply += '<tr>';
    	insReply += '<td class="p-0 text-left">';
    	insReply += '<div>';
    	insReply += '댓글 수정하기: <input type="text" name="nickName" value="${sNickName}" size="6" readonly class="p-0"/>';
    	insReply += '</div>';
    	insReply += '</td><td>';
    	insReply += '<input type="button" value="댓글수정" onclick="updateReply('+idx+')" />';
    	insReply += '</td></tr><tr><td colspan="2" class="text-center p-0">';
    	insReply += '<textarea rows="3" class="form-control p-0" name="content" id="content'+idx+'" />';
    	insReply += content.replaceAll("<br/>", "\n");
    	insReply += '</textarea>';
    	insReply += '</td>';
    	insReply += '</tr>';
    	insReply += '</table>';
    	insReply += '</div>';
    	
    	$("#replyBoxOpenBtn"+idx).hide();
    	$("#replyBoxCloseBtn"+idx).show();
    	$("#replyBox"+idx).slideDown(500);
    	$("#replyBox"+idx).html(insReply);
    }
    
    // 대댓글 수정하기
    function updateReply(idx) {
    	let content = $("#content"+idx).val();
    	let hostIp = "${pageContext.request.remoteAddr}";
    	
    	if(content == "") {
    		alert("답변글(대댓글)을 입력하세요!");
    		$("#content"+idx).focus();
    		return false;
    	}
    	
    	let query = {
    			idx : idx,
    			content : content,
    			hostIp  : hostIp
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/board/boardReplyUpdate",
    		data : query,
    		success:function() {
    			alert("수정완표");
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
  </script>
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
  <br/>
  
  <table class="table table-borderless" style="width:1100px; margin:0 auto;">
  	<tr>
      <td colspan="4" class="text-right">
      	<c:if test="${sMid == vo.mid || sLevel == 0}">
        	<input type="button" value="삭제하기" class="btn btn-outline-dark" onclick="adminBoardDelete()"/>
      	</c:if>
      </td>
    </tr>
  </table>
  
  <table class="table table-borderless" style="width:1100px; margin:0 auto;">
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
      <td colspan="3">
        <a href="javascript:goodDBCheck(${goodVo.idx})">
          <c:if test="${!empty goodVo}"><font color="red">❤</font></c:if>
          <c:if test="${empty goodVo}">❤</c:if>이 글이 도움이 되었나요?
        </a>
      </td>
    </tr>
  </table>
  
  <!-- 댓글 리스트보여주기 -->
  <div id="reply" class="container mt-5">
    <table class="table table-borderless" style="width:1100px; margin:0 auto;">
      <tr>
        <th> &nbsp;작성자</th>
        <th>내용</th>
        <th>작성일</th>
        <th></th>
      </tr>
      <c:forEach var="replyVO" items="${replyVOS}" varStatus="st">
        <tr>
          <td>
	          <c:if test="${replyVO.level>=1}">&nbsp;&nbsp;&nbsp;&nbsp;└─</c:if>
            ${replyVO.nickName}
            <c:if test="${sMid == replyVO.mid || sLevel == 0}">
              (<a href="javascript:replyDelete(${replyVO.idx},${replyVO.level})" title="댓글삭제"><b>x</b></a>
              <c:if test="${sMid == replyVO.mid || sLevel == 0}">
	            	,<a href="javascript:updateReplyForm('${replyVO.idx}','${content}')" title="댓글수정" id="replyBoxUpdateBtn${replyVO.idx}">√</a>
	            </c:if>
              )
            </c:if>
          </td>
          <td>${fn:replace(replyVO.content, newLine, "<br/>")}</td>
          <td class="text-center">${fn:substring(replyVO.WDate,0,10)}</td>
          <td class="text-center">
            <c:set var="content" value="${fn:replace(replyVO.content, newLine, '<br/>')}" />
            <a href="javascript:insertReply('${replyVO.idx}','${replyVO.groupId}','${replyVO.level}','${replyVO.nickName}')" id="replyBoxOpenBtn${replyVO.idx}" class="badge badge-dark">답글</a>
            <input type="button" value="접기" onclick="closeReply(${replyVO.idx})" id="replyBoxCloseBtn${replyVO.idx}" class="btn btn-warning btn-sm" style="display:none;" />
          </td>
        </tr>
        <tr>
          <td colspan="5" class="m-0 p-0" style="border-top:none;"><div id="replyBox${replyVO.idx}"></div></td>
        </tr>
      </c:forEach>
    </table>
  </div>

<p><br/></p>  
<p><br/></p>  
<p><br/></p>  
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