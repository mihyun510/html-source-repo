<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><!-- 브라우저가 jsp파일이지만 html로 인식한다. -->
<!-- 스트립틀릿 get방식은 주소창에 =뒤에 값을 써주면 값이 화면에 나타난다. 즉, 단위테스트가 가능한것이다.-->
<%
    String u_id = request.getParameter("u_id");
    out.print("u_id:"+u_id);
%>
