<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%
	List<Map<String,Object>> deptList = new ArrayList<>();
	Map<String,Object> map = new HashMap<>();
	map.put("dname","영업부");
	deptList.add(map);
	map = new HashMap<>();
	map.put("dname","개발부");
	deptList.add(map);
	map = new HashMap<>();
	map.put("dname","품질관리부");
	deptList.add(map);
%>
<table border="1">
<%
	for(int i=0; i<deptList.size(); i++){	
		Map<String,Object> rmap = deptList.get(i);
%>
	<tr><td><% out.print(rmap.get("dname")); %></td></tr>
<%
	}
%>
</table>







