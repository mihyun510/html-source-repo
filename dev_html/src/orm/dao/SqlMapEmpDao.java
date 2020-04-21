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
		String resource = "orm/mybatis/Configuration.xml"; //DB연동에 필요
		try {
			Reader reader = Resources.getResourceAsReader(resource); //Reader는 java것이 맞아서 임포트가능
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			//sql문을 요청하기 위한 SqlSession객체 생성하기
			SqlSession sqlSes = sqlMapper.openSession();
			elist = sqlSes.selectList("empList",pMap);
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
