<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../a_menu.jsp" %>
<%
ArrayList<MemberInfo> memberList = (ArrayList<MemberInfo>)request.getAttribute("memberList");
AdmPageInfo pageInfo = (AdmPageInfo)request.getAttribute("pageInfo");
String schtype, keyword, ord;
schtype =	pageInfo.getSchtype();	// 검색조건(관리자 아이디, 관리자 이름)
keyword =	pageInfo.getKeyword();	// 검색어
ord =		pageInfo.getOrd();		// 정렬조건

if(keyword == null)					keyword = "";
if(schtype == null)					schtype = "";

String args = "", schArgs = "";

if (!keyword.equals("")) {
	schArgs += "&schtype=" + schtype + "&keyword=" + keyword;
}
else {
	schtype = "";	keyword = "";
}

if (ord != null)		schArgs += "&ord=" + ord;			
else					ord = "";

int cpage	= pageInfo.getCpage();	// 현재 페이지 번호
int pcnt	= pageInfo.getPcnt();	// 전체 페이지 수
int psize	= pageInfo.getPsize();	// 페이지 크기
int bsize	= pageInfo.getBsize();	// 블록 페이지 개수
int spage	= pageInfo.getSpage();	// 블록 시작 페이지 번호
int epage	= pageInfo.getEpage();	// 블록 종료 페이지 번호
int rcnt	= pageInfo.getRcnt();	// 검색된 게시물 개수
schArgs = "&psize=" + psize + schArgs;
args = "&cpage=" + cpage + schArgs;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#sch {margin:15px 0; display:block; text-align:right;}
#sch table {width:1200px;}
#sch td {padding:2px;}
#admList {margin-top:50px; }
#admList table {width:1200px;}
#admList th {text-align:left; padding:5px 5px 10px 5px;}
#admList td {text-align:left; border-top:1px solid black; padding:5px;}
#paging {width:1200px; text-align:center; margin-top:20px; }
#statusBtn {background-color:black; color:white; width:80px; height:40px; }
</style>
</head>
<body>
<div id="wrapper">
	<h2>회원 목록</h2>
	<form name="schFrm" action="" method="get">
	<div id="sch">
	<table cellspacing="0">
	<tr>
	<td>
		<select name="schtype">
			<option value="id" <% if (schtype.equals("id")) { %>selected="selected"<% } %>>아이디</option>
			<option value="name" <% if (schtype.equals("") || schtype.equals("name")) { %>selected="selected"<% } %>>이름</option>
			<option value="status" <% if (schtype.equals("status") || schtype.equals("status")) { %>selected="selected"<% } %>>상태</option>
		</select>
		<input type="text" name="keyword" />
		<input type="submit" value="검색" />
	</td>
	</tr>
	</table>
	</div>
	</form>

	
	<div id="admList">
		<table cellspacing="0" cellpadding="10">
		<tr>
		<th>아이디<a href="member_list.mem?ord=ida">▲</a> <a href="member_list.mem?ord=idd">▼</a></th>
		<th>이름<a href="member_list.mem?ord=namea">▲</a> <a href="member_list.mem?ord=named">▼</a></th>
		<th>성별</th><th>생일</th><th>잔여포인트</th><th>상태</th>
		<th>가입일<a href="member_list.mem?ord=datea">▲</a> <a href="member_list.mem?ord=dated">▼</a></th>
		<th>마지막 방문일<a href="member_list.mem?ord=lasta">▲</a> <a href="member_list.mem?ord=lastd">▼</a></th>
		</tr>
	<%
	
	for(int i = 0; i < memberList.size(); i++) {
	%>
		<tr>
		<td><a href="member_detail.mem?id=<%=memberList.get(i).getMlid() %>"><%=memberList.get(i).getMlid() %></a></td>
		<td><%=memberList.get(i).getMlname() %></td>
		<td><%=memberList.get(i).getMlgender() %></td>
		<td><%=memberList.get(i).getMlbirth() %></td>
		<td><%=memberList.get(i).getMlpoint() %></td>
		<td><%=memberList.get(i).getMlstatus() %></td>
		<td><%=memberList.get(i).getMldate().substring(0, 11) %></td>
		<td><%=memberList.get(i).getMllast().substring(0, 11) %></td>
		</tr>
	<%
	} 
	%>
		</table>
	</div>
		
	<div id="paging">
	<table width="100%" cellpadding="5">
	<tr>
	<td width="*">
	<%
	if (rcnt > 0) {	// 검색결과 회원들이 있을 경우에만 페이징을 함
		if (cpage == 1) {
			out.println("<<&nbsp;&nbsp;<&nbsp;&nbsp;");
		} else {
			out.print("<a href='member_list.mem?cpage=1" + schArgs + "'>");
			out.println("<<</a>&nbsp;&nbsp;");
			out.print("<a href='member_list.mem?cpage=" + (cpage - 1) + schArgs + "'>");
			out.println("<</a>&nbsp;&nbsp;");
		}
	
		for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++) {
			if (cpage == j) {
				out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
			} else {
				out.print("&nbsp;<a href='member_list.mem?cpage=" + j + schArgs + "'>");
				out.println(j + "</a>&nbsp;");
			}
		}
	
		if (cpage == pcnt) {
			out.println("&nbsp;&nbsp;>&nbsp;&nbsp;>>");
		} else {
			out.print("&nbsp;&nbsp;<a href='member_list.mem?cpage=" + (cpage + 1) + schArgs + "'>");
			out.println("></a>");
			out.print("&nbsp;&nbsp;<a href='member_list.mem?cpage=" + pcnt + schArgs + "'>");
			out.println(">></a>");
		}
	} else {
%>
		<td colspan="8">검색 결과가 없습니다.
<%
	}
	%>
	</td>
	</tr>
	</table>
	</div>
</div>
</body>
</html>