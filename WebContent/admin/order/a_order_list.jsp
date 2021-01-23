<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../a_menu.jsp" %>
<%
ArrayList<OrdListInfo> ordList = (ArrayList<OrdListInfo>)request.getAttribute("ordList");
OrdPageInfo pageInfo = (OrdPageInfo)request.getAttribute("pageInfo");
int cpage	= pageInfo.getCpage();	// 현재 페이지 번호
int pcnt	= pageInfo.getPcnt();	// 전체 페이지 수
int psize	= pageInfo.getPsize();	// 페이지 크기
int bsize	= pageInfo.getBsize();	// 블록 페이지 개수
int spage	= pageInfo.getSpage();	// 블록 시작 페이지 번호
int epage	= pageInfo.getEpage();	// 블록 종료 페이지 번호
int rcnt	= pageInfo.getRcnt();	// 검색된 게시물 개수

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
.pointer {cursor:pointer;}
</style>
<script>
function openDetail(olid){
	var win = window.open("ord_detail.orda?olid="+ olid, "a_order_detail.jsp", "width=900, height=450");
}
function openPdt(plid){
	var win = window.open("pdt_view.orda?id="+ plid, "a_product_detail.jsp", "width=900, height=450");
}
function getStatus(){
	var arrVal = document.listFrm.status;
	var status = "";
	for(var i = 0; i < arrVal.length; i++){
		status += "," + arrVal[i].options[arrVal[i].selectedIndex].value;
	}
	status = status.substring(1);
	return status;
}

function chVal(){
	var frm = document.listFrm;
	var st = document.getElementById("st");
	if(confirm("주문상태값을 변경하시겠습니까?")){
		var status = getStatus();	//b,a
		st.value = status;	
		frm.submit();
	}
}
</script>
</head>
<body>
<div id="wrapper">
<%
String plid = "";
if(ordList != null) out.println("ordList not null");
if(pageInfo != null) out.println("pageInfo not null");
%>
	<h3>주문 목록</h3>
	<form name="listFrm" action="ord_proc.orda" method="post">
	<input type="hidden" name="wtype" value="chStatus" />
	<input type="hidden" name="st" id="st" value="" />
	<table width="100%">
	<tr>
	<th>주문번호</th><th>주문자</th><th>상품명</th><th>주문금액</th>
	<th>주문일</th><th>결제방법</th><th>주문상태</th>
<!-- <th>취소/반품/교환 사유</th>  -->
	</tr>
<%
if(ordList != null && rcnt > 0){
	String idx = "", idxs = "";
	for(int i = 0; i < ordList.size(); i++){
		idx = ordList.get(i).getOl_id();
		idxs += "," + idx;
%>
	<tr>
	<td><span class="pointer" onclick="openDetail(<%=ordList.get(i).getOl_id() %>);"><%=ordList.get(i).getOl_id() %></span></td>
	<td><%=(ordList.get(i).getOl_buyer().length() > 20) ? "비회원" : ordList.get(i).getOl_buyer() %></td>
	<td>
<%
		for(int j = 0; j < ordList.get(i).getOrdDetailList().size(); j++){
			plid = ordList.get(i).getOrdDetailList().get(j).getPl_id();
			String plname = ordList.get(i).getOrdDetailList().get(j).getPl_name();
%>
		<span class="pointer" onclick="openPdt('<%=plid%>');"><%=plname %></span><br />
<%
		}
%>
	</td>
	<td><%=ordList.get(i).getOl_pay() %></td>
	<td><%=ordList.get(i).getOl_date().substring(0,11).replace("-", ".") %></td>
	<td>
<%
		switch(ordList.get(i).getOl_payment()){
			case "a" : out.println("카드 결제");	break; 
			case "b" : out.println("휴대폰 결제");	break; 
			case "c" : out.println("계좌이체");	break; 
			case "d" : out.println("무통장 입금");	break; 
		}
%>	
	</td>
	<td>
	<select name="status" id="status">
		<option value="a" <%if (ordList.get(i).getOl_status().equals("a")) { %> selected="selected" <%} %>>입금 전</option>
		<option value="b" <%if (ordList.get(i).getOl_status().equals("b")) { %> selected="selected" <%} %>>입금 확인</option>
		<option value="c" <%if (ordList.get(i).getOl_status().equals("c")) { %> selected="selected" <%} %>>상품준비중</option>
		<option value="d" <%if (ordList.get(i).getOl_status().equals("d")) { %> selected="selected" <%} %>>배송중</option>
		<option value="e" <%if (ordList.get(i).getOl_status().equals("e")) { %> selected="selected" <%} %>>배송완료</option>
		<option value="f" <%if (ordList.get(i).getOl_status().equals("f")) { %> selected="selected" <%} %>>교환요청</option>
		<option value="g" <%if (ordList.get(i).getOl_status().equals("g")) { %> selected="selected" <%} %>>교환완료</option>
		<option value="h" <%if (ordList.get(i).getOl_status().equals("h")) { %> selected="selected" <%} %>>환불요청</option>
		<option value="i" <%if (ordList.get(i).getOl_status().equals("i")) { %> selected="selected" <%} %>>환불완료</option>
		<option value="j" <%if (ordList.get(i).getOl_status().equals("j")) { %> selected="selected" <%} %>>취소</option>
		<option value="k" <%if (ordList.get(i).getOl_status().equals("k")) { %> selected="selected" <%} %>>후기작성 완료</option>
	</select>
	</td>
<%
	} 
	idxs = idxs.substring(1);
%>
	<input type="hidden" name="idxs" value="<%=idxs %>" />
	</tr>	
<%
} 
else {
	out.println("<tr align='center'><td colspan='8'>주문 내역이 없습니다.</td></tr>");
}
%>
	<tr><td colspan="4" style="text-align:right; padding-top:20px;">
	<input type="button" id="statusBtn" value="주문상태 변경" onclick="chVal();"/></td></tr>
	</table>
	</form>
	<div class="paging">
	<table width="100%" cellpadding="5">
	<tr><td align="center">
<%
if (rcnt > 0) {	// 검색결과 상품들이 있을 경우에만 페이징을 함
	if (cpage == 1) {
		out.println("<<&nbsp;&nbsp;<&nbsp;&nbsp;");
	} else {
		out.print("<a href='ord_list.orda?cpage=1'>");
		out.println("<<</a>&nbsp;&nbsp;");
		out.print("<a href='ord_list.orda?cpage=" + (cpage - 1) +  "'>");
		out.println("<</a>&nbsp;&nbsp;");
	}
	for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.print("&nbsp;<a href='ord_list.orda?cpage=" + j +  "'>");
			out.println(j + "</a>&nbsp;");
		}
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;>&nbsp;&nbsp;>>");
	} else {
		out.print("&nbsp;&nbsp;<a href='ord_list.orda?cpage=" + (cpage + 1)  + "'>");
		out.println("></a>");
		out.print("&nbsp;&nbsp;<a href='ord_list.orda?cpage=" + pcnt  + "'>");
		out.println(">></a>");
	}
}
%>
	</td></tr>
	</table>
	</div>
</div>
</body>
</html>