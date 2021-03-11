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

int janBuy=0, febBuy=0, marBuy=0;
int py4EB = 0, cy1EB = 0, cy2EB = 0, cy3EB = 0; 
try{
   Class.forName(driver);
   conn = DriverManager.getConnection(url, "root", "1234");
   stmt = conn.createStatement();
   
 
	  	//1월 당기상품원가
	  	String sql4 ="select SUM(pl_cost) as sum FROM t_product_list WHERE left(pl_date,7)= '2021-01'";
	  	System.out.print(sql4);
	  	rs = stmt.executeQuery(sql4);
	  	while (rs.next()) { 
	  		janBuy = rs.getInt(1);
	System.out.print(janBuy);
		   
	  }
	  	//2월 당기상품원가
	  	String sql5 ="select SUM(pl_cost) as sum FROM t_product_list WHERE left(pl_date,7)= '2021-02'";
	  	System.out.print(sql5);
	  	rs = stmt.executeQuery(sql5);
	  	while (rs.next()) { 
	  		febBuy = rs.getInt(1);
	System.out.print(febBuy);
		   
	  }
	  	//1월 당기상품원가
	  	String sql6 ="select SUM(pl_cost) as sum FROM t_product_list WHERE left(pl_date,7)= '2021-03'";
	  	System.out.print(sql6);
	  	rs = stmt.executeQuery(sql6);
	  	while (rs.next()) { 
	  		marBuy = rs.getInt(1);
	System.out.print(marBuy);
		   
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
	 .calBtn { width: 150px; height: 25px; margin-right:2px; border: 1px solid darkblue; background-color: darkblue; color: white; padding: 2px; }

</style> 

<hr />
</head>
<script>
function calcJan(){  // 매출원가 = 기초재고 + 사온재고 - 기말재고 
    var resultJan = document.forms[0].py4EB.value - document.forms[0].cy1EB.value;
    document.forms[0].cgsJan.value = resultJan + <%=janBuy %>;
}

function calcFeb(){  // 매출원가 = 기초재고 + 사온재고 - 기말재고 
    var resultFeb = document.forms[0].cy1EB.value - document.forms[0].cy2EB.value;
    document.forms[0].cgsFeb.value = resultFeb + <%=febBuy %>;
}

function calcMar(){  // 매출원가 = 기초재고 + 사온재고 - 기말재고 
    var resultMar = document.forms[0].cy2EB.value - document.forms[0].cy3EB.value;
    document.forms[0].cgsMar.value = resultMar + <%=marBuy %>;
}

</script>
<body>

<div id="wrapper">

	<form name="frmCal" action="qEndSales.jsp" method="get"> 
	<table cellpadding="5">
	<tr><td colspan="3"><p style="font-size:30px; color: darkblue">월간매출 비교</p></td> </tr>
	<tr><a href="https://txsi.hometax.go.kr/docs/customer/dictionary/view.jsp?word=&word_id=6195">
	실제재고조사법</a> : 매출원가 산출을 위해 재고 조사  결과를 넣어주세요  </tr>
	
	<tr>
		<td><input type="text" name="py4EB" placeholder="작년말 재고 "  >원  </td>
		<td><input type="text" name="cy1EB" placeholder="1월말 재고 " >원</td>
		<td><input type="button" value="계산하기" class="calBtn" onclick="calcJan(); "></td>	
		<td>1월 매출원가: <input type="text"  name="cgsJan">원 </td>
	</tr>	
	<br />
	<tr>
		<td><input type="text" name="cy1EB" placeholder="1월말 재고 "  >원   </td>
		<td><input type="text" name="cy2EB" placeholder="2월말 재고 " >원 </td>
		<td><input type="button" value="계산하기" class="calBtn" onclick="calcFeb()"></td>
		<td>2월 매출원가: <input type="text"  name="cgsFeb">원</td>
	</tr>
	<br />
	<tr>	
		<td><input type="text" name="cy2EB" placeholder="2월말 재고 "  >원   </td>
		<td><input type="text" name="cy3EB" placeholder="3월말 재고 " >원 </td>
		<td><input type="button" value="계산하기" class="calBtn" onclick="calcMar()"></td>
		<td>3월 매출원가: <input type="text"  name="cgsMar">원</td>
	</tr>
	<hr />
	<tr align="center">
		<td colspan="2"  ><input type="reset" class="calBtn" value="다시입력"> </td>
		<td colspan="2" ><input type="submit" class="calBtn" value="그래프로 이동하기"></td> 
	</tr>
	<tr>
		<td colspan="4"><주의사항></td>
	</tr>
	<tr>
		<td colspan="4">* 순이익 및 매출원가를 산출하기 위해서는 월말 및 기말 재고 금액을 넣어야 합니다  </td>
	</tr>
	<tr>
		<td colspan="4">** 계속기록법으로 재고관리 하시거나 상품 매출 및 상품 매출 원가를 제외한 기타 계정에 관련된 문의는 02-xxxx-xxxx 바랍니다 </td>
	</tr>
	<tr>
		<td ><input type="button" class="navyBtn" value="홈페이지로" onClick="location.href='../../index.jsp'"> </td>
		<td ><input type="button" class="navyBtn" value="관리자 페이지로" onClick="location.href='../a_index.jsp'"></td> 
		<td ><input type="button" class="navyBtn" value="연간 매출 비교" onClick="location.href='yrlyCGSForm.jsp'"></td> 
		<td ><input type="button" class="navyBtn" value="최고 금액 주문자" onClick="location.href='bestCustomer.jsp'"></td> 
	
	</tr>
	
	
	</table>
	</form>
</div>
</body>
</html>
