package orm.dao;

import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources; //ibatis가 mybatis가 됨을 확인할 수 있음
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger; //Logger가 포함되어있다.


public class SqlMapEmpDao {
	Logger logger = Logger.getLogger(SqlMapEmpDao.class); //logger파일 사용하기, (SqlMapEmpDao.class) 객체주입을 어떤것에 해줄것인가를 결정.
	SqlSessionFactory sqlMapper = null; //파일을 배포해놨기 떄문에 사용가능. SqlSessionFactory는 java의 것이 아니다.
	
	//INSERT INTO emp VALUES(?,?,?,?,?,?,?,?)
	/********************************************************************************
	 * 사원등록하기
	 * sql문 INSERT INTO emp VALIUES(?,?,?,?,?,?,?,?)
	 * @param pMap(사원번호, 사원명, job, 급여, 인센티브, 고용날짜, 부서장번호 , 부서번호)  
	 * @return result:인서트된갯수?
	 ********************************************************************************/
	public int empINS(Map<String, Object> pMap) { //여기서는 Map이나 VO가 와야된다. 여러가지의 타입을 담기 위해서
		logger.info("empINS 호출");
		int result = 0;
		String resource = "orm/mybatis/Configuration.xml";
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSec = sqlMapper.openSession();
			result = sqlSec.insert("empINS",pMap);
			//result = sqlSec.update("empINS",pMap); 쿼리문을 id로 구별하기 때문에 insert, delete, update가 의미가 없다. delete로도 insert가 됨을 확인
			logger.info("result: "+ result); //executeUpdate():int    
			//오토커밋모드가 꺼진상태이므로 반드시 commit해주어야 한다.
			sqlSec.commit();
		} catch (Exception e) {
			e.printStackTrace(); //스택영역에 히스토리를 모두 찍어준다. 힌트가 많음.
		}
		return result;
	}
	public List<Map<String, Object>> empList(Map<String, Object> pMap){
		logger.info("empList호출성공");
		logger.debug("debug"); //가장 낮은 단계
		logger.warn("warn");   
		logger.error("error"); 
		logger.fatal("fatal"); 
		List<Map<String, Object>> elist = null;
		String resource = "orm/mybatis/Configuration.xml"; //DB연동에 필요, DB의 정보를 가지고 있는 xml파일
		try {
			Reader reader = Resources.getResourceAsReader(resource); //Reader는 java것이 맞아서 임포트가능, DB연동에 가지고 있는 xml파일을 Reader클래스로 읽어서 scan한다.
			sqlMapper = new SqlSessionFactoryBuilder().build(reader); //scan한 객체을 sqlSessionFactory안에 주입하여 디비연결를 한다.
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession(); //연결이 완료 되었다면 연결을 성공했다는 인증을 받음. 세션을 open한다.
			//									 ┌>pmap에 널값을 넣어도 출력이 되던데 결과물이 있으면 null값으로 테스트가 안되지 않나..? 생성되지 않은 객체를 넘겨도 되는것인가..?
			elist = sqlSes.selectList("empList2",pMap);	//연결 인증을 받았으니 executeQuery() 대신에 id로 selectList를 호출해서 List 결과를 받음.
			System.out.println("조회한 로우 수: "+elist.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return elist;
	}
	
	/********************************************************************************
	 * 사원수정하기
	 * sql문 UPDATE emp SET ...... WHERE 컬럼명 = 값
	 * @param pMap(사원번호)  
	 * @return int
	 ********************************************************************************/
	public int empUPD(Map<String, Object> pMap) {
		logger.info("empUPD 호출");
		int result = 0;
		String resource = "orm/mybatis/Configuration.xml";
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSec = sqlMapper.openSession();
			result = sqlSec.update("empUPD",pMap);
			logger.info("result: "+ result);
			sqlSec.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/********************************************************************************
	 * 사원삭제하기
	 * sql문 DELETE FROM 테이블명 WHERE 컬럼명 IN (값)
	 * @param String empnos[]  
	 * @return int
	 ********************************************************************************/
	public int empDEL(String empnos[]) {
		logger.info("empDEL 호출");
		int result = 0;
		String resource = "orm/mybatis/Configuration.xml";
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			List<Integer> list = new ArrayList<Integer>();
			for(int i =0; i<empnos.length;i++) {
				logger.info(empnos[i]);
				list.add(Integer.parseInt(empnos[i]));
			}
			SqlSession sqlSec = sqlMapper.openSession();
			result = sqlSec.delete("empDEL",list); //자료구조를 스트링배열에 있던것을 list로 바꿔야된다. foreach문안에 collection의 타입이 list이므로 리스트여야지 데이터가 꽂힌다.
			logger.info("result: "+ result);
			sqlSec.commit();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public static void main(String[] args) {
		SqlMapEmpDao smd = new SqlMapEmpDao();
		smd.empList(null); //조회한 로우 수: 16 조회된 갯수가 나옴.
	}
}
