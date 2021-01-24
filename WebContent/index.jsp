<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ include file="menu.jsp" %>
<%@ include file="banner.jsp" %>
<%@ page import="vo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#bestList {width:80%; position:absolute; top:950px; left:150px;}

</style>
<!-- 
<link href="css/reset.css" type="text/css" rel="stylesheet" />
<link href="css/base.css" type="text/css" rel="stylesheet" />
 -->
</head>
<body>
<%
session.setMaxInactiveInterval(1800);
request.setCharacterEncoding("utf-8");
DecimalFormat df = new DecimalFormat("###,###");
Connection conn = null;
Statement stmt = null, stmt2 = null;
ResultSet rs = null, rs2 = null;
String sql = null;
String driver ="com.mysql.cj.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/fourplay?useUnicode=true&characterEncoding=utf8&verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";
try{
	Class.forName(driver);
	conn = DriverManager.getConnection(url, "root", "1234");
	PdtInfo pdtInfo = null;
	ArrayList<PdtInfo> bestList = new ArrayList<PdtInfo>();
	sql = "select p.pl_id, sum(s.ps_salecnt) as salecnt from t_product_size s, t_product_list p " +
		" where p.pl_id = s.pl_id and s.ps_stock != 0 and p.pl_view = 'y' group by p.pl_id order by salecnt desc limit 30 ";
	// 판매량 30위 상품들
	System.out.println(sql);
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	String plid = "";
	int salecnt = 0;
	while(rs.next()){
		plid = rs.getString(1);
		salecnt = rs.getInt(2);
		sql = "select * from t_product_list where pl_id = '" + plid + "' ";
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(sql);
		
		while(rs2.next()){
			pdtInfo = new PdtInfo();
	        pdtInfo.setPl_id(rs2.getString("pl_id"));
	        pdtInfo.setCs_idx(rs2.getInt("cs_idx"));
	        pdtInfo.setPl_name(rs2.getString("pl_name"));
	        pdtInfo.setPl_price(rs2.getInt("pl_price"));
	        pdtInfo.setPl_discount(rs2.getInt("pl_discount"));
	        pdtInfo.setPl_opt(rs2.getString("pl_opt"));
	        pdtInfo.setPl_img1(rs2.getString("pl_img1"));
	        pdtInfo.setPl_review(rs2.getInt("pl_review"));
	        bestList.add(pdtInfo);
		}
	}
	
%>
<div id="bestList">
<h3 align="center">BEST ITEM</h3>
<table width="100%">
<% 
int max = 3; 
if(bestList != null){
	String lnk = "", price="";
	for (int i = 0; i < bestList.size(); i++){
		lnk = "<a href='pdt_view.pdt?id=" + bestList.get(i).getPl_id() + "'>";
	    if (i % max == 0)   out.println("<tr align=\"center\">");
	    price = bestList.get(i).getPl_price() + "";
        if (bestList.get(i).getPl_discount() > 0){ // 할인율이 있으면
	        float rate = (float)bestList.get(i).getPl_discount() / 100;
	        int dcPrice = Math.round(bestList.get(i).getPl_price() - (bestList.get(i).getPl_price() * rate));
	        price = "<del>" + price + "</del><br/>" + df.format(dcPrice) + " 원";
        }
%>
<td>
	<div class="pdtBox<%=max%>">
      <%=lnk %><img src="/fourplay/product/pdt_img/<%=bestList.get(i).getPl_img1() %>" width="<%=max == 3 ? 250 : 190 %>" height="<%=max == 3 ? 200 : 140 %>" /></a><br />
      <%=lnk + bestList.get(i).getPl_name() %></a><br />
      <%= price %><br/>
   </div>
</td>
<%
		if (i % max == max - 1)   out.println("</tr>");
	}
}	else {
   out.println("<tr><td align='center'>검색결과가 없습니다.</td></tr>");
}
%>
</table>
</div>
<%
}catch(Exception e){
	e.printStackTrace();
	out.println("오류가 발생했습니다.");
}finally{
	try {
		rs.close(); 	rs2.close();	stmt.close();		stmt2.close();		conn.close();
	} catch(Exception e){
		e.printStackTrace();
	}
}
%>
</body>
</html>