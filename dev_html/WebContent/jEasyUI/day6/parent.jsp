<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
  		//오라클과 연계했다라고 가정하고 작성한 코드
  		//json이 아니여도 jsp화면에 데이터를 출력할 수 있는 방법
    	List<Map<String, Object>> mList = new ArrayList<>();
    	Map<String, Object> rmap = new HashMap<>();
    	rmap.put("name", "이성계"); //꼭 소문자로 해야됨. 왜?
    	mList.add(rmap);
    	rmap = new HashMap<>();
    	rmap.put("name", "강감찬"); //꼭 소문자로 해야됨. 왜?
    	mList.add(rmap);
    	rmap = new HashMap<>();
    	rmap.put("name", "김유신"); //꼭 소문자로 해야됨. 왜?
    	mList.add(rmap);
    	
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>json없이 DB를 연동하여 java코드로 jsp화면에 데이터 뿌리기</title>
<%@ include file="../day5/JEasyUICommon.jsp" %>
<script type="text/javascript" src="../../js/commons.js"></script>
<script type="text/javascript">
	function test(p_url, p_width, p_height, p_name){
		cmm_window_popup(p_url, p_width, p_height, p_name);
	}
	function fun(){
		//alert("fun 호출 성공");
		$("#dg").datagrid({ //직접넣어주는 경우와 밖에서 넣어주는 경우 누가 더 우선한가? fun호출을 하지 않았으니 밑의 것이 더 우선 그러나 등록을 누르는 순간 fun()이 더 우선순위를 가진다.
			url:"../day5/jsonEmpList.jsp"
			,onLoadSuccess:function(data){
				alert("emp목록 로딩 성공");
			}
		});
	}
</script>
</head>
<body>
	<table id="dg" class="easyui-datagrid" title="데이터출력 방법 종류" style="width:600px;">
		<thead>
			<tr><th data-options="field:'ENAME', width:150">이름</th></tr><!-- data-options안에다가 width을 주어야지 적용된다. -->
		</thead>
		<tbody>
		<%
			for(int i =0; i<mList.size(); i++){
				Map<String, Object> pmap = mList.get(i);
		%>
			<!-- 자바에서 직접꺼낸것을 출력 - 자바코드로 처리		┌>json형태로 출력한 것이 아니니 필드명이 달라도 영향을 미치지 않음-->
			<tr><td width=150px;><% out.print(pmap.get("name")); %></td></tr><!-- width가 먹지 않은다. easyui가 지원하는 방식이아니다. -->
		<%
			}
		%>
		</tbody>
	</table>
	<table border="1" title="데이터출력 방법 종류" style="width:600px;">
		<thead>
			<tr>
			<th>이름</th>
			<th>주소</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(int i =0; i<mList.size(); i++){
				Map<String, Object> pmap = mList.get(i);
		%>
			<tr>
			<td width=150px;><% out.print(pmap.get("name")); %></td><!-- width가 표준에서는 잘 먹었는데 easyui에서는 적용되지 않음 이것은 easyui에서 자체적으로 만들어진 아이디에 적용해야됨 -->
			<td>주소</td>
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<button onClick="test('child2.jsp','700','450','child')">등록</button>
</body>
</html>