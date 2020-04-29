<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사원관리 - [jEasyUI활용, 한페이지 안에 모두 코딩하기, db을 경유하지 않는경우] </title>
	<%@ include file="./JEasyUICommon.jsp" %><!-- 공통된 내용을 인클루드 디렉티브하여 사용하기 include file= :인클루드 디렉티브, include page= :인클루드-->
	<script type="text/javascript">
	//전역변수 자리이다.
	var g_address=""; //사용자가 선택한 주소정보 담기
	$.fn.datebox.defaults.formatter = function(date){
		var y = date.getFullYear();
		var m = date.getMonth()+1;
		var d = date.getDate();
		return y+'-'+(m<10 ? "0"+m:m)+'-'+(d<10 ? "0"+d:d);
	}
	//데이트박스의 날짜에 대한 포맷을 지정함.
	$.fn.datebox.defaults.parser = function(s){
		var t = Date.parse(s);
		if (!isNaN(t)){
			return new Date(t);
		} else {
			return new Date();
		}
	}
		function empINS(){
			//insert here
			alert("empINS()함수 호출 성공");
			 $('#dlg_ins').dialog('open').dialog('center').dialog('setTitle','사원입력');
		}
		function empUPD(empno){
			alert("empUDP()함수 호출 성공");
			 $('#dlg_upd').dialog('open').dialog('center').dialog('setTitle','사원편집');
		}
		function empDEL(){
			alert("empDEL()함수 호출 성공");
			 $('#dlg_del').dialog('open').dialog('center').dialog('setTitle','사원삭제');
		}
		function empnoSearch(){ //사원번호로 사원검색하는 기능.
			alert("empnoSearch 호출");
			var s_empno = $("#s_empno").val();
			$("#dg_emp").datagrid({ //검색한 값으로 화면에 다시 뿌리기 . 조건을 넣으면 검색된 결과는 한개일것임.
				url: 'jsonEmpList.jsp?empno='+s_empno
			});  
		}
		function empList(){
			$("#dg_emp").datagrid({
	            url:"./jsonEmpList.jsp"
           		,onLoadSuccess: function(data){
           			data = JSON.stringify(data); //오브젝트로 받아오는거 string으로 파싱해주기
					alert("새로고침 처리 성공: "+ data);
           		}
			});
		}
		////////////////////DataGrid에 직접 수정 모드 추가하기 시작/////////////////////////
		function getRowIndex(target){
		    var tr = $(target).closest('tr.datagrid-row');
		    return parseInt(tr.attr('datagrid-row-index'));
		}
		function editrow(target){
		    $('#dg_emp').datagrid('beginEdit', getRowIndex(target));
		}
		function deleterow(target){
		    $.messager.confirm('Confirm','Are you sure?',function(r){ //삭제버튼 cancle을 눌렀을때 나오는 경고창.
		        if (r){
		            $('#dg_emp').datagrid('deleteRow', getRowIndex(target));
		        }
		    });
		}
		function saverow(target){
		    $('#dg_emp').datagrid('endEdit', getRowIndex(target));
		}
		function cancelrow(target){
		    $('#dg_emp').datagrid('cancelEdit', getRowIndex(target));
		}
		////////////////////DataGrid에 직접 수정 모드 추가하기 끝/////////////////////////
		function zipcode_search(){
			alert("우편번호찾기 호출완료");
			//사용자가 입력한 동  정보 담기
			var u_dong = $("#dong").val(); //사용자가 입력한 동이름이 담김
			alert("u_dong:"+u_dong);
			if(u_dong == null || u_dong.length<1){
				alert("동을 입력하세요.");
				return;//여기서는 함수의 영역을 빠져나감
			} else {
				$("#dg_zipcode").datagrid({
					url:'./jsonZipCodeList.jsp?dong='+u_dong
				});
			}
		}
		//사원정보 등록 처리
		function emp_ins(){
			alert("저장 눌림");
			//form전송을 위한 코드를 추가 - 데이터전송을 from전송으로 하자.
			//화면에서 입력받은 http프로토콜을 이용해서 서버쪽으로 전송되는데 이때 유니코드로 변환
			//되어 전달됨
			//해결방법 - server.xml문서에 포트번호 설정 위치(63번라인) URIEncoding="UTF-8"
			//단, get방식에만 적용된다. post방식일때는 java코드를 활용하여 별도 처리
			$("#f_ins").attr("method", "get");
			$("#f_ins").attr("action", './empInsert.jsp');
			$("#f_ins").submit(); //this을 사용해도 되지 않을까? - 구현이 완료되면 테스트해보기
		}
		//사원정보 수정 처리
		function emp_upd(){
			alert("수정 저장 눌림");
			$("#f_upd").attr("method", "get");
			$("#f_upd").attr("action", './empUpdate.jsp');
			$("#f_upd").submit(); //this을 사용해도 되지 않을까? - 구현이 완료되면 테스트해보기
					
			alert("empno: "+empno)
			var param = "empno="+empno
			$.ajax({
				method:"post"
				,url:"./jsonEmpList.jsp"
				,data: param
				,success:function(data){
					alert("data"+data);
					$("#empno").textbox('setValue',empno);
					$("#ename").textbox('setValue',data.ENAME);
					$("#job").textbox('setValue',data.JOB);
					$("#sal").textbox('setValue',data.SAL);
					$("#comm").textbox('setValue',data.COMM);
					$("#hiredate").textbox('setValue',data.HIREDATE);
					$("#mgr").textbox('setValue',data.MGR);
					$("#deptno").textbox('setValue',DEPTNO);
				}
			});
		}
	</script>
</head>
<body>
<!--=================검색조건 추가하기 시작=====================-->
<div id="tbar_emp"><!-- form까지 같이 감싸서 js로 조작이 가능한 상태가 된다. div를 굳이 감싸는 이유 -->
	<form id="f_search">
		<table>
			<tr>
				<td width="190px">
					<label width="80px">사원번호</label>
					<input id="s_empno" name="s_empno" class="easyui-searchbox" data-options="prompt:'사원번호', searcher:empnoSearch" style="width:110px">
				</td>
			</tr>
			<tr>
				<td>
				 	 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" plain="true" onclick="empList()">사원조회</a>
				     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="empINS()">사원입력</a>
				     <a id="btn_upd" href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true">사원편집</a><!--  onclick="empUPD()" -->
				     <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="empDEL()">사원삭제</a> 
				</td>
			</tr>
		</table>
	</form>
</div>
<!--=================검색조건 추가하기 끝=====================-->
	<table id="dg_emp" class="jeasyui-datagrid"></table>
	<script type="text/javascript">
		$(document).ready(function(){//태그 스캔 완료 - js로 접근, 조작이 가능한 상태
			/* 동이름 입력 후 엔터 쳤을때 처리하기 */
			var selEmpno = 0;
			var t = $('#dong');
			t.textbox('textbox').bind('keydown', function(e){
				if (e.keyCode == 13){	// when press ENTER key, accept the inputed value.
					alert("엔터쳤을때");
					//t.textbox('setValue', $(this).val());
					$("#dg_zipcode").datagrid({
						url:'./jsonZipCodeList.jsp?dong='+$(this).val()
						,singleSelect:true	
						//선택한 로우의 우편번호와 주소 정보 읽어서 변수에 담아 담기 처리
						//여기서 말하는 row는 사용자가 선택한  row의 정보를 가지고 있다. index는 선택한 row의 인덱스이다.
						,onSelect:function(index,row){
							//아래 선택된 로우인지는 어떻게 아는 걸까? - 인덱스로 로우를 아는게 아닐까?
							//alert(row.ADDRESS+", "+row.ZIPCODE);
							g_address = row.ADDRESS; //필트명은 mybatis를 사용했으니까 꼭 대문자로 필드명을 적어야된다.
						}
						,onDblClickCell: function(index,field,value){ //value에 셀을 선택하여 그 선택된 셀의 값이 온다.
							if("ZIPCODE"==field){//너가 선택한 필드가 우편번호 셀(컬럼)을 선택한 것이니?
								//더블 클릭 이벤트를 셀을 선택했으니까 세번째 파라미터의 value는 
								//사용자가 선택한 로우에 그 셀에 값을 가짐.
								$("#zipcode").textbox('setValue',value); //셀을 집코드를 선택했기 때문에 value에는 zipcode의 값이 들어가 있다.
								$("#mem_addr").textbox('setValue',g_address);
								$("#dg_zipcode").datagrid("clearSelections");//선택한 것을 지워주자.
								$("#dlg_zipcode").dialog('close');
							}
						}
					});                                            
				}
			});
			/* 우편번호 찾기  화면에 대한 초기화 */
			$("#dg_zipcode").datagrid({ 
				title: '우편번호 찾기 검색 결과'
				,width: 500
			 	,columns:[[
				   {field:'ZIPCODE', title:'우편번호', width: 100, align:'center'}
				  ,{field:'ADDRESS', title:'주소', width: 400, align:'left'}				   
			   ]]   
			});
			$("#dlg_zipcode").dialog({
			   width: 580
			   ,height: 550
			   ,title:"우편번호검색기"
			   ,closed:true
			});
			/* 우편번호찾기 버튼 */
			$("#btn_zipcode").linkbutton({
				onClick:function(){
					//alert("우편번호찾기버튼클릭");
				 	$("#dlg_zipcode").dialog({
				 		closed: false
					}).dialog('center'); 
				}
			});
			$('#dg_emp').datagrid({
			    //url:'./jsonEmpList.jsp' DB를 바로 경유 하지 않는다.
			    title:"회원관리 - [jEasyUI활용, 한페이지 안에 모두 코딩하기, 바로 DB를 경유하지 않는 경우]"
			    ,width: 1000
			    ,height: 600
			    ,pagination: true
			    ,rownumbers: true
			    ,fitColumns: true
			    ,singleSelect: true
			    ,columns:[[
			        {field:'CK', checkbox:true , width:100, align:'center'}
			        ,{field:'EMPNO',title:'사원번호',width:100, align:'center', editor:'numberbox'} //varchar or Stirng => text로 설정 
			        ,{field:'ENAME',title:'사원이름',width:100, align:'center', editor:'text'}
			        ,{field:'JOB',title:'사원직급',width:100,align:'center', editor:'text'}
			        ,{field:'SAL',title:'급여',width:100,align:'center', editor:'numberbox'}
			        ,{field:'COMM',title:'인센티브',width:100,align:'center', editor:'numberbox'}
			        ,{field:'HIREDATE',title:'입사날짜',width:100,align:'center', editor:'text'}//hidden:'true':필요하지 않은 정보는 숨길수 있어요. 개발자들이 봐야되는 정보와 사용자가 봐야되는 정보가 구분되어 있다. 갖고는 있지만 보여주지는 않음.
			        ,{field:'MGR',title:'부서장번호',width:100,align:'center', editor:'numberbox'}
			        ,{field:'DEPTNO',title:'부서번호',width:150,align:'center'
			        	    , editor:{
			        	    	type:'combobox'
			        	    	,options:{
			        	    		valueField:'DEPTNO' //실제 서버에 넘어가는 필드, 그리고 텍스트 필드에 보여지는 값
			        	    		,textField:'DNAME'//화면에 출력되는 필드, 콤보박스의 내용에 들어가는 값
			        	    		,url:'./jsonDeptList.jsp'
			        	    		,required:true
			        	    	}////////////end of options
			        	    }////////////////end of editor
			        } //실제로 값이 넘어가는 건 번호가 넘어가지만 화면에 보여지는 것은 부서이름이 보여지게 하기 
			        ,{field:'action',title:'Action',width:100,align:'center'
			        	    , formatter:function(value,row,index){
		                    if (row.editing){
		                        var s = '<a href="javascript:void(0)" onclick="saverow(this)">Save</a> ';
		                        var c = '<a href="javascript:void(0)" onclick="cancelrow(this)">Cancel</a>';
		                        return s+c; //'안녕'||'내일봐'와 같은 의미 s와 c를 붙혀서 써주세요.
		                    } else {
		                        var e = '<a href="javascript:void(0)" onclick="editrow(this)">Edit</a> ';
		                        var d = '<a href="javascript:void(0)" onclick="deleterow(this)">Delete</a>';
		                        return e+d;
		                    }
		                }
		            }
			    ]]
				,onEndEdit:function(index,row){
					var ed = $(this).datagrid('getEditor', {
						index: index,
						field: 'productid'
					});
					row.productname = $(ed.target).combobox('getText');
				},
				onBeforeEdit:function(index,row){
					row.editing = true;
					$(this).datagrid('refreshRow', index);
				},
				onAfterEdit:function(index,row){
					row.editing = false;
					$(this).datagrid('refreshRow', index);
				},
				onCancelEdit:function(index,row){
					row.editing = false;
					$(this).datagrid('refreshRow', index);
				}
				,toolbar: '#tbar_emp'
				,onClickRow:function(index, row){ 
					alert("선택했네 ==> "+index+", "+row.EMPNO); //선택한 행의 사원번호 가져오기
					selEmpno = row.EMPNO;
				}
			});////////end of datagrid
			$("#btn_upd").linkbutton({
				onClick: function(){
					emp_upd(selEmpno);
				}
			});
		    //클래스로 한번에 속성주기
			/*$("#dlg_upd").dialog({ //아이디로 속성주기 dom조작 제이쿼리를 이용해서, DOM이 구성된후 id에 접근할 수 있으니 ready함수에서 속정을 주기위해 제이쿼리로 아이디로 접근하기. ,data-options=""태그로 옵션 속성수기가능
				closed:true
			});*/
		});////////////end of ready
	</script>
	<!--======================우편번호 찾기 시작 다이아로그창=========================-->
	<div id="dlg_zipcode" class="easyui-dialog" style="width:100%; max-width:600px; padding:30px 30px;">
		<input class="easyui-textbox" id="dong" name="dong" labelPosition="top" data-options="prompt: '동이름이나 주소 정보 입력...'" style="width: 210px;"/>
		<a id="btn_search" href="javascript:zipcode_search();" class="easyui-linkbutton" data-options="iconCls:'icon-search'">찾기</a> <!-- 스크립트처리하고싶다면 id를 주어서 처리하는 방법연습 href로 처리하는 방법과 script로 처리하는 방법 알긔 -->
		<div style="margin-bottom: 10px;"></div>
		<table id="dg_zipcode"></table><!-- 우편번호 찾기의 결과가 여기에 들어옴. 버튼을 누르면 검색화면이 열리도록 해보기  -->
	</div> 
	<!--======================우편번호 찾기 끝  =========================-->
	<!--========================  사원등록  시작 [서브페이지는 메인페이지보다 앞에오면 안됨]  ==================================-->
	<div id="dlg_ins" class="easyui-dialog"  data-options="closed:true, modal: true, footer: '#d_ins'" style="width: 100%; max-width: 480px; padding: 30px 60px"><!-- 반응형 웹을 위한 속성들.. -->
		<form id="f_ins">
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="empno" name="empno" label="사원번호" labelPosition="top" data-options="prompt: 'Enter a EmpNO'" style="width: 200px;"/>
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="ename" name="ename" label="사원명" labelPosition="top" data-options="prompt: 'Enter a ENAME'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="job" name="job" label="사원직급" labelPosition="top" data-options="prompt: 'Enter a JOB'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="sal" name="sal" label="급여" labelPosition="top" data-options="prompt: 'Enter a SAL'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="comm" name="comm" label="인센티브" labelPosition="top" data-options="prompt: 'Enter a COMM'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-datebox" id="hiredate" name="hiredate" label="입사날짜" labelPosition="top" data-options="prompt: 'Enter a HIREDATE'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="mgr" name="mgr" label="부서장번호" labelPosition="top" data-options="prompt: 'Enter a MGR'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-combobox" id="deptno" name="deptno" label="부서번호" labelPosition="top" style="width: 200px;"
					   data-options="prompt: 'Enter a DEPTNO'
					   				 ,valueField: 'DEPTNO'
							         ,textField: 'DNAME'
							         ,url: './jsonDeptList.jsp'
							         ,onSelect: function(rec){
							          }"/>
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="zipcode" name="zipcode" label="우편번호" labelPosition="top" data-options="prompt: 'Enter a ZIPCODE'" style="width: 200px;">
				<a id="btn_zipcode" class="easyui-linkbutton">우편번호찾기</a>
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="mem_addr" name="mem_addr" label="주소" labelPosition="top" data-options="prompt: 'Enter a ADDRESS'" style="width: 360px;">
			</div>
		</form>
			<div id="d_ins" style="margin-bottom: 10px" align="center">
			<!-- 						┌>여기에 자바스크립트 코드를 사용할 수 있음. 제이쿼리를 이용해서 사용할 수 있고 메소드를 호출할 수 있다. -->
				<a id="btn_save" href="javascript:emp_ins()" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="width: 120px;">저장</a>
				<a id="btn_close" href="javascript:$('#dlg_ins').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" style="width: 120px;">닫기</a>
			</div>
	</div>
	<!--========================  사원등록  끝    [서브페이지는 메인페이지보다 앞에오면 안됨]  ==================================-->
	<!--========================  사원수정  시작 [서브페이지는 메인페이지보다 앞에오면 안됨]  ==================================-->
	<div id="dlg_upd" class="easyui-dialog" data-options="closed:true, modal: true, footer: '#d_upd'" style="width: 100%; max-width: 480px; padding: 30px 60px"><!-- 반응형 웹을 위한 속성들.. -->
		<form id="f_upd">
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="empno" name="empno" label="사원번호" labelPosition="top" data-options="prompt: 'Enter a EmpNO'" style="width: 200px;"/>
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="ename" name="ename" label="사원명" labelPosition="top" data-options="prompt: 'Enter a ENAME'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="job" name="job" label="사원직급" labelPosition="top" data-options="prompt: 'Enter a JOB'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="sal" name="sal" label="급여" labelPosition="top" data-options="prompt: 'Enter a SAL'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="comm" name="comm" label="인센티브" labelPosition="top" data-options="prompt: 'Enter a COMM'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-datebox" id="hiredate" name="hiredate" label="입사날짜" labelPosition="top" data-options="prompt: 'Enter a HIREDATE'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="mgr" name="mgr" label="부서장번호" labelPosition="top" data-options="prompt: 'Enter a MGR'" style="width: 200px;">
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-combobox" id="deptno" name="deptno" label="부서번호" labelPosition="top" style="width: 200px;"
					   data-options="prompt: 'Enter a DEPTNO'
					   				 ,valueField: 'DEPTNO'
							         ,textField: 'DNAME'
							         ,url: './jsonDeptList.jsp'
							         ,onSelect: function(rec){
							          }"/>
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="zipcode" name="zipcode" label="우편번호" labelPosition="top" data-options="prompt: 'Enter a ZIPCODE'" style="width: 200px;">
				<a id="btn_zipcode" class="easyui-linkbutton">우편번호찾기</a>
			</div>
			<div style="margin-bottom: 10px"><!-- 반응형웹으로 발전하면서 table태그보다 div를 사용하여 여백을 주는 방식을 많이 사용 -->
				<input class="easyui-textbox" id="mem_addr" name="mem_addr" label="주소" labelPosition="top" data-options="prompt: 'Enter a ADDRESS'" style="width: 360px;">
			</div>
		</form>
		<div id="d_upd" style="margin-bottom: 10px" align="center">
			<!-- 						┌>여기에 자바스크립트 코드를 사용할 수 있음. 제이쿼리를 이용해서 사용할 수 있고 메소드를 호출할 수 있다. -->
				<a id="btn_save" href="javascript:emp_upd();" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="width: 120px;">저장</a>
				<a id="btn_close" href="javascript:$('#dlg_upd').dialog('close')" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" style="width: 120px;">닫기</a>
		</div>
	</div>
	<!--========================  사원수정  끝    [서브페이지는 메인페이지보다 앞에오면 안됨]  ==================================-->
	<!--========================  사원삭제  시작 [서브페이지는 메인페이지보다 앞에오면 안됨]  ==================================-->
	<div id="dlg_del" class="easyui-dialog" data-options="closed:true, modal: true" style="width: 100%; max-width: 480px; padding: 30px 60px"><!-- 반응형 웹을 위한 속성들.. -->
		<form id="f_del">
		삭제화면
		</form>
	</div>
	<!--========================  사원삭제  끝    [서브페이지는 메인페이지보다 앞에오면 안됨]  ==================================-->
</body>
</html>