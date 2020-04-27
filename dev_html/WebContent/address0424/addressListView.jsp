<%@page import="com.google.gson.Gson"%>
<%@page import="orm.dao.SqlMapCommonDao"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	List<Map<String, Object>> zdoList = null;
    	SqlMapCommonDao smcd = new SqlMapCommonDao();
    	zdoList = smcd.getZDOList();
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax실전연습-[1:ajax, 2:html,html+js,js, 3:myBatis]</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<style type="text/css">
	table{
		border: 3px solid #CCAAFF;
	}
	td{
		border: 3px solid #CCAAFF;
		text-align: center;
		height: 45px;
	}
</style>
<script type="text/javascript">
	function siguIN(){
		//구가 바꼈을때 구에대한 값가져오기
		$("#i_sigu").change(function(){
			$("#i_sigu option:selected").each(function(){//i_sigu의 옵션중에서 선택되면 그리고 이것을 만족하면 콜백함수 실행.
				$("#sigu").val($(this).text()); //선택된 값을 setText하기 this -> i_sigu
			});
		});
	}
	function dongIN(){
		//구가 바꼈을때 구에대한 값가져오기
		$("#i_dong").change(function(){
			$("#i_dong option:selected").each(function(){
				$("#dong").val($(this).text()); 
			});
		});
	}
</script>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#i_zdo").change(function(){
			$("#i_zdo option:selected").each(function(){ //콤보박스가 선택되었을때 ?.. 아이디가 와여되는 자리에 해당 아이디의 옵션까지 와도 되는 것인가요?
				var p_zdo = $(this).text();
				//alert("p_zdo: "+p_zdo);
				$("#zdo").val(p_zdo);
				var param="zdo="+p_zdo;
				$.ajax({
					method:"post"
					,url:"./getSiGuList.jsp"
					,success:function(result){
						$("#d_sigu").html(result); //콤보박스가 나온다.
						siguIN();
					}
				});
			});
		});///////////end of i_zdo
		$("#d_sigu").change(function(){
			$("#d_sigu option:selected").each(function(){ //옵션의 값 중에 선택된 인덱스
				var p_sigu = $(this).text();
				//alert("p_sigu:"+p_sigu);
				var p_zdo = $("#zdo").text();
				$("#sigu").val(p_sigu);
				var param="zdo="+p_zdo+"sigu="+p_sigu;
				$.ajax({
					method:"post"
					,url:"./getDongList.jsp"
					,success:function(result){
						$("#d_dong").html(result);
						dongIN();
					}
				});
			});
		});
	});
</script>
<table width="600" height="60" cellpadding="0" cellspacing="0">
	<tr>
		<td width="60">시도</td>
		<td width="140">
			<select id="i_zdo" style="width:120px; height:20px;"><!-- html로 그리는 combobox select는 combobox -->
				<option value="선택">선택</option>
				<%
					for(int i=0; i<zdoList.size();i++){
						Map<String,Object> rmap = zdoList.get(i);
				%>
				<option value="<%=rmap.get("ZDO")%>"><%=rmap.get("ZDO") %></option>
				<%
					}
				%>
			</select>
		</td>
		<td width="60">구</td>
		<td width="140">
			<div id="d_sigu" ><!-- 여기서부터는 zdo에서 선택한 조건에 대한 구가 들어와야되니 아작스로 처리된 값이 들어와야 된다. -->
			</div>
		</td>
		<td width="60">동</td>
		<td width="140">
			<div id="d_dong"><!-- 앞에서 선택한 조건의 값에 따라서 값이 들어온다. -->
			</div>
		</td>
	</tr>
	<tr>
		<td width="60">시도</td>
		<td width="140">
			<input id="zdo" name="zdo" type="text" style="width:120px; height:30px;"/>
		</td>
		<td width="60">구</td>
		<td width="140">
			<input id="sigu" name="sigu" type="text" style="width:120px; height:30px;"/>
		</td>
		<td width="60">동</td>
		<td width="140">
			<input id="dong" name="dong" type="text" style="width:120px; height:30px;"/>
		</td>
	</tr>
</table>
</body>
</html>