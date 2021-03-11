<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
String requestUri = request.getRequestURI();
String contextPath = request.getContextPath();
String command = requestUri.substring(contextPath.length());
System.out.println(command);
AdminInfo admMember = (AdminInfo)session.getAttribute("adminMember");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.statMenu {
	position:absolute; top:30%; left:50px; width:100px;  padding:10px;
	font-size:18px; text-align:center;
}
.statMenu ol { list-style:none; margin:0; padding:0; width:100%;}	
.statMenu li {height:30px; list-style-type:none; margin-bottom:10px; padding:0; }
.selected {background-color:#5b8588; font-weight:bold;}
.selected a{ text-decoration: none; color: white; }
</style>
</head>
<body>
<div class="statMenu">
<ol>
	<li<%if(command.equals("/admin/stat/mem_stat.jsp")) { %> class="selected" <%} %>><a href="mem_stat.stat?kind=gender">회원 통계</a></li>
	<li<%if(command.equals("/admin/stat/pdt_stat.jsp")) { %> class="selected" <%} %>><a href="pdt_stat.stat">상품 통계</a></li>
	<li<%if(command.equals("/admin/stat/sales_stat.jsp")) { %> class="selected" <%} %>><a href="sales_stat.stat">매출 통계</a></li>
</ol>
</div>
</body>
</html>