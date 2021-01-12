<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
request.setCharacterEncoding("utf-8");
Connection conn = null;
Statement stmt = null;
String sql = null;

String aid 		= request.getParameter("aid").toLowerCase().trim();
String pwd 		= request.getParameter("pwd").trim();
String name 	= request.getParameter("name").trim();
String phone	= request.getParameter("phone");
String email 	= request.getParameter("email");

String driver ="com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/fourplay?useUnicode=true&characterEncoding=utf8&verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";

try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	stmt = conn.createStatement();
	sql = "insert into t_admin_list (al_id, al_pwd, al_name, al_phone, al_email) values " +
		"('" + aid + "', '" + pwd + "', '" + name + "', '" + phone + "', '" + email + "' ) ";
	System.out.println(sql);	
	
	int result = stmt.executeUpdate(sql);
	if (result != 0){	//관리자 계정 생성에 성공하면
		out.println("<script>");
		out.println("location.href='admin_list.adm';");
		out.println("</script>");
	}else {		
		out.println("<script>");
		out.println("alert('계정 생성에 실패하였습니다.\n다시 시도하세요');");
		out.println("location.href='admin_join.jsp';");
		out.println("</script>");
	}
}catch(Exception e){
	e.printStackTrace();
	out.println("오류가 발생했습니다.");
}finally{
	try {
		stmt.close();		conn.close();
	} catch(Exception e){
		e.printStackTrace();
	}
}
%>