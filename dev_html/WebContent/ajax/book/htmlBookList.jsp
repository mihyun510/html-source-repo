<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="orm.dao.SqlMapBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- include할 페이지 --%>
<%
	String book_title = request.getParameter("book_title");
	String choMode = request.getParameter("choMode");
	//out.print(book_title+", "+choMode);//아ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ여기서 나오는 것이였네ㅔㅔㅔㅔㅔㅔ
	SqlMapBookDao bDao = new SqlMapBookDao();
	Map<String, Object> pmap = new HashMap<>();
	pmap.put("book_title", book_title);
	pmap.put("choMode", choMode);
	List<Map<String, Object>> blist = new ArrayList<>();	
	blist = bDao.bookList(pmap);
	//out.print(blist);
	//json이 없으면 JSON형태로 데이터를 출력하지 않는다. 
%>
<table border="1" borderColor="red">
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
	<!-- 		   ┌>출력을 위한 표현식 ;도 붙히면 안된다. BOOK_NO의 값이 id값으로 입력된다. BOOK_NO로 식별하기.-->
		<td id="<%=rMap.get("BOOK_NO") %>"><% out.print(rMap.get("BOOK_TITLE"));%></td>
	</tr>
<% 
		}////end of for 
	}////end of else
%>
</table>