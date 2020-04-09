<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="JeasyUI.member.MemeberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- mineType을  application/json으로 설정이 가능. --%>
<%-- HTML 땅 - mine타입이 html일때 
	jsp주석으로 반드시 처리할 것.
	<% 스크립틀릿 - 자바의 땅 %>
--%>
<%
	MemeberDAO mdao = new MemeberDAO();
	List<Map<String, Object>> mList = null;
	mList = mdao.procMemList();
	Gson g = new Gson();
	String imsi = g.toJson(mList);
	out.print(imsi);
%>