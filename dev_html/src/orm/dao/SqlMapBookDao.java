package orm.dao;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapBookDao {
	Logger loger = Logger.getLogger(SqlMapBookDao.class);
	SqlSessionFactory sqlMapper = null;
	String resource = "orm/mybatis/Configuration.xml";
	/***********************************************************
	 * 도서정보 조회하기 구현
	 * @param pMap - 사용자가 자동완성 textbox에 입력한 도서제목 정보
	 * @return - 사용자가 입력한 도서정보를 선분조건(LIKE패턴)으로 검색하여 결과 반환
	 ***********************************************************/
	public List<Map<String, Object>> bookList(Map<String, Object> pMap){
		loger.info("book_title: "+pMap.get("book_title")+", choMode:"+pMap.get("choMode"));
		//25번에서 선언만 되어 있다. 따라서 검색 결과가 존재하지 않으면 NullpointException의 원인이 될 수도 있다.
		//가급적이면 에러를 피해 갈수 있도록 코딩을 전개한다.
		List<Map<String, Object>> blist = new ArrayList<Map<String,Object>>();
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSec = sqlMapper.openSession();
			blist = sqlSec.selectList("bookList", pMap);
			System.out.println("조회한 로우 수:"+blist.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return blist;
	}
}
