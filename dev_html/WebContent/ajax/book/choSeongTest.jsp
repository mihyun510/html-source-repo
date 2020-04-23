<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>초성 테스트</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
</head>
<!-- 
	    16진수
	가 - 44032
	나 - 45208
	다 - 
 -->
<body>
<div id="d_msg"></div>
<script type="text/javascript">
	function choSeongAccount(str){
		//alert("가".charCodeAt()); '가'는 16진수로 44032번?을 가지고 있음
		var cho = [
			"ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ"
			, "ㄹ","ㅁ", "ㅂ","ㅃ", "ㅅ"
			,"ㅆ", "ㅇ","ㅈ", "ㅉ", "ㅊ"
			, "ㅋ", "ㅌ","ㅍ", "ㅎ"
			];
		var code;
		var result=''; //ㅈㅂ을 반환하는 변수, [※여기서 ''빈문자열로 초기화해주지 않으면 null로 초기화가 되어 undefine이 같이 출력된다.※]
		//alert(str.charCodeAt()); //charCodeAt(): 초성을 16진수로 확인하기
		for(i = 0; i<str.length; i++){
			code = str.charCodeAt(i)-44032; //바꿔가면서 체크하기
			//alert("code");
			//$("#d_msg").append(code+" "); 7056 4116
			//배열의 인덱스를 구한다. 그래서 해당 초성을 꺼내오기.
			if(code > -1 && code < 11172) result += cho[Math.floor(code/588)]; 
		} 
		return result;
	}
	//choSeongAccount("가");
	//choSeongAccount("나");
	var a = choSeongAccount("초성모드가 아니면 아무것도 출력되지 않음"); //초성이면 빈문열임
	alert("a: "+a);
</script>
</body>
</html>