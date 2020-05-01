<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="orm.dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = 0;
	String ename = "";
	String job ="";
	double sal = 0.0;
	double comm = 0.0;
	String hiredate = "";
	int mgr = 0;
	int deptno = 0;
	
	if(request.getParameter("u_empno")!=null){
		empno = Integer.parseInt(request.getParameter("u_empno"));
	}
	ename = request.getParameter("u_ename");
	job = request.getParameter("u_job");
	if(request.getParameter("u_sal")!=null){
		sal = Integer.parseInt(request.getParameter("u_sal"));
	}
	if(request.getParameter("u_comm")!=null){
		comm = Integer.parseInt(request.getParameter("u_comm"));
	}
	hiredate = request.getParameter("u_hiredate");
	if(request.getParameter("u_mgr")!=null){//그룹코드임.
		mgr = Integer.parseInt(request.getParameter("u_mgr"));
	}
	if(request.getParameter("u_deptno")!=null){
		deptno = Integer.parseInt(request.getParameter("u_deptno"));
	}
	
	SqlMapEmpDao eDao = new SqlMapEmpDao();
	Map<String, Object> pmap = new HashMap<>();
	
	pmap.put("empno", empno);
	pmap.put("ename", ename);
	pmap.put("job", job);
	pmap.put("sal", sal);
	pmap.put("comm", comm);
	pmap.put("hiredate", hiredate);
	pmap.put("mgr", mgr);
	pmap.put("deptno", deptno);

	int result = eDao.empUPD(pmap);
	out.print("result:"+result);
	//response.sendRedirect("EmpManager7.jsp"); //페이지 이동 - 새로고침을 위한 것 초기화면으로 가면 새로고침이됨. 현재상태는 페이지이동이 없어도 오라클을 경유함 페이지 열리기 전에 db경우

	if(result == 1){ //수정성공
								//				   ┌> 업데이트에 관한 값을 넘겨야지 새로고침이 일어난다.
		response.sendRedirect("./EmpManager10.jsp?mode=update"); //성공하면 페이지를 경유함. //sendRedirect: 페이지를 이동 시킴. 새로운 요청으로 인지한다. url이 변한다. 이전에 페이지의 데이터는 유지되지 않는다.
	} else { //수정실패
		response.sendRedirect("./empInsertFail.jsp"); // 페이지 열리기 전 db 경유함
	}
%>