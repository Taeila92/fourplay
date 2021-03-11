<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%

ArrayList<QAInfo> articleList = 
	(ArrayList<QAInfo>)request.getAttribute("articleList");
QAPageInfo pageInfo = (QAPageInfo)request.getAttribute("pageInfo");

String schtype = null, keyword = null, schargs = "", args = "";
if (pageInfo.getSchtype() == null || pageInfo.getKeyword() == null) {
	schtype = "";	keyword = "";
} else {	
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
a:hover { color:grey; text-decoration:underline; font-weight:bold; }
a:active { color:#f00; text-decoration:none; }	
a:focus { color:#f00; text-decoration:underline; }
</style>
</head>
<body>
<span>Q&A</span> &nbsp;&nbsp;&nbsp;&nbsp; 자유질문 게시판입니다.

<table width="700" cellpadding="5" cellspacing="0" id="brdList">
<tr>
<th width="8%">번호</th><th width="*">제목</th><th width="15%">작성자</th>
<th width="15%">작성일</th><th width="8%">상태</th>
</tr>
<%
if (articleList != null && rcnt > 0) {	// 검색결과가 있으면
	int seq = rcnt - (10 * (cpage - 1));	// 현재 페이지에서의 시작번호
	String title = "", reply = "", lnk = "";
	for (int i = 0 ; i < articleList.size() ; i++) {
		title = articleList.get(i).getQl_title();
		lnk = "<a href='brd_view.qna?idx=" + 
			articleList.get(i).getQl_idx() + args + 
			"' title='" + title + "'>";

		if (title.length() > 28)
			title = title.substring(0, 26) + "...";

%>
<tr align="center" onmouseover="this.style.background='#efefef';" 
	onmouseout="this.style.background='';">
<td><%=seq-- %></td>
<td align="left"><%=lnk + title + "</a>" + reply %></td>
<td><%=articleList.get(i).getQl_writer() %></td>
<td><%=articleList.get(i).getQl_qdate().substring(2, 10).replace('-', '.') %></td>
<td><%=articleList.get(i).getQl_adate().substring(2, 10).replace('-', '.') %></td>
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
		out.print("<a href='brd_list.qna?cpage=1" + schargs + "'>");
		out.println("[<<]</a>&nbsp;&nbsp;");
		out.print("<a href='brd_list.qna?cpage=" + (cpage - 1) + schargs + "'>");
		out.println("[<]</a>&nbsp;&nbsp;");
	}

	for (int i = 1, j = spage ; i <= 10 && j <= pcnt ; i++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.print("&nbsp;<a href='brd_list.qna?cpage=" + j + schargs + "'>");
			out.println(j + "</a>&nbsp;");
		}
	}

	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[>]&nbsp;&nbsp;[>>]");
	} else {
		out.print("&nbsp;&nbsp;<a href='brd_list.qna?cpage=" + (cpage + 1) + schargs + "'>");
		out.println("[>]</a>");
		out.print("&nbsp;&nbsp;<a href='brd_list.qna?cpage=" + pcnt + schargs + "'>");
		out.println("[>>]</a>");
	}
}
%>
</td>
<td width="10%">
	<input type="button" value="글쓰기" onclick="location.href='brd_form.qna?wtype=in';" />
</td>
</tr>
</table>
<form name="frmSch" method="get">
<table width="700" cellpadding="5">
<tr><td align="right">
	<select name="schtype">
		<option value="title" <% if (schtype.equals("title")) { %>
			selected="selected"<% } %>>제목</option>
		<option value="content" <% if (schtype.equals("content")) { %>
			selected="selected"<% } %>>내용</option>
		<option value="tc" <% if (schtype.equals("tc")) { %>
			selected="selected"<% } %>>제목+내용</option>
		<option value="writer" <% if (schtype.equals("writer")) { %>
			selected="selected"<% } %>>작성자</option>
	</select>
	<input type="text" name="keyword" value="<%=keyword %>" />
	<input type="submit" value="검색" />
</td></tr>
</table>
</form>
</body>
</html>
