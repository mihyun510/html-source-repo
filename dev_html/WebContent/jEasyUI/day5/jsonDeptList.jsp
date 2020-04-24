<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.SqlMapDeptDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SqlMapDeptDao dDao = new SqlMapDeptDao();
	Map<String, Object> pmap = new HashMap<>();
	List<Map<String, Object>> dlist = new ArrayList<>();
	dlist = dDao.deptList();
	Gson g = new Gson();
	String imsi = g.toJson(dlist);
	out.print(imsi);
%>