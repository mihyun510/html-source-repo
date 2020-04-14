<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String db_id = "test";
	String db_pw = "123";
	String db_name = null;
//스크립틀릿에서 선언한 변수는 모두 다 지역변수임.
	String u_id = request.getParameter("mem_id");
	String u_pw = request.getParameter("mem_pw");
	
	if(db_id.equals(u_id)){//아이디가 존재하니?
		if(db_pw.equals(u_pw)){//비번은?
			/* $.cookie("c_name", db_name);
			//로그인이 성공했으므로 d_login은 숨기고 d_logout를 보여줌.
			$("#d_login").hide();
			$("#d_logout").show(); 쿠키에서 할일은 여기서 안한다*/
			db_name = "공효진";
		}else{
			db_name="비밀번호가 틀렸습니다.";
			//alert("비번이 틀렸습니다.");
			//$("#mem_pw").password('setValue',''); html에서 사용하는 문장 여기서는 사용안한다.
		}
	}else{//아이디가 없네
		//alert("아이디가 없습니다.");
		db_name="아이디가 없습니다.";
	}
	
	out.print(db_name); //자바코드는  개발자도구에서 확인하지 못한다. 그러나 브라우저에 출력하는 문장인 out.print만 보인다.
%>
