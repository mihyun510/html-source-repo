<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//<input id="tb_id" name="tb_id" class="easyui-textbox" placeholder="아이디">
	//textbocAction.jsp?tb_id=apple
	String tb_name = request.getParameter("umem_id");
			//							 	└>name
	out.print("사용자가 입력한 아이디:"+tb_name);

%>