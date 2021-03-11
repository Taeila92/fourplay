<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../menu.jsp" %>
<%
NoticeInfo article = (NoticeInfo)request.getAttribute("article");
if (article == null) {
// 저장된 게시물이 없으면
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
.commenu td { align:left; }
.nvcon td { border-bottom:1px #8C8C8C solid; height:30px; }
.nvcon input { border:1px #8C8C8C solid;}
#aname td { border-bottom:2px #BDBDBD solid; }
#content { width:100%; height:300px; border:1px #8C8C8C solid; }
.button { border:0px; background-color:#002266; color:#FFFFFF; font-size:13px; }
</style>
</head>
<body>
<div id="wrapper">
<table class="commenu" width="100%">
<tr>
<td>COMMUNITY&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>&nbsp;<a href="bbs_list.notice">NOTICE</a></td>
<td>/&nbsp;<a href="bbs_list.faq">FAQ</a></td>
<td>&nbsp;/&nbsp;<a href="brd_list.qna">Q&A</a></td>
<td width="80%"></td>
</tr>
<tr height="60">
</tr>
</table>
<table class="bnview" width="100%" cellpadding="5" cellspacing="0">
<tr id="aname"><td colspan="6">
Notice
</td></tr>
<tr class="nvcon">
<td align="center" width="10%">제목</td><td width="30%"><%=article.getNl_title() %></td>
<td width="*"><td>
<td align="right">작성일</td>
<td width="12%" align="right"><%=article.getNl_date().substring(2, 10).replace('-', '.') %>&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
<td colspan="6">
<textarea id="content" name="content" rows="10" cols="60" readonly="readonly">
<%=article.getNl_content() %></textarea>
</td></tr>
<tr height="30"></tr>
<tr>
<td align="right" colspan="6"><input class="button" type="button" value="목록으로" onclick="location.href='bbs_list.notice<%=args %>';" /></td>
</tr>
</table>
</div>
</body>
</html>