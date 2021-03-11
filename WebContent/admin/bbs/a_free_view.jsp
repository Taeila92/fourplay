<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../a_menu.jsp" %>
<%
FreeInfo article = (FreeInfo)request.getAttribute("article");
if (article == null) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
}

String uid = null;
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
if (loginMember != null)	uid = loginMember.getMlid();

int idx = Integer.parseInt(request.getParameter("idx"));
int cpage = Integer.parseInt(request.getParameter("cpage"));
String schtype = request.getParameter("schtype");
String keyword = request.getParameter("keyword");
String args = "?cpage=" + cpage;
if (schtype != null && keyword != null && !keyword.equals("")) {
	args += "&schtype=" + schtype + "&keyword=" + keyword;
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div id="wrapper">
<h2>자유 게시판 글보기 화면</h2>
<table width="700" cellpadding="5" cellspacing="0" id="friboard" border="1px">
<tr>
<td align="center" width="15%">이름</td>
<td width="60%"><%=article.getFl_writer() %></td>
<td align="center" width="15%">게시여부</td>
<td width="*">	
	<select>
		<option value="up">게시</option>
		<option value="down">미게시</option>
	</select>
</td>
</tr>
<tr>
<td align="center">제목</td>
<td colspan="3"><%=article.getFl_title() %></td>
</tr>
<tr>
<td><%=article.getFl_content() %></td>
</tr>
</table>
<table width="700" cellpadding="5" cellspacing="0">
<tr>
<td align="right">
	<input type="button" value="목록으로" onclick="location.href='brd_list.afree';" />
</td>
</tr>
</table>
</div>
</body>
</html>
