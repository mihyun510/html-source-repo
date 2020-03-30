<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.dept.DeptVO"%>
<%@page import="com.dept.DeptDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	DeptDao ddao = new DeptDao();
	List<DeptVO> dlist = null;
	dlist = ddao.deptVOList();
	Gson g = new Gson();
	String imsi = g.toJson(dlist);
	out.print(imsi);
%>