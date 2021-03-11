<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../a_menu.jsp" %>
<%@ include file="../statistics_menu.jsp" %>
<%
request.setCharacterEncoding("utf-8");
int male = (int)request.getAttribute("male");
int female = (int)request.getAttribute("female");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
</style>
<script src="stat/js/Chart.min.js"></script>
<script src="stat/js/utils.js"></script>
<script>
var config = {
	type: 'pie',
	data: {
		datasets: [{
			data: [<%=male%>, <%=female%>], 
			backgroundColor: [
				window.chartColors.blue,
				window.chartColors.red,
			],
			label: '회원 성별'
		}],
		labels: ["남자", "여자"]
	},
	options: { responsive:true, title:{ display:true, text:'회원 성별' } }
};

window.onload = function() {
	var ctx = document.getElementById('chart-area').getContext('2d');
	window.myPie = new Chart(ctx, config);
};
</script>
</head>
<body>
<div id="wrapper">
<div id="canvas-holder" style="width:70%">
<canvas id="chart-area"></canvas>
</div>
</div>
</body>
</html>