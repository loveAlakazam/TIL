<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>01_handler</title>
</head>
<body>
	<h2>회원가입</h2>
	<form name="personFrm" action="${pageContext.request.contextPath}/handler.do"  method="post">
		<table>
			<tr>
				<td class="Mytd">성명</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td class="Mytd">성별</td>
				<td>
					<div id="radioset">
						<label for="man">남</label><input type="radio" name="gender" id="man" value="남"> 
						<label for="woman">여</label><input type="radio" name="gender" id="woman" value="여">     
					</div>
				</td>
			</tr>
			<tr>
				<td class="Mytd">나이</td>
				<td><input type="number" name="age" id="age"></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="전송" onClick="goSubmit(0);">
					<input type="button" value="전송" onClick="goSubmit(1);">
					<input type="button" value="전송" onClick="goSubmit(2);">
				</td>
			</tr>		
		</table>
		<%--사용자에게는 보이지 않으면서, form전송에는 사용할 목적의 type="hidden"에 view단 주소를 담음.--%>
		<input type="hidden" name="view">
	</form>
	
	<script type="text/javascript">
		function goSubmit(flag){
			var frm = document.personFrm; //frm=> id가 personFrm인 폼태그를 의미한다.
			if(flag == 0){
				frm.view.value = "02_scriptlet.jsp"; // input의 name이 view에 해당하는 값(value)를 세팅
			} else if(flag == 1){
				frm.view.value = "03_action.jsp";
			} else{
				frm.view.value = "04_el.jsp";
			}
			
			frm.submit();
		}
	</script>
</body>
</html>