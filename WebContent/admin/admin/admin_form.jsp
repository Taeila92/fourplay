<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../admin_menu.jsp" %>
<%

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.form {
	width:800px; display:block; margin-left:380px; margin-top:50px; font-size:20px; font-weight:bold;
}
.form .text { display:block; text-align:center; }
.form .text input { width:400px; height:40px; margin-bottom:15px; font-size:17px;}
.form .fixed { display:block; text-align:left; margin-bottom:15px; }
.form #btn { 
	width:110px; height:50px; background-color:black; color:white; font-weight:bold;
}
.fontRed { color:red; font-weight:bold; }
.fontBlue { color:blue; font-weight:bold; }

h2 {display:block; margin-left:530px;}
</style>
</head>
<body>
<div id="wrapper">
	<h2>정보 수정</h2>
	<form name="frmUpdate" action="admin_proc.adm" method="post">
	<input type="hidden" name="idChk" id="idChk" value="N" />
	<input type="hidden" name="aid" id="aid" value="<%=adminMember.getAl_id() %>" />
	<input type="hidden" name="name" id="name" value="<%=adminMember.getAl_name() %>" />
	<input type="hidden" name="wtype" value="up" />
	
	<div class="form">
	<table cellpadding="5" align="center">
	<tr><td class="fixed" align="left"><%=adminMember.getAl_id() %></td></tr>
	<tr><td class="fixed" align="left"><%=adminMember.getAl_name() %></td></tr> 
	<tr><td class="text"><input type="password" name="pwd" value="<%=adminMember.getAl_pwd() %>" /></td></tr>
	<tr>
		<td class="text"><input type="password" name="pwd2" placeholder="비밀번호 확인" /></td><span id="idMsg"> </span>
	</tr>
	<tr><td class="text"><input type="text" name="email" value="<%=adminMember.getAl_email() %>" /></td></tr>
	<tr><td class="text"><input type="text" name="phone" value="<%=adminMember.getAl_phone() %>" /></td></tr>
	<tr><td align="center">
		<input type="submit" id="btn" value="정보 수정" />
	</td></tr>
	</table>
	</div>
	</form>
</div>
</body>
</html>