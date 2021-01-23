<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../admin_menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="jquery-3.5.1.js"></script>
<script>
function chkData(frm){	
	var name = frm.name.value;			var aid = frm.aid.value;			var pwd = frm.pwd.value;			
	var pwd2 = frm.pwd2.value;			var email = frm.email.value;		var phone = frm.phone.value;				

	if (name == "")	{ 
		alert("이름을 입력하세요.");				frm.name.focus();	
		return false; 
	}else if (name.length < 2)	{			//이름을 2자 미만으로 입력했으면
		alert("이름은 2~20자 이내로 입력하세요."); 	frm.name.select();	
		return false; 
	}
	if (aid == "")	{ 						//유무부터 검사하고 밑에서 else if로 구체적인 개수 검사
		alert("아이디를 입력하세요.");				frm.aid.focus();	
		return false; 
	}else if (aid.length < 4)	{			//아이디를 4자 미만으로 입력했으면
		alert("아이디는 4~20자 이내로 입력하세요."); 	frm.aid.select();	
		return false; 
	} else if (aid.charAt(0).toLowerCase() < 'a' || aid.charAt(0).toLowerCase() > 'z'){		//아이디의 첫글자가 영문이 아니면
		alert("아이디의 첫글자는 반드시 영문자로 입력해야 합니다.");
		frm.aid.value="";	
		return false; 
	} else { 
		for (var i = 0; i < aid.length ; i++ )	{	
			var c = aid.charAt(i).toLowerCase();
			if (!(c >= 'a' && c<= 'z' || c >= '0' && c <= '9'))	{
				alert("아이디는 영문과 숫자로만 입력해야 합니다.");			
				frm.aid.value="";	
				return false; 
			}
		}
	}

	if (pwd == "")	{ 
		alert("비밀번호를 입력하세요.");			frm.pwd.focus();	
		return false; 
	} else if (pwd.length < 4)	{ //비밀번호를 4자 미만으로 입력했으면
		alert("비밀번호는 4~20자 이내로 입력하세요."); frm.pwd.select();	
		return false; 
	} else { 
		for (var i = 0; i < pwd.length ; i++ )	{	//pwd의 글자개수만큼 루프를 돌면서 작업
			var c = pwd.charAt(i).toLowerCase();
			if (!(c >= 'a' && c<= 'z' || c >= '0' && c <= '9'))	{
				alert("비밀번호는 영문과 숫자로만 입력해야 합니다.");	frm.pwd.value="";	
				return false; 
			}
		}
	}
	if (pwd2 == "")	{ 
		alert("비밀번호 확인을 입력하세요.");		frm.pwd2.focus();	return false; 
	} else if (pwd2 != pwd)	{
		alert("비밀번호와 비밀번호 확인이 다릅니다.");	
		frm.pwd2.value="";					frm.pwd2.focus();	
		return false; 
	}
	if (email == "")	{ 
		alert("이메일을 입력하세요.");				frm.email.focus();	
		return false; 
	}
	if (phone == "")	{ 
		alert("전화번호를 입력하세요.");			frm.phone.focus();	
		return false; 
	} else if (phone.length <3){
		alert("'-'를 구분자로 하여 12자리 이상 입력하세요.");		frm.phone.value="";	
		return false; 
	}
	return true;
}

function chkDupAId(){
	var aid = $("#aid").val();
	if (aid.length > 1) {
		$.ajax({
			type : "POST",	// 데이터 전송방법 
			url : "/fourplay/dupAID", 	// 중복체크를 위해 이동할 컨트롤러 URL
			data : {"aid":aid}, // url로 지정한 곳으로 보낼 데이터
			success : function(chkRst) {
			// 함수 실행시 url로 지정한 곳에서 작업한 결과를 chkRst로 받아 옴
				var msg = "";
				if(chkRst == 0) {
					msg = "<span class='fontBlue'>사용하실 수 있는 ID입니다.</span>";
					$("#idChk").val("Y");
				} else {
					msg = "<span class='fontRed'>이미 사용중인 ID입니다.</span>";
					$("#idChk").val("N");
				}
				document.getElementById("idMsg").innerHTML = msg;
			}
		});
	}
}
</script>
<style>
.join {
	width:800px; display:block; margin-left:380px; margin-top:50px;
}
.join .text input { width:400px; height:40px; margin-bottom:15px;}
.join .text { display:block; text-align:center; }
.join #btn { 
	width:110px; height:50px; background-color:black; color:white; font-weight:bold;
}
.fontRed { color:red; font-weight:bold; }
.fontBlue { color:blue; font-weight:bold; }

h2 {display:block; margin-left:480px;}
</style>
</head>
<body>
<div id="wrapper">
	<h2>관리자 계정 생성</h2>
	<form name="frmJoin" action="admin_proc.adm" method="post" onsubmit="return chkData(this);">
	<input type="hidden" name="idChk" id="idChk" value="N" />
	<input type="hidden" name="wtype" value="join" />
	<div class="join">
	<table cellpadding="5" align="center">
	<tr><td class="text">
		<input type="text" name="aid" id="aid" onkeyup="chkDupAId();" placeholder="아이디" />
		<br /><span id="idMsg"> </span>
	</td></tr>
	<tr><td class="text" align="center"><input type="text" name="name" class="input" placeholder="이름" /></td></tr>
	<tr><td class="text"><input type="password" name="pwd" placeholder="비밀번호" /></td></tr>
	<tr><td class="text"><input type="password" name="pwd2" placeholder="비밀번호 확인" /></td></tr>
	<tr><td class="text"><input type="text" name="email" placeholder="이메일" /></td></tr>
	<tr><td class="text"><input type="text" name="phone" placeholder="휴대폰 번호" /></td></tr>
	<tr><td align="center">
		<input id="btn" type="submit" value="계정 생성" />
	</td></tr>
	</table>
	</div>
	</form>
</div>
</body>
</html>