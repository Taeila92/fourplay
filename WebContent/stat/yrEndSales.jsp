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

ResultSetMetaData rsmd = null;

String cgsFirstYr = request.getParameter("cgsFirstYr");
int firstYr =0, secondYr= 0, pyEB=0, cyEB=0;

try{
   Class.forName(driver);
   conn = DriverManager.getConnection(url, "root", "1234");
   stmt = conn.createStatement();
   
  //매출액 sql
		String sql1 ="select SUM(ol_pay) as sum FROM t_order_list WHERE left(ol_date,4)= 2020;";
	   	System.out.print(sql1);
	   	rs = stmt.executeQuery(sql1);
	   	while (rs.next()) { 
	   		firstYr = Integer.parseInt(rs.getString(1));
		System.out.print(firstYr);
			   
	   }	
  	 
	   	String sql2 ="select SUM(ol_pay) as sum FROM t_order_list WHERE left(ol_date,4)= 2021;";
	   	System.out.print(sql2);
	   	rs = stmt.executeQuery(sql2);
	   	while (rs.next()) { 
	   		secondYr = Integer.parseInt(rs.getString(1));
		System.out.print(secondYr);			   
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
var firstNetSales=0, secondNetSales=0; 
firstNetSales = <%=firstYr%> - 0; // 2019년 자료가 필요하지만 없으므로 0으로 대입
secondNetSales = <%=secondYr%> - <%=cgsFirstYr%>;


var color = Chart.helpers.color;
var barChartData = {
	labels: ['2020년', '2021년'],
	datasets: [{
		label: '매출액',
		backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
		borderColor: window.chartColors.red,
		borderWidth: 1,
		data: [<%=firstYr%>, <%=secondYr%>]
	}, {
		label: '매출원가',
		backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [1000000, <%=cgsFirstYr%>]
	}

	, {
		label: '매출총이익',
		backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [15, 20]
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
			title:{ display:true, text:'연도별 상품 매출 비교' }
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
