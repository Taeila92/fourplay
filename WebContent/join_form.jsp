<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String user_id = (String)session.getAttribute("uid");
if (user_id != null) {
	out.println("<script>");
	out.println("history.back();");
	out.println("</script>");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.fontRed { color:red; font-weight:bold; }
.fontBlue { color:blue; font-weight:bold; }
hr { border:2px sloid gray;}
</style>
<script src="jquery-3.5.1.js"></script>
<script>
function chkDupId(){
	var uid = $("#uid").val();
	if (uid.length >= 4) {
		$.ajax({
			type : "POST",	// 데이터 전송방법 
			url : "dupID", 	// 중복체크를 위해 이동할 컨트롤러 URL
			data : {"uid":uid}, // url로 지정한 곳으로 보낼 데이터
			success : function(chkRst) {
			// 함수 실행시 url로 지정한 곳에서 작업한 결과를 chkRst로 받아 옴
				var msg = "";
				if(chkRst == 0) {
					msg = "<span class='fontBlue'>사용하실 수 있는 ID입니다.</span>";
					$("#idChk").val("Y");
				} else {
					msg = "<span class='fontRed'>이미 사용중 인 ID입니다.</span>";
					$("#idChk").val("N");
				}
				document.getElementById("idMsg").innerHTML = msg;
			}
		});
	}
}
</script>
<style>
.text input { width:300px; height:30px; }
.text { text-align:center; }
</style>
</head>
<body>
<h2 align="center">Join Us</h2>
<hr />
<form name="frmJoin" action="joinProc.jsp" method="post">
<input type="hidden" name="idChk" id="idChk" value="N" />
<table cellpadding="5" align="center">
<tr><td class="text" align="center"><input type="text" class="input" placeholder="이름" /></td></tr>
<tr>
<td class="text">
	<input type="text" name="uid" id="uid" onkeyup="chkDupId();" placeholder="아이디" />
	<br /><span id="idMsg">아이디는 4~20자 이내의 영문, 숫자 조합으로 입력하세요.</span>
</td>
</tr>
<tr><td class="text"><input type="password" name="pwd" placeholder="비밀번호" /></td></tr>
<tr><td class="text"><input type="password" name="pwd2" placeholder="비밀번호 확인" /></td></tr>
<tr><td class="text"><input type="text" name="email" placeholder="이메일" /></td></tr>
<tr><td class="text"><input type="text" name="phone" placeholder="휴대폰 번호" /></td></tr>
<tr><td class="text"><input type="text" name="birth" placeholder="생년월일" /></td></tr>
<tr><td align="center">
	<input type="submit" value="회원 가입" />
</td></tr>
</table>
</form>
</body>
</html>
