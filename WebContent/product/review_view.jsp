<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
String uid = loginMember.getMlid();
String idx = request.getParameter("idx");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#wrapper .review {width:50%; margin:0 auto;}
.rTitle {float:left; border:1px solid red;}
.rTitle:first-child {width:20%;border:1px solid red;}
.rContent {width:100%; display:block; border:1px solid blue;}
.Btn {float:left;}
.btn {}
</style>
</head>
<body>
<div id="wrapper">
dddd
</div>
</body>
</html>