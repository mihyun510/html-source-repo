<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>b2.jsp</title>
</head>
<body>
b2.jsp
창이열리는게 아니라 직접 페이지를 이동함. - 이동 2번째 타입
<script type="text/javascript">
	function move(){
						//		┌>값을 원하는 페이지로 전달. a2페이지에서는 이값을 받는 코드를 가지고 있어야됨                              
		location.href="./a2.jsp?mode=update"; //다시 b2.jsp에서 a2.jsp로 이동하는 경우
	}
</script>
<button onClick="move()">a2페이지</button>
</body>
</html>