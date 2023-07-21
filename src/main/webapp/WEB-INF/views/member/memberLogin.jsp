<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberLogin.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
  <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>		<!-- 카카오로그인 js파일 -->
  <script>
		// 카카로그인을 위한 자바스크립트 키
		window.Kakao.init("14ef82a97fb2cefdd36103a9fd72d8f9");
	
	  // 카카오 로그인
		function kakaoLogin() {
			window.Kakao.Auth.login({
				scope: 'profile_nickname, account_email',
				success:function(autoObj) {
					console.log(Kakao.Auth.getAccessToken(),"로그인 OK");
					console.log(autoObj);
					window.Kakao.API.request({
						url : '/v2/user/me',
						success:function(res) {
							const kakao_account = res.kakao_account;
							console.log(kakao_account);
							//alert(kakao_account.email + " / " + kakao_account.profile.nickname);
							location.href="${ctp}/member/memberKakaoLogin?nickName="+kakao_account.profile.nickname+"&email="+kakao_account.email;
						}
					});
				}
			});
		}

  </script>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <div class="modal-dialog">
	  <div class="modal-content p-4">
		  <h2 class="text-center">로그인</h2>
		  <form name="myform" method="post" class="was-validated">
		    <div class="form-group">
		      <label for="mid">회원 아이디</label>
		      <input type="text" class="form-control" name="mid" id="mid" value="${mid}" placeholder="아이디를 입력하세요." required autofocus />
		      <div class="valid-feedback">Ok!!!</div>
		      <div class="invalid-feedback">아이디를 입력해 주세요.</div>
		    </div>
		    <div class="form-group">
		      <label for="pwd">비밀번호</label>
		      <input type="password" class="form-control" name="pwd" id="pwd" value="1234" placeholder="Enter email" required />
		      <div class="valid-feedback">Ok!!!</div>
		      <div class="invalid-feedback">비밀번호를 입력해 주세요.</div>
		    </div>
 				<div class="form-group text-center">
		    	<button type="submit" class="btn btn-outline-dark mr-1">로그인</button>
		    	<button type="button" onclick="location.href='${ctp}/member/memberJoin';" class="btn btn-outline-dark">회원가입</button>
		    </div>
		    <div class="text-center mb-3">
		      <div><a href="javascript:kakaoLogin();"><img src="${ctp}/images/kakao_login_medium_narrow.png" width="150px" /></a></div>			      
			  </div>	
		    <div class="row text-center" style="font-size:12px">
		      <span class="col"><input type="checkbox" name="idSave" checked />아이디 저장</span>
		      <span class="col">
		        [<a href="${ctp}/member/memberIdFind">아이디찾기</a>] /
		        [<a href="${ctp}/member/memberPwdFind">비밀번호찾기</a>]
		      </span>
		    </div>
		  </form>
	  </div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>