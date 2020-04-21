<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%--SqlMapEmpDao의 테스트 파일 -> json파일로 사원정보가 화면에 열리는 것을 테스트. --%>
<%
	SqlMapEmpDao edao = new SqlMapEmpDao();
	List<Map<String, Object>> elist = edao.empList(null);
	Gson g = new Gson();
	String imsi = g.toJson(elist);
	out.print(imsi);
%>