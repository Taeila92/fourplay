<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../menu.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

OrdListInfo total = (OrdListInfo)request.getAttribute("total");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="./css/reset.css" type="text/css" rel="stylesheet" />
<style>

h3 { font-size:12px; }
hr { width:100%; height:2px; background-color:rgb(212,212,212); }
a { text-decoration:none;}

.mypage-list{background:#eee; padding:20px 10px; display:flex; margin-top:100px;}
.mypage-list a{display:block;width:100%;background:#fff;border-radius:30px;margin-right:10px;text-align:center;color:#999;font-size:14px;}
.mypage-list a:last-child{margin-right:0;}
.mypage-list a .img{width:80px;height:80px;margin:auto;display:flex;justify-content:space-between;padding-top:20px;padding-bottom:10px;}
.mypage-list a img{height:100%;}
.mypage-list a p{padding-bottom:30px;position:relative;}
.mypage-list a p:after{clear:both;content:'';display:block;position:absolute;bottom:0;left:0;right:0;margin:auto;width:100px;height:2px;background:#eee;}
.mypage-list a span{display:block;padding:30px 0 50px;font-size:12px;}
</style>
</head>
<body>
<div id="wrapper">
<div>
	<div style="display:flex;justify-content:space-between;align-items:center;padding:20px 10px;">
		<h2>MY PAGE</h2>
		<p><span style="color:#888;">home&nbsp;>&nbsp;</span><span>mypage</span></p>
	</div>
	<div style="display:flex;justify-content:space-between;align-items:center;padding:20px;border:5px solid #eee;">
		<div style="width:100%;padding:0 20px;">
			<div style="display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #eee;font-size:14px;padding:10px 0;">
				<p> <%=loginMember.getMlname() + " [" + loginMember.getMlid() + "]님" %>&nbsp;<a href="member_info.mpg" style="color:#000;font-weight:bold;">[정보변경]</a></p>
				<a href="mypage_pwd.mpg" style="color:#000;font-weight:bold;">[회원탈퇴]</a>
			</div>
		</div>
		<div style="width:100%;padding:0 20px; border-left: 1px solid #eee;">
			<div style="display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #eee;font-size:14px;padding:10px 0;">
				<p>총 주문금액</p>
				<p><%=total.getOl_pay() %> 원</p>
				 
			</div>
			<div style="display:flex;justify-content:space-between;align-items:center;border-bottom:1px solid #eee;font-size:14px;padding:10px 0;">
				<p>적립금&nbsp;<a href="point_list.mpg" style="color:#000;font-weight:bold;">[내역확인]</a></p>
				<p><%=loginMember.getMlpoint() %> 원</p>
			</div>
		</div>
	</div>
	
	<div class="mypage-list">
		<a href="order_list.mpg">
			<div class="img"><img src="./images/ORDER.png"></div>
			<h4>ORDER</h4>
			<p>주문상태 현황</p>
			<span>고객님께서 주문하신 상품의<br>주문내역을 확인하실 수 있습니다.</span>
		</a>
		<a href="member_info.mpg">
			<div class="img"><img src="./images/PROFILE.png"></div>
			<h4>PROFILE</h4>
			<p>회원정보</p>
			<span>회원이신 고객님의 개인정보를<br>관리하는 공간입니다.</span>
		</a>
		<a href="wish_list.crt">
			<div class="img"><img src="./images/WISHLIST.png"></div>
			<h4>WISHLIST</h4>
			<p>관심상품</p>
			<span>관심상품으로 등록하신<br>상품의 목록을 보여드립니다.</span>
		</a>
		<a href="cart_list.crt">
			<div class="img"><img src="./images/CARTLIST.png"></div>
			<h4>CARTLIST</h4>
			<p>장바구니</p>
			<span>장바구니에 등록하신<br>상품의 목록을 보여드립니다.</span>
		</a>
	</div>
</div>
</div>
</body>
</html>
