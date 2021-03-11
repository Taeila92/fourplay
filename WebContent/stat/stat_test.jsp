<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

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


int jan =0, feb= 0, mar= 0, fQBuy=0;
int pyEB = 0, fQEB = 0; 
try{
   Class.forName(driver);
   conn = DriverManager.getConnection(url, "root", "1234");
   stmt = conn.createStatement();
   
  
		String sql1 ="select SUM(ol_pay) as sum FROM t_order_list WHERE left(ol_date,7)= '2021-01'";
	   	System.out.print(sql1);
	   	rs = stmt.executeQuery(sql1);
	   	while (rs.next()) { 
	   		jan = Integer.parseInt(rs.getString(1));
		System.out.print(jan);
			   
	   }	
   	 
	   	String sql2 ="select SUM(ol_pay) as sum FROM t_order_list WHERE left(ol_date,7)= '2021-02'";
	   	System.out.print(sql2);
	   	rs = stmt.executeQuery(sql2);
	   	while (rs.next()) { 
		    feb = Integer.parseInt(rs.getString(1));
		System.out.print(feb);
			   
	   }	
	   	
		String sql3 ="select SUM(ol_pay) as sum FROM t_order_list WHERE left(ol_date,7)= '2021-03'";
	   	System.out.print(sql3);
	   	rs = stmt.executeQuery(sql3);
	   	while (rs.next()) { 
		    mar = Integer.parseInt(rs.getString(1));
		System.out.print(mar);
			   
	   }
	   	
	   	//1월 당기상품원가 db에서 가져오기
	   	String sql4 ="select SUM(pl_cost) as sum FROM t_product_list WHERE left(pl_date,7)= '2021-01'";
	   	System.out.print(sql4);
	   	rs = stmt.executeQuery(sql4);
	   	while (rs.next()) { 
	   		fQBuy = Integer.parseInt(rs.getString(1));
		System.out.print(fQBuy);
			   
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



<body>
<form name="frmCal" action="" method="get"> 
	<input type="text" name="py4EB" placeholder="작년말 재고 "  >  <br />
	<input type="text" name="cy1EB" placeholder="올해연말 재고 " > <br />
	* 순이익 및 매출원가를 산출하기 위해서는 기말 재고 금액을 넣어야 합니다  <br />
	** 상품 매출 및 상품 매출 원가를 제외한 기타 계정에 관한 문의는 02-xxxx-xxxx 바랍니다 <br />
	당기매출원가:<input type="button" value="계산하기" onclick="calcJan()">
	<input type="text"  name="result">&nbsp;&nbsp;&nbsp;
	<input type="submit" value="전송"> 
</form>
<script>
function calcJan(){  // 매출원가 = 기초재고 + 사온재고 - 기말재고 
    var result = document.forms[0].py4EB.value - document.forms[0].cy1EB.value;
    document.forms[0].result.value = result + <%=fQBuy %>;
}



	   
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
		label: '순이익',
		backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [result, 20, 33]
	}
/* -- �뜲�씠�꽣 留됰� 異붽�
	, {
		label: '�닚�씠�씡2',
		backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),
		borderColor: window.chartColors.blue,
		borderWidth: 1,
		data: [15, 20, 17, 13, 28, 22, 9]
	}
*/
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
			title:{ display:true, text:'분기별 매출 비교' }
		}
	});
};
</script>
</head>
<body>


<div id="container" style="width: 75%;">
	<canvas id="canvas"></canvas>
</div>
</body>
</html>
