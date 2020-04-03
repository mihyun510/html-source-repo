package project.restaurant;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

public class RestaurantDao {
	
	DBConnectionMgr   dbMgr = DBConnectionMgr.getInstance();
	Connection 		  con 	= null;
	PreparedStatement pstmt = null;
	ResultSet 		  rs 	= null;
	
	public RestaurantDao() {
		// TODO Auto-generated constructor stub
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
		sql.append("SELECT res_name, res_photo, lat, lng");
		sql.append(" FROM restaurant");
		try {
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			Map<String, Object> rmap = null;
			while(rs.next()) {
				rmap = new HashMap<String, Object>();
				rmap.put("res_name", rs.getString("res_name"));
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
