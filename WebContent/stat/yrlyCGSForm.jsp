<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.sql.*" %>
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

int firstYrBuy=0, secondYrBuy=0;

try{
   Class.forName(driver);
   conn = DriverManager.getConnection(url, "root", "1234");
   stmt = conn.createStatement();
 
 
	  	//2020년 당기상품원가
	  	String sql1 ="select SUM(pl_cost) as sum FROM t_product_list WHERE left(pl_date,4)= 2021";
	  	System.out.print(sql1);
	  	rs = stmt.executeQuery(sql1);
	  	while (rs.next()) { 
	  		secondYrBuy = rs.getInt(1);
	System.out.print(secondYrBuy);
		   
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
<title>Insert title here</title>
<style type="text/css"> 
	a { text-decoration:none }
	 a:link { color: blue; text-decoration: none; }
	 a:visited { color: purple; text-decoration: none; }
	 a:hover { color: red; text-decoration: underline; }
	 a:active { color: white; background-color: green; } 
	.navyBtn { width: 200px; margin-right:4px; border: 1px solid darkblue; background-color: darkblue; color: white; padding: 5px; }
	.calBtn { width: 100px; margin-right:2px; border: 1px solid darkblue; background-color: darkblue; color: white; padding: 2px; }

</style> 

</head>
<script>
function calcSecondYr(){  // 매출원가 = 기초재고 + 사온재고 - 기말재고 
    var resultSecondYr = document.forms[0].pyEB.value - document.forms[0].cyEB.value;
    document.forms[0].cgsSecondYr.value = resultSecondYr + <%=secondYrBuy %>;
}

</script>
<body>
<div id="wrapper">
<table width="1000px" align="center">
<form name="frmCal" action="yrEndSales.jsp" method="get"> 
<tr><td colspan="3"><p style="font-size:30px; color: darkblue">연간매출 비교</p></td> </tr>
<tr><td colspan="3">실제재고조사법: 매출원가 산출을 위해 재고 조사  결과를 넣어주세요 </p></td> </tr>
<tr>
	<td width="20%"><input type="text" name="pyEB" placeholder="작년말 재고 "  >원</td>   
	<td width="20%"><input type="text" name="cyEB" placeholder="올해말 재고 " >원 </td>
	<td width="*"><input type="button" value="계산하기" class="calBtn" onclick="calcSecondYr(); "></td>
	
	<td width="40%">2021년 매출원가: <input type="text"  name="cgsSecondYr">원</td>
</tr>

<tr><td colspan="2"><input type="reset" class="calBtn" value="다시입력"></td> <td colspan="2"><input type="submit" class="calBtn" value="그래프로 이동하기"></td> </tr>
<tr><td><주의사항></td></tr>
<tr><td colspan="4">	* 순이익 및 매출원가를 산출하기 위해서는 월말 및 기말 재고 금액을 넣어야 합니다 </td></tr>
<tr><td colspan="4">	** 계속기록법으로 재고관리 하시거나 상품 매출 및 상품 매출 원가를 제외한 기타 계정에 관련된 문의는 02-xxxx-xxxx 바랍니다</td></tr>
<tr>	
	<td ><input type="button" class="navyBtn" value="홈페이지로" onClick="location.href='../../index.jsp'"> </td>
	<td ><input type="button" class="navyBtn" value="관리자 페이지로" onClick="location.href='../a_index.jsp'"></td> 
	<td ><input type="button" class="navyBtn" value="월간 매출 비교" onClick="location.href='mthlyCGSForm.jsp'"></td>
</tr>
</form>
</table>

</div>
</body>
</html>
