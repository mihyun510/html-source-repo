<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.SqlMapCommonDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<Map<String, Object>> sigulist = new ArrayList<>();
	Map<String, Object> pmap = new HashMap<>(); 
	SqlMapCommonDao smcd = new SqlMapCommonDao();
	String zdo = request.getParameter("zdo");
	pmap.put("ZDO", zdo);
	sigulist = smcd.getSiGuList(pmap);
%>
<select id="i_sigu" style="width:120px">
	<option value="선택">선택</option>
	<%
		for(int i = 0; i<sigulist.size(); i++){
			Map<String, Object> rmap = sigulist.get(i);
	%>
	<option value="<%=rmap.get("SIGU")%>"><%=rmap.get("SIGU") %></option>
	<%
		}
	%>
</select>