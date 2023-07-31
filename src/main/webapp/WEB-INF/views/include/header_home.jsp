<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
	<link rel="stylesheet" href="${ctp}/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${ctp}/css/owl.theme.default.min.css">
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<script src="${ctp}/js/owl.carousel.js"></script> 
	<script src="${ctp}/js/owl.carousel.min.js"></script>

<style>
.item {
		margin: 20px;
	}
	.item:hover {
		transform: scale(1.05);
		transition: transform 0.15s ease 0s;
	}
	.owl-carousel {
		z-index: 0;
	}


.rec__title{
  font-size: 25px;
  color: gray;
  border-top: 1px solid rgb(226, 204, 204);
  padding: 40px 0px 80px 0px;
  font-weight: bolder;
  text-align: center;  
}
.rec a{
text-decoration: none;
color: rgb(153, 123, 123);
}
.rec__box, .rec_box2{
  display: flex;
  flex-wrap: wrap;
}
.rec{
  width: 33%;
  color: rgb(136, 108, 118);
  text-align: center;
}
.rec__info{
	text-align:center;

}
.rec__info1{
  font-weight: bolder;
}
.rec__info2, .rec__info3{
  font-size: 12px;  
}
.rec2{
display : grid;

}
</style>

		<div id="demo" class="carousel slide" data-ride="carousel" style="z-index:0">
	  <!-- Indicators -->
	  <ul class="carousel-indicators">
	    <li data-target="#demo" data-slide-to="0" class="active"></li>
	    <li data-target="#demo" data-slide-to="1"></li>
	  </ul>
	  
	  <!-- The slideshow -->
	  <div class="carousel-inner text-center" style="z-index:0">
	    <div class="carousel-item active" style="z-index:0">
	      <img src="${ctp}/images/mainImg1.jpg" width="1200px" height="687px">
	      <div class="carousel-caption" style="width:100%">
	      </div>   
	    </div>
	   <%--  <div class="carousel-item">
	      <img src="${ctp}/images/crs1.jpg" width="80%" height="700px">
	      <div class="carousel-caption" style="width:100%">
	      </div>   
	    </div>
	    <div class="carousel-item">
	      <img src="${ctp}/images/crs2.jpg" width="80%" height="700px">
	      <div class="carousel-caption" style="width:100%">
	      </div>   
	    </div> --%>
	  </div>
	  <!-- Left and right controls -->
	  <a class="carousel-control-prev" href="#demo" data-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </a>
	  </a>
	</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<div class="container text-center">
	<div class="owl-carousel owl-theme">
		<c:forEach var="vo" items="${newVOS}">
    	<div class="item">
    		<a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}">
	    		<img src="${ctp}/dbShop/product/${vo.FSName}" class="w3-round" width=350px; height=230px;><br/>
    		</a>
    	</div>
		</c:forEach>
	</div>
</div>
<p><br/></p>
<p><br/></p>
<div class="text-center"><font size="6">NEW ITEM</font></div>
<div class="text-center" style="margin-left:275px;">
<c:set var="cnt" value="0"/>
  <div class="row mt-4">
   <c:forEach var="vo" items="${newVOS3}">
   <c:set var="productDetail" value="${fn:split(vo.detail,'/')}" />
     <div class="mr-3">
       <div style="text-align:center">
       
         <a href="${ctp}/dbShop/dbProductContent?idx=${vo.idx}">
         
         
         	<c:if test="${vo.productStatus == '품절'}">
           	<img src="${ctp}/dbShop/product/${vo.FSName}" class="w3-grayscale-max" width="330px" height="330px" style="opacity:40%" />
            	<div class="mt-2"><font size="2">${vo.productName}<span class="badge badge-danger ml-1">품절</span></font></div>
           </c:if>
           
         	<c:if test="${vo.productStatus != '품절'}">
         		<!-- <button class="w3-button w3-red bestBtn" id="bestBtn">Best</button> -->
           	<img src="${ctp}/dbShop/product/${vo.FSName}" width="330px" height="330px"/>
           	<div class="mt-2">
            	<font size="2"><b>${vo.productName}</b>
								<c:if test="${vo.day_diff < 10}"><span class="badge badge-warning ml-1">NEW</span></c:if>
								<c:if test="${vo.day_diff > 10}"></c:if>
            	</font>
           	</div>
         </c:if>
         
         </a>
           <div><font size="2">${vo.mainPrice}원</font></div>
           <div style="border-bottom:solid 2px gray" class="pt-1 pb-1 mb-1"></div>
           <div>
          	 <c:forEach var="i" begin="0" end="${fn:length(productDetail)-1}">
             <font size="2">
	           	 <a href="${ctp}/dbShop/dbProductList?part=${part}&sort=상품명순&searchString=${productDetail[i]}">
	           	  <span class="badge badge-light" style="background-color:#ded9d5;">#${productDetail[i]}</span>
	             </a>
             </font>
					  </c:forEach>
           </div>
       </div>
      </div>
      <c:set var="cnt" value="${cnt+1}"/>
      <c:if test="${cnt%4 == 0}">
        </div>
        <div class="row mt-5">
      </c:if>
    </c:forEach>
  </div>
</div>
</div>
<p><br/></p>
<p><br/></p>


<p><br/></p>
<p><br/></p>
<p><br/></p>


<script>
var owl = $('.owl-carousel');
owl.owlCarousel({
    items:4,
    loop:true,
    margin:10,
    autoplay:true,
    autoplayTimeout:2000,
    autoplayHoverPause:true
});
$('.play').on('click',function(){
    owl.trigger('play.owl.autoplay',[2000])
})
$('.stop').on('click',function(){
    owl.trigger('stop.owl.autoplay')
})
	</script>
