<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="a_menu.jsp" %>
<%
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.status, .sales_stat, .pdt_stat, .mem_stat { 
	width:100px; height:100px; border:1px solid gray; 
}

</style>
</head>
<body>
<div id="wrapper">
	<h2>관리자 모드</h2>
	<a href="brd_list.afree">자유게시판</a><br/>
	<a href="brd_list.aqna">qna</a><br/>
	<a href="pdt_in_form.pdta">상품등록</a><br/>
	<a href="pdt_list.pdta">상품목록</a><br/>
	
</div>
</body>
</html>