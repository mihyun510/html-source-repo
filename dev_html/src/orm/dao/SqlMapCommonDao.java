package orm.dao;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapCommonDao {
	Logger loger = Logger.getLogger(SqlMapCommonDao.class);
	SqlSessionFactory sqlMapper = null;
	String resource = "orm/mybatis/Configuration.xml";
	/*********************************************************************
	 * 주소 검색 - 우편번호 정보 조회하기
	 * @param pmap pmap.get("dong")
	 * @return List<Map<String,Object>>
	 * 업무설명: 동이름을 입력하면 조건검색을 통하여 구간검색 처리하기
	 * 작성자: kmh
	 * 2020년 04월 27일
	 *********************************************************************/
	public List<Map<String, Object>> zipcodeList(Map<String, Object> pmap){
		List<Map<String, Object>> zipcodeList = null;
		loger.info("zipcodeList 호출 성공"+pmap.get("dong"));
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSec = sqlMapper.openSession();
			zipcodeList = sqlSec.selectList("zipcodeList",pmap);
			loger.info("조회수:"+zipcodeList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return zipcodeList;
	}
	/*********************************************************************
	 * 주소 검색 - 도 정보 조회하기
	 * @param pmap
	 * @return List<Map<String,Object>>
	 * 작성자: kmh
	 * 2020년 04월 24일
	 *********************************************************************/
	public List<Map<String, Object>> getZDOList(){
		List<Map<String, Object>> zdoList = null;
		loger.info("getZDOList 호출 성공");
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSec = sqlMapper.openSession();
			zdoList = sqlSec.selectList("getZDOList");
			loger.info("조회수:"+zdoList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return zdoList;
	}
	/*********************************************************************
	 * 주소 검색 - 구 정보 조회하기
	 * @param pmap
	 * @return List<Map<String,Object>>
	 * 작성자: kmh
	 * 2020년 04월 24일
	 *********************************************************************/
	public List<Map<String, Object>> getSiGuList(Map<String, Object> pmap){
		List<Map<String, Object>> siguList = null;
		loger.info("getSiGuList 호출 성공");
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSec = sqlMapper.openSession();
			siguList = sqlSec.selectList("getSiGuList", pmap);
			loger.info("siguList크기: "+ siguList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return siguList;
	}
	/*********************************************************************
	 * 주소 검색 - 동 정보 조회하기
	 * @param pmap
	 * @return List<Map<String,Object>>
	 * 작성자: kmh
	 * 2020년 04월 24일
	 *********************************************************************/
	public List<Map<String, Object>> getDongList(Map<String, Object> pmap){
		List<Map<String, Object>> dongList = null;
		loger.info("getDongList 호출 성공");
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			SqlSession sqlSec = sqlMapper.openSession();
			dongList = sqlSec.selectList("getDongList", pmap);
			loger.info("dongList의 크기: "+dongList.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dongList;
	}
}
