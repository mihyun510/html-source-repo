<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="json.ui.JsonDeptList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	JsonDeptList jdl = new JsonDeptList();
	List<Map<String,Object>> deptList = jdl.getDeptList();
	Gson g = new Gson();
	String temp = g.toJson(deptList);
	out.print(temp);
%>