<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../community_menu.jsp" %>
<%
QAInfo article = (QAInfo)request.getAttribute("article");
if (article == null) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}

String uid = null;
if (adminMember != null)	uid = adminMember.getAl_id();

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
<style>
.bnview { font-size:13px; }
.nvcon td { border-bottom:1px #8C8C8C solid; }
.nvcon input { border:1px #8C8C8C solid;}
#aname td { border-bottom:2px #BDBDBD solid; }
#content { width:100%; height:300px; border:1px #8C8C8C solid; }
.button { border:0px; background-color:#002266; color:#FFFFFF; font-size:13px; }
</style>
</head>
<body>
<div id="wrapper">
<table class="bnview" width="700" cellpadding="5" cellspacing="0">
<tr id="aname"><td colspan="6">
FAQ
</td></tr>
<tr class="nvcon">
<td align="center" width="10%">제목</td><td width="30%"><%=article.getQl_title() %></td>
<td width="*" colspan="2"><td>
</tr>
<tr class="nvcon">
<td align="center">작성자</td><td width="10"><%=article.getQl_writer() %></td>
<td align="center" width="10%">작성일</td><td><%=article.getQl_qdate().substring(2, 10).replace('-', '.') %></td>
<td width="*" colspan="2"></td>
</tr>
<tr>
<td colspan="6">
<textarea id="content" name="content" rows="10" cols="60">
<%=article.getQl_content().replace("\r\n", "<br />") %></textarea>
</td></tr>
<%
boolean isPms = false;	
String link1 = null, link2 = null;

if (uid != null && uid.equals(article.getQl_writer())) {
	isPms = true;
	link1 = "location.href='brd_form.aqna?wtype=up&idx=" + idx + "';";
	link2 = "notCool(" + idx + ");";
} 

%>
<script>
function notCool(idx) {
	if (confirm("정말 삭제하시겠습니까?")) {
		location.href="brd_proc.aqna?wtype=del&idx=" + idx;
	}
}
</script>
<tr>
<td align='left'><input class="button" type="button" value="수정" onclick="<%=link1 %>" /></td>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<td><input class="button" type="button" value="삭제" onclick="<%=link2 %>" /></td>
<td align="right" colspan="4"><input class="button" type="button" value="목록으로" onclick="location.href='brd_list.aqna<%=args %>';" /></td>
</tr>
</table>
</div>
</body>
</html>