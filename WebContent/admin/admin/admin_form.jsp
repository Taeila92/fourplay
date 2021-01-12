<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
session.setMaxInactiveInterval(1800);
AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
if (adminMember == null) {
	out.println("<script>");
	out.println("alert('접근 권한이 없는 계정입니다.');");
	out.println("location.replace('login_form.jsp');");
	out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.text input { width:300px; height:30px; }
.text { text-align:center; }
</style>
</head>
<body>
<h2>관리자 계정 생성 화면</h2>
<form name="frmUpdate" action="admin_proc.adm" method="post">
<input type="hidden" name="idChk" id="idChk" value="N" />
<input type="hidden" name="aid" id="aid" value="<%=adminMember.getAl_id() %>" />
<input type="hidden" name="name" id="name" value="<%=adminMember.getAl_name() %>" />
<input type="hidden" name="wtype" value="up" />
<table cellpadding="5" align="center">
<tr><td align="left"><%=adminMember.getAl_id() %></td></tr>
<tr><td align="left"><%=adminMember.getAl_name() %></td></tr> 
<tr><td class="text"><input type="password" name="pwd" value="<%=adminMember.getAl_pwd() %>" /></td></tr>
<tr>
	<td class="text"><input type="password" name="pwd2" placeholder="비밀번호 확인" /></td><span id="idMsg"> </span>
</tr>
<tr><td class="text"><input type="text" name="email" value="<%=adminMember.getAl_email() %>" /></td></tr>
<tr><td class="text"><input type="text" name="phone" value="<%=adminMember.getAl_phone() %>" /></td></tr>
<tr><td align="center">
	<input type="submit" value="정보 수정" />
</td></tr>
</table>
</form>
</body>
</html>