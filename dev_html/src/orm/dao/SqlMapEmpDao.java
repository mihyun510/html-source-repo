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
	
	public static void main(String[] args) {
		SqlMapEmpDao smd = new SqlMapEmpDao();
		smd.empList(null); //조회한 로우 수: 16 조회된 갯수가 나옴.
	}
}
