package ajax.pizza;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class CustomerInfo {
	//gson를 java에서도 꺼네보기, ctrl+o = 한꺼번에 임포트하기
	
	public static void main(String[] args) {
		List<Map<String, Object>> cusList = new ArrayList<>();
		Map<String, Object> rmap = null;
		rmap = new HashMap<>();
		rmap.put("mem_name", "공효진");
		rmap.put("mem_addr", "서울시 관악구 삼성동");
		rmap.put("mem_tel", "01012345678");
		cusList.add(rmap);
		
		rmap = new HashMap<>();
		rmap.put("mem_name", "박나래");
		rmap.put("mem_addr", "서울시 관악구 봉천동");
		rmap.put("mem_tel", "01011112222");
		cusList.add(rmap);
		
		rmap = new HashMap<>();
		rmap.put("mem_name", "송해나");
		rmap.put("mem_addr", "서울시 관악구 대학동");
		rmap.put("mem_tel", "01033334444");
		cusList.add(rmap);
		
		//Gson g = new Gson();
		//Gson g = new GsonBuilder().create(); //
		Gson g = new GsonBuilder().setPrettyPrinting().create(); // setPrettyPrinting(): 가독성이 좋게 데이터를 구글에서 확인하는 포맷처럼 콘솔에서 보여준다.
		String result = g.toJson(cusList);
		
		System.out.println(result); // 콘솔에 출력하기 위한 문장.
		//out.print(result); - jsp 파일에서 브라우저에 출력하기 위한 문장. 
	}
}
