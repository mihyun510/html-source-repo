<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- html땅 -->
<%
	//자바영역
	String mem_id = request.getParameter("mem_id");
	out.print(mem_id); //브라우저에 찍는 것이니 out.print사용.
%>
</body>
</html>