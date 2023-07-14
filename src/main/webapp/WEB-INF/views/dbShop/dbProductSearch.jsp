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
  <title>dbProductList.jsp</title>
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
    	location.href = "${ctp}/dbShop/dbProductList?part="+part;
    }
    
    
    if(${pageVO.pag} > ${pageVO.totPage}) location.href="${ctp}/dbShop/dbProductList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}";
    
    function pageCheck() {
    	let pageSize = document.getElementById("pageSize").value;
    	location.href = "${ctp}/dbShop/dbProductList?pag=${pageVO.pag}&pageSize="+pageSize;
    }
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
	<div class="text-center">
	  <span id="cate"><b><a href="${ctp}/dbShop/dbProductList">전체상품</a></b></span>
	  	<c:forEach var="mainTitle" items="${mainTitleVOS}" varStatus="st">
	  	<span id="cate"><a href="${ctp}/dbShop/dbProductList?part=${mainTitle.categoryMainName}">#${mainTitle.categoryMainName}</a></span>
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
			  	<span><a href="${ctp}/dbShop/dbProductList?part=${part}&sort=높은가격순" class="p-2">높은가격순</a></span>|
			  	<span><a href="${ctp}/dbShop/dbProductList?part=${part}&sort=낮은가격순" class="p-2">낮은가격순</a></span>|
			  	<span><a href="${ctp}/dbShop/dbProductList?part=${part}&sort=신상품순" class="p-2">신상품순</a></span>|
			  	<span><a href="${ctp}/dbShop/dbProductList?part=${part}&sort=상품명순" class="p-2">상품명순</a></span>
			  </div>
      </td>
    </tr>
  </table>
  <c:set var="cnt" value="0"/>
  <div class="row mt-4">
    <c:forEach var="vo" items="${productVOS}">
      <div class="col-md-4">
        <div style="text-align:center">
          <a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}">
          	<c:if test="${vo.productStatus == '품절'}">
            	<img src="${ctp}/dbShop/product/${vo.FSName}" width="300px" height="300px" style="opacity:40%" />
            	<div class="mt-2"><font size="2">${vo.productName}<span class="badge badge-danger ml-1">품절</span></font></div>
            </c:if>
          	<c:if test="${vo.productStatus != '품절'}">
            	<img src="${ctp}/dbShop/product/${vo.FSName}" width="300px" height="300px"/>
            	<div class="mt-2"><font size="2">${vo.productName}</font></div>
          </a>
            </c:if>
            <div><font size="2" color="orange"><fmt:formatNumber value="${vo.mainPrice}" pattern="#,###"/>원</font></div>
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
 <!-- 블록 페이징 처리 -->
  <div class="text-center m-4">
	  <ul class="pagination justify-content-center pagination-sm">
	    <c:if test="${pageVO.pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbProductList?pageSize=${pageVO.pageSize}&pag=1">첫페이지</a></li></c:if>
	    <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbProductList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}">이전블록</a></li></c:if>
	    <c:forEach var="i" begin="${pageVO.curBlock*pageVO.blockSize + 1}" end="${pageVO.curBlock*pageVO.blockSize + pageVO.blockSize}" varStatus="st">
	      <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link text-white bg-secondary border-secondary" href="${ctp}/dbShop/dbProductList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	      <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbProductList?pageSize=${pageVO.pageSize}&pag=${i}">${i}</a></li></c:if>
	    </c:forEach>
	    <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbProductList?pageSize=${pageVO.pageSize}&pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}">다음블록</a></li></c:if>
	    <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/dbShop/dbProductList?pageSize=${pageVO.pageSize}&pag=${pageVO.totPage}">마지막페이지</a></li></c:if>
	  </ul>
  </div>
  <p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>