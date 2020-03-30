<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.dept.DeptDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	DeptDao ddao = new DeptDao();
	List<Map<String,Object>> dlist = null;
	dlist = ddao.deptList();
	//out.print(dlist.size()); json파일로 보고싶다면 ※주의※ <%밖에 주석을 달면 안되고 gson파일 외에 출력되는 내용이 없어야된다.
	Gson g = new Gson();
	String imsi = g.toJson(dlist);
	out.print(imsi);
%>