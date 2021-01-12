<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<CartInfo> wishList = (ArrayList<CartInfo>)request.getAttribute("wishList");

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
<script>
function notCool(idx) {
	if (confirm("해당 상품을 위시리스트에서 삭제하시겠습니까?")) {
		$.ajax({
			type : "POST", 
			url : "/fourplay/wish_del.crt", 
			data : { "idx" : idx }, 
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
<form name="frmWish" action="ord_form.rod" method="post">
<table width="700" cellpadding="5">      
<tr>
<th width="*%">상품</th><th width="20%">적립금</th><th width="20%">가격</th>
<th width="10%">삭제</th>
</tr>
<%
if (wishList != null && wishList.size() > 0) {	// 위시리스트에 데이터가 들어 있으면
	for (int i = 0; i < wishList.size(); i ++) {	
		String lnk = "<a href='pdt_view.pdt" + args + "&id=" + wishList.get(i).getPl_id() + "'>";
%>
<tr>
<td align="left">
	<%=lnk%><img src="/mvcMall/product/pdt_img/<%=wishList.get(i).getPl_img1() %>" width="50" height="50" align="absmiddle" />
	<%=wishList.get(i).getPl_name() %></a>
</td>
<td align="center"><%=wishList.get(i).getPrice() / 100 %></td>
<td align="center"><%=wishList.get(i).getPrice() %></td>
<td>
	<input type="button" value="삭제" onclick="notCool(<%=wishList.get(i).getWl_id() %>)" />
</td>
</tr>
<%
	}
} else {	// 위시리스트에 데이터가 없으면
	out.println("<tr><td colspan='4'>위시리스트가 비었습니다.</td></tr>");
}
%>
<tr><th colspan="4" align="center">
	<input type="button" value="계속 쇼핑하기" onclick="location.href='pdt_list.pdt<%=args%>'" /></th></tr>
</table>
</form>
</body>
</html>