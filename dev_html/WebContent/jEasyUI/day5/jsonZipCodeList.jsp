<%@page import="orm.dao.SqlMapCommonDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%--SqlMapEmpDao의 테스트 파일 -> json파일로 사원정보가 화면에 열리는 것을 테스트. --%>
<%
	String dong = request.getParameter("dong");
	SqlMapCommonDao cDao = new SqlMapCommonDao();
	Map<String, Object> pmap = new HashMap<>();
	pmap.put("dong", dong);
	List<Map<String, Object>> zlist = cDao.zipcodeList(pmap); //파라미터는 사원번호를 받아서 넘겨야되니 null이 되면안된다. 파라미터로 넘길 값이 없으면 즉, where절을 사용하는 쿼리문이 아니면 , 사용자로부터 값을 받아서 넘길것이 없으면 null로 넘겨서 테스트가 가능하다.
	Gson g = new Gson();
	String imsi = g.toJson(zlist);
	out.print(imsi);
%>