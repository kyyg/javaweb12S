<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<link rel="stylesheet" href="${ctp}/font/font.css">
<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>관리자 페이지</title>

    <!-- Custom fonts for this template-->
    <link href="../resources/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="../resources/https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="../resources/css/sb-admin-2.min.css" rel="stylesheet">
		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

</head>

<body id="page-top">

<!-- Page Wrapper -->
<div id="wrapper">
<jsp:include page="/WEB-INF/views/include/sidebar.jsp" />

<!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">

    <!-- Main Content -->
    <div id="content">

    <!-- Topbar -->
    <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

        <!-- Sidebar Toggle (Topbar) -->
        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
            <i class="fa fa-bars"></i>
        </button>

        <!-- Topbar Navbar -->
        <ul class="navbar-nav ml-auto">

        </nav>
        <!-- End of Topbar -->

        <!-- Begin Page Content -->
        <div class="container-fluid mb-5 pb-5">

            <!-- Page Heading -->

            <!-- Content Row -->
            <div class="row">

                <!-- Earnings (Monthly) Card Example -->
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-primary shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                       주간 신규 주문</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${weekOrder}</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Earnings (Monthly) Card Example -->
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-success shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                        주간 취소/환불</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${weekCancel}</div>
                                </div>
                                <div class="col-auto">
                                   <i class="fas fa-calendar fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Earnings (Monthly) Card Example -->
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-info shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-info text-uppercase mb-1">주간 제휴문의
                                    </div>
                                    <div class="row no-gutters align-items-center">
                                        <div class="col-auto">
                                            <div class="h5 mb-0 mr-3 font-weight-bold text-gray-800">${weekClass}</div>
                                        </div>
                                        <div class="col">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-clipboard-list fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pending Requests Card Example -->
                <div class="col-xl-3 col-md-6 mb-4">
                    <div class="card border-left-warning shadow h-100 py-2">
                        <div class="card-body">
                            <div class="row no-gutters align-items-center">
                                <div class="col mr-2">
                                    <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                        주간 문의글</div>
                                    <div class="h5 mb-0 font-weight-bold text-gray-800">${weekBoard}</div>
                                </div>
                                <div class="col-auto">
                                    <i class="fas fa-comments fa-2x text-gray-300"></i>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">

            <!-- Content Row -->
            
		<div class="row container-fluid pb-5 mb-5 mt-5" style="width:1500px; margin:0 auto;" >
			<table style="width:600px; height:200px" class="table table-borderless table-hover mr-5">
				<tr class="w3-indigo text-dark">
					<td colspan="4">
						<b>최근 주문</b> <a href="${ctp}/admin/adminOrder" class="badge badge-info text-right" >더보기</a> 
					</td>
				</tr>			
				<tr>
					<td>${fn:substring(order4VOS[0].orderDate,0,10)}</td>
					<td>${order4VOS[0].orderIdx}</td>
					<td>${order4VOS[0].mid}</td>
					<td>${order4VOS[0].orderTotalPrice}</td>
				</tr>
				<tr><td class="p-0 m-0"></td></tr>			
				<tr>
					<td>${fn:substring(order4VOS[1].orderDate,0,10)}</td>
					<td>${order4VOS[1].orderIdx}</td>
					<td>${order4VOS[1].mid}</td>
					<td>${order4VOS[1].orderTotalPrice}</td>
				</tr>			
				<tr><td class="p-0 m-0"></td></tr>			
				<tr>
					<td>${fn:substring(order4VOS[2].orderDate,0,10)}</td>
					<td>${order4VOS[2].orderIdx}</td>
					<td>${order4VOS[2].mid}</td>
					<td>${order4VOS[2].orderTotalPrice}</td>
				</tr>			
				<tr><td class="p-0 m-0"></td></tr>			
			</table>
			
			
			<table style="width:600px; height:200px" class="table table-borderless table-hover mr-5">
				<tr class="w3-indigo text-dark">
					<td colspan="4">
						<b>최근 반품/환불</b> <a href="${ctp}/admin/adminCancelOrder" class="badge badge-info text-right" >더보기</a> 
					</td>
				</tr>			
				<tr>
					<td>${fn:substring(cancelorder4VOS[0].cancelDate,0,10)}</td>
					<td>${cancelorder4VOS[0].orderIdx}</td>
					<td>${cancelorder4VOS[0].mid}</td>
					<td>${cancelorder4VOS[0].cancelStatus}</td>
				</tr>
				<tr><td class="p-0 m-0"></td></tr>			
				<tr>
					<td>${fn:substring(cancelorder4VOS[1].cancelDate,0,10)}</td>
					<td>${cancelorder4VOS[1].orderIdx}</td>
					<td>${cancelorder4VOS[1].mid}</td>
					<td>${cancelorder4VOS[1].cancelStatus}</td>
				</tr>			
				<tr><td class="p-0 m-0"></td></tr>			
				<tr>
					<td>${fn:substring(cancelorder4VOS[2].cancelDate,0,10)}</td>
					<td>${cancelorder4VOS[2].orderIdx}</td>
					<td>${cancelorder4VOS[2].mid}</td>
					<td>${cancelorder4VOS[2].cancelStatus}</td>
				</tr>			
				<tr><td class="p-0 m-0"></td></tr>			
			</table>
			
			
			<table style="width:600px; height:200px" class="table table-borderless table-hover mr-5">
				<tr class="w3-indigo text-dark">
					<td colspan="4">
						<b>이벤트 신청</b> <a href="${ctp}/admin/adminOnedayClass" class="badge badge-info text-right" >더보기</a> 
					</td>
				</tr>			
				<tr>
					<td>${fn:substring(class4VOS[0].WDate,0,10)}</td>
					<td>${class4VOS[0].mid}</td>
					<td>${class4VOS[0].className}</td>
					<td>${class4VOS[0].store}</td>
				</tr>
				<tr><td class="p-0 m-0"></td></tr>			
				<tr>
					<td>${fn:substring(class4VOS[1].WDate,0,10)}</td>
					<td>${class4VOS[1].mid}</td>
					<td>${class4VOS[1].className}</td>
					<td>${class4VOS[1].store}</td>
				</tr>			
				<tr><td class="p-0 m-0"></td></tr>			
				<tr>
					<td>${fn:substring(class4VOS[2].WDate,0,10)}</td>
					<td>${class4VOS[2].mid}</td>
					<td>${class4VOS[2].className}</td>
					<td>${class4VOS[2].store}</td>
				</tr>			
				<tr><td class="p-0 m-0"></td></tr>			
			</table>
			
			<table style="width:600px; height:200px" class="table table-borderless table-hover mr-5">
				<tr class="w3-indigo text-dark">
					<td colspan="4">
						<b>최근 이벤트 후기</b> <a href="${ctp}/admin/adminBoardList" class="badge badge-info text-right" >더보기</a> 
					</td>
				</tr>			
				<tr>
					<td>${fn:substring(baord4VOS[0].WDate,0,10)}</td>
					<td>${baord4VOS[0].mid}</td>
					<td>${baord4VOS[0].title}</td>
				</tr>
				<tr><td class="p-0 m-0"></td></tr>			
				<tr>
					<td>${fn:substring(baord4VOS[1].WDate,0,10)}</td>
					<td>${baord4VOS[1].mid}</td>
					<td>${baord4VOS[1].title}</td>
				</tr>			
				<tr><td class="p-0 m-0"></td></tr>			
				<tr>
					<td>${fn:substring(baord4VOS[2].WDate,0,10)}</td>
					<td>${baord4VOS[2].mid}</td>
					<td>${baord4VOS[2].title}</td>
				</tr>			
				<tr><td class="p-0 m-0"></td></tr>			
			</table>
</div>

<div class="container pb-5 ml-5 pl-5" style="width:1100px;">
	<table class="table table-bordered">
		<tr>
			<td colspan="3"><div class="text-left"><font color="red"><b><span class="badge badge-danger text-left mr-2">알림</span>재고가 10개 미만인 옵션이 ${optionVOSsize}개 존재합니다.</b></font></div></td>
		</tr>
		<tr class="text-center table-dark text-dark">
			<td>상품명</td>
			<td>옵션명</td>
			<td>옵션 개수</td>
		</tr>
	 	<c:forEach var="vo" items="${optionVOS}"> 
			<tr class="text-center">
				<td style="width:50%;">${vo.productName}</td>
				<td style="width:25%;">${vo.optionName}</td>
				<td style="width:25%;"><font color="red">${vo.optionStock}</font></td>
			</tr>
	 	</c:forEach>
	</table>
</div>

   <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['${chart1VOS[0].productName}', ${chart1VOS[0].proTotalSum}],
          ['${chart1VOS[1].productName}', ${chart1VOS[1].proTotalSum}],
          ['${chart1VOS[2].productName}', ${chart1VOS[2].proTotalSum}],
          ['${chart1VOS[3].productName}', ${chart1VOS[3].proTotalSum}]
        ]);

        var options = {
          title: '6개월간 상품 판매량순',
          pieHole: 0.4,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
    </script>
    
    <script type="text/javascript">
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
 /*      var data = google.visualization.arrayToDataTable([
          ['month', '${chart2VOS[0].salesMonth}월', '${chart2VOS[1].salesMonth}월', '${chart2VOS[2].salesMonth}월'],
          ['월별 매출액', ${chart2VOS[0].salesMonthPrice}, ${chart2VOS[1].salesMonthPrice}, ${chart2VOS[2].salesMonthPrice}],
          ['월별 환불/액반품', ${chart3VOS[0].cancelMonthPrice}, ${chart3VOS[1].cancelMonthPrice}, ${chart3VOS[2].cancelMonthPrice}]
        ]); */

      var data = google.visualization.arrayToDataTable([
          ['3개월간 매출액', '매출액', { role: 'style' }],
          ['${chart2VOS[0].salesMonth}월', ${chart2VOS[0].salesMonthPrice}, '#b87333'],            // RGB value
          ['${chart2VOS[1].salesMonth}월', ${chart2VOS[1].salesMonthPrice}, 'silver'],            // English color name
          ['${chart2VOS[2].salesMonth}월', ${chart2VOS[2].salesMonthPrice}, 'gold'],
       ]);
      
      
        var options = {
          chart: {
            title: '월별 매출액',
            subtitle: '3개월 간',
          }
        };

      var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
  </script>
	  <span class="ml-5" id="donutchart" style="width: 700px; height: 400px; background-color:#eee;"></span> &nbsp;&nbsp;
	  <span class="ml-5" id="columnchart_material" style="width: 700px; height: 400px;"></span>
      

      
   <!-- /.container-fluid -->
   <!-- End of Main Content -->
   <!-- End of Content Wrapper -->

</div>
<!-- End of Page Wrapper -->

<!-- Scroll to Top Button-->
<a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
</a>



<!-- Bootstrap core JavaScript-->
<script src="../resources/vendor/jquery/jquery.min.js"></script>
<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="../resources/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="../resources/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="../resources/vendor/chart.js/Chart.min.js"></script>

<!-- Page level custom scripts -->
<script src="../resources/js/demo/chart-area-demo.js"></script>
<script src="../resources/js/demo/chart-pie-demo.js"></script>

</body>

</html>