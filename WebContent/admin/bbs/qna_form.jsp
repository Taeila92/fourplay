<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
<%
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");

request.setCharacterEncoding("utf-8");
String wtype = request.getParameter("wtype");
String args = "";

String msg = "수정", writer = "", title = "", content = "", ismember = "";
int idx = 0;
if (wtype.equals("in")) {
	msg = "등록";
} else if (wtype.equals("up")) {	// 게시글 수정일 경우
	QAInfo article = (QAInfo)request.getAttribute("article");
	idx = article.getQl_idx();
	writer = article.getQl_writer();
	title = article.getQl_title();
	content = article.getQl_content();
	ismember = article.getQl_ismember();	// 게시글의 회원/비회원 여부

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
</head>
<body>
<h2>Q&A 게시판 글<%=msg %> 폼</h2>
<form name="frmQA" action="brd_proc.qna<%=args %>" method="post">
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="wtype" value="<%=wtype %>" />
<input type="hidden" name="ismember" value="<%=ismember %>" />
<table cellpadding="5">
<%
if (wtype.equals("in")) {
%>
<tr>
<%	if (loginMember == null) {	// 비회원일 경우 %>
<th>작성자</th><td><input type="text" name="writer" /></td>
<th>비밀번호</th><td><input type="password" name="pwd" /></td>
<%	} else {	// 로그인 한 회원일 경우 %>
<th>작성자</th><td><%=loginMember.getMlid() %></td>
<%	} %>
</tr>
<%
} else {
	out.println("<tr><th>작성자</th><td>" + writer + "</td></tr>");
}
%>
<tr>
<th>제목</th>
<td colspan="3"><input type="text" name="title" size="58" value="<%=title %>" /></td>
</tr>
<tr>
<th>내용</th>
<td colspan="3"><textarea name="content" rows="10" cols="60"><%=content %></textarea></td>
</tr>
<tr><td colspan="4" align="center">
	<input type="submit" value="글<%=msg %>" />
	<input type="reset" value="다시 입력" />
</td></tr>
</table>
</form>
</body>
</html>
