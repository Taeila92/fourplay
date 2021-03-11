<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!--autoload=false 파라미터를 이용하여 자동으로 로딩되는 것을 막습니다.-->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script>
/*
function getZip() {
	daum.postcode.load(function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	            // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	            if(fullRoadAddr !== ''){
	                fullRoadAddr += extraRoadAddr;
	            }
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('bzip').value = data.zonecode; //5자리 새우편번호 사용
	            document.getElementById('baddr1').value = fullRoadAddr;
	            document.getElementById('bjibun').value = data.jibunAddress;
	            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	            if(data.autoRoadAddress) {
	                //예상되는 도로명 주소에 조합형 주소를 추가한다.
	                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                var guide = document.getElementById('guide');
	                guide.innerHTML = '(도로명 주소 : ' + expRoadAddr + ')';
	            } else if(data.autoJibunAddress) {
	                var expJibunAddr = data.autoJibunAddress;
	                guide.innerHTML = '(지번 주소 : ' + expJibunAddr + ')';
	            } else {
	            	guide.innerHTML = '';
	            }
	        }
	    }).open();
	});
}
*/
function getZip(val) {
	daum.postcode.load(function(){
	    new daum.Postcode({
	        oncomplete: function(data) {
	        	var addr = "";
	        	// 사용자가 선택한 주소 타입에 따라 해당 주소 가져옴
	        	if(data.userSelectedType === "R"){	// 도로명 주소를 선택했을 경우
	        		addr = data.roadAddress;
	        	} else {	// 지번 주소를 선택했을 경우
	        		addr = data.jibunAddress;
	        	}
	        	if(val == "b"){
		        	document.getElementById("bzip").value = data.zonecode;
		        	document.getElementById("baddr1").value = addr;
		        	document.getElementById("baddr2").focus();
	        	} else {
	        		document.getElementById("rzip").value = data.zonecode;
		        	document.getElementById("raddr1").value = addr;
		        	document.getElementById("raddr2").focus();
	        	}
	        }
	    }).open();
	});
}


</script>
</head>
<body>
<input type="text" id="bzip" placeholder="우편번호" />
<input type="button" onclick="getZip('b')" value="우편번호 찾기" /><br>
<input type="text" id="baddr1" placeholder="주소" />
<input type="text" id="bjibun" placeholder="지번 주소" />
<input type="text" id="baddr2" placeholder="상세주소" /><br>
<span id="guide" style="color:#999"></span>

<input type="text" id="rzip" placeholder="우편번호" />
<input type="button" onclick="getZip('r')" value="우편번호 찾기" /><br>
<input type="text" id="raddr1" placeholder="주소" />
<input type="text" id="raddr2" placeholder="상세주소" />
</body>
</html>