package exam0407;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class DbInsert {
	  public static void main(String[] args) { 
	    Map<String, String> crawlingMap = new HashMap<String, String>();
	    
	    crawlingMap.put("이름", "유관순");
	    crawlingMap.put("나이", "18");
	    crawlingMap.put("생년월일", "1902년 12월 16일");
	    crawlingMap.put("출생지", "천안");
	    crawlingMap.put("업적", "일제 강점기의 독립운동가");
	     
	    try {
	      //DB연결
	      Class.forName("oracle.jdbc.driver.OracleDriver");
	      String url = "jdbc:oracle:thin:@192.168.0.15:1521:orcl11";
	      String userid="scott";
	      String userpw="tiger";
	      /*① 위 접속정보 이용하여 DB연결 및 Connection객체 생성 */
	      Connection con = DriverManager.getConnection(url, userid, userpw);
	      
	      //DB연결 성공시...
	      if(con!=null){      
	        /*② insert 쿼리문 작성 */
	    	  StringBuilder sql = new StringBuilder();
	    	  sql.append("insert into exam0407(name, age, birth, contury, history)");
	    	  sql.append(" values(?,?,?,?,?)");
	        /*③ PreparedStatement 객체 생성 및 인파라미터 설정 */ 
	    	  int i = 1;
	    	  PreparedStatement psmt = con.prepareStatement(sql.toString());
	    	  Set<String> keys = crawlingMap.keySet();
		      for(String key : keys) {
		        String value = crawlingMap.get(key);
		        psmt.setString(i++, value);
		      }
		//쿼리문실행 및 반환값 확인
	        int resultNum = psmt.executeUpdate();
	        System.out.println(resultNum +"행이 입력성공");
	      }
	    }
	    catch (ClassNotFoundException ce) {
	    	System.out.println("[[ClassNotFoundException]]:"+ce.toString());
	    }
	    catch (SQLException se) { 
	    	System.out.println("[[query]]:"+ se.toString());
	    }
	    catch (Exception e) { 
	    	System.out.println("[[Exception]]:" +e.toString());
	    }
	  }
	}
