<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="orm.dao.SqlMapCommonDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sigu = request.getParameter("sigu");
	String zdo = request.getParameter("zdo");
	Map<String, Object> pmap = new HashMap<>();
	pmap.put("ZDO", zdo);
	pmap.put("SIGU", sigu);
	SqlMapCommonDao smcd = new SqlMapCommonDao();
	List<Map<String, Object>> donglist = new ArrayList<>();
	donglist = smcd.getDongList(pmap);
%>
<select id="i_dong" style="width:120px">
	<option value="선택">선택</option>
	<%
		for(int i = 0; i<donglist.size(); i++){
			Map<String, Object> rmap = donglist.get(i);
	%>
	<option value="<%=rmap.get("DONG")%>"><%=rmap.get("DONG") %></option>
	<%
		}
	%>
</select>