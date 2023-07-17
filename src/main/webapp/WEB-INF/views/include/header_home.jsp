<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
	<link rel="stylesheet" href="${ctp}/css/owl.carousel.min.css">
	<link rel="stylesheet" href="${ctp}/css/owl.theme.default.min.css">
	<script src="${ctp}/js/owl.carousel.js"></script> 
	<script src="${ctp}/js/owl.carousel.min.js"></script>

<style>
.item {
		width: 200px;
		height: 200px;
		margin: 3px;
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
	      <img src="${ctp}/images/crs0.jpg" width="80%" height="700px">
	      <div class="carousel-caption" style="width:100%">
	      </div>   
	    </div>
	    <div class="carousel-item">
	      <img src="${ctp}/images/crs1.jpg" width="80%" height="700px">
	      <div class="carousel-caption" style="width:100%">
	      </div>   
	    </div>
	    <div class="carousel-item">
	      <img src="${ctp}/images/crs2.jpg" width="80%" height="700px">
	      <div class="carousel-caption" style="width:100%">
	      </div>   
	    </div>
	  </div>
	  <!-- Left and right controls -->
	  <a class="carousel-control-prev" href="#demo" data-slide="prev">
	    <span class="carousel-control-prev-icon"></span>
	  </a>
	  <a class="carousel-control-next" href="#demo" data-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </a>
	  <a class="carousel-control-next" href="#demo" data-slide="next">
	    <span class="carousel-control-next-icon"></span>
	  </a>
	</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>

   <div class="owl-carousel owl-theme">
		<div class="item"><img src="${ctp}/images/crs1.jpg" /></div>
		<div class="item"><img src="${ctp}/images/crs1.jpg" /></div>
		<div class="item"><img src="${ctp}/images/crs1.jpg" /></div>
   </div>

<p><br/></p>
<p><br/></p>
<p><br/></p>
<div class="container text-center">
	<span>
		<iframe width="1200" height=700" src="https://www.youtube.com/embed/0Z2_08ryoQc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe> 
	</span>
</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<script>
		$('.owl-carousel').owlCarousel({
		    stagePadding: 100,
		    loop:true,
		    margin:0,
		    nav:true,
		    autoplay:true,
		    autoplayTimeout:2000,
		    autoplayHoverPause:true,
		    responsive:{
		        0:{
		            items:1
		        },
		        600:{
		            items:3
		        },
		        1000:{
		            items:6
		        }
		    }
		})
	</script>
