<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../community_menu.jsp" %>
<%
ArrayList<NoticeInfo> articleList = (ArrayList<NoticeInfo>)request.getAttribute("articleList");
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
.bnotice { font-size:13px; }
#aname td { border-bottom:2px #BDBDBD solid; }
#bnsub { background-color:#EAEAEA; font-family:'Nanum Gothic'; }
#bncon { height:50px; }
#bncon td { border-bottom:1px #8C8C8C solid; }
#bncon select { vertical-align:middle; text-align-last:center; }
#submit { border:0px; background-color:#002266; color:#FFFFFF; font-size:13px; }
</style>
</head>
<body>
<div id="wrapper">
<table class="bnotice" width="700" cellpadding="5" cellspacing="0">
<tr id="aname"><td colspan="5">
Notice&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
새로운 이벤트 및 안내 가이드 게시글을 확인하실 수 있습니다.
</td></tr>
<tr height="15"></tr>
<tr id="bnsub"  align="center">
<th width="11%">번호</th><th width="*">제목</th><th width="15%">작성자</th>
<th width="15%">작성일</th><th width="11%">게시여부</th>
</tr>
<%
if (articleList != null && rcnt > 0) {
	int seq = rcnt - (10 * (cpage - 1));	
	String title = "", lnk = "";
	for (int i = 0 ; i < articleList.size() ; i++) {
		title = articleList.get(i).getNl_title();
		lnk = "<a href='bbs_view.anotice?idx=" + 
			articleList.get(i).getNl_idx() + args + 
			"' title='" + title + "'>";

		if (title.length() > 28)
			title = title.substring(0, 26) + "...";
%>
<tr id="bncon" align="center">
<td><%=seq-- %></td>
<td align="left"><%=lnk + title + "</a>" %></td>
<td><%=articleList.get(i).getNl_writer() %></td>
<td><%=articleList.get(i).getNl_date().substring(2, 10).replace('-', '.') %></td>
<td>
<select>
    <option value="up">게시</option>
	<option value="up">미게시</option>
</select>
</td>
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
<table class="bnotice" width="700" cellpadding="5">
<tr>
<td width="*" align="center">
<%
if (rcnt > 0) {
	pcnt = rcnt / 10;
	if (rcnt % 10 > 0)	pcnt++;

	if (cpage == 1) {
		out.println("[<<]&nbsp;&nbsp;[<]&nbsp;&nbsp;");
	} else {
		out.print("<a href='bbs_list.anotice?cpage=1" + schargs + "'>");
		out.println("[<<]</a>&nbsp;&nbsp;");
		out.print("<a href='bbs_list.anotice?cpage=" + (cpage - 1) + schargs + "'>");
		out.println("[<]</a>&nbsp;&nbsp;");
	}

	for (int i = 1, j = spage ; i <= 10 && j <= pcnt ; i++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.print("&nbsp;<a href='bbs_list.anotice?cpage=" + j + schargs + "'>");
			out.println(j + "</a>&nbsp;");
		}
	}

	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;[>]&nbsp;&nbsp;[>>]");
	} else {
		out.print("&nbsp;&nbsp;<a href='bbs_list.anotice?cpage=" + (cpage + 1) + schargs + "'>");
		out.println("[>]</a>");
		out.print("&nbsp;&nbsp;<a href='bbs_list.anotice?cpage=" + pcnt + schargs + "'>");
		out.println("[>>]</a>");
	}
}
%>
</td>

<td width="10%"><input id="submit" type="button" value="글 등록" onclick="location.href='bbs_form.anotice?wtype=in';" />

</tr>
</table>
<form name="frmSch" method="get">
<table class="bnotice" width="700" cellpadding="5">
<tr><td align="center">
	<input type="radio" name="schtype" value="writer" <% if (schtype.equals("writer")) { %>checked="checked" <% } %>>작성자
	<input type="radio" name="schtype" value="title"  <% if (schtype.equals("title")) { %>checked="checked"<% } %> />제목
	<input type="radio" name="schtype" value="tc" <% if (schtype.equals("tc")) { %>	checked="checked" <% } %>>제목+내용
	<input type="text" name="keyword" <%if(!keyword.equals("")){ %>value="<%=keyword %>" <%} %>/>
	<input type="submit" value="검색" />
</td></tr>
</table>
</form>
</div>
</body>
</html>
