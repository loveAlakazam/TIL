<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="member.model.vo.Member"	
%>
	
<%
	//myPage.me(MyPageServlet)에서 셋팅한 member를 가져온다.
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


		<%-- --%>
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
						<input type="hidden" maxlength="13" name="myId"  value="<%=member.getUserId() %>" required>
						
					</td>
				</tr>
				<tr>
					<td>이름</td>
					
					<td>
						<%= member.getUserName() %>
						<!-- 
							<input type="text" name="myName" required>
					 	-->
					 	<input type="hidden" name="myName" value="<%=member.getUserName() %>" required>
					
					</td>
				</tr>
				<tr>
					<td>닉네임</td>
					<td>
						<%= member.getNickName() %>
						<!--<input type="text" maxlength="15" name="myNickName" required>  -->
						<input type="hidden" maxlength="15" name="nickName" value="<%=member.getNickName() %>" required>
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td>
					<%=member.getPhone()==null? '-': member.getPhone() %>
					<!-- 	<input type="tel" maxlength="11" name="myPhone" placeholder="(-없이)01012345678"> -->
						<input type="hidden" maxlength="11" name="myPhone" value="<%=member.getPhone() %>" placeholder="(-없이)01012345678">
					
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td>
						<!-- <input type="email" name="myEmail"> -->
						<%= member.getEmail()==null? '-': member.getEmail()  %>
						<input type="hidden" value="<%=member.getEmail() %>" name="myEmail">
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td>
						<%=member.getAddress() ==null? '-': member.getAddress() %>
						<!-- <input type="text" name="myAddress"> -->
						<input type="hidden" value="<%=member.getAddress() %>" name="myAddress">
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
				<!--  
					수정하기 버튼을 누르면 => updateForm.me url을 요청하게되고
					updateForm.me url에 매핑된 서블릿(MemberUpdateFormServlet.java)이 요청을 받아들인다.
				 -->
				<input id="updateBtn" type="submit" value="수정하기"> 
				<input type="button" id="goMain" onclick="goMain();" value="메인으로">
			</div>
		</form>
	</div>
</body>
</html>