<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%

AdminInfo admMember = (AdminInfo)session.getAttribute("adminMember");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.statMenu {
	position:absolute; top:30%; left:25px; width:100px; border:1px solid gray;
}
.statMenu ol { list-style:none; margin:0; padding:0; width:100%;}	
.statMenu li {list-style-type:none; margin:0; padding:0; border-bottom:1px solid gray; height:30px; }
.selected {background-color:lightgray; }
</style>
</head>
<body>
<div class="statMenu">
<ol>
	<li><a href="mthlyCGSForm.jsp">월별 매출 비교</a></li>
	<li><a href="yrlyCGSForm.jsp">연도별 매출 비교</a></li>
</ol>
</div>

</body>
</html>