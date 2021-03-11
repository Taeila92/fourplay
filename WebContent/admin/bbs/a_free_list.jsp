<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../a_menu.jsp" %>
<%
ArrayList<FreeInfo> articleList = (ArrayList<FreeInfo>)request.getAttribute("articleList");
PageInfo pageInfo = (PageInfo)request.getAttribute("pageInfo");


String schtype = null, keyword = null, schargs = "", args = "";
if (pageInfo.getSchtype() == null || pageInfo.getKeyword() == null) {	// 검색을 하지 않은 경우
	schtype = "";	keyword = "";
} else {	// 검색을 했을 경우
	schtype = pageInfo.getSchtype();	
	keyword = pageInfo.getKeyword();	
	if (keyword != null && !keyword.equals("")) {
		schargs = "&schtype=" + schtype + "&keyword=" + keyword;
	}
}
int cpage = pageInfo.getCpage();
int pcnt = pageInfo.getPcnt();	
int spage = pageInfo.getSpage();
int epage = pageInfo.getEpage();
int rcnt = pageInfo.getRcnt();	

args = "&cpage=" + cpage + schargs;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#brdList tr { height:40px; }
#brdList td, #brdList th { border-bottom:1px black solid; }
a:link { color:#4f4f4f; text-decoration:none; }
a:visited { color:#4f4f4f; text-decoration:none; }
a:hover { color:pink; text-decoration:underline; font-weight:bold; }
a:active { color:#f00; text-decoration:none; }	
a:focus { color:#f00; text-decoration:underline; }
</style>
</head>
<body>
<h2>자유 게시판 목록 화면</h2>
<div id="wrapper">
<table width="700" cellpadding="5" cellspacing="0" id="brdList">
<tr>
<th width="8%">번호</th><th width="*">제목</th><th width="15%">작성자</th>
<th width="15%">작성일</th><th width="8%">조회</th>
</tr>
<%
if (articleList != null && rcnt > 0) {
	int seq = rcnt - (10 * (cpage - 1));	
	String title = "", reply = "", lnk = "";
	for (int i = 0 ; i < articleList.size() ; i++) {
		title = articleList.get(i).getFl_title();
		lnk = "<a href='brd_view.afree?idx=" + 
			articleList.get(i).getFl_idx() + args + 
			"' title='" + title + "'>";

		if (title.length() > 28)
			title = title.substring(0, 26) + "...";

		reply = "";	
		if (articleList.get(i).getFl_reply() > 0)
			reply = " [" + articleList.get(i).getFl_reply() + "]";
%>
<tr align="center" onmouseover="this.style.background='#efefef';" 
	onmouseout="this.style.background='';">
<td><%=seq-- %></td>
<td align="left"><%=lnk + title + "</a>" + reply %></td>
<td><%=articleList.get(i).getFl_writer() %></td>
<td><%=articleList.get(i).getFl_date().substring(2, 10).replace('-', '.') %></td>
<td><%=articleList.get(i).getFl_read() %></td>
</tr>
<%
	}
} else {	// 검색결과가 없으면
	out.println("<tr align='center'><td colspan='5'>");
	out.println("검색 결과가 없습니다.</td></tr>");
}
%>
</table>
<br />
<table width="700" cellpadding="5">
<tr>
<td width="*">
<%
if (rcnt > 0) {
	pcnt = rcnt / 10;
	if (rcnt % 10 > 0)	pcnt++;

	if (cpage == 1) {
		out.println("[<<]&nbsp;&nbsp;[<]&nbsp;&nbsp;");
	} else {
		out.print("<a href='brd_list.afree?cpage=1" + schargs + "'>");
		out.println("[<<]</a>&nbsp;&nbsp;");
		out.print("<a href='brd_list.afree?cpage=" + (cpage - 1) + schargs + "'>");
		out.println("[<]</a>&nbsp;&nbsp;");
	}

	for (int i = 1, j = spage ; i <= 10 && j <= pcnt ; i++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.print("&nbsp;<a href='brd_list.afree?cpage=" + j + schargs + "'>");
			out.println(j + "</a>&nbsp;");
		}
	}

	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[>]&nbsp;&nbsp;[>>]");
	} else {
		out.print("&nbsp;&nbsp;<a href='brd_list.afree?cpage=" + (cpage + 1) + schargs + "'>");
		out.println("[>]</a>");
		out.print("&nbsp;&nbsp;<a href='brd_list.afree?cpage=" + pcnt + schargs + "'>");
		out.println("[>>]</a>");
	}
}
%>
</td>
</tr>
</table>
<form name="frmSch" method="get">
<table width="700" cellpadding="5">
<tr><td align="center">
	<input type="radio" name="schtype" value="writer" checked="checked" <% if (schtype.equals("writer")) { %>
		<% } %>>작성자
	<input type="radio" name="schtype" value="title"  <% if (schtype.equals("title")) { %>
		<% } %> />제목
	<input type="radio" name="schtype" value="tc" <% if (schtype.equals("tc")) { %>
		<% } %>>제목+내용

	<input type="text" name="keyword" value="<%=keyword %>" />
	<input type="submit" value="검색" />
</td></tr>
</table>
</form>
</div>
</body>
</html>
