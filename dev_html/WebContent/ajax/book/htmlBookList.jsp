<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.SqlMapBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SqlMapBookDao smd = new SqlMapBookDao();
	List<Map<String, Object>> blist = new ArrayList<>();	
	blist = smd.bookList(null);
%>
<table>
<%
	if(blist == null){
%> 
	<tr>
	<td>조회된 결과가 없습니다.</td>
	</tr>
<%
	}else{
		for(int i = 0; i<blist.size(); i++){ 
		Map<String, Object> rMap = blist.get(i);
%>
	<tr>
		<td><% out.print(rMap.get("BOOK_NO"));%></td>
		<td><% out.print(rMap.get("BOOK_TITLE"));%></td>
		<td><% out.print(rMap.get("BOOK_IMG"));%></td>
		<td><% out.print(rMap.get("BOOK_AUTHOR"));%></td>
		<td><% out.print(rMap.get("BOOK_PUBLISH"));%></td>
		<td><% out.print(rMap.get("BOOK_DATE"));%></td>
		<td><% out.print(rMap.get("BOOK_PRICE"));%></td>
	</tr>
<% 
		}////end of for 
	}////end of else
%>

</table>