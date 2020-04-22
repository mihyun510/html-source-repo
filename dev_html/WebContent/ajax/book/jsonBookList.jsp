<%@page import="orm.dao.SqlMapBookDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%--SqlMapEmpDao의 테스트 파일 -> json파일로 사원정보가 화면에 열리는 것을 테스트. --%>
<%
//사용자로부터 입력받은 문자열(a, aj, aja, ajax....) - 초성검색 하기와 초성검색 대상이 아닌 경우
	String book_title = request.getParameter("book_title");
	SqlMapBookDao bdao = new SqlMapBookDao();
	Map<String, Object> pmap = new HashMap<>();
	pmap.put("book_title", book_title);
	List<Map<String, Object>> blist = bdao.bookList(pmap); //파라미터는 사원번호를 받아서 넘겨야되니 null이 되면안된다. 파라미터로 넘길 값이 없으면 즉, where절을 사용하는 쿼리문이 아니면 , 사용자로부터 값을 받아서 넘길것이 없으면 null로 넘겨서 테스트가 가능하다.
	Gson g = new Gson();
	String imsi = g.toJson(blist);
	out.print(imsi);
%>