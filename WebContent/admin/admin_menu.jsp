<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
String requestUri = request.getRequestURI();
String contextPath = request.getContextPath();
String command = requestUri.substring(contextPath.length());
AdminInfo admMember = (AdminInfo)session.getAttribute("adminMember");
System.out.println(command);

switch(command){
	case "/admin/admin/admin_list.jsp": case "/admin/admin/admin_pms.jsp": 
	case "/admin/admin/admin_join.jsp": case "/admin/admin/admin_del.jsp":
		if(!admMember.getAl_id().equals("sa")){
			out.println("<script>");
			out.println("alert('접근 권한이 없습니다.');");
			out.println("location.replace('../index.jsp');");
			out.println("</script>");
			out.close();
		}
	break;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.admMenu {
	position:absolute; top:30%; left:25px; width:100px; border:1px solid gray;
}
.admMenu ol { list-style:none; margin:0; padding:0; width:100%;}	
.admMenu li {list-style-type:none; margin:0; padding:0; border-bottom:1px solid gray;}
.selected {background-color:lightgray; }
</style>
</head>
<body>
<div class="admMenu">
<ol>
<%
if(admMember.getAl_id().equals("sa")){
%>
	<li<%if(command.equals("/admin/admin/admin_list.jsp")) { %> class="selected" <%} %>><a href="admin_list.adm">관리자 목록</a></li>
	<!-- <li<%if(command.equals("/admin/admin/admin_pms.jsp")) { %> class="selected" <%} %>><a href="admin_pms.adm">관리자<br />권한설정</a></li> -->
	<li<%if(command.equals("/admin/admin/admin_join.jsp")) { %> class="selected" <%} %>><a href="admin_join.adm">관리자<br />계정 생성</a></li>
	<li<%if(command.equals("/admin/admin/admin_del.jsp")) { %> class="selected" <%} %>><a href="admin_del.adm">관리자<br />계정 삭제</a></li>
<%} %>	
	<li<%if(command.equals("/admin/admin/admin_form.jsp")) { %> class="selected" <%} %>><a href="admin_form.adm">관리자 계정<br />정보 수정</a></li>
</ol>
</div>

</body>
</html>