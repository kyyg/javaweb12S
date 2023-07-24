	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>schedule.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"></jsp:include>
  <style>
	  #loadingImage {
	    /* position 속성을 absolute로 설정하여 부모 요소를 기준으로 위치를 결정합니다. */
	    position: absolute;
	    /* top과 left 값을 50%로 설정하여 부모 요소의 중앙에 배치합니다. */
	    top: 80%;
	    left: 50%;
	    /* transform 속성을 사용하여 요소의 크기를 50%로 줄이고, 정확한 중앙 위치를 조정합니다. */
	    transform: translate(-50%, -50%);
	  }
	</style>
  <script>
    'use strict';
    
    function eventCheck(ymd) {
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/schedule/eventToday",
    		data : {
    			mid : '${sMid}',
    			ymd : ymd
    		},
    		success:function(res){
    			if(res=="1"){
    				//alert("출석체크가 되었습니다.");
    				//location.reload();
    				showImage();
    				
    			} 
    			else if(res=="2") {
    				alert("출석이벤트를 달성하여 3000 포인트를 지급해드렸습니다.");
    				location.reload();
    			}
    			else{
    				//alert("이미 출석체크 하셨습니다.");
    				//location.reload();
    				showImage();
    			}
    		},
    		error: function() {
    			alert("전숑오류오류오류..겐");
    		}
    	});
    }
  
      function showImage() {
  	    // 이미지를 보여줍니다.
        document.getElementById("loadingImage").style.display = "block";

        // 3초 후에 페이지를 리로드합니다.
        setTimeout(function() {
          location.reload();
        }, 2000); // 3000ms (3초) 후에 리로드합니다.
      }
    
  </script>
  <style>
    #td1,#td8,#td15,#td22,#td29,#td36 {color:#7c638f}
    #td7,#td14,#td21,#td28,#td35 {color:#7c638f}
    .today {
      background-color: #e4dbea;
      color: #fff;
      font-weight: bolder;
    }
    td {
      text-align: center;
      vertical-align: top;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
<hr/>
<div class="text-center"><h3>출석체크 이벤트</h3></div>
<div class="text-center"><h6>한달 간 출석도장 20개를 찍으시면 3000point를 드립니다.</h6></div>
<div class="text-center"><h6>이달의 출석도장은 <b><font color="#7c638f">${vosSize}</font></b> 개!</h6></div>
<hr/>

  <div class="text-center">
    <button type="button" onclick="location.href='${ctp}/schedule/schedule?yy=${yy-1}&mm=${mm}';" class="btn btn-light btn-sm" title="이전년도"><font color:#e4dbea>◁◁</font></button>
    <button type="button" onclick="location.href='${ctp}/schedule/schedule?yy=${yy}&mm=${mm-1}';" class="btn btn-light btn-sm" title="이전월"><font color:#e4dbea>◀</font></button>
    <font size="5" style="color:#7c638f">${yy}년 ${mm+1}월</font>
    <button type="button" onclick="location.href='${ctp}/schedule/schedule?yy=${yy}&mm=${mm+1}';" class="btn btn-light btn-sm" title="다음월"><font color:#e4dbea>▶</font></button>
    <button type="button" onclick="location.href='${ctp}/schedule/schedule?yy=${yy+1}&mm=${mm}';" class="btn btn-light btn-sm" title="다음년도"><font color:#e4dbea>▷</font>▷</button>
    &nbsp;&nbsp;
  </div>
  <br/>
  <div class="text-center">
    <table class="table table-bordered" style="height:450px">
      <tr class="text-center" style="background-color:#e4dbea; color:#fff;">
        <th style="width:13%; vertical-align:middle">일</th>
        <th style="width:13%; vertical-align:middle">월</th>
        <th style="width:13%; vertical-align:middle">화</th>
        <th style="width:13%; vertical-align:middle">수</th>
        <th style="width:13%; vertical-align:middle">목</th>
        <th style="width:13%; vertical-align:middle">금</th>
        <th style="width:13%; vertical-align:middle">토</th>
      </tr>
      <tr>
        <c:set var="cnt" value="${1}"/>
        <!-- 시작일 이전의 공백을 이전달의 날짜로 채워준다. -->
        <c:forEach var="preDay" begin="${preLastDay-(startWeek-2)}" end="${preLastDay}">
          <td style="color:#ccc;font-size:0.6em">${prevYear}-${prevMonth+1}-${preDay}</td>
          <c:set var="cnt" value="${cnt+1}"/>
        </c:forEach>
        
        <!-- 해당월에 대한 날짜를 마지막일자까지 반복 출력한다.(단, gap이 7이되면 줄바꿈한다.) -->
        <c:forEach begin="1" end="${lastDay}" varStatus="st">
          <c:set var="todaySw" value="${toYear==yy && toMonth==mm && toDay==st.count ? 1 : 0}"/>
          <td id="td${cnt}" ${todaySw==1 ? 'class=today' : ''} style="font-size:0.9em; color:#7c638f" class="text-center">
            <c:set var="ymd" value="${yy}-${mm+1}-${st.count}"/>
            <c:if test="${todaySw==1}"><a href="javascript:eventCheck('${ymd}')">${st.count}</a></c:if>
            <c:if test="${todaySw!=1}">${st.count}</c:if>
            <br/>
            <c:forEach var="vo" items="${vos}">
              <c:if test="${vo.ymd == ymd}"><img src="${ctp}/images/event.png" width="100px"/></c:if>
            </c:forEach>
          </td>
          <c:if test="${cnt % 7 == 0}"></tr><tr></c:if>  <!-- 한주가 꽉차면 줄바꾸기 한다. -->
          <c:set var="cnt" value="${cnt + 1}"/>
        </c:forEach>
        
        <!-- 마지막일 이후를 다음달의 일자로 채워준다. -->
        <c:if test="${nextStartWeek != 1}">
	        <c:forEach begin="${nextStartWeek}" end="7" varStatus="nextDay">
	          <td style="color:#ccc;font-size:0.6em">${nextYear}-${nextMonth+1}-${nextDay.count}</td>
	        </c:forEach>
        </c:if>
      </tr>
    </table>
  </div>
</div>
  <div id="loadingImage" style="display: none;">
      <img src="${ctp}/images/kk.gif"/>
    </div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>