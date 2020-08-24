<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 닉네임 중복검사</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<h2>닉네임 중복 검사</h2>
	<form action="<%=request.getContextPath() %>/checkNickNameMyPage.me" id="nickNameCheckForm" >
		<input type="text" id="inputNickName" name="inputNickName">
		<input type="submit" value="중복확인">
	</form>
	

	<%
	
	if(request.getAttribute("result")!=null){ //만일 닉네임 중복여부 결과값이 null이 아니라면
		int result=(int)request.getAttribute("result");
		if(result>0){ // 중복된 닉네임
	%>
			<span style="color:red;">이미 사용하고 있는 닉네임 입니다!</span>
	<%	}else{ %>
			<span style="color:blue;">사용가능한 닉네임 입니다!</span>
	<%	} %>
	<%} %>
	
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
			//id가 updateForm(memberUpdateForm.jsp)인 부모창에서 닉네임(name이 nickName)입력값을 불러온다.
			let inputNickNameValue= $('#inputNickName');
			inputNickNameValue.val(opener.document.updateForm.nickName.value);
			
		}else{
			$('#inputNickName').val("<%=request.getAttribute("checkedNickName")%>");
		}
		
		//확인버튼을 클릭하면 함수를 실행한다.
		$('#usedNickName').click(function(){
			let inputNickNameValue= $('#inputNickName').val();
			console.log(inputNickNameValue);
			
			// 아이디가 nickName에 해당하는 태그의 값에 입력한 닉네임의 값을 넣는다.
			//vanilla js) opener.document.updateForm.nickName.value
			//jquery) $('#parentId', opener.document).val()
			$('#updateForm', opener.document).find('#nickName').val(inputNickNameValue);
			self.close();
		});
		
	});
	
	</script>

</body>
</html>