<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
//디클러레이션 <%! - 전역변수이다.
//싱글톤으로 관리한다.(서블릿-newsData_jsp.java=>HttpServlet 얘를 상속받았기 때문에 싱글톤으로 사용 - 이 객체는 계속 유지됨. - 새로고침을 당해도.) 
	int x = 1; //전역변수 이다. 전역에서 참조가능
	public String newsList(String news[]){
		//자바 성능 튜닝 팀 지적사항 - 삼성 SDS - 지방공개정보시스템
		StringBuilder sb = new StringBuilder();
		sb.append("<table width='500px' border='1'>");
		sb.append("<tr><td>"+news[0]+" > "+news[1]+"</td></tr>");
		sb.append("</table>");
		return sb.toString();
		//return "<b>"+news[1]+"</b>";
	}
%>
<%
	//int x =1; //지역변수이다. x가 변하지 않는다.
//스크립틀릿 <% - 메소드 선언 불가
	String news1[] = {"연합뉴스", "[2보] 코로나19 어제 13명 증가·총 1만674명…서울 신규확진 0명"};
	String news2[] = {"연합뉴스", "‘슬기로운 노래 실력’…조정석 음원 나올까’"};
	String news3[] = {"연합뉴스", "‘슬기로운 의사생활’, 5인방의 ‘슬기로운 식사생활’ 포스터"};
	String news4[] = {"연합뉴스", "(여자)아이들, '뮤직뱅크'서 꿈꾸던 지상파 1위 차지"};
	String news5[] = {"연합뉴스", "야나두, 코로나19 사태에 마스크 무상 지원 결정"};
	//화면에 내보내 질 코드 담기
	String datas = ""; 
	switch(x){ //선언부에서 작성한 변수와 메소드를 참조한다.
	case 1:
		datas= newsList(news1);
		x++;
		break;
	case 2:
		datas= newsList(news2);
		x++;
		break;
	case 3:
		datas= newsList(news3);
		x++;
		break;
	case 4:
		datas= newsList(news4);
		x++;
		break;
	case 5:
		datas= newsList(news5);
		x=1; //마지막 뉴스에서는 다시 처음의 뉴스로 돌아와야 된다.
		break;
	}
	out.clear();
	out.print(datas);
	
%>