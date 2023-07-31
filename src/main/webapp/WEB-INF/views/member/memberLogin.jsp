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
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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
  
  <style>
  
  .inp{
    item-align : center;
  	border : solid 0px #ccc;
  	width : 300px;
  	height : 45px;
  	background-color:#eee;
  	margin-left : 70px;
  }
  
  .loginBtn{
  background-color:#ded9d5;
  border:0px;
  border-radius: 5px;
  width:300px;
  height : 50px;
  }
  
  .finds{
  border : 1px solid #bfb6b2;
  border-radius : 4px;
  padding : 5px;
  }
  
  </style>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
  <div class="modal-dialog">
	  <div class="modal-content p-4" style="background-color:#f8f8f8">
		  <div class="text-center mt-5 mb-5"><img src="${ctp}/images/titleLogo.png" width="250px;" /></div>
		  <form name="myform" method="post" class="was-validated">
		    <div class="form-group">
		      <label for="mid"></label>
		      <input type="text" class="w3-bottombar inp text-center" name="mid" id="mid" value="${mid}" placeholder="아이디를 입력하세요." required autofocus />
		      <div class="valid-feedback"></div>
		      <div class="invalid-feedback"></div>
		    </div>
		    <div class="form-group">
		      <label for="pwd"></label>
		      <input type="password" class="w3-bottombar inp text-center" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." required />
		      <div class="valid-feedback"></div>
		      <div class="invalid-feedback"></div>
		    </div>
		    <div style="width:370px;" class="text-right mt-0 pt-0"><input type="checkbox" name="idSave" checked />&nbsp;<font size="2">아이디 저장</font></div>
 				<div class="form-group text-center">
		    	<button type="submit" class="mr-1 mt-3 loginBtn">로그인</button>
		    </div>
		    <div class="text-center mb-3">
		      <div><a href="javascript:kakaoLogin();"><img src="${ctp}/images/kakaoLogin2.png" width="65px" /></a></div>			      
			  </div>	
		    <div class="row text-center" style="font-size:12px">
		      <span class="col">
		       <a href="${ctp}/member/memberIdFind"><span class="finds">아이디 찾기</span></a>
		       <a href="${ctp}/member/memberPwdFind"><span class="finds">비밀번호 찾기</span></a>
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