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
	position:absolute; top:30%; left:25px; width:100px; border:1px solid gray;
}
.comMenu ol { list-style:none; margin:0; padding:0; width:100%;}	
.comMenu li {list-style-type:none; margin:0; padding:0; border-bottom:1px solid gray; height:30px; }
.selected {background-color:lightgray; }
</style>
</head>
<body>
<div class="comMenu">
<ol>
	<li<%if(command.equals("/admin/product/product_list.jsp")) { %> class="selected" <%} %>><a href="pdt_list.pdta">상품 목록</a></li>
	<li<%if(command.equals("/admin/product/product_in_form.jsp")) { %> class="selected" <%} %>><a href="pdt_in_form.pdta">상품 등록</a></li>
</ol>
</div>

</body>
</html>