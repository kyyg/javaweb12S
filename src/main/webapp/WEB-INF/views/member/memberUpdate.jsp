<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memberUpdate.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
    'use strict';
    // 닉네임 중복버튼을 클릭했는지의 여부를 확인하기위한 변수(버튼 클릭후에는 내용 수정처리 못하도록 처리)
    let nickCheckSw = 0;
    
    function fCheck() {
    	// 유효성 검사.....
    	// 아이디,닉네임,성명,이메일,홈페이지,전화번호,비밀번호 등등....
    	
    	let regMid = /^[a-zA-Z0-9_]{4,20}$/;
      let regNickName = /^[가-힣]+$/;
      let regName = /^[가-힣a-zA-Z]+$/;
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    	let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
    	
    	let mid = myform.mid.value.trim();
    	let nickName = myform.nickName.value;
    	let name = myform.name.value;
    	let email1 = myform.email1.value.trim();
    	let email2 = myform.email2.value;
    	let email = email1 + "@" + email2;
    	let tel1 = myform.tel1.value;
    	let tel2 = myform.tel2.value.trim();
    	let tel3 = myform.tel3.value.trim();
    	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
    	let submitFlag = 0;		// 모든 체크가 정상으로 종료되게되면 submitFlag는 1로 변경처리될수 있게 한다.

    	// 앞의 정규식으로 정의된 부분에 대한 유효성체크
   
      if(!regNickName.test(nickName)) {
        alert("닉네임은 한글만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 한글과 영문대소문자만 사용가능합니다.");
        myform.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지않습니다.");
        myform.email1.focus();
        return false;
      }
 
    	
    	if(tel2 != "" && tel3 != "") {
    	  if(!regTel.test(tel)) {
	    		alert("전화번호형식을 확인하세요.(000-0000-0000)");
	    		myform.tel2.focus();
	    		return false;
    	  }
    	  else {
    		  submitFlag = 1;
    	  }
    	}
    	else {		// 전화번호를 입력하지 않을시 DB에는 '010- - '의 형태로 저장하고자 한다.
    		tel2 = " ";
    		tel3 = " ";
    		tel = tel1 + "-" + tel2 + "-" + tel3;
    		submitFlag = 1;
    	}
    	
    	// 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
    	let postcode = myform.postcode.value + " ";
    	let roadAddress = myform.roadAddress.value + " ";
    	let detailAddress = myform.detailAddress.value + " ";
    	let extraAddress = myform.extraAddress.value + " ";
  		myform.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
    	  		
    	// 전송전에 모든 체크가 끝나면 submitFlag가 1로 되게된다. 이때 값들을 서버로 전송처리한다.
    	if(submitFlag == 1) {
    		if(nickCheckSw == 0) {
    			alert("닉네임 중복체크버튼을 눌러주세요!");
    			document.getElementById("nickNameBtn").focus();
    		}
    		else {
	    		myform.email.value = email;
	    		myform.tel.value = tel;
		    	myform.submit();
    		}
    	}
    	else {
    		alert("폼의 내용을 확인하세요.");
    	}
    }
    
    // 닉네임 중복체크
    function nickCheck() {
    	let nickName = myform.nickName.value;
    	if(nickName == '${sNickName}') {
    		nickCheckSw = 1;
    		return false;
    	}
    	if(nickName.trim() == "" || nickName.length < 2 || nickName.length > 20) {
    		alert("닉네임을 확인하세요!(닉네임는 2~20자 이내)");
    		myform.nickName.focus();
    		return false;
    	}
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/member/memberNickCheck",
    		data : {nickName : nickName},
    		success:function(res) {
    			if(res == "1") {
    				alert("이미 사용중인 닉네임 입니다. 다시 입력해 주세요");
    				$("#nickName").focus();
    			}
    			else  {
    				alert("사용 가능한 닉네임 입니다.");
    				nickCheckSw = 1;
    				$("#name").focus();
    			}
    		}
    	});
    }
    
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<hr/>
<div class="container">
	<div style="width:600px; margin: 0 auto;">
	<h3 class="text-center mt-5">회원정보수정</h3>
	<hr/>
	  <form name="myform" method="post" action="${ctp}/member/memberUpdateOk" class="was-validated">
	    <br/>
	    <div class="form-group">
	      아이디 : ${sMid}
	    </div>
	    <div class="form-group">
	      <label for="nickName">닉네임(한글) : &nbsp; &nbsp;<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="btn btn-outline-dark btn-sm" onclick="nickCheck()"/></label>
	      <input type="text" name="nickName" id="nickName" value="${vo.nickName}" class="form-control" placeholder="닉네임을 입력하세요." name="nickName" required />
	    </div>
	    <div class="form-group">
	      <label for="name">성명 :</label>
	      <input type="text" name="name" id="name" value="${vo.name}" placeholder="성명을 입력하세요." class="form-control" required />
	    </div>
	    <div class="form-group">
	      <label for="email1">Email address:</label>
	        <div class="input-group mb-3">
	          <c:set var="emails" value="${fn:split(vo.email,'@')}" />
	          <c:set var="email1" value="${emails[0]}"/>
	          <c:set var="email2" value="${emails[1]}"/>
	          <input type="text" name="email1" id="email1" value="${email1}" class="form-control" placeholder="Email을 입력하세요." required />
	          <div class="input-group-append">
	            <select name="email2" class="custom-select">
	              <option value="naver.com"   ${email2 == 'naver.com'   ? selected : ''}>naver.com</option>
	              <option value="hanmail.net" ${email2 == 'hanmail.net' ? selected : ''}>hanmail.net</option>
	              <option value="hotmail.com" ${email2 == 'hotmail.com' ? selected : ''}>hotmail.com</option>
	              <option value="gmail.com"   ${email2 == 'gmail.com'   ? selected : ''}>gmail.com</option>
	              <option value="nate.com"    ${email2 == 'nate.com'    ? selected : ''}>nate.com</option>
	              <option value="yahoo.com"   ${email2 == 'yahoo.com'   ? selected : ''}>yahoo.com</option>
	            </select>
	          </div>
	        </div>
	    </div>
	    <div class="form-group">
	      <div class="input-group mb-3">
	        <div class="input-group-prepend">
	          <span class="input-group-text">전화번호 :</span> &nbsp;&nbsp;
	            <c:set var="tel" value="${fn:split(vo.tel,'-')}"/>
	            <c:set var="tel1" value="${tel[0]}"/>
	            <c:set var="tel2" value="${fn:trim(tel[1])}"/>
	            <c:set var="tel3" value="${fn:trim(tel[2])}"/>
	            <select name="tel1" class="custom-select">
	              <option value="010" ${tel1=="010" ? selected : ""}>010</option>
	              <option value="02"  ${tel1=="02" ? selected : ""}>서울</option>
	              <option value="031" ${tel1=="031" ? selected : ""}>경기</option>
	              <option value="032" ${tel1=="032" ? selected : ""}>인천</option>
	              <option value="041" ${tel1=="041" ? selected : ""}>충남</option>
	              <option value="042" ${tel1=="042" ? selected : ""}>대전</option>
	              <option value="043" ${tel1=="043" ? selected : ""}>충북</option>
	              <option value="051" ${tel1=="051" ? selected : ""}>부산</option>
	              <option value="052" ${tel1=="052" ? selected : ""}>울산</option>
	              <option value="061" ${tel1=="061" ? selected : ""}>전북</option>
	              <option value="062" ${tel1=="062" ? selected : ""}>광주</option>
	            </select>-
	        </div>
	        <input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control"/>-
	        <input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 class="form-control"/>
	      </div>
	    </div>
	    <div class="form-group">
	      <label for="address">주소</label>
	      <c:set var="address" value="${fn:split(vo.address,'/')}"/>
	      <c:set var="postcode" value="${address[0]}"/>
	      <c:set var="roadAddress" value="${address[1]}"/>
	      <c:set var="detailAddress" value="${address[2]}"/>
	      <c:set var="extraAddress" value="${address[3]}"/>
	      <div class="input-group mb-1">
	        <input type="text" name="postcode" id="sample6_postcode" value="${postcode}" placeholder="우편번호" class="form-control">
	        <div class="input-group-append">
	          <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
	        </div>
	      </div>
	      <input type="text" name="roadAddress" id="sample6_address" value="${roadAddress}" size="50" placeholder="주소" class="form-control mb-1">
	      <div class="input-group mb-1">
	        <input type="text" name="detailAddress" id="sample6_detailAddress" value="${detailAddress}" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
	        <div class="input-group-append">
	          <input type="text" name="extraAddress" id="sample6_extraAddress" value="${extraAddress}" placeholder="참고항목" class="form-control">
	        </div>
	      </div>
	    </div>
	    <div class="text-center">
	    	<hr/>
		    <button type="button" class="btn btn-outline-dark form-control pt-2 pb-2" onclick="fCheck()">정보 수정</button> &nbsp;
	    </div>
	    <input type="hidden" name="email" />
	    <input type="hidden" name="tel" />
	    <input type="hidden" name="address" />
	    <input type="hidden" name="mid" value="${sMid}"/>
	  </form>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>