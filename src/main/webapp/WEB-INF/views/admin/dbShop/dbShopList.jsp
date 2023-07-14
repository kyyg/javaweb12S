<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbShoptList.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	
	<style>
	#cate{
	background-color:black;
	color:white;
	padding : 0px 2px 0px 2px;
	}
	</style>
	<script>
    // part선택시 해당 part만 불러오기
    function partCheck() {
    	let part = partForm.part.value;
    	location.href = "${ctp}/dbShop/dbShopList?part="+part;
    }
    
    
    if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/dbShop/dbShopList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
    
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/dbShop/dbShopList?pag=${pageVO.pag}&pageSize="+pageSize;
    }
	
    $(function(){
	    $("#productStatus").change(function(){
	      let select = $(this).val().split("/");
	      let productStatus = select[0];
	      let idx = select[1];
	      
	      let ans = confirm("상품의 판매 상태를 변경하시겠습니까?");
	      if (!ans) {
          location.reload();
          return false;
	      }
	      
	      $.ajax({
          type: "post",
          url: "${ctp}/dbShop/productStatusChange",
          data: {
	          idx: idx,
	          productStatus: productStatus
          },
          success: function() {
            location.reload();
          },
          error: function() {
            alert("전송 오류");
          }
	      });
	    });
    });

    function productStatusChange(e){
   	  let ans = confirm("상품의 판매 상태를 변경하시겠습니까?");
   	  	if(!ans) {
   	  		location.reload();
   	  		return false;
   	  	}
   		let item = e.value.split("/");
     	
     	$.ajax({
     		type : "post",
     		url : "${ctp}/dbShop/productStatusChange",
     		data : {
     			productStatus : item[0],
     			idx : 	 item[1]
     			},
     		success : function(res){
     				location.reload();
     		},
     		error:function(){
     			alert("전송오류");
     			location.reload();		
     		}
     	});
     }
    
    
	</script>
</head>
<body>
<p><br/></p>
<div class="container">
	<div class="text-center">
	  <span id="cate"><b><a href="${ctp}/dbShop/dbShopList">전체상품</a></b></span>
	  	<c:forEach var="mainTitle" items="${mainTitleVOS}" varStatus="st">
	  	<span id="cate"><a href="${ctp}/dbShop/dbShopList?part=${mainTitle.categoryMainName}">${mainTitle.categoryMainName}</a></span>
		  <c:if test="${!st.last}"> </c:if>
	 	</c:forEach> 
	  <h3 class="text-center">
	  <c:if test="${part == '전체'}"></c:if>
	  <c:if test="${part != '전체'}">${part}</c:if>
	  </h3>
  </div>
  <hr/>
  
    <table class="table table-borderless">
      <tr>
      <td class="text-left">
        <!-- 한페이지 분량처리 -->
        <select name="pageSize" id="pageSize" onchange="pageCheck()">
          <option <c:if test="${pageVO.pageSize == 3}">selected</c:if>>3</option>
          <option <c:if test="${pageVO.pageSize == 9}">selected</c:if>>9</option>
          <option <c:if test="${pageVO.pageSize == 12}">selected</c:if>>12</option>
          <option <c:if test="${pageVO.pageSize == 15}">selected</c:if>>15</option>
          <option <c:if test="${pageVO.pageSize == 18}">selected</c:if>>18</option>
        </select> 건
      </td>
      <td>
      	<div class="text-right">
			  	<span><a href="${ctp}/dbShop/dbShopList?part=${part}&sort=높은가격순" class="p-2">높은가격순</a></span>|
			  	<span><a href="${ctp}/dbShop/dbShopList?part=${part}&sort=낮은가격순" class="p-2">낮은가격순</a></span>|
			  	<span><a href="${ctp}/dbShop/dbShopList?part=${part}&sort=신상품순" class="p-2">신상품순</a></span>|
			  	<span><a href="${ctp}/dbShop/dbShopList?part=${part}&sort=상품명순" class="p-2">상품명순</a></span>
			  </div>
      </td>
    </tr>
  </table>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
      <table class="table table-borderless table-hover text-center">
      	<tr class="text-dark table-dark">
      		<th>고유번호</th>
      		<th>대분류</th>
      		<th>중분류</th>
      		<th>썸네일</th>
      		<th>상품 이름</th>
      		<th>상품 가격</th>
      		<th>비고</th>
      		<th>판매상태</th>
      		<th></th>
      	</tr>
		    <c:forEach var="vo" items="${productVOS}">
      	<tr>
      		<td>${vo.idx}</td>
      		<td>${vo.categoryMainCode}</td>
      		<td>${vo.categoryMiddleCode}</td>
      		<td>
      			<a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}">
            	<img src="${ctp}/dbShop/product/${vo.FSName}" width="50px" height="50px"/>
            </a>
            </td>
      		<td>${vo.productName}</td>
      		<td>${vo.mainPrice}</td>
      		<td>${vo.detail}</td>
      		<td>
      			<select name="productStatus" id="productStatus" onchange="productStatusChange(this)">
      				<option value="판매중/${vo.idx}" ${vo.productStatus == "판매중" ? "selected" : ""} >판매중</option>
      				<option value="판매중지/${vo.idx}" ${vo.productStatus == "판매중지" ? "selected" : ""} >판매중지</option>
      				<option value="품절/${vo.idx}" ${vo.productStatus == "품절" ? "selected" : ""} >품절</option>
      			</select>
      		</td>
      		<td><input type="button" value="상품수정" class="btn btn-outline-dark btn-sm" onclick="location.href='${ctp}/dbShop/productModify?idx=${vo.idx}';"/></td>
      	</tr>
		    </c:forEach>
      </table>
  </div>
</div>
 <!-- 블록 페이징 처리 -->
  <div class="text-center m-4">
	  <ul class="pagination justify-content-center pagination-sm">
	    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=1">첫페이지</a></li></c:if>
	    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">이전블록</a></li></c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li></c:if>
	    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbShopList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">마지막페이지</a></li></c:if>
	  </ul>
  </div>
  <p><br/></p>
</body>
</html>