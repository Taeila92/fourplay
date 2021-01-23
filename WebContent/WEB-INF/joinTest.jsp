<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="./css/reset.css" type="text/css" rel="stylesheet" />
<style>
.fontRed { color:red; font-weight:bold; }
.fontBlue { color:blue; font-weight:bold; }
#idMsg {
	font-size: 12px;
    padding-top: 5px;
    display: inline-block;
}
#chkMsg {
	font-size: 12px;
    padding-top: 5px;
    display: inline-block;
    color: gray;
}

#chkMsg2 {
	font-size: 12px;
    padding-top: 5px;
    display: inline-block;
}

.text input { width:300px; height:30px; text-indent:10px; }

.text { text-align:center; }

.text2 { text-align:center; font-size:14px;}

.text3 { resize:none; }

hr { border:2px sloid gray;}
</style>
</head>
<body>
<h2 align="center">Join Us</h2>
<hr />
<form name="frmJoin" action="join_proc.jsp" method="post" onsubmit="return chkData(this);">
<input type="hidden" name="idChk" id="idChk" value="N" />
<table cellpadding="5" align="center">
<tr><td class="text" align="center"><input type="text" name="name" placeholder="이름" /></td></tr>
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
<tr><td class="text"><input type="text" name="birth" placeholder="생년월일 ex) 2021-01-10" /></td></tr>
<tr>
<td>
	<input type="radio" name="gender" value="M" />남
	<input type="radio" name="gender" value="F"/>여
</td>
</tr>
<tr><td align="center" colspan="2">
	<input type="submit" value="회원 가입" />
	<input type="reset" value="취소" />
</td></tr>

</table>
</form>
<jsp:include page="/content.jsp"></jsp:include>
</body>
</html>
