<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//여기는 톰캑서버 내부에서처리되는 코드이고
	//처리된 결과만이 클라이언트 측으로 다운로드 됨.
	if(1==1) out.print("나야");
%>
<script>
	//부모의 함수를 호출하기 - javascript로 처리
	//처리주체가 사용자의 컴퓨터가 된다.
	opener.location.href="javascript:fun();";
	self.close(); //열렸다가 바로 스스로 닫김.
</script>