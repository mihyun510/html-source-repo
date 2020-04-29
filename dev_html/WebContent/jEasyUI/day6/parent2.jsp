<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>json으로 데이터 화면에 뿌리기.</title>
<%@ include file="../day5/JEasyUICommon.jsp" %>
</head>
<body>
<!-- 														┌>json으로 데이터 화면에 뿌리기. -->
	<table id="dg" class="easyui-datagrid" data-options="url:'./member.json'" title="데이터출력 방법 종류" style="width:600px;"><!-- 여기서 url은 tag로 처리하는 방식, json직접적으로 주어도 화면에 데이터를 뿌리기 가능함. -->
		<thead>
			<tr><th data-options="field:'ENAME', width:150">이름</th></tr><!-- data-options안에다가 width을 주어야지 적용된다. -->
		</thead>
		<tbody>
				<!-- json으로 데이터를 꺼냄, javascript로 처리 url은 js임 -->
			<tr><td width=150px;><% out.print("이성계"); %></td></tr><!-- width가 먹지 않은다. easyui가 지원하는 방식이아니다. -->
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
			<tr>
			<td width=150px;><% out.print("이성계"); %></td><!-- width가 표준에서는 잘 먹었는데 easyui에서는 적용되지 않음 이것은 easyui에서 자체적으로 만들어진 아이디에 적용해야됨 -->
			<td>주소</td>
			</tr>
		</tbody>
	</table>
</body>
</html>