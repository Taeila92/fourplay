<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../menu.jsp" %>
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
<td>Q&A&nbsp;&nbsp;&nbsp;&nbsp;</td>
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
Q&A
</td></tr>
<tr class="nvcon">
<td align="center" width="10%">제목</td><td width="30%"><%=article.getQl_title() %></td>
<td width="*"><td>
<td align="right">작성일</td>
<td width="12%" align="right"><%=article.getQl_qdate().substring(2, 10).replace('-', '.') %>&nbsp;&nbsp;&nbsp;</td>
</tr>
<tr>
<td colspan="6">
<textarea id="content" name="content" rows="10" cols="60" readonly="readonly">
<%=article.getQl_content().replace("\r\n", "</br>") %></textarea>
</td></tr>
<tr height="30"></tr>
<tr>
	<%
	boolean isPms = false;	// 수정 및 삭제 권한이 있는지 여부를 저장할 변수
	String link1 = null, link2 = null;
	
	 if (uid != null && uid.equals(article.getQl_writer())) {
		isPms = true;	// 현재 로그인한 회원의 글이므로 모든 권한을 가짐
		link1 = "brd_form.qna" + args + "&wtype=up&idx=" + idx;
		link2 = "notCool(" + idx + ");";
	} 
	
	 if (isPms) {	
			if (article.getQl_writer().equals("uid")) {
			// 회원이 등록한 글일 경우(현재 글이 로그인한 회원의 글이면)
	%>
	<script>
	function notCool(idx) {
		if (confirm("정말 삭제하시겠습니까?")) {
			location.href="brd_proc.qna?wtype=del&idx=" + idx;
		}
	}
	</script>
<%
			}
 
	} 
%>
	</td></tr>
	<tr><td align="right" colspan="6">
	<input type="button" class="button" value="수정" onclick="location.href='<%=link1 %>';" />&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" class="button" value="삭제" onclick="<%=link2 %>" />
	</td></tr>
	<tr height="20"></tr>
	</table>


		<table class="bnview"  width="100%" cellpadding="5" cellspacing="0">
		<tr id="aname"><td colspan="6">
		Q&A 답변
		</td></tr>
<% 
if (uid != null && article.getQl_status().equals("b"))  { 
%> 
		<tr >
		<td width="*" colspan="2"><td>
		</tr>
		<tr class="nvcon">
		<th align="center">작성자</th><td>fourplay</td>
		<th>작성일</th><td><%=article.getQl_adate() %></td>
		<td width="*" colspan="2"></td>
		</tr>
		<tr><th>내용</th>
		<td colspan="3"><%=article.getQl_answer() %></td></tr>
		<tr><td colspan="4" align="center">
			<input type="button" value="목록으로" onclick="location.href='brd_list.qna<%=args %>';" />
		
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="수정" onclick="location.href='<%=link1 %>';" />
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="삭제" onclick="<%=link2 %>" />
		
		</td></tr>
<% } else  { //답변이 없을 경우  %> 
<tr><td colspan="4">답변이 없습니다.</td></tr>
<% } %>
<tr>
<td align="right" colspan="6"><input class="button" type="button" value="목록으로" onclick="location.href='bbs_list.notice<%=args %>';" />
</td></tr>
</table>
</div>
</body>
</html>
