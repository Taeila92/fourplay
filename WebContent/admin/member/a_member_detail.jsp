<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../a_menu.jsp" %>
<%
MemberInfo member = (MemberInfo)request.getAttribute("member");
AddrInfo addr = (AddrInfo)request.getAttribute("addr");

String b1 = null; String b2 = null; String b3 = null;
String p1 = null, p2 = null, p3 = null, e1 = null, e2 = null;

String[] birth = member.getMlbirth().split("-");
b1 = birth[0];	b2 = birth[1];	b3 = birth[2];
String[] phone = member.getMlphone().split("-");
p1 = phone[0];	p2 = phone[1];	p3 = phone[2];
String[] email = member.getMlemail().split("@");
e1 = email[0];	e2 = email[1];
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function openPop1() {
	// 팝업창 뛰우는 메소드
	var w = (screen.width - 500) / 2;	// 수평 중심점
	var h = (screen.height - 400) / 2;	// 수직 중심점
	var win = window.open("/fourplay/addr_form.mpg", "width=500,height=400,left=" + w + ",top=" + h);
}
</script>
</head>
<body>
<div id="wrapper">
<h3>회원정보</h3>
<table cellpadding="5" cellspacing="0" align="center" border="1px solid #eee">
<tr>
<th>이름</th><td><%=member.getMlname() %></td></tr>
<tr>
<th>생년월일</th>
<td>
	<%=b1 %> 년 <%=b2 %> 월 <%=b3 %> 일 
	<input type="radio" name="gender" value="M" <% if (member.getMlgender().equals("M")) { %>checked="checked" <% } %> disabled="disabled" />남
	<input type="radio" name="gender" value="F" <% if (member.getMlgender().equals("F")) { %>checked="checked" <% } %> disabled="disabled"/>여
</td>
</tr>
<tr><th>회원ID</th><td><%=member.getMlid() %></td></tr>
<tr><th>이메일</th>
<td>
	<input type="text" name="e1" size="20" value="<%=e1%>" /> @
	<input type="text" name="e2" size="20" value="<%=e2%>" />
</td>
</tr>
<tr>
<th>휴대폰</th>
<td>
	<input type="text" name="p2" size="4" value="<%=p1%> "/> -
	<input type="text" name="p2" size="4" value="<%=p2%> "/> -
	<input type="text" name="p3" size="4" value="<%=p3%>" />
</td>
</tr>
<tr><th>잔여포인트</th><td><input type="text" value="<%=member.getMlpoint() %>"/></td></tr>
<tr>
<th>주소</th>
<td><input type="text" name="zip" value="<%= (addr.getMa_zip() == null) ? "" : addr.getMa_zip()  %>" />
<%
if(addr.getMa_zip() != null){
%>
	<input type="button" value="배송지 목록" onclick="openPop1();" />
<%
}
%>
	<br /><input type="text" size="48" name="addr1" value="<%= (addr.getMa_addr1() == null) ? "" : addr.getMa_addr1()  %>" />
	<br /><input type="text" size="48"name="addr2" value="<%= (addr.getMa_addr2() == null) ? "" : addr.getMa_addr2()  %>" />
</td>
</table>

</div>
</body>
</html>