<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%
request.setCharacterEncoding("utf-8");
MemberInfo loginMember = (MemberInfo)session.getAttribute("loginMember");
ArrayList<CartInfo> cartList = (ArrayList<CartInfo>)request.getAttribute("cartList");

int cpage = 1, psize = 12;
if (request.getParameter("cpage") != null)
	cpage = Integer.parseInt(request.getParameter("cpage"));
if (request.getParameter("psize") != null)
	psize = Integer.parseInt(request.getParameter("psize"));
String args = "?cpage=" + cpage + "&psize=" + psize;
String id, keyword, bcata, scata, sprice, eprice, ord;
id 		= request.getParameter("id");		keyword = request.getParameter("keyword");
bcata	= request.getParameter("bcata");	scata	= request.getParameter("scata");
sprice	= request.getParameter("sprice");	eprice	= request.getParameter("eprice");	
ord 	= request.getParameter("ord");

if (bcata != null && !bcata.equals(""))		args += "&bcata=" + bcata;
if (scata != null && !scata.equals(""))		args += "&scata=" + scata;
if (sprice != null && !sprice.equals(""))	args += "&sprice=" + sprice;
if (eprice != null && !eprice.equals(""))	args += "&eprice=" + eprice;
if (keyword != null && !keyword.equals(""))	args += "&keyword=" + keyword;
if (ord != null && !ord.equals(""))			args += "&ord=" + ord;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="jquery-3.5.1.js"></script>
<script>
function chCnt(idx, cnt) {	// 상품의 수량을 변경시키는 함수
		$.ajax({
			type : "POST", 
			url : "/fourplay/cart_up_cnt.crt", 
			data : { "idx" : idx, "cnt" : cnt }, 
			success : function(chkRst) {
				if(chkRst == 0)		alert("선택한 상품 수량 변경에 실패했습니다.\n다시 시도해 주십시오.");
				else				location.reload();
			}
		});
	}

function getSelectChk() {	// 사용자가 선택한 체크박스들의 value를 추출하는 함수
	var arrChk = document.frmCart.chk;
	// 문서내의 frmCart폼안에 있는컨트롤들 중 chk라는 이름을 가진 컨트롤들을 배열로 받아옴
	// 단 chk라는 이름을 가진 컨트롤이 하나일 경우에는 배열이 만들어 지지 않음
	var idx = "";
	for (var i = 0 ; i < arrChk.length ; i++) {
		if (arrChk[i].checked) {	// i인덱스의 체크박사가 선택된 상태라면
			idx += "," + arrChk[i].value;	// 선택된 체크박스의 value(cl_idx값)를 idx변수에 누적
		}
	}
	if (idx != "")	idx = idx.substring(1);
	
	return idx;
}

function cartDel(idx) {
	var isConfirm = false;
	if (idx == 0) {	// 선택한 상품(들) 삭제시
		var arrChk = document.frmCart.chk;
		idx = getSelectChk();	// 선택한 상품들의 idx들을 받아 옴
		if (idx != "") {	// 삭제할 상품을 선택했으면
			isConfirm = confirm("선택한 상품(들)을 장바구니에서 삭제하시겠습니까?");
		} else {	// 삭제할 상품을 선택하지 않았을 경우
			alert("삭제할 상품을 하나 이상 선택하세요.");
		}
	} else {	// 특정 상품 삭제시
		isConfirm = confirm("해당 상품을 장바구니에서 삭제하시겠습니까?");
	}

	if (isConfirm) {
		$.ajax({
			type : "POST", 
			url : "/fourplay/cart_del.crt", 
			data : { "idx" : idx }, 
			success : function(chkRst) {
				if(chkRst == 0)		alert("선택한 상품 삭제에 실패했습니다.\n다시 시도해 주십시오.");
				else				location.reload();
			}
		});
	}
}

function chkBuy() {
// 선택한 상품(들)을 구매하는 함수
	var arrChk = document.frmCart.chk;
	var idx = getSelectChk();	// 선택한 상품들의 idx들을 받아 옴
	if (idx != "") {	// 구매할 상품을 선택했으면
		document.frmCart.idxs.value = idx;
		document.frmCart.submit();
	} else {	// 구매할 상품을 선택하지 않았을 경우
		alert("구매할 상품을 하나 이상 선택하세요.");
	}
}

function chkAll(all) {
	var arrChk = document.frmCart.chk;
	// 폼(frmCart) 안에 chk라는 이름의 컨트롤이 여러 개 있으므로 배열로 변환하여 받아 옴
	for (var i = 0 ; i < arrChk.length ; i++) {
		arrChk[i].checked = all.checked;
	}
}
function goWish() {	// 위시리스트 담기 버튼 클릭시
	var frm = document.frmCart;
<%	if (loginMember != null){%>
		frm.action = "wish_in.crt";
		frm.submit();
<%	} else {%>
		if(confirm("로그인이 필요합니다. \n 로그인 하시겠습니까?")){
			frm.action = "login_form.jsp<%=args%>";
			frm.submit();
		}
<%	}%>
}
</script>
</head>
<body>
<h2>MY CART</h2><div>HOME > <strong>장바구니</strong></div>
<form name="frmCart" action="ord_form.ord" method="post">
<table width="700" cellpadding="5">      
<tr>
<th width="5%"><input type="checkbox" checked="checked" id="checkAll" onclick="chkAll(this);"/></th>
<th width="*%">상품명 / 옵션</th><th width="10%">수량</th>
<th width="10%">가격</th><th width="10%">적립금</th><th width="15%">배송비</th><th width="10%">선택</th>
</tr>
<%
if (cartList != null && cartList.size() > 0) {	// 장바구니에 데이터가 들어 있으면
	int total = 0;	// 총 구매가격을 저장할 변수
	int pdtprice = 0;
	for (int i = 0 ; i < cartList.size() ; i++) {
		String lnk = "<a href='pdt_view.pdt" + args + "&id=" + cartList.get(i).getPl_id() + "'>";
		int max = cartList.get(i).getPs_stock();
		pdtprice = cartList.get(i).getPrice() * cartList.get(i).getCl_cnt();
		String msg = "";
		if (max == -1)		max = 100;	// 수량 선택 최대값으로 재고량이 무제한인 상품의 최대값
		else if (max < cartList.get(i).getCl_cnt()) {
			msg = "선택하신 구매수량이 재고량을 초과 하였습니다. \n 다시 선택해주세요.";
		}
%>
<input type="hidden" name="id" value="<%=cartList.get(i).getPl_id() %>" />
<tr>
<td><input type="checkbox" name="chk" value="<%=cartList.get(i).getCl_idx() %>" checked="checked" /></td>
<td align="left">
	<%=lnk%><img src="/fourplay/product/pdt_img/<%=cartList.get(i).getPl_img1() %>" width="50" />
	<%=cartList.get(i).getPl_name() %></a> <br/>
	<%
		String option ="";
		String opts = cartList.get(i).getPl_opt();	// 상품이 가지는옵션
		String opt = cartList.get(i).getCl_opt();	// 사용자가 선택한 옵션
		if (opts != null && !opts.equals("")) {		// 해당 상품에 옵션이 있으면
			String[] arrOpt = opts.split(":");		// 옵션의 종류를 배열로 생성
			String[] arrChoose = opt.split(",");	// 선택한 옵션값을 배열로 생성
			for (int j = 0 ; j < arrOpt.length ; j++) {
				String[] arrTmp = arrOpt[j].split(",");
				option += " , " + arrTmp[0] + " : " + arrChoose[j];
			}
			option = option.substring(3);
		}
	%>
	옵션 / <%= option %>
</td>
<td>
	<select name="cnt<%=i%>" onchange="chCnt(<%=cartList.get(i).getCl_idx()%>, this.value);">
<%		for (int j = 1 ; j <= max ; j++) { %>
		<option value="<%=j%>" <% if (j == cartList.get(i).getCl_cnt()) { %>selected<% } %>><%=j%></option>
<%		} %>
	</select>
</td>
<td style="color:red; font-weight:bold;"><%=pdtprice %></td>
<td><%=pdtprice /100 %></td>
<td align="center">
<%		if (pdtprice > 50000){%>
[기본배송]<br/>무료
<%		} else { %>
2500
<%		} %>
</td>
<td>
	<input type="button" value="관심상품" onclick="goWish();" />
	<input type="button" value="삭제하기" onclick="cartDel(<%=cartList.get(i).getCl_idx()%>);" />
</td>
</tr>
<%
		total += cartList.get(i).getPrice() * cartList.get(i).getCl_cnt();
	}
%>
</table>
<table width="700" cellpadding="15" cellspacing="0">
<tr>
<td width="*">
	<input type="button" value="선택한 상품 구매" onclick="chkBuy();" />
	<input type="button" value="선택한 상품 삭제" onclick="notCool(0);" /> 
</td>
<td width="250" align="right">총 구매가격 : <span id="total"><%=total %></span> 원</td>
</tr>
<tr><td colspan="2" align="center">
	<input type="button" value="전체 구매" onclick="" />
	<input type="button" value="계속 쇼핑" onclick="location.href='pdt_list.pdt<%=args %>';" />
</td></tr>
<%
} else {	// 장바구니에 데이터가 없으면
%>
<tr><td colspan="6" align="center">장바구니가 비었습니다.</td></tr>
<tr><td colspan="6" align="center">
	<input type="button" value="계속 쇼핑" onclick="location.href='pdt_list.pdt<%=args %>';" />
</td></tr>
<%
}
%>
</table>
</form>
</body>
</html>