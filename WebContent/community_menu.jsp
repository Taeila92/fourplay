<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
String requestUri = request.getRequestURI();
String contextPath = request.getContextPath();
String command = requestUri.substring(contextPath.length());
AdminInfo admMember = (AdminInfo)session.getAttribute("adminMember");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.comMenu {
	position:absolute; top:30%; left:50px; width:100px;  padding:10px;
	font-size:18px; text-align:center;
}
.comMenu ol { list-style:none; margin:0; padding:0; width:100%;}	
.comMenu li {height:30px; list-style-type:none; margin-bottom:10px; padding:0; }
.selected {background-color:#5b8588; font-weight:bold;}
.selected a{ text-decoration: none; color: white; }

</style>
</head>
<body>
<div class="comMenu">
<ol>
	<li<%if(command.equals("/admin/bbs/a_notice_list.jsp")) { %> class="selected" <%} %>><a href="bbs_list.anotice">공지사항</a></li>
	<li<%if(command.equals("/admin/bbs/a_faq_list.jsp")) { %> class="selected" <%} %>><a href="bbs_list.afaq">FAQ</a></li>
<!-- 	<li<%if(command.equals("/admin/brd/a_aqa_list.jsp")) { %> class="selected" <%} %>><a href="brd_list.aqna">Q&A</a></li> -->
</ol>
</div>

</body>
</html>