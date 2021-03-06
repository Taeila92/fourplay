<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="vo.*" %>
<%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

String status = "";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- 
<link href="css/reset.css" type="text/css" rel="stylesheet" />
<link href="css/base.css" type="text/css" rel="stylesheet" />
 -->
<style>
#wrapper table td {border-bottom:1px solid lightgray; align:center;}
.paging {
	width:100%; position:relative; top:30%; border:0;
}
</style>
<script src="jquery-3.5.1.js"></script>
<script>
function ordCancel(olid) {
	if (confirm('주문을 취소하시겠습니까?\n취소 철회는 불가능합니다.')) {
		$.ajax({
			type : "POST", 
			url : "/fourplay/ord_proc.ord", 
			data : { "olid" : olid, "wtype" : "cancel" }, 
			success : function(chkRst) {
				if(chkRst == 0)		alert("주문 취소에 실패했습니다.\n다시 시도해 주십시오.");
				else				location.reload();
			}
		});
	}
}
</script>
</script>
</head>
<body>
<div id="wrapper">
<h2>ORDER LIST</h2>
<table width="100%" cellpadding="5" cellspacing="0" border="0">
	<div class="head">
	<tr style="background-color:#e1e1e1; "><th width="15%">주문일자<br />[주문번호]</th><th width="10%">사진</th><th width="*">상품정보</th><th width="5%">수량</th>
	<th width="8%">가격</th><th width="10%">주문처리상태</th><th width="15%">취소/교환/반품</th></tr>
	</div>
<%
if(ordList != null && rcnt > 0){
	for(int i = 0; i < ordList.size(); i++){ 
		switch(ordList.get(i).getOl_status()){
			case "a": 	status = "입금 전<br />계좌번호: 국민은행<br />6131802-01473-365(김현수)";		break;
			case "b": 	status = "입금 확인";								break;
			case "c": 	status = "상품준비중";								break;
			case "d": 	status = "배송중<br/>한진택배: 419079564046";		break;
			case "e": case "k":			
						status = "배송완료";								break;
			case "f": 	status = "교환요청";								break;
			case "g": 	status = "교환완료";								break;
			case "h": 	status = "환불요청";								break;
			case "i": 	status = "환불완료";								break;
			case "j": 	status = "취소";									break;	
	}
%>
	<tr>
	<td><a href="order_detail.mpg?olid=<%=ordList.get(i).getOl_id() %>">
	<%=ordList.get(i).getOl_date().substring(0,11) %><br />[<%=ordList.get(i).getOl_id() %>]</a></td>
	<td><img src='/fourplay/product/pdt_img/<%=ordList.get(i).getOrdDetailList().get(0).getPl_img1() %>' width='50' align="absmiddle"/></td>
	<td>
<%
		for (int j = 0; j < ordList.get(i).getOrdDetailList().size(); j++) {
			String plid = ordList.get(i).getOrdDetailList().get(j).getPl_id();
			String plname = ordList.get(i).getOrdDetailList().get(j).getPl_name();
			String opt = ordList.get(i).getOrdDetailList().get(j).getOd_opt();
			if(opt == null || opt.equals(""))		opt = "옵션없음";
			
			if (j == ordList.get(i).getOrdDetailList().size() -1)	{
				out.print("<a href='pdt_view.pdt?id="+plid+"'>" 
				+ plname + "<br />[" + opt + "]</a><br />");
			}else {
				out.print("<a href='pdt_view.pdt?id=" + plid + "'>" 
						+ plname + "<br />[" + opt + "]</a>, <br />");
			}
		} 
%>
	</td>
	<td>
<%
		int cnt = 0;
		for (int j = 0; j < ordList.get(i).getOrdDetailList().size(); j++) {
			cnt += ordList.get(i).getOrdDetailList().get(j).getOd_cnt();
		} 
		out.print(cnt);
%>
	</td>
	<td><%=ordList.get(i).getOl_pay() %></td>
	<td><%=status%></td>
	<td>
		<% switch(ordList.get(i).getOl_status()){
			case "a": case "b": case"c": 	out.print("<input type='button' value='주문취소' onclick='ordCancel("+ ordList.get(i).getOl_id()+");'/>");		break;
			case "d": case "g":				out.print("<input type='button' value='교환/반품' onclick=''/>");					break;
			case "e":	out.print("<input type='button' value='구매후기' onclick='location.href=\"order_detail.mpg?olid="+ordList.get(i).getOl_id()+"\" '/>");		
			break;
			case "f": 	out.print("교환요청");	break;
			case "h": 	out.print("환불요청");	break;
			case "i": 	out.print("환불완료");	break;
			case "j": 	out.print("취소완료");	break;
			case "k": 	out.print("배송완료");	break;
		}
	%>
	</td>
	</tr>
<%
	}
}else {	//검색 결과가 없으면
	out.println("<tr align='center'><td colspan='7'>주문 내역이 없습니다.</td></tr>");
}
%>
	<tr><td colspan="7">
	<div class="paging">
	<table width="100%" cellpadding="5">
	<tr><td align="center">
<%
if (rcnt > 0) {	// 검색결과 상품들이 있을 경우에만 페이징을 함
	if (cpage == 1) {
		out.println("<<&nbsp;&nbsp;<&nbsp;&nbsp;");
	} else {
		out.print("<a href='order_list.mpg?cpage=1'>");
		out.println("<<</a>&nbsp;&nbsp;");
		out.print("<a href='order_list.mpg?cpage=" + (cpage - 1) +  "'>");
		out.println("<</a>&nbsp;&nbsp;");
	}
	for (int i = 1, j = spage ; i <= bsize && j <= pcnt ; i++, j++) {
		if (cpage == j) {
			out.println("&nbsp;<strong>" + j + "</strong>&nbsp;");
		} else {
			out.print("&nbsp;<a href='order_list.mpg?cpage=" + j +  "'>");
			out.println(j + "</a>&nbsp;");
		}
	}
	if (cpage == pcnt) {
		out.println("&nbsp;&nbsp;>&nbsp;&nbsp;>>");
	} else {
		out.print("&nbsp;&nbsp;<a href='order_list.mpg?cpage=" + (cpage + 1)  + "'>");
		out.println("></a>");
		out.print("&nbsp;&nbsp;<a href='order_list.mpg?cpage=" + pcnt  + "'>");
		out.println(">></a>");
	}
}
%>
	</td></tr>
	</table>
	</div>
	</td></tr>
</table>
</div>
<br />

</body>
</html>