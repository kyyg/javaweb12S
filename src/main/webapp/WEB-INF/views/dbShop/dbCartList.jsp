<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<html>
<head>
  <title>dbCartList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <link rel="stylesheet" href="${ctp}/font/font.css">
  <style>

.tbb {
display: grid;
grid-template-columns: 1fr 1fr;
margin-left:50px;
} 

.tb{
margin-top : 60px;
background-color:#e9ecef;
border-radius : 5px;
padding-top : 20px;
padding-bottom : 20px;
margin-left : 5px;
padding-left:15px;
height:320px;
}
  
  .bbtn{
  background-color:#c9c2bc;
  border : 0px solid;
  border-radius : 5px;
  
  }
  </style>
  <script>
    'use strict';
    
    function onTotal(){
      let total = 0;
  		let checkIdxs = document.getElementsByName("idxChecked");
      for(let i=1;i<=checkIdxs.length;i++){
        if(document.getElementById("idx"+i).checked){  
          total += parseInt(document.getElementById("optionPrice"+i).value); 
        }
      }
      document.getElementById("total").value=numberWithCommas(total);
      document.getElementById("orderTotal").value=total;
      
      if(total>=50000||total==0){
        document.getElementById("baesong").value=0;
      } else {
        document.getElementById("baesong").value=2500;
      }
      let lastPrice=parseInt(document.getElementById("baesong").value)+total;
      document.getElementById("lastPrice").value = numberWithCommas(lastPrice);
      document.getElementById("orderTotalPrice").value = lastPrice;
    }

    function onCheck(){
	let total = 0;
    	let checkIdxs = document.getElementsByName("idxChecked");
        for (let i = 1; i <= checkIdxs.length; i++) {
      	  if (document.getElementById("idx"+i).checked) {
      		total += parseInt(document.getElementById("optionPrice"+i).value); 
      		document.getElementById("total").value=numberWithCommas(total);
          document.getElementById("orderTotal").value=total;
      	  }
      		if(total>=50000||total==0){
            document.getElementById("baesong").value=0;
          } else {
            document.getElementById("baesong").value=2500;
          }
      	}   
        let lastPrice=parseInt(document.getElementById("baesong").value)+total;
        document.getElementById("lastPrice").value = numberWithCommas(lastPrice);
        document.getElementById("orderTotalPrice").value = lastPrice;
    }

		
    function allCheck() {
      for(let i=0; i<myform.idxChecked.length; i++) {
        myform.idxChecked[i].checked = !myform.idxChecked[i].checked;
      }
      onTotal();
    }
  
    function cartDelete(idx){
      let ans = confirm("선택하신 상품을 삭제 하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/dbShop/dbCartDelete",
        data : {idx : idx},
        success:function() {
          location.reload();
        },
        error : function() {
        	alert("전송에러!");
        }
      });
    }

    function order(){
    	let idxs = "";
        let checkIdxs = document.getElementsByName("idxChecked");

        for (let i = 0; i < checkIdxs.length; i++) {
      	  if (checkIdxs[i].checked) {
      	    idxs += checkIdxs[i].value + "/";
      	  }
      	}

      document.getElementById("idxs").value = idxs;
      document.myform.baesong.value=document.getElementById("baesong").value;
      
      if(document.getElementById("lastPrice").value==0){
        alert("주문 할 상품을 선택해주세요!");
        return false;
      } 
      else {
        document.myform.submit();
      }
    }
		    
		
    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
		
		
function numChange(idx){
	let num = document.getElementById("optionNum"+idx).value;
	$.ajax({
		type : "post",
		url : "${ctp}/dbShop/dbCartNumChange",
		data : {
			idx : idx,
			num : num
		},
		success:function() {
			
				location.reload();
	
		},
		error:function(){
			//alert("전송오류");
			location.reload();
		}
	});
}

// 선택한 것만 삭제하기
function idxDelete(){
	let ans = confirm("선택하신 상품을 장바구니에서 삭제하시겠습니까?");
      if(!ans){
          location.reload();
          return false;
      }  
      let idxs = "";
      let checkIdxs = document.getElementsByName("idxChecked");

      for (let i = 0; i < checkIdxs.length; i++) {
    	  if (checkIdxs[i].checked) {
    	    idxs += checkIdxs[i].value + "/";
    	  }
    	}
      //console.log(idxs);
      //alert(idxs);
	      
      let query = {
      	idxs   : idxs
      }
       $.ajax({
        type : "post",
        url : "${ctp}/dbShop/cartDelete2",
        data : query,
        success : function(res){
	        if(res == "1"){
	         alert("장바구니에서 삭제 되었습니다.")
	         location.reload();
	        }
	        else{
	        	alert("삭제에 실패했습니다.");
	        	location.reload();
	        }
        },
        error : function(){
         alert("전송 오류");
        }
      }) 
		}
		
		
  </script>
  
  <style>
    .totSubBox {
      background-color:#ddd;
      border : none;
      width : 95px;
      text-align : center;
      font-weight: bold;
      padding : 5 0px;
      color : brown;
    }
    td { padding : 5px; }
    
    .optionNum{
   	 width:60px;
    }
    
    .optionPrice{
     width:100px;
     border:0px;
     text-align : right;
    }
    
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="container">
  <div class="text-center" style="font-size:25px;">장바구니</div>
<div class="tbb">  
<form name="myform" method="post">
<table class="table text-center" style="width:800px">
	<tr>
		<td><input type="button" id="idxCheck" class="btn btn-outline-dark" value="선택삭제" onclick="idxDelete()" /></td>
	</tr>
  <tr class="text-dark bbtn" style="background-color:#c9c2bc">
    <th style="width:10%"><input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/></th>
    <th style="width:45%" colspan="2">상품</th>
    <th style="width:10%">수량</th>
    <th style="width:25%">금액</th>
    <th style="width:10%"></th>
  </tr>
  <tr><td class="p-0 m-0"></td></tr>  
  <c:set var="idxCnt" value="1"/>
  <c:forEach var="listVO" items="${cartListVOS}">
    <tr align="center">
      <td><input type="checkbox" name="idxChecked" id="idx${idxCnt}" value="${listVO.idx}" onClick="onCheck()" /></td>
      <td><a href="${ctp}/dbShop/dbProductContent?idx=${listVO.productIdx}"><img src="${ctp}/dbShop/product/${listVO.thumbImg}" width="50px"/></a></td>     <td align="left">
	<div class="contFont">
		<span><a href="${ctp}/dbShop/dbProductContent?idx=${listVO.productIdx}"><font size="2"><b>${listVO.productName}</b></font></a></span><br/></div>
	<div style="font-size:12px">
	    &nbsp;옵션&nbsp;[${listVO.optionName}] 
	</div>
      </td>
      <td >
	 <input type="number" class="optionNum" id="optionNum${listVO.idx}" value="${listVO.optionNum}" size="1" min="1" max="10" onchange="numChange(${listVO.idx})"/>
      </td>
      <td>
	<div class="text-center">
		<input type="number" class="optionPrice" id="optionPrice${idxCnt}" value="${listVO.optionPrice*listVO.optionNum}" readonly/>원&nbsp;&nbsp;&nbsp;<br/><br/>
		<input type="hidden" id="totalPrice${listVO.idx}" value="${listVO.totalPrice}"/>
	</div>
      </td>
      <td>
	<button type="button" onClick="cartDelete(${listVO.idx})" class="badge badge-outilne-dark m-1" style="border:0px;">X</button>
	<input type="hidden" name="mid" value="${sMid}"/>
      </td>
    </tr>
    <c:set var="idxCnt" value="${idxCnt+1}"/>
  </c:forEach>
  <tr><td colspan="6" class="p-0 m-0"></td></tr>
</table>
  <input type="hidden" id="maxIdx" name="maxIdx" value="${idxCnt}"/>
  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
  <input type="hidden" name="orderTotal" id="orderTotal"/>
<input type="hidden" name="baesong"/>
<input type="hidden" name="idxs" id="idxs" />
</form>
 <div class="tb">
  <div class="tb1">
		<table class="table-borderless text-right" style="margin:auto">
		  <tr>
		    <th>상품금액</th>
		    <td><input type="text" id="total" value="0" class="totSubBox form-control" readonly/></td>
		  </tr>
		  <tr>
		    <th>배송비</th>
		    <td><input type="text" id="baesong" value="0" class="totSubBox form-control" readonly/></td>
		  </tr>
		  <tr>
		    <th>총 결제금액</th>
		    <td><input type="text" id="lastPrice" value="0" class="totSubBox form-control" readonly/></td>
		  </tr>
		</table>
	</div>
	<p><br/></p>
	<div class="tb2">
	  <p class="text-center">
	    <font size="2px">5만원 이상 구매 시 배송비 무료!</font>
	  </p>
		<div class="text-center">
		  <button class="bbtn p-3 pr-5 pl-5" onClick="order()" style="background-color:#c9c2bc">주문하기</button> &nbsp;
		</div>
	</div>
</div>
</div>
</div>
<p><br/></p>
<p><br/></p>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
