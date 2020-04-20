<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Vector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.util.DBConnectionMgr"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//여기서 바로 값을 받아올려면 함수을 사용하지 않고 바로 작성
	DBConnectionMgr dbmgr = DBConnectionMgr.getInstance();
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	StringBuilder sql = new StringBuilder("");
	Vector<Map<String,Object>> v = new Vector<>();
	Map<String, Object> rmap = null;
	try{
		sql.append("select mem_name, 0 as ck from member_t");
		con = dbmgr.getConnection();
		pstmt = con.prepareStatement(sql.toString());
		rs = pstmt.executeQuery();
		while(rs.next()){
			rmap = new HashMap<>();
			rmap.put("mem_name", rs.getString("mem_name"));
			rmap.put("ck", rs.getInt("ck"));
			v.add(rmap);
		}
	}catch(SQLException se){
		System.out.println(se.toString());
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbmgr.freeConnection(con, pstmt, rs);
	}
	
	Gson g = new Gson();
	String imsi = g.toJson(v);
	out.print(imsi);
	
%>