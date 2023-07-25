<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

  <!DOCTYPE html>
<html lang="en">

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

    <!-- Sidebar - Brand -->
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.html">
        <div class="sidebar-brand-icon rotate-n-15">
            <i class="fas fa-laugh-wink"></i>
        </div>
        <div class="sidebar-brand-text mx-3">관리자</div>
    </a>

    <!-- Divider -->
    <hr class="sidebar-divider my-0">

    <!-- Nav Item - Dashboard -->
    <li class="nav-item active">
        <a class="nav-link" href="${ctp}/">
            <i class="fas fa-fw fa-tachometer-alt"></i>
            <span>메인화면으로</span></a>
    </li>

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Member
    </div>

    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
            aria-expanded="true" aria-controls="collapseTwo">
            <i class="fas fa-fw fa-folder"></i>
            <span>회원 관리</span>
        </a>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">회원관리</h6>
                <a class="collapse-item" href="${ctp}/admin/adminMemberList">회원리스트</a>
            </div>
        </div>
    </li>

   

    <!-- Divider -->
    <hr class="sidebar-divider">

    <!-- Heading -->
    <div class="sidebar-heading">
        Order
    </div>

    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages1"
            aria-expanded="true" aria-controls="collapsePages1">
            <i class="fas fa-fw fa-folder"></i>
            <span>주문/예약 관리</span>
        </a>
        <div id="collapsePages1" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">상품주문</h6>
                <a class="collapse-item" href="${ctp}/admin/adminOrder">전체주문 조회</a>
                <a class="collapse-item" href="${ctp}/admin/adminCancelOrder">반품/환불 조회</a>
                <h6 class="collapse-header">클래스</h6>
                <a class="collapse-item" href="${ctp}/admin/adminOnedayClass">클래스 예약 조회</a>
            </div>
        </div>
    </li>
    
        <!-- Heading -->
    <div class="sidebar-heading">
        Store
    </div>
    <!-- Nav Item - Pages Collapse Menu -->
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
            aria-expanded="true" aria-controls="collapsePages">
            <i class="fas fa-fw fa-folder"></i>
            <span>상품관리</span>
        </a>
        <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <h6 class="collapse-header">조회</h6>
                <a class="collapse-item" href="${ctp}/dbShop/dbShopList">전체상품 조회</a>
                <div class="collapse-divider"></div>
                <h6 class="collapse-header">등록</h6>
                <a class="collapse-item" href="${ctp}/dbShop/dbCategory">카테고리 등록</a>
                <a class="collapse-item" href="${ctp}/dbShop/dbOption">옵션 등록</a>
                <a class="collapse-item" href="${ctp}/dbShop/dbProduct">상품 등록</a>
            </div>
        </div>
    </li>
    
    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Heading -->
    <div class="sidebar-heading">
        Board
    </div>
		<!-- Nav Item - Pages Collapse Menu -->
		    <li class="nav-item">
		        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2"
		            aria-expanded="true" aria-controls="collapsePages2">
		            <i class="fas fa-fw fa-folder"></i>
		            <span>게시판 관리</span>
		        </a>
		        <div id="collapsePages2" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
		            <div class="bg-white py-2 collapse-inner rounded">
		                <h6 class="collapse-header">게시판</h6>
		                <a class="collapse-item" href="${ctp}/admin/adminNoticeList">공지 관리</a>
		                <a class="collapse-item" href="${ctp}/admin/adminQnaList">문의 관리</a>
		                <a class="collapse-item" href="${ctp}/admin/adminBoardList">이벤트 후기 관리</a>
		            </div>
		        </div>
		    </li>
		    
    <!-- Heading -->
    <div class="sidebar-heading">
        Review
    </div>
		<!-- Nav Item - Pages Collapse Menu -->
		    <li class="nav-item">
		        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages7"
		            aria-expanded="true" aria-controls="collapsePages7">
		            <i class="fas fa-fw fa-folder"></i>
		            <span>리뷰 관리</span>
		        </a>
		        <div id="collapsePages7" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
		            <div class="bg-white py-2 collapse-inner rounded">
		                <h6 class="collapse-header">게시판</h6>
		                <a class="collapse-item" href="${ctp}/admin/adminReviewList">일반 리뷰 관리</a>
		                <a class="collapse-item" href="${ctp}/admin/adminReportReviewList">신고 리뷰 관리</a>
		            </div>
		        </div>
		    </li>

    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">


		<!-- Heading -->
    <div class="sidebar-heading">
        Contact
    </div>
		<!-- Nav Item - Pages Collapse Menu -->
		    <li class="nav-item">
		        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages6"
		            aria-expanded="true" aria-controls="collapsePages2">
		            <i class="fas fa-fw fa-folder"></i>
		            <span>제휴 문의</span>
		        </a>
		        <div id="collapsePages6" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
		            <div class="bg-white py-2 collapse-inner rounded">
		                <h6 class="collapse-header">제휴 문의</h6>
		                <a class="collapse-item" href="${ctp}/admin/adminContactList">제휴문의 목록</a>
		            </div>
		        </div>
		    </li>



    <!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">

    <!-- Heading -->
    <div class="sidebar-heading">
        Offline Store
    </div>
		<!-- Nav Item - Pages Collapse Menu -->
		    <li class="nav-item">
		        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages3"
		            aria-expanded="true" aria-controls="collapsePages3">
		            <i class="fas fa-fw fa-folder"></i>
		            <span>오프라인 매장 관리</span>
		        </a>
		        <div id="collapsePages3" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
		            <div class="bg-white py-2 collapse-inner rounded">
		                <h6 class="collapse-header">오프라인 매장</h6>
		                <a class="collapse-item" href="${ctp}/admin/kakaomap/storeRegistration">매장 등록</a>
		                <a class="collapse-item" href="${ctp}/admin/kakaomap/kakaoStoreList">매장 조회/삭제</a>
		            </div>
		        </div>
		    </li>
		    
		<!-- Divider -->
    <hr class="sidebar-divider d-none d-md-block">




    <!-- Sidebar Toggler (Sidebar) -->
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
<!-- End of Sidebar -->

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>
