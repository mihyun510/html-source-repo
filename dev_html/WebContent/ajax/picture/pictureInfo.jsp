<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//책 82참고
	//get방식
	//:노출 - query string - 주소창에 노출
	//:전송시에 헤더영역에 값이 전달됨.
	//:link를 걸 수 있다.
	//:전송크기에 제한이 있다.(브라우저 마다 달라. 256kb)
	//:url에 직접 작성해서 요청을 정송할 수 있다.
	//ex) a.jsp?mem_id=test&mem_pw=123
	//	  location.href="c.jsp?mem_id=tomato";
	//	  ajax({ url:'a.jsp'});
	//	  response.sendRedirect("b.jsp"); //get방식
	
	//post방식
	//:전송크기에 제한이 없다.
	//:단위테스트가 불가함. 
	//:자바스크립트 도움이 있어야만 전송이 가능함.
	//ex) <form method="post">, $("f_login").attr(method, "post"); 이런 방식이 아니고서야 테스트 불가능.
	//:url에 직접 작성하는 것은 모두가 get방식이다.
	
	//화면이 없어도 단위테스트가 가능해야된다.
	//디자이너가 내 페이지를 내 페이지를 아직 못 만들었어도 나는 코딩할 수 있다.
	//클래스 쪼개기를 잘해야 야근을 피해요...
	
	//192.168.0.244:8000/dev_html/ajax/pictureInfo.jsp?id=picture2.jpg
	String img = request.getParameter("id"); //id를 비교해서 이미지의 이름정보를 가져온다.	
	//picture2.jpg 처럼 찍힐 것이다.
	//out.print("img:"+img); //여기서 가져온 이미지 정보가 뭐니 ? 찍어보자.
	String imgs[] = {"picture1.jpg", "picture2.jpg", "picture3.jpg", "picture4.jpg"};
	
	String cimg = null;
	for(int i = 0; i<imgs.length; i++){
		//equals: 값를 비교한다. ==: 객체를 비교한다.
		if(img.equals(imgs[i])){
			cimg = imgs[i];
		}
	}
%>

<img src="./<% out.print(cimg); %>" width='400px' height='270px' border="1">

















