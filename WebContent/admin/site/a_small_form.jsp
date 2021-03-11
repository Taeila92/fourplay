<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<CataBigInfo> cataBigList = (ArrayList<CataBigInfo>)request.getAttribute("cataBigList");
ArrayList<CataSmallInfo> cataSmallList = (ArrayList<CataSmallInfo>)request.getAttribute("cataSmallList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
<%
String scName = null;
int bc = 0, sc = 0;
// bc : 대분류 idx를 저장하기 위한 변수로 배열의 이름으로 사용됨
// sc : 소분류 idx를 저장하기 위한 변수
for (int i = 0, j = 1 ; i < cataSmallList.size() ; i++, j++) {
// i : cataSmallList 에 들어있는 데이터의 개수만큼 루프를 돌리며 cataSmallList의 인덱스로 사용하기 위한 변수
// j : cataSmallList 의 값을 배열에 넣을 때 사용하기 위한 인덱스번호를 저장하는 변수
	if (bc != cataSmallList.get(i).getCb_idx()) {
	// 기존 대분류 idx(bc)와 현재 대분류 idx가 다르면-배열을 새롭게 생성
		j = 1;	// 새롭게 생성할 배열에 값을 넣을 때 사용할 인덱스 번호 초기화
%>
var arr<%=cataSmallList.get(i).getCb_idx()%> = new Array();
// 대분류 idx를 이용하여 유니크한 이름의 배열을 생성
arr<%=cataSmallList.get(i).getCb_idx()%>[0] = new Option("", "소분류 선택");
// 배열의 0번 인덱스에 콤보박스의 제일 위에서 보여줄 option 아이템을 지정
<%
	}
	bc = cataSmallList.get(i).getCb_idx();	// 대분류 idx를 bc에 저장
	sc = cataSmallList.get(i).getCs_idx();	// 소분류 idx를 sc에 저장
	scName = cataSmallList.get(i).getCs_name();	// 대분류명을 scName에 저장
%>
arr<%=bc%>[<%=j%>] = new Option("<%=sc%>", "<%=scName%>");
// 소분류 콤보박스용 배열에 콤보박스에서 사용할 option태그를 생성하여 저장
<%
}
%>

function setCategory(obj, target) {
	var x = obj.value;	// 대분류에서 선택한 값을 x에 담음

	// 소분류 콤보박스를 첫번째 option을 제외하고 모두 지움
	for (var m = target.options.length - 1 ; m > 0 ; m--) {
	// target : sCata라는 소분류 콤보박스
	// options : option이라는 태그들의 배열(여기서는 sCata라는 소분류 콤보박스의 option태그들 배열)
	// length : 배열의 길이를 의미(여기서는 target의 options 배열의 길이를 뜻함)
	// target.options.length - 1 : target이라는 컨트롤의 option태그 배열 개수에서 1을 뺌(즉, 마지막 인덱스 번호)
		target.options[m] = null;
		// target컨트롤의 options배열에 m번 인덱스에 해당하는 값(option태그)을 지움
	}

	if (x != "") {
	// 대분류에서 특정 대분류를 선택했을 경우
		var selectedArray = eval("arr" + x);	// 보여줄 배열 지정
		// 선택한 대분류에 속한 소분류들이 들어있는 배열을 selectedArray에 담음

		for (var i = 0 ; i < selectedArray.length ; i++) {
			target.options[i] = new Option(selectedArray[i].value, selectedArray[i].text);
			// 소분류 콤보박스에 새로운 option태그를 지정함(selectedArray배열에서 value와 text를 가져옴)
		}
		target.options[0].selected = true;
		// 새롭게 만들어진 콤보박스에서 첫번째 option이 선택된 상태로 있게 함
	}
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>상품 등록 폼</h2>
<form name="smallform" action="pdt_in_proc.pdta" method="post" enctype="multipart/form-data">
<table width="700" cellpadding="5" cellspacing="0" id="smallform" border="1px">
<tr>
<td width="50%">대분류 
	<select name="bCata" onchange="setCategory(this, this.form.sCata);">
		<option>대분류 선택</option>
<% for (int i = 0 ; i < cataBigList.size() ; i++) { %>
		<option value="<%=cataBigList.get(i).getCb_idx()%>"><%=cataBigList.get(i).getCb_name()%></option>
<% } %>
	</select>
</td>
<td width="50%"> 소분류 명
	<select name="sCata">
		<option value="">소분류 선택</option>
	</select>
</table>
<table width="700">
<tr>
<td align="right"><input type="submit" value="등록" onclick="" /></td>
</tr>
</table>
</form>
</body>
</html>