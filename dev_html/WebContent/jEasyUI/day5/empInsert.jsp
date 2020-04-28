<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
	
	if(request.getParameter("empno")!=null){
		empno = Integer.parseInt(request.getParameter("empno"));
	}
	ename = request.getParameter("ename");
	job = request.getParameter("job");
	if(request.getParameter("sal")!=null){
		sal = Integer.parseInt(request.getParameter("sal"));
	}
	if(request.getParameter("comm")!=null){
		comm = Integer.parseInt(request.getParameter("comm"));
	}
	hiredate = request.getParameter("hiredate");
	if(request.getParameter("mgr")!=null){//그룹코드임.
		mgr = Integer.parseInt(request.getParameter("mgr"));
	}
	if(request.getParameter("deptno")!=null){
		deptno = Integer.parseInt(request.getParameter("deptno"));
	}
	
	SqlMapEmpDao eDao = new SqlMapEmpDao();
	Map<String, Object> pmap = new HashMap();
	
	pmap.put("empno", empno);
	pmap.put("ename", ename);
	pmap.put("job", job);
	pmap.put("sal", sal);
	pmap.put("comm", comm);
	pmap.put("hiredate", hiredate);
	pmap.put("mgr", mgr);
	pmap.put("deptno", deptno);

	int result = eDao.empINS(pmap);
	//response.sendRedirect("EmpManager7.jsp"); //페이지 이동 - 새로고침을 위한 것 초기화면으로 가면 새로고침이됨.

%>