<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 
//고객정보를 넣어보기
//이름: mem_name
//주소: mem_addr
//전화번호: mem_tel 
jsp 주석: <% %> 소스보기의 안보임
//:자바주석: 소스보기에 보임 - json포맷이 아니다.
--%>
<%
	List<Map<String, Object>> cusList = new ArrayList<>();
	Map<String, Object> rmap = null;
	rmap = new HashMap<>();
	rmap.put("mem_name", "공효진");
	rmap.put("mem_addr", "서울시 관악구 삼성동");
	rmap.put("mem_tel", "01012345678");
	cusList.add(rmap);
	
	rmap = new HashMap<>();
	rmap.put("mem_name", "박나래");
	rmap.put("mem_addr", "서울시 관악구 봉천동");
	rmap.put("mem_tel", "01011112222");
	cusList.add(rmap);
	
	rmap = new HashMap<>();
	rmap.put("mem_name", "송해나");
	rmap.put("mem_addr", "서울시 관악구 대학동");
	rmap.put("mem_tel", "01033334444");
	cusList.add(rmap);
	
	Gson g = new Gson();
	String result = g.toJson(cusList);
	
	out.print(result);
%>