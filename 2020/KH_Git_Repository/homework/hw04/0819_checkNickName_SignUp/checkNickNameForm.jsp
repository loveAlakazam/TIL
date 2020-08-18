<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>닉네임 중복 검사</title>
</head>
<body>
	<h2>닉네임 중복 검사</h2>
	
	<%-- 
		submit버튼을 누르면 => checkNickName.me url을 요청하고
		checkNickName.me url과 매핑된 서블릿을 호출한다.
		checkNickNameServlet.java
	 --%>
	<form action="<%=request.getContextPath() %>/checkNickName.me" id="nickNameCheckForm" >
		<input type="text" id="inputNickName" name="inputNickName">
		<input type="submit" value="중복확인">
	</form>
	

	<%
		// getAttribute("result") : CheckNickNameServlet에서 입력한 닉네임이 중복인지 쿼리실행결과(result)를 불러온다. 
		if(request.getAttribute("result")!=null){
			//쿼리 실행결과문 result가 존재한다면(0이거나 1)
			int result=(int)request.getAttribute("result");
			
			if(result>0){ //중복된 아이디라면
	%>
				<span style="color: red">이미 사용하고 있는 닉네임 입니다</span>
	<% 
			}else{// 중복된 아이디가 아니라면
	%>
				<span style="color: blue">사용가능한 닉네임 입니다</span>
	<%
			}
			
		}
	%>
	
	<br>
	<br>
	
	<input type="button" id="usedNickName" value="확인" >
	<input type="button" id="cancel" value="취소" onclick="window.close();">
	<script>
	$(function(){
		//CheckedNickNameServlet.java페이지에서
		//세팅한 result와 checkedNickName을 얻는다.
		
		//요구한 checkNickName이 null이라면 
		if('<%=request.getAttribute("checkedNickName")%>'=='null')
		{
			//id가 joinForm(signUpForm.jsp)인 부모창에서 닉네임(name이 nickName)입력값을 불러온다.
			let inputNickNameValue= $('#inputNickName');
			inputNickNameValue.val(opener.document.joinForm.nickName.value);
		}else{
			$('#inputNickName').val("<%=request.getAttribute("checkedNickName")%>");
		}
		
		//확인버튼을 클릭하면 함수를 실행한다.
		$('#usedNickName').click(function(){
			let inputNickNameValue= $('#inputNickName').val();
			console.log(inputNickNameValue);
			opener.document.joinForm.nickName.value=inputNickNameValue;
			self.close();
		});
		
	});
	
	</script>

</body>
</html>