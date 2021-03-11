<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
session.setMaxInactiveInterval(1000);
AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
if(adminMember == null){
	out.println("<script>");
	out.println("alert('접근 권한이 없습니다.');");
	out.println("location.replace('../index.jsp');");
	out.println("</script>");
	out.close();
} 
String aid = adminMember.getAl_id();
String name = adminMember.getAl_name();
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
	width:80%; min-width:800px; position:absolute; top:200px; left:15%;
}

/* 여기만 추가 */
@media (max-width:1000px){
	#wrapper{padding-left:180px;}
}

/* header */
.page-header { 
	background:#fff; z-index:9999; position:fixed; top:0; opacity:1; background:#fff; 
	z-index:9999; width: 100%; min-width: 960px;   
}
.top { text-align:right; margin:5px 10px 5px 0;}
.mode {color:red;}
#logo a {
	font-size:30px; font-weight:bold; display:block; width:200px; text-align:left; margin-left:20px; 
	position:absolute; top:15px;
}
.primary-nav { background:#fff; z-index:9999; width: 100%; border-bottom: 1px solid #ddd; }
.primary-nav .main_menu{ overflow: hidden; width:100%; margin: auto; }
.primary-nav .main_menu>li { float: left; position:relative; width: 10%; padding: 30px 0; text-align: center;}
.primary-nav .main_menu>li>a{ font-size:15px; }
.primary-nav .sub_menu{ 
	background:#fff; z-index:9999; overflow: hidden; width: 100%; height: 0; padding-top: 20px; 
}
.primary-nav .sub_menu>li>a{ display: block; padding: 5px; }
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<script>
</script>
</head>
<body>
<header class="page-header">
   <div class="primary-nav" >
   	  <ul class="top" width="900">
   	  	 <li><span class="mode">관리자 모드 </span><a href="../logout" >로그아웃</a> </li>
<%
if(adminMember != null){
%>
		 <li><%=aid %> (<%=name %>)님</li>
<%} %>
   	  </ul>
      <ul class="main_menu" width="900">
      	 <li>
   	  	 	<h1 id="logo"> <a href="../index.jsp" >fourplay</a> </h1>
   	  	 </li>
         <li> 
<%
if (aid.equals("sa")){
%>
			<a href="admin_list.adm">ADMIN</a>
<%} else { %>
            <a href="admin_form.adm">ADMIN</a>
<%} %> 
         </li>
         <!-- 
         <li> 
            <a href="#">사이트 관리</a> 
         </li>
          -->
         <li> 
            <a href="ord_list.orda">주문 관리</a> 
         </li>
         <li> 
            <a href="pdt_list.pdta">상품 관리</a> 
         </li>
         <li> 
            <a href="member_list.mem">회원 관리</a> 
         </li>
         <li> 
            <a href="bbs_list.anotice">커뮤니티 관리</a> 
         </li>
<!-- 
         <li> 
            <a href="#">스케줄</a> 
         </li>
 -->
         <li> 
            <a href="mem_stat.stat?kind=gender">통계</a> 
         </li>
      </ul>
   </div>
</header>
</body>
</html>