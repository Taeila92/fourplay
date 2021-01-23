<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
session.setMaxInactiveInterval(18000);
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
/* reset - 태그들 스타일 기본값 초기화 */
*{ padding: 0; margin: 0; }
ul li, ol li{ list-style: none; text-decoration: none; }
a{ text-decoration: none; color: #222; }
a:link { color:#4f4f4f; text-decoration:none; }
a:visited { color:#4f4f4f; text-decoration:none; }
a:hover { color:pink; text-decoration:none;  font-weight:bold;}
a:active { color:#f00; text-decoration:none; }   
a:focus { color:pink; text-decoration:none; }

/* common - 페이지 공통으로 쓰이는 css */
.sticky { background:#fff; z-index:9999; position:fixed; top:0; opacity:1; }
#wrapper {
   width:80%; min-width:800px; position:absolute; top:350px; left:10%;
}

/* header */
.page-header { background:#fff; position:absolute; z-index:9999; width: 100%; min-width: 960px;   }
.shortcut{ padding: 20px; }
.shortcut ul{ overflow: hidden; text-align: right; }
.shortcut ul li{ display: inline-block; }
#logo a {font-size:35px; font-weight:bold; display:block; width:200px; margin:20px auto; }
.primary-nav { background:#fff; z-index:9999; display:block; width: 100%; border-bottom: 1px solid #ddd; }
.primary-nav .main_menu{ overflow: hidden; width:900px; margin: auto; }
.primary-nav .main_menu>li { float: left; position:relative; width: 16.66%; padding: 30px 0; text-align: center;}
.primary-nav .main_menu>li:first-child { margin-left:70px;}
.sub {font-size:12px;}
/*best 메뉴 만들면 first-child 스타일 삭제하기*/

.primary-nav .main_menu>li:first-child { margin-left:67px;}
.primary-nav .main_menu>li>a{ font-size:15px; }
.primary-nav .sub_menu{ background:#fff; z-index:9999; overflow: hidden; width: 100%; height: 0; padding-top: 20px; }
.primary-nav .sub_menu>li>a{ display: block; padding: 5px; }

#submit { height:20px; width:20px; border-style:none; }
#searchbox { width:120px; border-top-style:none; border-left-style:none; 
      border-right-style:none; border-bottom: solid #8C8C8C 1px;
}

#logo { width:100%; position:relative; }
.logo2 { position: relative; }
#search{ position: absolute; top: 0;right: 20px; }

</style>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function(){
   $(".primary-nav").each(function(){
      var $window=$(window),   
      $header=$(this),   
      headerOffsetTop = $header.offset().top;

      $window.on('scroll', function(){
         if ($window.scrollTop() > headerOffsetTop)   {
            $header.addClass('sticky');
         }else {
            $header.removeClass('sticky');
         }
      });
      $window.trigger('scroll');
   });
   
   $(".main_menu").hover(function(){   
      $(".sub_menu").css("height", "150px");
   },function(){
      $(".sub_menu").css("height", "0");
   });
});

</script>
</head>
<body>
<header class="page-header">
   <div class="shortcut">
      <ul>
<%
if(loginMember == null && adminMember == null){
%>
         <li> <a class="sub" href="login_form.jsp" >로그인</a> </li> 
         <li> <a class="sub" href="join_form.jsp" >회원가입</a> </li> 
<%
} else {
%>
       <li> <a class="sub" href="logout" >로그아웃</a> </li>
<%} %>
         <li> <a class="sub" href="cart_list.crt" >장바구니</a> </li>
         <li> <a class="sub" href="mypage.mpg" >마이페이지</a> </li>
         <li> <a class="sub" href="order_list.mpg" >주문조회</a> </li>
         <li> <a class="sub" href="" >Q&A</a> </li>
      </ul>
   </div>
   <div id="logo">
   <h1> <a href="index.jsp" >fourplay</a> </h1>
   </div>
   <form action="pdt_list.pdt" method="get" name="find">
   <div class="logo2">
     <!--클릭하면나옴1-->
     <div id="search">
           <input id="searchbox" type="text" name="keyword" />   
         <input type="image" src="images/bt01.jpg" name="submit" value="submit" id="submit /">
        </div>
   </div>
   </form>
   <div class="primary-nav" >
      <ul class="main_menu" width="900">
     <!--<li> <a href="#" class="bigCatetory">BEST</a> </li> -->    
         <li> 
            <a href="#" class="bigCatetory">DRESS SHOES</a> 
            <ul class="sub_menu">
               <li><a href="pdt_list.pdt?scata=2101">OXFORD</a></li>
               <li><a href="pdt_list.pdt?scata=2102">WINGTIP</a></li>
               <li><a href="pdt_list.pdt?scata=2103">MONK</a></li>
               <li><a href="pdt_list.pdt?scata=2104">DERBY</a></li>
            </ul>
         </li>
         <li> 
            <a href="#" class="bigCatetory">LOAFER</a> 
            <ul class="sub_menu">
               <li><a href="pdt_list.pdt?scata=3101">PLAIN</a></li>
               <li><a href="pdt_list.pdt?scata=3102">PENNY</a></li>
               <li><a href="pdt_list.pdt?scata=3103">TASSEL</a></li>
            </ul>
         </li>
         <li> 
            <a href="#" class="bigCatetory">BOOTS</a> 
            <ul class="sub_menu">
               <li><a href="pdt_list.pdt?scata=4101">PLAIN</a></li>
               <li><a href="pdt_list.pdt?scata=4102">CHELSEA</a></li>
            </ul>
         </li>
         <li> 
            <a href="#" class="bigCatetory">ACC</a> 
            <ul class="sub_menu">
               <li><a href="pdt_list.pdt?scata=5101">ACC</a></li>
            </ul>
         </li>
         <li> 
            <a href="#" class="bigCatetory">COMMUNITY</a> 
            <ul class="sub_menu">
               <li><a href="">NOTICE</a></li>
               <li><a href="">Q&A</a></li>
            </ul>
         </li>
      </ul>
   </div>
</header>
</body>
</html>