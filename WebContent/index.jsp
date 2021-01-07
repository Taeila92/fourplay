<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>fourplay</title>
</head>
<body>

<%
if (loginMember == null) {
%>
<a href="login_form.jsp">로그인</a>
<%
} else {
%>
<%=loginMember.getMlid() + "(" + loginMember.getMlname() + ")" %>
님 환영합니다.<br />
현재 <%=loginMember.getMlpoint() %>p 보유중<br />
<a href="logout">로그아웃</a>
<%
}
%>
<hr />
<a href="order_list.mpg">주문내역조회- 프론트</a>
<form name="frm" action="non_order_list.mpg" method="post">
주문자 : <input type="text" name="bname" />
주문번호: <input type="text" name="olid" />
<input type="submit" name="확인" />
<hr />
<a href="pdt_list.pdt">상품내역- 프론트</a>
</body>
</html>
