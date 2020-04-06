<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%> <%-- jsp를 사용하기 위한 코드 필수. 확장자는 jsp이지만 html로 취급받는다. 소스보기 하면 thml소스코드만 보이고 자바코드는 모두 빠진다. --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>부서목록</title>
</head>
<body>
    <!-- script 사용대신 jsp로 테이블 만들기-->
<table border='1' borderColor='red' width='460'>
<tr><th>부서번호</th><th>부서명</th><th>지역</th></tr><!--  width='200'속성값을 빼야지 스플릿이된다. -->
<%
    for(int i = 0; i<3; i++) {
%>
<tr><td>1</td><td>2</td><td>3</td></tr>
<%
    }
%>
</table>
</body>
</html>