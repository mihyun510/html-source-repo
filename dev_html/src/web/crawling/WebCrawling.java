package web.crawling;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class WebCrawling {
	//웹크롤링:웹페이지의 내용을 검색한다.
	void methodA() {
		//크롤링 예외처리 필수.
		try {
			//크롤링할 URL입력받기
			URL url = new URL("http://localhost:8000/day4/deptList2.jsp");
			InputStreamReader isr = new InputStreamReader(url.openStream());
			BufferedReader br = new BufferedReader(isr);
			String tags = null;
			StringBuilder sb = new StringBuilder();
			while((tags = br.readLine())!=null) {
				sb.append(tags);
			}
			System.out.println(sb.toString());
			br.close();
			//크롤링 시작 - 키(타이틀)가져오기 : 클롤링을 하여 태그에 접근하기.
			List<String> titleList = new ArrayList<String>();
			String strs[] = sb.toString().split("<th>");
			for(int i =0;i<strs.length;i++) {
				System.out.println("strs["+i+"]==>"+strs[i]);
			}
			String strs2[] = null;
			for(int i = 1; i<strs.length; i++) {
				strs2 = strs[i].split("</th>");
				titleList.add(strs2[0]);
			}
			for(String title : titleList) {
				System.out.println(title);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}
	public static void main(String[] args) {
		WebCrawling wc = new WebCrawling();
		wc.methodA();
	}
}
