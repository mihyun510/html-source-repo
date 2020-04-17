package project.restaurant;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

import oracle.jdbc.OracleCallableStatement; //오라클 회사가 지원하는 클래스
import oracle.jdbc.OracleTypes;

public class RestaurantDao {
	
	DBConnectionMgr   dbMgr = DBConnectionMgr.getInstance();
	Connection 		  con 	= null;
	PreparedStatement pstmt = null;
	ResultSet 		  rs 	= null;
	
	CallableStatement cstmt = null;
	OracleCallableStatement ocstmt = null;
	
	
	public RestaurantDao() {}
	
	/************************************************************************************
	 * 프로시저를 활용하여 로그인 처리하기
	 * @param mem_id : 사용자가 입력한 아이디
	 * @param mem_pw : 사용자가 입력한 비번
	 * @return
	 ************************************************************************************/
	public String login(String mem_id, String mem_pw) {
		String msg = null;
		int result = 0;
		try {
			con = dbMgr.getConnection();
			cstmt = con.prepareCall("{ call proc_login2020(?,?,?) }");
			cstmt.setString(1, mem_id); //메소드의 파라미터로 사용자가 입력한 아이디를 받아옴.
			cstmt.setString(2, mem_pw);
			cstmt.registerOutParameter(3, OracleTypes.VARCHAR); //OUT속성일때만 사용 in일때는 set을 사용, JDBCType:오라클에서 재공하는 타입을 사용해도되고 자바에서 제공하는 타입인 이것을 사용해도 된다.
			//cstmt.execute();//반환타입 - boolean
			result = cstmt.executeUpdate();//반환타입 - int
			msg = cstmt.getString(3);
			System.out.println("result:"+result+", msg:"+msg);
		} catch (SQLException se) {
			System.out.println(se.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbMgr.freeConnection(con, cstmt, rs);
		}
		return msg;
	}
	public List<Map<String , Object>> procRestList(){
		List<Map<String, Object>> mList = new ArrayList<Map<String,Object>>();
		Map<String, Object> rmap = null;
		try {
			//오라클사가 배포하는 드라이버 클래스를 스캔함
			con = dbMgr.getConnection(); //물리적으로 떨어져 있는 서버에 연결통로 확보
			//DML를 요청할 땐 PreparedStatement
			//프로시저로 요청할 땐  CallableStatement
			cstmt = con.prepareCall("{ call proc_resturant(?) }"); //프로시저를 부른다. call 명령어 사용
			//프로시저의 OUT속성을 지정함.
			cstmt.registerOutParameter(1, OracleTypes.CURSOR); //커서타입을 지정해준다. out타입임으로 오라클 밖으로 꺼내야된다.(물음표갯수, 오라클타입 커서)
			cstmt.execute(); //프로시저를 처리해달라고 오라클의 옵티마이저에게 요청
			ocstmt = (OracleCallableStatement) cstmt; //오라클이 제공하는 클래스 타입으로 변경
			rs = ocstmt.getCursor(1); //커서를 꺼낸다.
			while(rs.next()) {
				rmap = new HashMap<String, Object>();
				rmap.put("res_num", rs.getInt("res_num"));
				rmap.put("res_name", rs.getString("res_name"));
				rmap.put("res_tel", rs.getString("res_tel"));
				rmap.put("res_addr", rs.getString("res_addr"));
				rmap.put("res_hate", rs.getString("res_hate"));
				rmap.put("res_like", rs.getString("res_like"));
				rmap.put("res_photo", rs.getString("res_photo"));
				rmap.put("res_info", rs.getString("res_info"));
				rmap.put("res_time", rs.getString("res_time"));
				rmap.put("lat", rs.getDouble("lat"));
				rmap.put("lng", rs.getDouble("lng"));
				mList.add(rmap);
			}
			System.out.println(mList.size());
		} catch (SQLException se) {
			System.out.println("[[query]]: "+se.toString());
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			dbMgr.freeConnection(con, cstmt, rs);
		}
		return mList;
	}
	
	
	public int restINS(Map<String, Object> pMap) {
		int result = 0;
		StringBuilder sql = new StringBuilder();
		try {
			int i = 1;
			sql.append("insert into restaurant(res_num, res_name, res_tel, res_addr, res_hate");
			sql.append(",res_like, res_photo, res_info, res_time, lat, lng)");
			sql.append(" VALUES(SEQ_RESTAURANT_NUM.nextval,?,?,?,0,0,?,?,?,?,?)");
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(i++, pMap.get("res_name").toString());
			pstmt.setString(i++, pMap.get("res_tel").toString());
			pstmt.setString(i++, pMap.get("res_addr").toString());
			pstmt.setString(i++, pMap.get("res_photo").toString());
			pstmt.setString(i++, pMap.get("res_info").toString());
			pstmt.setString(i++, pMap.get("res_time").toString());
			pstmt.setDouble(i++, Double.parseDouble(pMap.get("lat").toString()));
			pstmt.setDouble(i++, Double.parseDouble(pMap.get("lng").toString()));
			
			result = pstmt.executeUpdate();
			System.out.println("result: "+result);
		} catch (SQLException se) {
			System.out.println("[[Query]]"+sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbMgr.freeConnection(con, pstmt);
		}
		return result;
	}
	
	public List<Map<String,Object>> restList(){
		List<Map<String, Object>> rList = new ArrayList<Map<String,Object>>();
		StringBuilder sql = new StringBuilder("");
		sql.append("SELECT res_num, res_name, res_tel, res_addr, res_hate");
		sql.append(" ,res_like, res_photo, res_info, res_time, lat, lng");
		sql.append(" FROM restaurant");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			Map<String, Object> rmap = null;
			while(rs.next()) {
				rmap = new HashMap<String, Object>();
				rmap.put("res_num", rs.getInt("res_num"));
				rmap.put("res_name", rs.getString("res_name"));
				rmap.put("res_tel", rs.getString("res_tel"));
				rmap.put("res_addr", rs.getString("res_addr"));
				rmap.put("res_hate", rs.getString("res_hate"));
				rmap.put("res_like", rs.getString("res_like"));
				rmap.put("res_photo", rs.getString("res_photo"));
				rmap.put("res_info", rs.getString("res_info"));
				rmap.put("res_time", rs.getString("res_time"));
				rmap.put("lat", rs.getDouble("lat"));
				rmap.put("lng", rs.getDouble("lng"));
				rList.add(rmap);
			}
			System.out.println(rList.size()); //5
		} catch (SQLException se) {
			System.out.println("[[query]]: "+se.toString());
		} catch (Exception e) {
			System.out.println("[[EXCEPTION]]: "+e.toString());
			e.printStackTrace();
		} finally {
			dbMgr.freeConnection(con, pstmt, rs);
		}
		return rList;
	}
	
	public List<Map<String,Object>> mapRestList(){
		List<Map<String, Object>> mrList = new ArrayList<Map<String,Object>>();
		StringBuilder sql = new StringBuilder("");
		sql.append("SELECT res_num, res_name, res_tel, res_like, res_hate, res_photo, lat, lng");
		sql.append(" FROM restaurant");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			Map<String, Object> rmap = null;
			while(rs.next()) {
				rmap = new HashMap<String, Object>();
				rmap.put("res_num", rs.getInt("res_num"));
				rmap.put("res_name", rs.getString("res_name"));
				rmap.put("res_tel", rs.getString("res_tel"));
				rmap.put("res_like", rs.getInt("res_like"));
				rmap.put("res_hate", rs.getInt("res_hate"));
				rmap.put("res_photo", rs.getString("res_photo"));
				rmap.put("lat", rs.getDouble("lat"));
				rmap.put("lng", rs.getDouble("lng"));
				mrList.add(rmap);
			}
			System.out.println(mrList.size()); 
		} catch (SQLException se) {
			System.out.println("[[query]]: "+se.toString());
		} catch (Exception e) {
			System.out.println("[[EXCEPTION]]: "+e.toString());
			e.printStackTrace();
		} finally {
			dbMgr.freeConnection(con, pstmt, rs);
		}
		return mrList;
	}
	
}
