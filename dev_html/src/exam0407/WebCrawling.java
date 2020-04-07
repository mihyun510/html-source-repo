package exam0407;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class WebCrawling{
	  public static void main(String[] args) {
	    try {      
	      //크롤링할 URL 입력
	      URL url = new URL("http://localhost:8000/exam0407/sample1.jsp");
	 
	      //입력스트림 생성
	      InputStreamReader reader = new InputStreamReader(url.openStream());
	      BufferedReader br = new BufferedReader(reader);
	      String inLine = null;
	      StringBuffer contents = new StringBuffer();
	  
	      //URL을 통해 가져온 HTML 내용을 라인단위로 읽어 변수에 저장
	      while((inLine = br.readLine())!=null){
	        contents.append(inLine);
	      }
	  
	      //모든 내용을 읽어들인후 스트림 소멸
	      br.close();
	      
	      //크롤링 시작 - 키(타이틀)
	      ArrayList<String> titleList = new ArrayList();
	      /*①*/
	      String thArray1[] = contents.toString().split("<th>");
	      for(int i=1 ; i<thArray1.length ; i++){      
	        String[] thArray2 = thArray1[i].split("</th>");
	        titleList.add(thArray2[0]);
	      }
	      //크롤링 시작 - 값(데이터)
	      ArrayList<String> dataList = new ArrayList();
	      String[] tdArray1 = contents.toString().split("<td>");
	      for(int i=1 ; i<tdArray1.length ; i++){
	        String[] tdArray2 = tdArray1[i].split("</td>");
	        dataList.add(tdArray2[0]);
	      }
	      //Map컬렉션에 저장
	      Map<String, String> crawlingMap = new HashMap<String, String>();
	      for(int i=0 ; i<dataList.size() ; i++){
	        /*②*/
	    	  crawlingMap.put(titleList.get(i), dataList.get(i));
	      }      
	      //저장된 내용 출력
	      Set<String> keys = crawlingMap.keySet();
	      for(String key : keys) {
	        String value = crawlingMap.get(key);
	        System.out.println(String.format("%s:%s", key, value));
	      }
	    }
	    catch (Exception e) {
	      e.printStackTrace();
	    }
	  }
	}
