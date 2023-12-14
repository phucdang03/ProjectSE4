<%@page import="java.util.List"%>
<%@page import="dal.ProductDAL"%>
<%@page import="model.Product"%>
<%@page import="model.Account"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String user = (String) session.getAttribute("user");
    String pass = (String) session.getAttribute("pass");
    Account acc = new Account(user, pass);
    String catid = request.getParameter("catid");
    session.setAttribute("catid", catid);
%>
<html lang="en">
    <!-- Basic -->
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">

        <!-- Mobile Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Site Metas --
        <title>Shop</title>
        <meta name="keywords" content="">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Site Icons -->
        <link rel="shortcut icon" href="images/favicon.ico" type="image/x-icon">
        <link rel="apple-touch-icon" href="images/apple-touch-icon.png">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>


        <script src="js/home.js"></script>
        <!-- Bootstrap CSS -->
        <!--        <link rel="stylesheet" href="css/bootstrap.min.css">-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" 
              integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <!-- Site CSS -->
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <!-- Responsive CSS -->
        <link rel="stylesheet" type="text/css" href="css/responsive.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" type="text/css" href="css/custom.css">

        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
          <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->
        <title>Shop</title>
    </head>

    <body id="shop-container">

        <!-- Start Main Top -->
        <header class="main-header">
            <!-- Start Navigation -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light navbar-default bootsnav shop-navbar">
                <div class="container">
                    <!-- Start Header Navigation -->
                    <div class="navbar-header">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar-menu" aria-controls="navbars-rs-food" aria-expanded="false" aria-label="Toggle navigation">
                            <i class="fa fa-bars"></i>
                        </button>
                        <a class="navbar-brand" href="home"><img src="images/logo.png" class="logo" alt=""></a>
                    </div>
                    <!-- End Header Navigation -->

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="navbar-menu">
                        <ul class="nav navbar-nav ml-auto" data-in="fadeInDown" data-out="fadeOutUp">
                            <li class="nav-item active"><a class="nav-link" href="home">Home</a></li>
                                <c:choose>
                                    <c:when test="${sessionScope.user == null || sessionScope.pass == null}">
                                        ${'<li class="nav-item"><a class="nav-link" href="signin">Sign In <i class="fas fa-sign-in-alt"></i></a></li>'}
                                    </c:when>
                                    <c:otherwise>
                                        ${'<li class="nav-item"><a class="nav-link" href="account.jsp">Account <i class="fas fa-user-circle"></i></a></li>'}
                                    </c:otherwise>
                                </c:choose>
                        </ul>
                    </div>
                    <!-- /.navbar-collapse -->

                    <!-- Start Atribute Navigation -->
                    <div class="attr-nav">
                        <ul>
                            <li class="side-menu">
                                <c:choose>
                                    <c:when test="${sessionScope.user == null || sessionScope.pass == null}">
                                        <a href="signin">
                                            <i class="fa fa-shopping-bag"></i>
                                            <span class="badge"></span>
                                            <p>My Cart</p>
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="cart">
                                            <i class="fa fa-shopping-bag"></i>
                                            <span class="badge"></span>
                                            <p>My Cart</p>
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                        </ul>
                    </div>
                    <!-- End Atribute Navigation -->
                </div>
                <!-- Start Side Menu -->

                <!-- End Side Menu -->
            </nav>
            <!-- End Navigation -->
        </header>
        <!-- End Main Top -->

        <!-- Start Top Search -->
        <div class="top-search">
            <div class="container">
                <div class="input-group">
                    <span class="input-group-addon"><i class="fa fa-search"></i></span>
                    <input type="text" class="form-control" placeholder="Search">
                    <span class="input-group-addon close-search"><i class="fa fa-times"></i></span>
                </div>
            </div>
        </div>
        <!-- End Top Search -->

        <!-- Start All Title Box -->
        <div class="all-title-box">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <h2 id="titleCategory">All Product</h2>
                        <ul class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home">Home</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- End All Title Box -->

        <!-- Start Shop Page  -->
        <div class="shop-box-inner">
            <div class="container">
                <div class="row">
                    <div class="col-xl-9 col-lg-9 col-sm-12 col-xs-12 shop-content-right">
                        <div class="right-product-box">
                            <div class="product-item-filter row">
                                <div class="col-12 col-sm-8 text-center text-sm-left">
                                    <div class="search-product">
                                        <form action="home" method="get">
                                            <input class="form-control" placeholder="Search here..." type="text" name="search">
                                            <button type="submit" title="Search">
                                                <i class="fa fa-search" aria-hidden="true"></i>
                                            </button>
                                        </form>
                                    </div>
                                </div>

                            </div>

                            <div class="product-categorie-box">
                                <div class="tab-content">
                                    <div role="tabpanel" class="tab-pane fade show active" id="grid-view">
                                        <div class="row">
                                            <c:forEach var="book" items="${bookList}">
                                                <div class="col-sm-6 col-md-6 col-lg-4 col-xl-4">
                                                    <div class="products-single fix">
                                                        <div class="box-img-hover">
                                                            <img src="products/${book.image}" class="img-fluid" alt="Image">
                                                            <div class="mask-icon">
                                                                <ul>
                                                                    <li><a href="detail?pid=${book.pid}" target="_blank" data-toggle="tooltip" data-placement="right" title="View"><i class="fas fa-eye"></i></a></li>
                                                                </ul>
                                                                <c:choose>
                                                                    <c:when test="${sessionScope.user == null || sessionScope.pass == null}">
                                                                        <a class="cart" href="signin">Add to Cart</a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a class="cart add-to-cart" href="home?catid=${catid}&pid=${book.pid}&amount=1" data-quantity="${book.quantity}">Add to Cart</a>
                                                                    </c:otherwise>
                                                                </c:choose>

                                                            </div>
                                                        </div>
                                                        <div class="why-text">
                                                            <h4>${book.name}</h4>
                                                            <h5>$${book.price}</h5>
                                                            <h5 style="margin-top: 3px">Available: ${book.quantity} book(s)</h5>
                                                        </div>
                                                    </div>
                                                </div>

                                            </c:forEach>
                                        </div>

                                        <div class="pagination-container">
                                            <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                                                <a class="${i==page?"active":""}" href="home?page=${i}&sort=${requestScope.sort}">
                                                    <span class="page-item ${i==page?"active":""}">
                                                        ${i}
                                                    </span>

                                                </a>
                                            </c:forEach>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-3 col-lg-3 col-sm-12 col-xs-12 sidebar-shop-left">
                        <div class="product-categori">

                            <div class="filter-sidebar-left">
                                <div class="title-left">
                                    <h3>Categories</h3>
                                </div>
                                <div class="list-group list-group-collapse list-group-sm list-group-tree" id="list-group-men" data-children=".sub-men">
                                    <a href="home" class="list-group-item " onclick="activeCategory(this)"> All </a>
                                    <a href="home?catid=cat1&sort=${requestScope.sort}" class="list-group-item " onclick="activeCategory(this)" value="Literature"> Literature </a>
                                    <a href="home?catid=cat2&sort=${requestScope.sort}" class="list-group-item " onclick="activeCategory(this)" value="Mystery"> Mystery </a>
                                    <a href="home?catid=cat3&sort=${requestScope.sort}" class="list-group-item " onclick="activeCategory(this)" value="Romance"> Romance </a>
                                </div>
                            </div>
                        </div>
                        <div class="filter-sidebar-left">
                            <div class="title-left">
                                <h3>SORT BY</h3>
                            </div>
                            <div class="list-group list-group-collapse list-group-sm list-group-tree" id="list-group-men" data-children=".sub-men">
                                <a href="home?catid=${requestScope.category}&sort=price↑" class="list-group-item " onclick="activeCategory(this)" > Price↑ </a>
                                <a href="home?catid=${requestScope.category}&sort=price↓" class="list-group-item " onclick="activeCategory(this)" > Price↓ </a>
                                <a href="home?catid=${requestScope.category}&sort=bestSeller" class="list-group-item " onclick="activeCategory(this)" > Best Seller </a>
                                <a href="home?catid=${requestScope.category}&sort=name" class="list-group-item " onclick="activeCategory(this)" > Name </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Shop Page -->

        <div id="modal-add-to-cart" class="modal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmation</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="confirmation-notify"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>




        <!-- Start Footer  -->
        <footer>
            <div class="footer-main">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4 col-md-12 col-sm-12">
                            <div class="footer-top-box">
                                <h3>Office Address</h3>
                                <ul class="list-time">
                                    <li>Trường Đại học FPT Hà Nội</li><li>Km29 - Đại lộ Thăng Long</li> <li>Khu CNC Hòa Lạc</li> <li>xã Thạch Hòa, huyện Thạch Thất</li> <li>Thành phố Hà Nội</li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-12 col-sm-12">
                            <div class="footer-top-box">
                                <h3>Social Media</h3>
                                <p></p>
                                <ul>
                                    <li><a href="#"><i class="fab fa-facebook" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-twitter" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-linkedin" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-google-plus" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-rss" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-pinterest-p" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fab fa-whatsapp" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-12 col-sm-12">
                            <div class="footer-top-box">
                                <h3>Contact number</h3>
                                <p></p>
                                <h4 style="color:white">0829787976</h4>
                            </div>
                        </div>
                    </div>
                    <hr>
                </div>
            </div>
        </footer>
        <!-- End Footer  -->
        <!-- End Footer  -->

        <!-- Start copyright  -->
        <div class="footer-copyright">
            <p class="footer-company">2023 &copy; by <a href="#" target="_blank">Dang Vinh Phuc</a> - PRJ301
        </div>
        <!-- End copyright  -->

        <a href="#" id="back-to-top" title="Back to top" style="display: none;">&uarr;</a>

        <!-- ALL JS FILES -->
        <!--<script src="js/jquery-3.2.1.min.js"></script>-->
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <!-- ALL PLUGINS -->
        <script src="js/jquery.superslides.min.js"></script>
        <script src="js/bootstrap-select.js"></script>
        <script src="js/inewsticker.js"></script>
        <script src="js/bootsnav.js."></script>
        <script src="js/images-loded.min.js"></script>
        <script src="js/isotope.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/baguetteBox.min.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/jquery.nicescroll.min.js"></script>
        <script src="js/form-validator.min.js"></script>
        <script src="js/contact-form-script.js"></script>
        <script src="js/custom.js"></script>
        <script src="https://kit.fontawesome.com/228aa84c51.js" crossorigin="anonymous"></script>
        <script src="js/shop.js"></script>
    </body>

</html>