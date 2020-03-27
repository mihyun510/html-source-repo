package json.ui;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.util.DBConnectionMgr;

public class EmpListDao {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
	
	public List<Map<String, Object>> empList(){
		StringBuilder sql = new StringBuilder("");
		try {
			sql.append("Select empno, ename, job, mgr, hiredate, comm, deptno from emp");
			
			con = dbMgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			Map<String, Object> rmap = null;
			while(rs.next()) {
				rmap = new HashMap<String, Object>();
				rmap.put("empno", rs.getInt("empno"));
				rmap.put("ename", rs.getString("ename"));
				rmap.put("job", rs.getString("job"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
}
