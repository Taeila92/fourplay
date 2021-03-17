<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ include file="../menu.jsp" %>
<%
request.setCharacterEncoding("utf-8");
String wtype = request.getParameter("wtype");
int cpage = Integer.parseInt(request.getParameter("cpage"));
String args = "";

String msg = "수정", writer = "", title = "", content = "";
int idx = 0;
if (wtype.equals("in")) {
	msg = "등록";
	args = "?cpage=" + cpage;
} else if (wtype.equals("up")) {	// 게시글 수정일 경우
	QAInfo article = (QAInfo)request.getAttribute("article");
	idx = article.getQl_idx();
	writer = article.getQl_writer();
	title = article.getQl_title();
	content = article.getQl_content();

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
.commenu td { align:left; }
.qfcon td { border-bottom:1px #8C8C8C solid; height:30px; }
.qfcon input { border:1px #8C8C8C solid;}
#aname td { border-bottom:2px #BDBDBD solid; }
#title { border:none; }
#content { width:100%; height:300px; border:1px #8C8C8C solid; }
.button { border:0px; background-color:#002266; color:#FFFFFF; font-size:13px; }
</style>
</head>
<body>
<div id="wrapper">
<table class="commenu" width="100%">
<tr>
<td>Q&A&nbsp;&nbsp;&nbsp;&nbsp;</td>
<td>&nbsp;<a href="bbs_list.notice">NOTICE</a></td>
<td>/&nbsp;<a href="bbs_list.faq">FAQ</a></td>
<td>&nbsp;/&nbsp;<a href="brd_list.qna">Q&A</a></td>
<td width="80%"></td>
</tr>
<tr height="60">
</tr>
</table>
<form name="frmQA" action="brd_proc.qna<%=args %>" method="post">
<input type="hidden" name="idx" value="<%=idx %>" />
<input type="hidden" name="wtype" value="<%=wtype %>" />
<%
if (loginMember != null){
%>
<input type="hidden" name="writer" value="<%=loginMember.getMlid() %>" />
<%} %>
<table class="bqform" width="100%" cellpadding="5" cellspacing="0">
<tr id="aname"><td colspan="5">
Q&A 
</td></tr>
<%
if (wtype.equals("in") ) {
%>
<tr class="qfcon">
		<%	if (adminMember != null) { // 관리자인 경우 %> 
			<td align="center">관리자</td><td><%=adminMember.getAl_id() %></td>
		<% } else if (loginMember != null) { // 작성자 경우 %> 
			<td align="center">작성자</td><td><%=loginMember.getMlid() %></td>
		<% } else { 
			response.setContentType("text/html;charset=utf-8");
			out.println("<script>");
			out.println("alert('로그인 해주세요.');");
			out.println("location.href='./login_form.jsp'");
			out.println("</script>");
			out.close();
		} %> 
</tr>

<%
} else { %>
	<tr class="qfcon"><td align="center">작성자</td><td><%=writer %></td></tr>
<% } %>		
<!-- 
<tr>
<th>분류</th>
<td>상품문의</td>
<td>소분류</td>
<td>상품명 </td>
</tr>
 -->
<tr class="qfcon">
<td align="center">제목</td>
<td colspan="3"><input type="text" id="title" name="title" size="60" value="<%=title %>" /></td>
</tr>
<tr>
<td colspan="4">
	<textarea id="content" name="content" rows="10" cols="60" placeholder=" 상품코드:&#13;&#10; 상품명:&#13;&#10; 문의사항:" ><%=content %></textarea>
</td>
</tr>
<tr height="10"></tr>
<tr><td colspan="4" align="right">
	<input class="button" type="submit" value="글<%=msg %>" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input class="button" type="reset" value="다시 입력" />
</td></tr>
</table>
</form>
</div>
</body>
</html>
