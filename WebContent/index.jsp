<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
session.setMaxInactiveInterval(1800);
//out.println(session.getId());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 
<link href="css/reset.css" type="text/css" rel="stylesheet" />
<link href="css/base.css" type="text/css" rel="stylesheet" />
 -->
</head>
<body>
<%
if (loginMember == null) {   //일반 회원 로그인이 되어있지 않으면
   if(adminMember != null){   //관리자 계정 로그인이 되어있으면
      out.println(adminMember.getAl_id() +"("+ adminMember.getAl_name() + ") 님 환영합니다.<br />");
      out.println("<a href=\"logout\">로그아웃</a>");
      out.println("<a href=\"admin/a_index.jsp\">어드민으로 이동</a>");
   } else{      // 일반회원도, 관리자 계정도 로그인되어 있지 않으면 
%>
<a href="login_form.jsp">로그인</a>
<%
   }
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
<hr />
<a href="pdt_list.pdt">상품내역- 프론트</a>
<hr />
<a href="cart_list.crt">장바구니- 프론트</a>
<hr />
<a href="wish_list.crt">위시리스트- 프론트</a>
</body>
</html>