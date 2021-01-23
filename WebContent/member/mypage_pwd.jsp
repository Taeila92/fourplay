<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function notColl () {
	if (confirm("정말 삭제하시겠습니까?")) {
		document.chkPwd.submit();
	} 
}
</script>
</head>
<body>
<h2>비밀번호</h2>
<form name = "chkPwd" action="member_del_proc.mpg" method="post" >
<input type="hidden" name="uid" value="<%=loginMember.getMlid() %>" />
<input type="password" name="pwd" /><br />
<input type="button" value="확인" onclick="notColl();"  />
<input type="button" value="취소" onclick="location.href='mypage.mpg'"/>
</form>
</body>
</html>
