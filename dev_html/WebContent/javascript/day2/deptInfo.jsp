<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//JSON포맷을 javascript코드에서 활용하기 연습
	out.print("[{\"AGE\":\"34\",\"NAME\":\"박나래\",\"PNAME\":\"나혼자산다\"},"); //json파일 jsp파일로 흉내내기 오류발생
	out.print(" {\"AGE\":\"28\",\"NAME\":\"아이유\",\"PNAME\":\"호텔델루나\"},"); //json파일 jsp파일로 흉내내기 오류발생
	out.print(" {\"AGE\":\"31\",\"NAME\":\"박새로이\",\"PNAME\":\"이태원클래스\"}]"); //json파일 jsp파일로 흉내내기 오류발생
%>