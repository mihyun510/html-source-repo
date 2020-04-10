<%@page import="project.restaurant.RestaurantDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//mapDesign.html문서에서 사용자가 화면에 입력한 아이디 가져오기.
	String mem_id = request.getParameter("mem_id"); //쿼리스트링의 값을 넣어줘야된다. 주소에서 [?mem_id=입력한 값]?뒤에 오는 값.
//mapDesign.html문서에서 사용자가 화면에 입력한 비번 가져오기.
	String mem_pw = request.getParameter("mem_pw"); 
	//out.print("사용자가 입력한 아이디는 "+mem_id);
	RestaurantDao rdao = new RestaurantDao();
	String msg = null;
	msg = rdao.login(mem_id, mem_pw);
	out.print(msg);
%>
