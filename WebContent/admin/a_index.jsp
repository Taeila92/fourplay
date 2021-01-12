<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
session.setMaxInactiveInterval(18000);
AdminInfo adminMember = (AdminInfo)session.getAttribute("adminMember");
if (adminMember == null) {
	out.println("<script>");
	out.println("alert('접근 권한이 없는 계정입니다.');");
	out.println("location.href='../login_form.jsp';");
	out.println("</script>");
} else{
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>관리자 모드</h2>
<%=adminMember.getAl_id() %>로 로그인 중입니다.<br />
<a href="../logout">로그아웃</a>
<a href="../index.jsp">프론트로 가기</a><br />
<a href="admin_form.adm">admin - 관리자 계정 정보 수정</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="">사이트 관리</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="">주문관리</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="">상품관리</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="">회원관리</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="">커뮤니티 관리</a><br />
<%
	if (adminMember.getAl_id().equals("sa")){
%>
<br />
<a href="admin_list.adm">admin - 관리자 목록</a><br />
<a href="admin_pms.adm">admin - 관리자 권한 부여</a><br />
<a href="admin_join.adm">admin - 관리자 계정 생성</a><br />
<a href="admin_del.adm">admin - 관리자 계정 삭제</a><br />

<%
	}
}
%>
</body>
</html>