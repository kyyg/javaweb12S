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
	      <img src="${ctp}/images/crs0.jpg" class="w3-circle" width="70%" width="800px"; height="700px">
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
<div class="container text-center" style="width:1000px; margin:0 auto;">
	<h3 class="mb-5">NEW ITEM</h3>
	<table> 
		<tr>
		<c:forEach var="vo" items="${newVOS3}">
			<td class="mr-5">
		 		<img src="${ctp}/dbShop/product/${vo.FSName}" class="w3-round mb-2" width=300px; height=300px; /><br/>
		 		<span class="text-center">${vo.productName}</span><br/>
		 		<span class="text-center">${vo.mainPrice}원</span><br/>
			</td>
			<td class="mr-5 pr-5"></td>
  	</c:forEach>
		</tr>		
	</table>
</div>
<p><br/></p>
<p><br/></p>

<div class="container text-center" style="width:1000px; margin:0 auto;">
	<h3 class="mb-5">BEST ITEM</h3>
	<table> 
		<tr>
		<c:forEach var="vo" items="${newVOS3}">
			<td class="mr-5">
		 		<img src="${ctp}/dbShop/product/${vo.FSName}" class="w3-round mb-2" width=300px; height=300px; /><br/>
		 		<span class="text-center">${vo.productName}</span><br/>
		 		<span class="text-center">${vo.mainPrice}원</span><br/>
			</td>
			<td class="mr-5 pr-5"></td>
  	</c:forEach>
		</tr>		
	</table>
</div>
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
