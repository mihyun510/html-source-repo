<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String empnoArr = request.getParameter("empno"); //7899, 9011, 9013
	String empnos[] = null;
	if(empnoArr!=null){
		empnos = empnoArr.split(",");
	}
	SqlMapEmpDao eDao = new SqlMapEmpDao();
	int result = eDao.empDEL(empnos);
	out.print("result:"+result);
	//response.sendRedirect("EmpManager7.jsp"); //페이지 이동 - 새로고침을 위한 것 초기화면으로 가면 새로고침이됨. 현재상태는 페이지이동이 없어도 오라클을 경유함 페이지 열리기 전에 db경우
	if(result > 0){ //삭제성공
								//				   ┌> 업데이트에 관한 값을 넘겨야지 새로고침이 일어난다.
		response.sendRedirect("./EmpManager10.jsp?mode=update"); //성공하면 페이지를 경유함. //sendRedirect: 페이지를 이동 시킴. 새로운 요청으로 인지한다. url이 변한다. 이전에 페이지의 데이터는 유지되지 않는다.
	} else { //삭제실패
		response.sendRedirect("./empInsertFail.jsp"); // 페이지 열리기 전 db 경유함
	}
%>