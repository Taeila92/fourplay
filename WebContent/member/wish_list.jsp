<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<CartInfo> wishList = (ArrayList<CartInfo>)request.getAttribute("wishList");
DecimalFormat df = new DecimalFormat("###,###");
int cpage = 0, psize = 0;
if(request.getParameter("cpage") != null)
	cpage = Integer.parseInt(request.getParameter("cpage"));
if(request.getParameter("psize") != null)
	psize = Integer.parseInt(request.getParameter("psize"));

String args = "";
if (cpage > 0 && psize > 0)		args = "?cpage=" + cpage + "&psize=" + psize;
String id, keyword, bcata, scata, brand, sprice, eprice, ord;
keyword = request.getParameter("keyword");	bcata	= request.getParameter("bcata");	
scata	= request.getParameter("scata");	brand	= request.getParameter("brand");	
sprice	= request.getParameter("sprice");	eprice	= request.getParameter("eprice");	
ord 	= request.getParameter("ord");

if (bcata != null && !bcata.equals(""))		args += "&bcata=" + bcata;
if (scata != null && !scata.equals(""))		args += "&scata=" + scata;
if (brand != null && !brand.equals(""))		args += "&brand=" + brand;
if (sprice != null && !sprice.equals(""))	args += "&sprice=" + sprice;
if (eprice != null && !eprice.equals(""))	args += "&eprice=" + eprice;
if (keyword != null && !keyword.equals(""))	args += "&keyword=" + keyword;
if (ord != null && !ord.equals(""))			args += "&ord=" + ord;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#kTitle {color:#8e8e8e; font-size:17px; }
#wishList #wishTitle { background-color:#d1d1d1;}
#wishList table{ border-bottom:1px solid darkgray; margin-bottom:10px;}
#wishTitle th { border-top:2px solid darkgray;}
a{ text-decoration: none; color: #222; }
a:link { color:#4f4f4f; text-decoration:none; }
a:visited { color:#4f4f4f; text-decoration:none; }
a:hover { color:pink; text-decoration:none;  font-weight:bold;}
a:active { color:#f00; text-decoration:none; }   
a:focus { color:pink; text-decoration:none; }
.btngray {
	border:0px; color:#fff; background-color:darkgray; margin:5px;
	width:50px; height:20px;
}
.btnblue {
	border:0px; color:#fff; background-color:#10255F; margin:5px;
	width:160px; height:35px; font-size:20px;
}
</style>
<script src="jquery-3.5.1.js"></script>
<script>
function wishDel(id) {
	if (confirm("해당 상품을 위시리스트에서 삭제하시겠습니까?")) {
		$.ajax({
			type : "POST", 
			url : "/fourplay/wish_del.crt", 
			data : { "id" : id }, 
			success : function(chkRst) {
				if(chkRst == 0)		alert("선택한 상품 삭제에 실패했습니다.\n다시 시도해 주십시오.");
				else				location.reload();
			}
		});
	}
}
</script>
</head>
<body>
<div id="wrapper">	
<h2>WISH LIST <span id="kTitle"> 관심상품</span></h2>
<form name="frmWish" action="" method="post">
<div id="wishList" width="100%" align="center">
<table width="700" cellpadding="5" cellspacing="0">      
<tr id="wishTitle">
<th width="*%">상품</th><th width="20%">적립금</th><th width="20%">가격</th>
<th width="10%">삭제</th>
</tr>
<%
if (wishList != null && wishList.size() > 0) {	// 위시리스트에 데이터가 들어 있으면
	for (int i = 0; i < wishList.size(); i ++) {
		int price = wishList.get(i).getPrice();
		int point = wishList.get(i).getPrice() / 10000 * 100;
		String lnk = "<a href='pdt_view.pdt" + args + "&id=" + wishList.get(i).getPl_id() + "'>";
%>
<tr>
<td align="left">
	<%=lnk%><img src="/fourplay/product/pdt_img/<%=wishList.get(i).getPl_img1() %>" width="50" height="50" align="absmiddle" />
	<%=wishList.get(i).getPl_name() %></a>
</td>
<td align="center"><%=df.format(point) %></td>
<td align="center"><%=df.format(price) %></td>
<td>
	<input type="button" class="btngray"  value="삭제" onclick="wishDel(<%=wishList.get(i).getWl_id() %>)" />
</td>
</tr>
<%
	}
} else {	// 위시리스트에 데이터가 없으면
	out.println("<tr><td colspan='4' align='center'>위시리스트가 비었습니다.</td></tr>");
}
%>
<tr><th colspan="4" align="center">
</table>
</div>
<div width="100%" align="center">
	<input type="button" class="btnblue" value="계속 쇼핑하기" onclick="location.href='pdt_list.pdt<%=args%>'" /></th></tr>
</div>
</form>
</div>
</body>
</html>