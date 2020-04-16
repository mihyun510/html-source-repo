
public class Equals {
	public static void main(String[] args) {
		String s = "안녕";
		String s1 = new String("안녕");
		/*
		 * s == s1 같니? : 객체가 같니? 주소번지가 같니? 
		 * s.Equals(s1) 같니? : 그 주소번지가 가리키느 값이 같니? 안녕이 같니?
		 */
		if(s == s1) { //System.out.println("s==s1은 다른다.");
			System.out.println("s==s1은 같다");
		} else {
			System.out.println("s==s1은 다른다.");
		}
		
		if(s.equals(s1)) { //System.out.println("s.equals(s1)은 같다.");
			System.out.println("s.equals(s1)은 같다.");
		} else {
			System.out.println("s.equals(s1)은 다르다.");
		}
	}
}
