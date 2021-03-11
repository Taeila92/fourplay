<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../stat_menu.jsp" %>

<%
String driver ="com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/fourplay?useUnicode=true&";
url += "characterEncoding=utf8&verifyServerCertificate=false&";
url += "useSSL=false&serverTimezone=UTC";


Connection conn = null;
Statement stmt = null;
PreparedStatement pstmt = null;
ResultSet rs = null;



String cgsJan = request.getParameter("cgsJan");
String cgsFeb = request.getParameter("cgsFeb");
String cgsMar = request.getParameter("cgsMar");



int jan =0, feb= 0, mar=0, janBuy=0, febBuy=0, marBuy=0;
int py4EB = 0, cy1EB = 0, cy2EB = 0, cy3EB = 0; 
try{
   Class.forName(driver);
   conn = DriverManager.getConnection(url, "root", "1234");
   stmt = conn.createStatement();
   
 
	 	String sql1 ="select SUM(ol_pay) as sum FROM t_order_list WHERE left(ol_date,7)= '2021-01'";
	 	System.out.print(sql1);
	 	rs = stmt.executeQuery(sql1);
	 	while (rs.next()) { 
	 		jan = rs.getInt(1);
		System.out.print(jan);
		   
	  }	
	 
	 	String sql2 ="select SUM(ol_pay) as sum FROM t_order_list WHERE left(ol_date,7)= '2021-02'";
	 	System.out.print(sql2);
	 	rs = stmt.executeQuery(sql2);
	 	while (rs.next()) { 
	 		feb = rs.getInt(1);
	System.out.print(feb);
		   
	 }	
	 	
		String sql3 ="select SUM(ol_pay) as sum FROM t_order_list WHERE left(ol_date,7)= '2021-03'";
	 	System.out.print(sql3);
	 	rs = stmt.executeQuery(sql3);
	 	while (rs.next()) { 
	 		mar = rs.getInt(1);
	System.out.print(mar);   
	 }
} catch(Exception e){
	   out.println("오류가 발생했습니다.");
	   e.printStackTrace();
	
} finally {
	try {
		rs.close();
		stmt.close();
		conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
}
  
%>   
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Bar Chart</title>
<style>
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>
<script src="js/Chart.min.js"></script>
<script src="js/utils.js"></script>
<script>
var net1 = <%=jan%> - <%=cgsJan%>;
var net2 = <%=feb%> - <%=cgsFeb%>;
var net3 = <%=mar%> - <%=cgsMar%>;
	   
var color = Chart.helpers.color;
var barChartData = {
	labels: ['1월', '2월', '3월'],
	datasets: [{
		label: '분기별 매출 비교',
		backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
		borderColor: window.chartColors.red,
		borderWidth: 1,
		data: [<%=jan%>, <%=feb%>, <%=mar%>]
	}, {
		label: '매출원가',
		backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [<%=cgsJan%>, <%=cgsFeb%>, <%=cgsMar%>]
	}

	, {
		label: '순이익',
		backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [net1, net2, net3]
	}

	]
};

window.onload = function() {
	var ctx = document.getElementById('canvas').getContext('2d');
	window.myBar = new Chart(ctx, {
		type: 'bar',
		data: barChartData,
		options: {
			responsive: true,
			legend:{ position:'top' }, 
			title:{ display:true, text:'월별 매출 비교' }
		}
	});
};
</script>
</head>
<body>
<div id="wrapper">

<div id="container" style="width: 75%;">
	<canvas id="canvas"></canvas>
</div>
<table>
	<tr>
		<td colspan="2"><input type="button" class="navyBtn" value="홈페이지로" onClick="location.href='../../index.jsp'"> </td>
		<td colspan="2"><input type="button" class="navyBtn" value="관리자 페이지로" onClick="location.href='../a_index.jsp'"></td> 
		<td colspan="2"><input type="button" class="navyBtn" value="연간 매출 비교" onClick="location.href='yrlyCGSForm.jsp'"></td> 
	</tr>
</table>
</div>
</body>
</html>
