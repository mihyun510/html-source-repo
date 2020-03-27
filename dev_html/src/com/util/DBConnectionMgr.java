package com.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

//공동으로 사용할 속성 모아놓기
public class DBConnectionMgr {
	
	//선언부
//	Connection con = null;
	//이 클래스를 읽어야 오라클 제품인것을 확인가능함
	public static final String _DRIVER = "oracle.jdbc.driver.OracleDriver";//oracle.jdbc.driver패키지이름
	//물리적으로 떨어져 있는 오라클 서버에 URL정보 추가 //여기 컴퓨터가 켜져있어야 접근가능,orcl11 sd아이디?
	public static final String _URL = "jdbc:oracle:thin:@192.168.0.15:1521:orcl11"; //서버가 이전하면 ip주소가 바뀜 -> 나 자신의 ip말고 
	//계정이 있어야 게임서버에 접속가능, 사원이 퇴사하면 바꿔야 되니 final은 아님
	public static String _USER = "bank";
	public static String _PW = "tiger"; //오라클 회사에서 만들어서 제공해주는 driver임. 오라클 서버에 접근하기 위한 사전준비 코드
	//물리적으로 떨어져 있는 오라클 서버와 연결통로를 만들 때 사용하는 클래스 
	//static - 클래스 급이다. - 공유(하나다)
	private static DBConnectionMgr dbMgr = null;
	public static Connection con = null;
	public PreparedStatement pstmt = null; //패키지 이름 java.sql.
	//오라클에 살고있는 커서를 조작하는 클래스를 제공함.
	//커서 위치에 로우가 존재하면 true, 조회된 결과가 없으면 false리턴 - if사용 sql를 사용하면 결과가 하나여서
	//java.lang폴더를 제외하고는 모두 다 import해주어야 JVM이 그 클래스를 찾음.
	public ResultSet rs = null;
	private DBConnectionMgr() {}
	//싱글톤 패턴으로 객체 관리하기 - 인스턴스화 과정이다.
	public static DBConnectionMgr getInstance() {
		if(dbMgr == null) {
			dbMgr = new DBConnectionMgr(); //한번도 인스턴스화가 되지 않았다면 인스턴스화 진행, null이 아닐때는 그냥 있는거 써라
		}
		return dbMgr;
	}
	//커넥션가져오기
	//프리페어스테이트먼트 준비
	//쿼리 준비
	//
	//물리적으로 떨어져 있는 오라클 서버와 연결통로 만들기
	//인스턴스화를 해주는 메소드 구현
	public Connection getConnection() {
		System.out.println("getConnention호출 성공");
		//오라클 회사정보를 수정함.
		try {
			Class.forName(_DRIVER); //오라클 제조사 제품정보 드라이버 이름이 런타임오류가 날수있으니 예외처리 해주어야됨.
			//con = new Connection(); 반드시 구현체 클래스가 있어야한다. 
			con = DriverManager.getConnection(_URL, _USER, _PW);//DriverManager.getConnection(_URL, _USER, _PW) 반환타입이 connetion
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 클래스 이름을 찾을 수 없어요"); //정상적으로 진행이 안되면 잡음 잡힌다면 출력
		} catch (Exception e) {
			System.out.println("예외가 발생했음. 정상적으로 처리가 안됨.");
		}
		return con; //con이 null이 아닌 주소번지를참조하고 있다면 오라클 디비연동이 잘 이루어졌다.
	}
	/* DBConnectionMgr은 여러 업무에서 공통으로 사용하는 클래스 입니다.
	 * 사용한 자원(Connection, PreparedStatement, ResultSet)은 
	 * 반드시 반납을 하도록 합니다.
	 * 동시 접속자 수가 많은 시스템에서 자원사용은 곧 메모리랑 직결되므로
	 * 서버가 다운되거나 시스템 장애 발생에 원인이 됩니다.
	 */
	public void freeConnection(Connection con,PreparedStatement pstmt, ResultSet rs) {
		try {
			//사용자원의 생성 역순으로 반환할것.
			if(rs!=null) {
				rs.close();
			}
			if(pstmt!=null) {
				pstmt.close();
			}
			if(con!=null){
				con.close();
			}
		}catch(Exception e) {
			System.out.println("Exception : "+e.toString());
		}
	}
	//자바에서는 같은 이름의 메소드를 여러개 만들 수 있다.
	//1)메소드 오버로딩 - 파라미터갯수, 타입
	//2)메소드 오버라이딩 - 상속) 기능이 다름
	public void freeConnection(Connection con,PreparedStatement pstmt) {
		try {
			//사용자원의 생성 역순으로 반환할것.
			if(rs!=null) {
				rs.close();
			}
			if(pstmt!=null) {
				pstmt.close();
			}
			if(con!=null){
				con.close();
			}
		}catch(Exception e) {
			System.out.println("Exception : "+e.toString());
		}
	}
}
