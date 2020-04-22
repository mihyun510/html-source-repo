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
			position:absolute;
		}
	</style>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
		 /* $('#book_title').textbox{
				$(this).bind('keydown', function(e){
					if(e.keyCode == 13){
						$(this).textbox('setValue', $(this).val());
					}
				});
			}); */
			$('#book_title').textbox({
				alert("test");
			});
		});
	</script>
	<input id="book_title" class="easyui-textbox" style="width:300px;"/>
	<div id="d_search"></div>
</body>
</html>