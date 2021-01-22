<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");

ArrayList<CataBigInfo> cataBigList = (ArrayList<CataBigInfo>)request.getAttribute("cataBigList");
ArrayList<CataSmallInfo> cataSmallList = (ArrayList<CataSmallInfo>)request.getAttribute("cataSmallList");
PdtInfo pdtInfo = (PdtInfo)request.getAttribute("pdtInfo");

int cpage = Integer.parseInt(request.getParameter("cpage"));
int psize = Integer.parseInt(request.getParameter("psize"));

// 검색조건 및 정렬조건 쿼리스트링을 받음
String id, isview, schtype, keyword, sdate, edate, bcata, scata, sprice, eprice, stock, ord;
id		= request.getParameter("id");		isview	= request.getParameter("isview");
schtype = request.getParameter("schtype");	keyword = request.getParameter("keyword");
sdate	= request.getParameter("sdate");	edate	= request.getParameter("edate");
bcata	= request.getParameter("bcata");	scata	= request.getParameter("scata");
sprice	= request.getParameter("sprice");	eprice	= request.getParameter("eprice");
stock	= request.getParameter("stock");	ord 	= request.getParameter("ord");

String args = "?cpage=" + cpage + "&psize=" + psize;
if (isview != null && !isview.equals(""))	args += "&isview=" + isview;
if (sdate != null && !sdate.equals(""))		args += "&sdate=" + sdate;
if (edate != null && !edate.equals(""))		args += "&edate=" + edate;
if (bcata != null && !bcata.equals(""))		args += "&bcata=" + bcata;
if (scata != null && !scata.equals(""))		args += "&scata=" + scata;
if (sprice != null && !sprice.equals(""))	args += "&sprice=" + sprice;
if (eprice != null && !eprice.equals(""))	args += "&eprice=" + eprice;
if (stock != null && !stock.equals(""))		args += "&stock=" + stock;
if (keyword != null && !keyword.equals(""))
	args += "&schtype=" + schtype + "&keyword=" + keyword;
if (ord != null && !ord.equals(""))			args += "&ord=" + ord;

int csIdx = pdtInfo.getCs_idx();	// 소분류 idx
String cbIdx = (csIdx + "").substring(0, 2);	// 대분류 idx(소분류의 앞 두자리 숫자값)
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#pdtUpForm th, #pdtUpForm td { border-bottom:1px solid black; height:30px; }
</style>
<script>
<%
String scName = null;
int bc = 0, sc = 0;
for (int i = 0, j = 1 ; i < cataSmallList.size() ; i++, j++) {
	if (bc != cataSmallList.get(i).getCb_idx()) {
		j = 1;
%>
var arr<%=cataSmallList.get(i).getCb_idx()%> = new Array();
arr<%=cataSmallList.get(i).getCb_idx()%>[0] = new Option("", "소분류 선택");
<%
	}
	bc = cataSmallList.get(i).getCb_idx();
	sc = cataSmallList.get(i).getCs_idx();
	scName = cataSmallList.get(i).getCs_name();
%>
arr<%=bc%>[<%=j%>] = new Option("<%=sc%>", "<%=scName%>");
<%
}
%>
function getSelectChk() {	// 사용자가 선택한 체크박스들의 value를 추출하는 함수
	var arrChk = document.frmPdt.opt;
	// 문서내의 frmCart폼안에 있는컨트롤들 중 opt라는 이름을 가진 컨트롤들을 배열로 받아옴
	var arropt = "";
	for (var i = 0 ; i < arrChk.length ; i++) {
		if (arrChk[i].checked) {	// i인덱스의 체크박사가 선택된 상태라면
			arropt += "," + arrChk[i].value;	// 선택된 체크박스의 value(cl_idx값)를 idx변수에 누적
		}
	}
	if (arropt != "") {
		if(arropt.indexOf(",,") > -1)	arropt = arropt.substring(2);
		else							arropt = arropt.substring(1);
		arropt = "Size,"+ arropt + ":Width,regular,wide:Heel,조정없음,+1cm,+2cm";
	}
	return arropt;
}
function sizeCheck() {	// 사용자가 선택한 체크박스들의 value를 추출하는 함수
	var arrChk = document.frmPdt.opt;
	// 문서내의 frmCart폼안에 있는컨트롤들 중 opt라는 이름을 가진 컨트롤들을 배열로 받아옴
	var sizeOpt = "";
	for (var i = 0 ; i < arrChk.length ; i++) {
		if (arrChk[i].checked) {	// i인덱스의 체크박사가 선택된 상태라면
			sizeOpt += "," + arrChk[i].value;	// 선택된 체크박스의 value(cl_idx값)를 idx변수에 누적
		}
	}
	if (sizeOpt != "") {
		if(sizeOpt.indexOf(",,") > -1)	sizeOpt = sizeOpt.substring(2);
		else							sizeOpt = sizeOpt.substring(1);
	}
	return sizeOpt;
}
function setCategory(obj, target) {
	var x = obj.value;
	for (var m = target.options.length - 1 ; m > 0 ; m--) {
		target.options[m] = null;
	}
	if (x != "") {
		var selectedArray = eval("arr" + x);
		for (var i = 0 ; i < selectedArray.length ; i++) {
			target.options[i] = new Option(selectedArray[i].value, selectedArray[i].text);
		}
		target.options[0].selected = true;
	}
}
function chVal(){
	var frm = document.frmPdt;
	var opt = getSelectChk();
	var size = sizeCheck();
	if (opt != "") {
		document.frmPdt.allopt.value = opt;
	}
	if (size != "") {
		document.frmPdt.sizeOpt.value = size;
	}
	frm.submit();
}
</script>
</head>
<body>
<h2>상품 수정 폼</h2>
<form name="frmPdt" action="pdt_up_proc.pdta" method="post" enctype="multipart/form-data">
<input type="hidden" name="opt" value="" />
<input type="hidden" name="allopt" value="" />
<input type="hidden" name="sizeOpt" value="" />
<input type="hidden" name="args" value="<%=args %>" />
<input type="hidden" name="id" value="<%=pdtInfo.getPl_id() %>" />
<input type="hidden" name="oldImg1" value="<%=pdtInfo.getPl_img1() %>" />
<input type="hidden" name="oldImg2" value="<%=(pdtInfo.getPl_img2() == null) ? "" : pdtInfo.getPl_img2() %>" />
<input type="hidden" name="oldImg3" value="<%=(pdtInfo.getPl_img3() == null) ? "" : pdtInfo.getPl_img3() %>" />
<input type="hidden" name="oldDesc" value="<%=pdtInfo.getPl_desc() %>" />
<table width="800" cellpadding="5" cellspacing="0" id="pdtUpForm">
<tr>
<th width="150">대분류</th>
<td width="250">
	<select name="bCata" onchange="setCategory(this, this.form.sCata);">
		<option value="">대분류 선택</option>
<% for (int i = 0 ; i < cataBigList.size() ; i++) { %>
		<option value="<%=cataBigList.get(i).getCb_idx()%>" 
		<% if ((cataBigList.get(i).getCb_idx() + "").equals(cbIdx)) { %>
		selected="selected"<% } %>><%=cataBigList.get(i).getCb_name()%></option>
<% } %>
	</select>
</td>
<th width="150">소분류</th>
<td width="250">
	<select name="sCata">
		<option value="">소분류 선택</option>
<%
for (int i = 0 ; i < cataSmallList.size() ; i++) {
	if (cbIdx.equals((cataSmallList.get(i).getCs_idx() + "").substring(0, 2))) {
%>
		<option value="<%=cataSmallList.get(i).getCs_idx()%>" 
		<% if (csIdx == cataSmallList.get(i).getCs_idx()) { %>selected="selected"<% } %>>
		<%=cataSmallList.get(i).getCs_name()%></option>
<%
	}
}
%>
	</select>
</td>
</tr>
<tr>
</tr>
<tr>
<th>상품명</th><td><input type="text" name="name" value="<%=pdtInfo.getPl_name() %>" /></td>
<th>가격</th><td><input type="text" name="price" value="<%=pdtInfo.getPl_price() %>" /></td>
</tr>
<tr>
<th>원가</th><td><input type="text" name="cost" value="<%=pdtInfo.getPl_cost() %>" /></td>
<th>할인율</th><td><input type="text" name="discount" value="<%=pdtInfo.getPl_discount() %>" /></td>
</tr>
<tr>
<th>옵션</th>
<%
String fullOpt = pdtInfo.getPl_opt(); // 전체옵션
String[] arrOpt = null;
String[] sizeOpt = null;
if(fullOpt != null && !fullOpt.equals("") && fullOpt.indexOf(":") > 0 ){ // 옵션이 여러개있으면
	arrOpt = fullOpt.split(":");
	fullOpt = arrOpt[0].toString();
	fullOpt = fullOpt.substring(5);
	sizeOpt = fullOpt.split(",");
%>
<td colspan="3">
<%		for (int i = 240, j = 0; i <= 285 ; i += 5, j++){ 
%>
			<input type="checkbox" name="opt"<%if(sizeOpt[j].equals(i + "")){%> checked="checked" <%}%> value="<%=i %>" /> <%=i %>
<%
		}

} else {
%>
<td colspan="3">옵션 선택불가
<%	
}
%>
</td>
</tr>
<tr>
<th>이미지1</th><td><input type="file" name="img1" /><br />
<%=(pdtInfo.getPl_img1() == null) ? "이미지 없음" : pdtInfo.getPl_img1() %></td>
<th>이미지2</th><td><input type="file" name="img2" /><br />
<%=(pdtInfo.getPl_img2() == null) ? "이미지 없음" : pdtInfo.getPl_img2() %></td>
</tr>
<tr>
<th>이미지3</th><td><input type="file" name="img3" /><br />
<%=(pdtInfo.getPl_img3() == null) ? "이미지 없음" : pdtInfo.getPl_img3() %></td>
<th>설명이미지</th><td><input type="file" name="desc" /><br />
<%=(pdtInfo.getPl_desc() == null) ? "이미지 없음" : pdtInfo.getPl_desc() %></td>
</tr>
<tr>
<th>재고</th>
<td>
	<select name="stock">
		<option value="-1">무제한</option>
<% for (int i = 0 ; i <= 100 ; i++) { %>
		<option value="<%=i%>"><%=i%></option>
<% } %>
	</select> EA
</td>
<th>게시여부</th>
<td>
	<input type="radio" name="view" value="y" <% if (pdtInfo.getPl_view().equals("y")) { %>checked="checked"<% } %> />상품 게시
	<input type="radio" name="view" value="n" <% if (pdtInfo.getPl_view().equals("n")) { %>checked="checked"<% } %> />상품 미게시
</td>
</tr>
<tr><td colspan="4" align="center">
	<input type="button" value="목록으로" onclick="location.href='pdt_list.pdta<%=args %>';" />
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="button" value="상품 수정" onclick="chVal();"/>
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<input type="reset" value="다시 입력" />
</td></tr>
</table>
</form>
</body>
</html>
