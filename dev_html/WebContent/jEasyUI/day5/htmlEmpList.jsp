<%-- <%@page import="com.google.gson.Gson"%> --%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%--SqlMapEmpDao의 테스트 파일 -> json파일로 사원정보가 화면에 열리는 것을 테스트. --%>
<%
	SqlMapEmpDao edao = new SqlMapEmpDao();
	List<Map<String, Object>> elist = edao.empList(null);
/* 	제이슨 형태 대신 html형식으로 데이터를 뽑아 올 것이다.
	Gson g = new Gson();
	String imsi = g.toJson(elist);
	out.print(imsi); */
%>
<table>
<%
	//<!-- 조회결과가 없을 때 -->
	if(elist==null){
		
%>
	<tr>
		<td>조회결과가 없습니다.</td>
	</tr>
<%
	}else{
	//<!-- 조회결과가 있을 때 -->
		for(int i = 0; i<elist.size(); i++){ //조회결과를 가져오는데 여러건이 존재한다. for문을 돌리자.
			Map<String, Object> rmap = elist.get(i); //
%>
	<tr>
		<%--<td>조회결과가 없습니다.</td> --%>
		<%-- <td><% out.print(rmap.get("무엇을 넣어야 하지? - 키값을 넣어야 된다.")); %></td> --%>
		<td><% out.print(rmap.get("EMPNO")); %></td>
		<td><% out.print(rmap.get("ENAME")); %></td>
		<td><% out.print(rmap.get("JOB")); %></td>
		<td><% out.print(rmap.get("HIREDATE")); %></td>
		<td><% out.print(rmap.get("MGR")); %></td>
		<td><% out.print(rmap.get("DEPTNO")); %></td>
		<td><% out.print(rmap.get("SAL")); %></td>
		<td><% out.print(rmap.get("COMM")); %></td>
	</tr>
<%
		}////////end of for
	}//////////end of else
%>
</table>