package json.ui;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

public class JsonDeptList {
	public List<Map<String, Object>> getDeptList(){
		List<Map<String, Object>> deptList = new ArrayList<Map<String,Object>>();
		Map<String, Object> rmap = new HashMap<String, Object>();//1EA
		rmap.put("rno", 1);
		rmap.put("deptno", 10);
		rmap.put("dname", "총무부");
		rmap.put("loc", "인천");
		deptList.add(rmap);//List.add추가

		rmap = new HashMap<String, Object>();
		rmap.put("rno", 2);
		rmap.put("deptno", 20);
		rmap.put("dname", "영업부");
		rmap.put("loc", "서울");
		deptList.add(rmap);//List.add추가

		rmap = new HashMap<String, Object>();
		rmap.put("rno", 3);
		rmap.put("deptno", 30);
		rmap.put("dname", "개발부");
		rmap.put("loc", "제주도");
		deptList.add(rmap);//List.add추가

		return deptList;
	}
	public static void main(String[] args) {
		JsonDeptList jdl = new JsonDeptList();
		List<Map<String, Object>> deptList = jdl.getDeptList();
		Gson g  = new Gson();
		String temp = g.toJson(deptList);
		System.out.println(temp);
		/* json확장자를 갖는 파일안에 다가 넣어주면 확인한 결과를 제이슨 타입으로 웹에서 확인가능. */
	}
}
