<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서검색[자동완성기능 + 초성검사]</title>
	<link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css"><!-- css사용 -->
	<link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css"><!-- 아이콘 사용 -->
	<link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css"> <!-- 색 사용 -->
	<link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css"> <!-- 데모버전 사용 -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script> <!-- jquery사용 api에서 제공하는 안정화된 버전 사용-->
	<script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script> <!-- eaayui사용 -->
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script><!-- jquery 쿠기 사용 -->
	<style type="text/css">
		#d_search{
			position:absolute; /* div위치 잡아주기  default: positive*/
			border: 1px dotted black;
			background: #AACCFF;
		}
		.listIn{ /* 마우스오버시에 특정 색갈 주기 */
			background: #CCFFFF;
		}
		.listOut{
			background: #FFFFFF;
		}
	</style>
	<script type="text/javascript">
		//함수선언, 전역변수 선언 위치
		function choSeongAccount(str){ //이 함수의 테스트는 choSeongTest.jsp에서 확인가능
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
	function clearMethod(){
		//alert("clearMethod()호출")
		$("#d_search").css("backgroundColor","#FFFFFF");
		$("#d_search").css("border","none");
		$("#d_search").html(""); //화면상에서 사라짐
	}
	</script>
</head>
<body>
	<script type="text/javascript">
	//DOM구성이 완료되었을 때 
		$(document).ready(function(){
			var t = $('.textbox-f'); //#book_title로 접근가능,_easyui_textbox_input1:실제 아이디값
			t.textbox('textbox').bind('keyup', function(e){
				var v_word = $("#_easyui_textbox_input1").val().toUpperCase(); //toUpperCase(): 값을 대문자로 변경
				var choKeyword = choSeongAccount(v_word);//초성키워드를 담을 변수
				//초성 검색 구분
				if(v_word != "" && choKeyword ==""){ //단어가 빈문자열이 아니고 초성 키워드도 빈문자열이 아니면 실행 
					choMode = "Y";
				} else {
					choMode = "N";
				}
				//alert("choMode: "+choMode); 영어도 초성으로 인식. 영어가 초성임? 그치 왜냐하면 test에서 a도 빈문자열를 반환했음
				var p_word = $("#_easyui_textbox_input1").val(); //실제아이디값으로 접근해야 돔조작가능
				var param = "book_title="+p_word+"&choMode="+choMode;
				$.ajax({//스타일 다음 아작스
					method:'post'
					,url: "htmlBookList.jsp"
					,data: param
					,success: function(result){ 
						//alert("result: "+result);
						$("#d_search").css("border", "1px solid #000000");
						$("#d_search").css("background", "#FFFFFF");
						$("#d_search").css("top", $("#_easyui_textbox_input1").offset().top+ $("#_easyui_textbox_input1").offset().bottom+"px");
						$("#d_search").css("left", $("#_easyui_textbox_input1").offset().left+"px");
						$("#d_search").html(result); //text로 출력하면 태그를 그냥 보여준다. htmlBookList.jsp페이지의 내용이 담김 <=result에 담김
						var tds = document.getElementsByTagName("td");//array전환 tds=td이다 왜냐하면 td의 이름을 가지고 옴.
						for(var i=0; i<tds.length; i++){
							tds[i].onmouseover = function(){
								this.className = "listIn";//마우스 인 되었을때 클레스 이름을 부여
								//htmlBookList.jsp안에 td태그안에 특정한 속성에 접근
								var b_no = $(this).attr("id");//1,2,3,4,5 ... id가 나올 것이다. td의 id의 값이 나올 것이다. 여기서 id는 1~ 일것이다 BOOK_NO로 id를 지정했다.
								//alert("b_no====>"+b_no);
								/* 책번호로 if문의 조건구별*/
								var targetURL='';
								//해당 텍스트 클릭하면 해당 페이지로 이동하도록 아작스를 사용해서 구현해보기.
								if("1" == $(this).attr("id")){ //javascript는 ==로 문자열의 값을 비교, 자바는 equals, 아작스 안에 아작스를 사용하는 것이 가능하다.
									targerURL = 'bookSearchDetail1.jsp'; //변수를 사용해서 URL주소도 변경하면서 사용하자.
								}else if("2" == $(this).attr("id")){
									targetURL = 'bookSearchDetail2.jsp';
								}else if("3" == $(this).attr("id")){
									targetURL = 'bookSearchDetail3.jsp';
								}else if("4" == $(this).attr("id")){
									targetURL = 'bookSearchDetail4.jsp';
								}else if("5" == $(this).attr("id")){
									targetURL = 'bookSearchDetail5.jsp';
								}
								$.ajax({//아작스를 여러개 겹쳐서 사용이 가능하다.
									//method:'get'
									method:'post'
									,url:targetURL
									,success:function(result){
										//alert(result); 마우스 오버하면 그 상태의 jsp의 내용이 출력
										alert("b_no:"+b_no);
										if("1"==b_no){ //1번이 선택되면 나머지는 빈문자열로 처리
											location.href=targetURL;
										}else if("2"==b_no){
											location.href=targetURL;
										}else if("3"==b_no){
											location.href=targetURL;
										}else if("4"==b_no){
											location.href=targetURL;
										//}else if("5"==$(this).attr("id")){ 'get'방식일때
										}else if("5"==b_no){
											location.href=targetURL;
											
										}
									}
								});
								
							};//////////td
							tds[i].onmouseout = function(){
								//clearMethod(); 
								this.className = "listOut";//마우스 아웃 되었을때 클레스 이름을 부여
							}
							tds[i].onclick = function(){
								$("#_easyui_textbox_input1").val($(this).text()); //클릭이벤트를 적용시켰을대 우리가 클릭한 td박스의 값을 가져오고 문자열을 가져와서 텍스트박스의 값을 초기화한다.
								clearMethod();
							}  
						}
					}//////////end success
					,error:function(xhrObject){ //에러가 발생할 경우 응답을 
						alert(xhrObject.responseText); //text형식으로 출력해서 확인하자.
					}
				});////////end of ajax
				//$("#d_search").text(p_word); 
			});/////end of keyup : 키가 눌렀다가 때었을 때 이벤트처리
			if($("#_easyui_textbox_input1").val().length == 0){
				//alert("아무것도 없음");
				//clearMethod(); //$("#d_search").hide();
				//$("#d_search").hide(); //DOM에 대한 내용이 사라진다. 그래서 검색이 안됨.
			}
		});///////////////end of ready
	</script>
	<input id="book_title" class="easyui-textbox" style="width:400px;"/>
	<div id="d_search">조회결과처리화면</div>
</body>
<!-- 텍스트값이 clear안됨/ if문의 문제가 있음..1번의 책을 마우스오버하고 alert을 확인하면 또하나의 textbox가 생김...; -->
</html>


