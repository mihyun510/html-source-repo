<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="project.restaurant.RestaurantDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 스크립틀릿[자바코드를 쓸 수 있는 땅] 여기안에는 제이슨 파일을 가져올것이라서 주석이있으면 제대로 제이슨파일로 가져오지 못하니 주석도 달지 말자 스크립틀릿 주석으로 달아요..!!!.
	, 디비에서 가져온 값을 json파일로 테스트해볼것이다. 그러니 html소스코드가 하나도 필요가 없다 --%>
<% 
	RestaurantDao rDao = new RestaurantDao();
	List<Map<String, Object>> mrList = rDao.mapRestList();
	Gson g = new Gson();
	String imsi = g.toJson(mrList);
	out.print(imsi);
%>