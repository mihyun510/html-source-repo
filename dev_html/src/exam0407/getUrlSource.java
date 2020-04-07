package exam0407;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Scanner;

public class getUrlSource {
	  public static void main(String[] args) {
	    System.out.println("URL을 입력하면 해당 웹페이지의 소스를 출력합니다. ");
	    System.out.print("URL(http://포함)=>");
	    Scanner scanner = new Scanner(System.in);
	    String inputUrl = scanner.nextLine();
	    
	    try {
	      URL url = new URL(inputUrl);      
	      InputStreamReader reader = new InputStreamReader(url.openStream());
	      BufferedReader br = new BufferedReader(reader);
	      /*①*/
	      String inLine = null;
	      /*②*/
	      StringBuilder contents = new StringBuilder();
	      while((inLine = br.readLine())!=null){
	        contents.append(inLine);
	      }      
	      br.close();      
	      
	      System.out.println("HTML소스출력");
	      System.out.println(contents);
	    }
	    catch (Exception e) {
	      System.out.println("예외가 발생하였습니다.");
		}
	  }
	}
