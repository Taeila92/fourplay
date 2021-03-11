<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    <%@ page import="java.net.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../stat_menu.jsp" %>
 <%
request.setCharacterEncoding("utf-8");
String driver ="com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/fourplay?useUnicode=true&";
url += "characterEncoding=utf8&verifyServerCertificate=false&";
url += "useSSL=false&serverTimezone=UTC";


Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String sql1 ="SELECT o.ol_buyer , o.ol_bname, o.ol_id, o.ol_pay, p.pl_name FROM t_order_list o, t_product_list p ORDER BY o.ol_pay desc LIMIT 5";


try{
   Class.forName(driver);
   conn = DriverManager.getConnection(url, "root", "1234");


} catch(Exception e){
	   out.println("오류가 발생했습니다.");
	   e.printStackTrace();
	
} 
  
%>   

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css"> 
	
	.navyBtn { width: 200px; margin-right:4px; border: 1px solid darkblue; background-color: darkblue; color: white; padding: 5px; }
	.calBtn { width: 100px; margin-right:2px; border: 1px solid darkblue; background-color: darkblue; color: white; padding: 2px; }

</style> 
</head>
<body>
<div id="canvas-holder" style="width:70%">
<canvas id="chart-area"></canvas>
</div>
<h2>최고 금액 상품 주문자 5명</h2>
<table border="1" cellpadding="5" >
<tr>
<th>순위</th>
<th>아이디 </th><th>이름</th><th>주문번호</th><th>주문금액</th><th>주문상품</th>
</tr>
<%
try {
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql1);	//	rs(result set)을 받은 후, 무조건 next로 있는지 확인해야 한다.
	if (rs.next()) {	// 결과가 있을 경우,
		int num = 1;
		do {
	%>		
<tr align="center">
	<td><%=num %></td>
	<td><%=rs.getString("o.ol_buyer") %></a></td>
	<td><%=rs.getString("ol_bname")%></td>
	<td><%=rs.getString("ol_id") %></td>
	<td><%=rs.getString("ol_pay") %></td>
	<td><%=rs.getString("pl_name") %></td>
	
</tr>
<%
			num++;
		} while(rs.next());
	} else {
		out.println("<tr><td colspan='6' align='center'>검색결과가 없습니다.</td></tr>");
	}
} catch(Exception e){
	   out.println("오류가 발생했습니다.");
	   e.printStackTrace();
} 
%>
</table>
<table>
	<tr>
		<td colspan="2"><input type="button" class="navyBtn" value="홈페이지로" onClick="location.href='../../index.jsp'"> </td>
		<td colspan="2"><input type="button" class="navyBtn" value="관리자 페이지로" onClick="location.href='../a_index.jsp'"></td> 
		<td colspan="2"><input type="button" class="navyBtn" value="연간 매출 비교" onClick="location.href='yrlyCGSForm.jsp'"></td> 
	</tr>
</table>
</body>
</html>
<%
try {
	rs.close();
	stmt.close();
	conn.close();
} catch(Exception e) {
	e.printStackTrace();
}
%>