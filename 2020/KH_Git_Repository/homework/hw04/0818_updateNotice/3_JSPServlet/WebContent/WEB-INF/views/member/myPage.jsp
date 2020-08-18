<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%
	Member member= (Member) request.getAttribute("member");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
.outer {
	width: 48%;
	height: 450px;
	background-color: rgba(255, 255, 255, 0.4);
	border: 5px solid white;
	margin-left: auto;
	margin-right: auto;
	margin-top: 5%;
}

#myForm td {
	text-align: center;
}

#myForm>table {
	margin: auto;
}

#updateBtn {
	background: #D1B2FF;
	color: white;
}

#goMain {
	background: #B2CCFF;
	color: white;
}
</style>
</head>

<body>
	<%@ include file="../common/menubar.jsp"%>

	<div class="outer">
		<br>
		<h2 align="center">내 정보 보기</h2>

		<form action="<%=request.getContextPath()%>/updateForm.me"
			method="post" id="myForm" name="myForm">
			<table>
				<tr>
					<td width="200px">아이디</td>
					<td width="200px">
						<%=  member.getUserId() %>
						<!--  
							<input type="text" maxlength="13" name="myId" required>
						-->
						<input type="hidden" maxlength="13" name="myId" required>
						
					</td>
				</tr>
				<tr>
					<td>이름</td>
					
					<td>
						<%= member.getUserName() %>
						<!-- <input type="text" name="myName" required>
					 -->
					 	<input type="hidden" name="myName" required>
					
					</td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td>
						<%= member.getNickName() %>
						<!--<input type="text" maxlength="15" name="myNickName" required>  -->
						<input type="hidden" maxlength="15" name="myNickName" required>
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td>
					<%=member.getPhone()==null? '-': member.getPhone() %>
					<!-- 	<input type="tel" maxlength="11" name="myPhone" placeholder="(-없이)01012345678"> -->
						<input type="hidden" maxlength="11" name="myPhone" placeholder="(-없이)01012345678">
					
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<!-- <input type="email" name="myEmail"> -->
						<%= member.getEmail()==null? '-': member.getEmail()  %>
						<input type="hidden" name="myEmail">
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<%=member.getAddress() ==null? '-': member.getAddress() %>
						<!-- <input type="text" name="myAddress"> -->
						<input type="hidden" name="myAddress">
					</td>
				</tr>
				<tr>
					<td>관심분야</td>
					<td>
					
						<%= member.getInterest()==null? '-': member.getInterest()  %>
						<input type="hidden" id="sports" name="myInterest" value="<%= member.getInterest() %>">
					</td>
				</tr>
			</table>

			<br>

			<div class="myPageBtns" align="center">
				<input id="updateBtn" type="submit" value="수정하기"> <input
					type="button" id="goMain" onclick="goMain();" value="메인으로">
			</div>
		</form>
	</div>
</body>
</html>