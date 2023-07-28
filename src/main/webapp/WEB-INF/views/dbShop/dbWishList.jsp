<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>dbWishList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script>
  	'use srtict';
  	
  	function wishDelete(idx){
  	  let ans = confirm("위시리스트에서 삭제 하시겠습니까?");
 	  	if(!ans) {
 	  		location.reload();
 	  		return false;
 	  	}
			$.ajax({
				type : "post",
				url : "${ctp}/dbShop/wishDelete",
				data : {idx : idx},
				success:function(){
			    alert("위시리스트에서 삭제 되었습니다.");
					location.reload();
				},
				error:function(){
					alert("전송오류");					
				}
			});  		
  	}
  	
  	// 다중삭제
  	function idxDelete(){
  		let ans = confirm("선택하신 상품을 삭제하시겠습니까?");
  		if(!ans){
  			location.reload();
 	  		return false;
  		} 
  		
  		let idxs="";
  		let flag="";
  		let checkIdxs = document.getElementsByName("idxChecked");
  		for (let i = 0; i < checkIdxs.length; i++) {
    	  if (checkIdxs[i].checked) {
    	    idxs += checkIdxs[i].value + "/";
    	  }
    	}
  		
   		$.ajax({
        type : "post",
        url : "${ctp}/dbShop/wishDelete2",
        data : {
        	idxs : idxs
        },
        success : function(){
         alert("위시리스트에서 삭제 되었습니다.");
         location.reload();
        },
        error : function(){
         alert("전송 오류");
        }
      })  
  	}
  
  </script>
  <style>
  .wd-wrapper {
    position: relative;
    display: inline-block;
    margin-top: 2px; 
  }
  .wd{
    position: absolute;
    top: 265px;
    left: 285px;
  }
  
  .idxChecked-wrapper{
    position: relative;
    display: inline-block;
    margin-top: 0px; 
  }
  #idxChecked{
    position: absolute;
    top: -35px;
    left: 0;
  } 
  
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<jsp:include page="/WEB-INF/views/include/nav2.jsp" />
<hr/>
 <div class="text-center"><font size="5">위시리스트</font></div>
 <div class="text-center"><font size="2">위시리스트는 3개월 간 저장됩니다.</font></div>
 <input type="button" value="선택삭제" class="btn btn-outline-dark btn-sm ml-3" onclick="idxDelete()" />
 <hr/>
 <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${vos}">
      <div class="col-md-4">
      <a href="javascript:wishDelete(${vo.idx})" class="btn btn-light btn-sm ml-2 wd">삭제</a>
      	<input type="checkbox" name="idxChecked" id="idxChecked" value="${vo.idx}" class="ml-5 mt-5"/>
        <div style="text-align:center">
          <a href="${ctp}/dbShop/dbProductContent?idx=${vo.productIdx}">
            <img src="${ctp}/dbShop/product/${vo.FSName}" width="300px" height="300px"/>
            <div class="mt-2"><font size="2">${vo.productName}</font></div>
          </a>
            <div><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</div>
            <div><font size="2"><span class="badge badge-info">${vo.detail}</span></font></div>
        </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt%3 == 0}">
        </div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
  </div>

</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>