<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>onedayClass.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <style>
  
  *{
    padding: 0px;
    margin: 0px;
    box-sizing: border-box;
}

header{
    background-image: url('${ctp}/images/backgrounds.jpg');
    height: 880px;
    background-size: 100% 100%;
}

.nn {
    display: grid;
    grid-template-columns: auto auto;
    justify-content: space-between;
}
.logo{
    margin: 15px 0 0 20px;
    color: white;
    font-size: 35px;
    font-weight: 800;
}

.menu ul{
    margin: 20px 20px 0 20px;
    display:grid;
    grid-template-columns: auto auto auto auto;
    grid-gap: 30px;
    list-style-type: none;
 
}

.menu ul a {
    text-decoration: none;
    color:white;
    font-weight: 800;
}

.search__box{
    width:500px;
    display: inline-block;
    background-color: white;
    padding: 20px 30px;
    position: relative;
    top: 1px;
    left: 200px;
    border-radius: 6px;
    box-shadow: 0 2px 2px 0 rgb(216, 208, 208);
}

#content{
	width:700px;
  display: inline-block;
  padding: 20px 30px;
  position: relative;
  top: 150px;
  left: 500px;
}
.search__title{
    padding: 10px 0;
    font-size: 25px;
    font-weight: 800px;
    text-align : center;
    color: gray;
    border-bottom : 2px solid gray;

}

table{
    width:100%;
}

.search__sub__title{
padding: 10px 0;
font-size: 12px;
font-weight: 600;
}

.search__input{

    height: 35px;
    width: 100%;
    color: rgb(107, 107, 107);
    font-size:13px;
    border: 1px solid rgb(230,227,227);
}

.search__button{
    display: grid;
    justify-content: end;
    align-items: flex-end;
    padding: 20px 0 5px;
}

.search__button button {
   background-color: skyblue;
   color:rgb(255, 255, 255);
   font-size: 16px;
   font-weight: 800;
   border-radius: 6px;
   border: 0;
   cursor: pointer;
}

main{
margin: 30px 80px;
} 

section{
    margin: 30px 0;
}

.sec__title{
font-size:25px;
font-weight: 800;
color: rgb(117, 117, 117);
margin-bottom:10px;
}
  
</style>
<script>
  'use strict';
  
  function onedayClassCheck(){
	  let classTemp;
		let mid = $("#mid").val();
		let store = $("#store").val();
		let wDate = $("#wDate").val();
		let memberNum = $("#memberNum").val();
		let className = $("#className").val();
		
   	if(store == "" || wDate == "" || memberNum == "") {
   		alert("모든 정보를 기입해주세요.");
   		return false;
   	}
  	
	 // qr코드내역
		classTemp  = "["+className+"]\n";
		classTemp  += "아이디 : " + mid + ",\n";
		classTemp  += "매장명 : " + store + ",\n";
		classTemp  += "날짜 : " + wDate + ",\n";
		classTemp  += "인원수 : " + memberNum + "명\n";
		classTemp  += "반드시 QR코드를 지참하여 오시기 바랍니다.";
				
		let query = {
			mid : mid,
			className : className,
			store : store,
			wDate : wDate,
			memberNum : memberNum,
			classTemp : classTemp
		}
		
		$.ajax({
			type : "post",
			url  : "${ctp}/dbShop/dbOnedayClassInput",
			data : query,
			success:function() {
				alert("원데이 클래스 예약이 완료되었습니다.\n반드시 QR코드를 지참하여 오시기 바랍니다.");
				location.reload();
			},
			error:function(){
				alert("전송오류우웅!");
			}
		});
  }
  
  
  
  
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<header>
<div class="nn">
  <div class="logo">
  	ONEDAY CLASS EVENT
  </div>

  <div class="menu">
    <ul>
    </ul>
  </div>
</div>

 <div>
  <div class="search__box">
    <div class="search__title mb-4">
     명화 비누 제작<br/>
      원데이 클래스
    </div>
    <table>
      <tr>
    	  <td style="width:30%" class="search__sub__title">예약자 아이디</td>
        <td style="width:70%" class="text-left"><span><b>${sMid}</b></span></td>
      </tr>
      <tr>
        <td colspan="2" class="search__sub__title">매장 선택</td>
      </tr>
      <tr>
       <td colspan="2"> 
         <select class="form-control" name="store" id="store">
         	<option>매장 선택</option>
         	<option>매장1</option>
         	<option>매장2</option>
         </select>
       </td>
      </tr>
      <tr>
    	  <td colspan="2" class="search__sub__title">예약날짜</td>
      </tr>
      <tr>
          <td colspan="2"><input class="search__input" id="wDate" name="wDate" type="date" /></td>
      </tr>
      <tr>
          <td colspan="2" class="search__sub__title">인원</td>
      </tr>
      <tr>
      <td colspan="2">
       <select class="search__input" name="memberNum" id="memberNum" >
          <option>1</option>
          <option>2</option>
       </select>
       </td>
      </tr>
		<tr>
			<td colspan="2">
				<c:forEach var="vo" items="${vos}">
					<c:if test="${vo.validMember == sMid}">
	   				<input type="button" class="btn btn-outline-dark form-control mt-3" value="예약하기" onclick="onedayClassCheck()" />
	   			</c:if>
					<c:if test="${vo.validMember != sMid}">
	   			</c:if>
				</c:forEach>
			</td>
		</tr>
   </table>
   <input type="hidden" id="className" name="className" value="명화비누 제작 원데이 클래스">
   <input type="hidden" id="mid" name="mid" value="${sMid}">
  </div>
<div id="content" style="color:white;">
<b>명화비누 제작 원데이 클래스 이벤트(2023.06~)</b><br/>
<br/>
매주 주말 1시<br/>
소요시간 : 2시간<br/>
<br/>
3개월간 총 구매금액이 10만원 이상인 회원들을 대상으로 열리는 이벤트 입니다.<br/>
방문 시 예약한 날짜/장소에 QR코드를 지참하여 참석하셔야 합니다.<br/>
본 페이지에서 예약 후 예약확정문자를 발송해 드립니다.<br/>
숙성CP비누로 당일날은 가져 갈 수 없고, 보온 및 건조기간을 거쳐 한달 뒤 발송됩니다.<br/>
본 이벤트는 무료입니다.<br/>
</div>
  </section>
</header>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>