<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.text.*" %>
<%
request.setCharacterEncoding("utf-8");
DecimalFormat df = new DecimalFormat("###,###");
int cpage = 1, psize = 12;
if(request.getParameter("cpage") != null)  cpage = Integer.parseInt(request.getParameter("cpage"));
if(request.getParameter("psize") != null)  psize = Integer.parseInt(request.getParameter("psize"));

// 검색조건 및 정렬조건 쿼리스트링을 받음
String id, keyword, bcata, scata, brand, sprice, eprice, ord;
id		= request.getParameter("id");		keyword = request.getParameter("keyword");
bcata	= request.getParameter("bcata");	scata	= request.getParameter("scata");
sprice	= request.getParameter("sprice");	eprice	= request.getParameter("eprice");
ord 	= request.getParameter("ord");

String args = "?cpage=" + cpage + "&psize=" + psize;
if (bcata != null && !bcata.equals(""))		args += "&bcata=" + bcata;
if (scata != null && !scata.equals(""))		args += "&scata=" + scata;
if (sprice != null && !sprice.equals(""))	args += "&sprice=" + sprice;
if (eprice != null && !eprice.equals(""))	args += "&eprice=" + eprice;
if (keyword != null && !keyword.equals(""))	args += "&keyword=" + keyword;
if (ord != null && !ord.equals(""))			args += "&ord=" + ord;

PdtInfo pdtInfo = (PdtInfo)request.getAttribute("pdtInfo");
//추가
String plname = pdtInfo.getPl_name();

String soldout = "";
if (pdtInfo.getPs_stock() == 0)
	soldout = " <img src='/fourplay/images/soldout.png' width='80' align='absmiddle' />";

String psstock = String.valueOf(pdtInfo.getPs_stock());
if (psstock.equals("-1"))	psstock = "무제한";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.detail td { border-bottom:2px solid #efefef;}
td .borderwide {border-bottom:4px solid #eee;}
.detail s { color:red;}
.detail select { width:120px;}
.view li {
	display:inline; padding:0 3px 0 8px; no-repeat 0 3px; text-align:"center"
	/* 다른 글자들과의 조화때문에 3px정도 내려서 출력 */
}

/* 최상단 메뉴의 링크 글자색 변경 */
.view li a { color:#676767; text-decoration:none;}
.view li a:hover, #infoMenu li a:focus { color:#000; }
.view li:first-child { background:none; }
#thImg img { margin:10px; }
#submitbtn input {border:1px solid #eee; background:white;}
#submitbtn #buybtn {width:306px;}
#submitbtn .cartbtn {width:150px;}
</style>
<script>
function showImg(imgName) {
	var bigImg = document.getElementById("bigImg");
	bigImg.src = "/fourplay/product/pdt_img/" + imgName;
}

</script>
</head>
<body>
<div id="wrapper">
<h2>상품 상세보기 화면</h2>
<table width="800" cellpadding="5" cellspacing="0">
<tr>
<td width="55%" align="center" valign="middle">
	<table width="100%">
	<tr><td align="center" valign="middle">
		<img src="/fourplay/product/pdt_img/<%=pdtInfo.getPl_img1() %>" width="300" id="bigImg" />
	</td></tr>
	<tr><td align="center" valign="middle" id="thImg">
		<img src="/fourplay/product/pdt_img/<%=pdtInfo.getPl_img1() %>" width="50" onclick="showImg('<%=pdtInfo.getPl_img1() %>');" />
<% if (pdtInfo.getPl_img2() != null && !pdtInfo.getPl_img2().equals("")) { %>
		<img src="/fourplay/product/pdt_img/<%=pdtInfo.getPl_img2() %>" width="50" onclick="showImg('<%=pdtInfo.getPl_img2() %>');" /><% } %>
<% if (pdtInfo.getPl_img3() != null && !pdtInfo.getPl_img3().equals("")) { %>
		<img src="/fourplay/product/pdt_img/<%=pdtInfo.getPl_img3() %>" width="50" onclick="showImg('<%=pdtInfo.getPl_img3() %>');" /><% } %>
	</td></tr>
	</table>
</td>
<td width="*" valign="top">
	<table width="100%" cellpadding="8" cellspacing="0" class="detail">
   <tr><td colspan="2" class="borderwide">  <%=pdtInfo.getPl_name() %></td></tr>
<%
   String price = pdtInfo.getPl_price() + "";
   int point = pdtInfo.getPl_price() / 100;
   if (pdtInfo.getPl_discount() > 0){ // 할인율이 있으면
      int dcprice = pdtInfo.getPl_price() * (100 - pdtInfo.getPl_discount()) / 100;
      price = "<s>" + price + "</s><tr><td>할인적용</td><td>" + df.format(dcprice) + "</td></tr>";
      point = dcprice / 10000 * 100;
   }
%>
	<tr><td>소비자가</td><td><%=price %></td></tr>
	<tr><td>적립금</td><td><%=point %> (1%)</td></tr>
	<tr>
		<td  class="borderwide">판매량</td>
		<td class="borderwide"><%=pdtInfo.getPs_salecnt()%></td>
	</tr>
	<tr>
		<td  class="borderwide">재고량</td>
		<td class="borderwide"><% out.println((pdtInfo.getPs_stock() == -1) ? "무제한" : pdtInfo.getPs_stock()); %></td>
	</tr>
	</table>
</td>
</tr>
<table width="800">
<tr><td colspan="2" align="center"><hr width="100%" /></td></tr>
<tr>
	<td id="detail">
		<div width="100%">
			<ul class="view" align="center">
				<li><strong><span>DETAIL VIEW</span></strong>&nbsp;&nbsp;&nbsp;|</li>
				<li><a href="#review"><span>REVIEW</span></a>&nbsp;&nbsp;&nbsp;|</li>
				<li><a href="#qna"><span>Q&A</span></a></li>
			</ul>
		</div>
	</td>
</tr>
<tr><td colspan="2" align="center">
	<img src="/fourplay/product/pdt_img/<%=pdtInfo.getPl_desc() %>" width="780" />
</td></tr>
<tr><td colspan="2" align="center"><hr width="100%" /></td></tr>
</td></tr>
<tr>
	<td id="review">
		<div>
			<ul class="view" align="center">
				<li><a href="#detail"><span>DETAIL VIEW</span></a>&nbsp;&nbsp;&nbsp;|</li>
				<li><strong><span>REVIEW</span></strong>&nbsp;&nbsp;&nbsp;|</li>
				<li><a href="#qna"><span>Q&A</span></a></li>
			</ul>
		</div>
	</td>
</tr>
<tr><td>
	<iframe src="../product/review_list.review?plid=<%=id %>&plname=<%=plname %>" width="100%" height="500px" ></iframe>
</td></tr>
<tr>
	<td id="qna">
		<div>
			<ul class="view" align="center">
				<li><a href="#detail"><span>DETAIL VIEW</span></a>&nbsp;&nbsp;&nbsp;|</li>
				<li><a href="#review"><span>REVIEW</span></a>&nbsp;&nbsp;&nbsp;|</li>
				<li><strong><span>Q&A</span></strong></li>
			</ul>
		</div>
	</td>
</tr>
<tr><td>
Q&A 게시판 구역<br/>
</td></tr>
</table>
<br /><br />
</div>
</body>
</html>
