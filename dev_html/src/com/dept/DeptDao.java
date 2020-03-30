package com.dept;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sun.org.apache.regexp.internal.recompile;
import com.util.DBConnectionMgr;

public class DeptDao {
	DBConnectionMgr 	dbMgr 	= null;
	Connection 			con 	= null;
	PreparedStatement 	pstmt = null;
	ResultSet 			rs 		=null;
	
//	public List<Map<String, Object>> deptList(){
//		dbMgr = DBConnectionMgr.getInstance();
//		List<Map<String , Object>> dlist = null;
//		StringBuilder sql = new StringBuilder();
//		try {
//			sql.append("SELECT deptno, dname, loc FROM dept");
//			con = dbMgr.getConnection();
//			pstmt = con.prepareStatement(sql.toString());
//			rs = pstmt.executeQuery(); //table 생성 - Create : execute()사용
//			//parsing-DBMS 실행계획을 세운다 - 옵티마이저 - open..fetch(읽어들인 내용 메모리에 상주시킴)..close
//			//세개 컬럼은 Map에 담고 여러개의 로우는 List담기
//			dlist = new ArrayList<Map<String,Object>>();
//			Map<String, Object> rMap = null;
//			while(rs.next()) {
//				rMap = new  HashMap<>();
//				rMap.put("deptno", rs.getInt("deptno")); //DEPTNO - 키값을 대문자로 주면 
//				rMap.put("dname", rs.getString("dname"));
//				rMap.put("loc", rs.getString("loc"));
//				dlist.add(rMap); //Map => 컬럼 3개,dlist => 로우 1개가 담긴다.
//			}
//			System.out.println("dlist의 크기===> " + dlist.size());
//		} catch (SQLException e) {
//			System.out.println("[[query]]: "+sql.toString());
//		} catch (Exception e) {
//			System.out.println("[[Exception]]: "+e.toString());
//			e.printStackTrace();
//		}finally {
//			dbMgr.freeConnection(con, pstmt, rs);
//		}
//		return dlist;
//	}
	
	public List<DeptVO> deptVOList(){
		List<DeptVO> dlist = null;
		StringBuilder sql = new StringBuilder();
		dbMgr = DBConnectionMgr.getInstance();
		try {
			sql.append("SELECT deptno, dname, loc FROM dept");
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery(); //table 생성 - Create : execute()사용
			//parsing-DBMS 실행계획을 세운다 - 옵티마이저 - open..fetch(읽어들인 내용 메모리에 상주시킴)..close
			//세개 컬럼은 Map에 담고 여러개의 로우는 List담기
			dlist = new ArrayList<>();
			DeptVO dVO = null;
			while(rs.next()) {
				dVO = new  DeptVO();
				dVO.setDeptno(rs.getInt("deptno"));
				dVO.setDname(rs.getString("dname"));
				dVO.setLoc(rs.getString("loc"));
				dlist.add(dVO); //Map => 컬럼 3개,dlist => 로우 1개가 담긴다.
			}
			System.out.println("dlist의 크기===> " + dlist.size());
		} catch (SQLException e) {
			System.out.println("[[query]]: "+sql.toString());
		} catch (Exception e) {
			System.out.println("[[Exception]]: "+e.toString());
			e.printStackTrace();
		}finally {
			dbMgr.freeConnection(con, pstmt, rs);
		}
		return dlist;
	}
}
