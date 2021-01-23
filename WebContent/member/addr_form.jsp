<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
function goSubmit() {
    var frm = document.frmAddr;
    frm.action = "addr_in_proc.mpg";
    frm.submit();
    
}
</script>
<body onload="window.resizeTo(500, 400);">
<h2>주소추가</h2>
<form name="frmAddr" action="" method="post">
<input type="hidden" name="uid" value="<%=loginMember.getMlid() %>">
<table>
<tr>
<td>우편번호 : <input type="text" name="zip"  /><br />
	주소 1 : &nbsp;&nbsp;&nbsp; <input type="text" size="48" name="addr1" /><br />
	주소 2 : &nbsp;&nbsp;&nbsp;<input type="text" size="48" name="addr2"  />
</td>
</tr>
<tr>
	<td align="right"><input type="button" value="주소추가" onclick="goSubmit();" /></td>
</tr>
</table>
</form>
</body>
</html>
