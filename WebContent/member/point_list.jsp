<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="../menu.jsp" %>
<%@ page import="vo.*" %>

<%
request.setCharacterEncoding("utf-8");
ArrayList<MemberInfo> pointList = (ArrayList<MemberInfo>)request.getAttribute("pointList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="./css/reset.css" type="text/css" rel="stylesheet" />
<style>
table tr{height:50px; font-size:14px;}
table th{background:#eee; text-align:center;}
table td{text-indent:15px;}

.flex{height:60px; display:flex; justify-content: space-between; align-items: center;}
</style>
<script src="jquery-3.5.1.js"></script>
</head>
<body>
<div id="wrapper">
<div class="flex">
	<h2>MEMBER INFORMATION</h2>
	<h3>HOME > MYPAGE > 회원정보 수정</h3>
</div>
<form name= "frmPoint" action="" method="post">
<table border="1px solid balck" width="100%" >
<tr><th width="20%">날짜</th><th width="*">적립내용</th><th width="15%">적립/사용내역</th></tr>

<%
if (loginMember != null) {
	if (pointList != null && pointList.size() > 0) {
		for (int i = 0; i < pointList.size(); i++) {
%>
<tr align="center">
<td><%=pointList.get(i).getMpdate().substring(2, 10) %></td>
<td><%=pointList.get(i).getMpdetail() %></td>
<td><%=pointList.get(i).getMpuse() %><%=pointList.get(i).getMppoint() %></td>
</tr>
<%
		}	
%>
</table>
<br />
<%
	} else {
%>
<table>
<tr><td colspan="3" align="center">포인트 내역이 비었습니다.</td></tr>
</table>
<% 
	}
}
%>
<div align="right">
<input type="button" value="뒤로가기" onclick="history.back();"  />
</div>
</form>
</div>
</body>
</html>
