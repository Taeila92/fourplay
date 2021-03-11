<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../community_menu.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String wtype = request.getParameter("wtype");
String args = "";

String msg = "수정", writer = "", title = "", content = "";
int idx = 0;
if (wtype.equals("in")) {
	msg = "등록";
} else if (wtype.equals("up")) {	// 게시글 수정일 경우
	FaqInfo article = (FaqInfo)request.getAttribute("article");
	// 수정할 게시글의 데이터가 저장된 article 인스턴스를 request에서 받아 생성
	idx = article.getFq_idx();
	writer = article.getFq_writer();
	title = article.getFq_title();
	content = article.getFq_content();

	int cpage = Integer.parseInt(request.getParameter("cpage"));
	args = "?cpage=" + cpage;
	String schtype = request.getParameter("schtype");
	String keyword = request.getParameter("keyword");
	if (keyword != null && !keyword.equals("")) {
		args += "&schtype=" + schtype + "&keyword=" + URLEncoder.encode(keyword, "UTF-8");
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.bqform { font-size:13px; }
.qfcon td { border-bottom:1px #8C8C8C solid; }
.qfcon input { border:1px #8C8C8C solid;}
#aname td { border-bottom:2px #BDBDBD solid; }
#content { width:100%; height:300px; border:1px #8C8C8C solid; }
.button input { border:0px; background-color:#002266; color:#FFFFFF; font-size:13px; }
</style>
</head>
<body>
<div id="wrapper">
<form name="bbsfaqform" action="bbs_proc.afaq<%=args %>" method="post">
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="wtype" value="<%=wtype %>" />
<table class="bqform" width="700" cellpadding="5" cellspacing="0">
<tr id="aname"><td colspan="5">
FAQ
</td></tr>
<%
if (wtype.equals("in")) {
%>
<tr class="qfcon">	
<td align="center">작성자</td><td><%=adminMember.getAl_id() %>
</tr>
<%
} else {
// 글 수정상황이면
	out.println("<tr><td>작성자</td><td>" + writer + "</td></tr>");
}
%>
<tr class="qfcon">
<td align="center">제목</td>
<td colspan="3"><input type="text" name="title" size="60" value="<%=title %>" /></td>
</tr>
<tr>
<td colspan="4"><textarea id="content" name="content" rows="10" cols="60"><%=content %></textarea></td>
</tr>
<tr class="button"><td colspan="4" align="right">
	<input type="button" value="목록으로" onclick="location.href='bbs_list.afaq<%=args %>';" />
	&nbsp;&nbsp;&nbsp;
	<input type="submit" value="글<%=msg %>"  />
</td></tr>
</table>
</form>
</div>
</body>
</html>
