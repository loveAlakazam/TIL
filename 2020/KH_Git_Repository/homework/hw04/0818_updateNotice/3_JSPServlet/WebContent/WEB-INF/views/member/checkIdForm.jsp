<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	    
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Check ID</title>
</head>
<body onload="inputValue();">
	<b>아이디 중복 검사</b>
	<br>
	<form action="<%= request.getContextPath() %>/checkId.me" id="idCheckForm">
		<input type="text" id="inputId" name="inputId">
		<input type="submit" value="중복확인"/>
	</form>
	
	<%
		if(request.getAttribute("result")!=null){
			//result값을 받는다.
			int result= (int)request.getAttribute("result");
			
			if(result>0){ //중복된아이디
	%>
				
				중복된 아이디입니다.
	<%		
			}else{//중복되지 않은 아이디
	%>			
				사용가능한 아이디입니다.
	<%
			}
		}
	%>
	
	
	<br>
	<br>
	
	<input type="button" id="usedId" value="확인" onclick="usedId();">
	<input type="button" id="cancel" value="취소" onclick="window.close();">
	<script>
		function inputValue(){
			//document.getElementById('inputId').value =opener.document.joinForm.joinUserId.value;
			//opener: 부모창(sign up form)
			//document 전체
			//거기에있는 joinForm에 있는 joinUserId의 value를 가지고온다.
			
			if('<%=request.getAttribute("checkedId")%>'== 'null'){
				document.getElementById('inputId').value=opener.document.joinForm.joinUserId.value;
				
			}else{
				document.getElementById('inputId').value="<%= request.getAttribute("checkedId") %>";
			}
		}
		
		function usedId(){
			opener.document.joinForm.joinUserId.value= document.getElementById("inputId").value; //값을 넣는다.
			
			self.close(); //닫기
		}
	</script>
</body>
</html>