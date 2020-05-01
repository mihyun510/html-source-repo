<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>a.jsp-[시작페이지]</title>
<!-- 현재 내가 바라보는 곳 jeasyUI/day5/move
	이동해야 되는 곳 js/ -->
<script type="text/javascript" src="../../../js/commons.js"></script>
<script type="text/javascript">
	function move(){
		//여기서 이동을 실행
		//a와 b는 다른 창이다. a의 데이터가 b에 유지 되지 않는다 url자체가 다름
		cmm_window_popup('./b.jsp','500','350','b'); //target을 따로 지정하지 않았기 때문에 새로 윈도우창을 만들어서 따로 띄움 - 팝업창을 사용
	}
	
</script>
</head>
<body>
내용
<button onClick="move()">b페이지</button>
</body>
</html>