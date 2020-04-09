package JeasyUI.member;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;
import oracle.jdbc.oracore.OracleType;
/*
 * DML(기본) - 프로시저 - MyBatis[ORM솔루션-30%이상 줄어듬]
 */
public class MemeberDAO {
	//회원목록조회 실습1 - select문
	DBConnectionMgr 	dbMgr = DBConnectionMgr.getInstance();
	
	Connection 			con   = null;
	PreparedStatement 	pstmt = null; //일반 데이터 받아오는 요원
	ResultSet		 	rs 	  = null; //일반 쿼리문이나 프로시저나 모두 필요 rs.next(), rs.previous(), rs.absolute(3)
	
	CallableStatement 		cstmt  = null; //프로시저 전담 요원 - refcursor
	OracleCallableStatement ocstmt = null;  //REFCURSOR 조작
	
	public List<Map<String, Object>> memberList(){
		List<Map<String, Object>> mList = new ArrayList<Map<String,Object>>();
		Map<String, Object> rmap = null;
		StringBuilder sql = new StringBuilder();
		try {
			sql.append("select mem_no, mem_id, mem_pw, mem_name, zipcode, mem_email, mem_addr");
			sql.append(" from member_t");
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rmap = new HashMap<String, Object>();
				rmap.put("mem_no", rs.getInt("mem_no"));
				rmap.put("mem_id", rs.getString("mem_id"));
				rmap.put("mem_pw", rs.getString("mem_pw"));
				rmap.put("mem_name", rs.getString("mem_name"));
				rmap.put("zipcode", rs.getString("zipcode"));
				rmap.put("mem_email", rs.getString("mem_email"));
				rmap.put("mem_addr", rs.getString("mem_addr"));
				mList.add(rmap);
			}
		} catch(SQLException se) {
			System.out.println("[[SQLEception]]"+se.toString());
		}
		catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbMgr.freeConnection(con, pstmt, rs);
		}
		return mList;
	}
	//회원목록조회 실습2 - 프로시저[물류,금융,회계]
	public List<Map<String, Object>> procMemList(){
		List<Map<String, Object>> mList = new ArrayList<Map<String,Object>>();
		Map<String, Object> rmap = null;
		try {
			//DBConnectionMgr 공통코드를 작성했으므로 드라이버명, 계정정보, orcl11[SID]생략
			con = dbMgr.getConnection();
			cstmt = con.prepareCall("{ call proc_memberList(?) }"); //프로시저를 부르는 예약어 call 프로시저 이름 (매개번수 갯수에따른 ?추가)
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.execute(); //프로시저를 처리 요청 메소드 호출
			//오라클에서만 제공되는 refcursor[로 데이터를 꺼내와야되기 때문에] 이므로 오라클에서 제공하는 인터페이스로 형변환하기 - 제조사마다 드라이버가 틀린것처럼 제공되는 커서가 다르다. 
			ocstmt = (OracleCallableStatement) cstmt;
			rs = ocstmt.getCursor(1); //데이터의 파싱이 끝난 프로시저의 커서를 가져와서 resultset에 전달.
			while(rs.next()) { //커서의 위치에 데이터가 있는거야? - 있다면 실행해
				rmap = new HashMap<String, Object>();
				rmap.put("mem_no", rs.getInt("mem_no"));
				rmap.put("mem_id", rs.getString("mem_id"));
				rmap.put("mem_pw", rs.getString("mem_pw"));
				rmap.put("mem_name", rs.getString("mem_name"));
				rmap.put("zipcode", rs.getString("zipcode"));
				rmap.put("mem_email", rs.getString("mem_email"));
				rmap.put("mem_addr", rs.getString("mem_addr"));
				mList.add(rmap);
			}
		} catch (SQLException se) {
			System.out.println("[[query]]"+se.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbMgr.freeConnection(con, cstmt, rs);
		}
		return mList;
	}

	public static void main(String[] args) {
		MemeberDAO mdao = new MemeberDAO();
		List<Map<String, Object>> mList = null;
		mList = mdao.procMemList();
		if(mList != null) {
			System.out.println("mList.size():"+mList.size());
		}
	}
}
