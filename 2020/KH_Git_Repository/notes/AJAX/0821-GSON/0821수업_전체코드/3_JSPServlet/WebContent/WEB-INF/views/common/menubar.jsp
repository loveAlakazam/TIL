<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="member.model.vo.Member"	
%>
	
	
<%
	//로그인한 유저가 있는지 확인한다
	Member loginUser= (Member)session.getAttribute("loginUser");
	
	//회원가입 메시지를 세션으로부터 전달받는다.
	String msg=(String) session.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP & Servlet</title>
<%-- <script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery-3.5.1.min.js"></script>
--%>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
body {
	background: url('<%=request.getContextPath()%>/images/bg.png') no-repeat
		center center fixed;
	background-size: cover;
}

.loginArea {
	float: right;
}

#loginTable {
	text-align: right;
}

#loginTable td:nth-child(1) {
	padding-right: 15px;
}

.loginBtns {
	float: right;
	margin-left: 5px;
}

#loginBtn, #myPage {
	background: #D1B2FF;
}

#joinBtn, #logout {
	background: #B2CCFF;
}

input[type=button], input[type=submit] {
	cursor: pointer;
	border-radius: 15px;
	color: white;
}

#userInfo label {
	font-weight: bold;
}


.wrap{
	background: white;
	width: 100%;
	height: 50%;
}

.menu{
	background: white;
	color: navy;
	text-align: center;
	font-weight: bold;

	vertical-align: middle;
	width: 150px;
	height: 50px;
	display: table-cell;
}

nav{
	width: 600px;
	margin-left: auto;
	margin-right: auto;
}

.menu:hover{
	background:beige;
	color: orangered;
	font-weight: bold;
	cursor: pointer;
}



</style>
</head>

<body>
	<h1 align="center">Welcome to JSP&amp;Servlet World!</h1>

	<div class="loginArea">
		<%-- 로그인이 안되어있을 때 적용한다. --%>
		<% if(loginUser==null){ %>
			<%-- annotaion을 이용하여 url을 매핑하여, 매핑한 url을 불러온다. --%>
			<form id="loginForm" action="<%=request.getContextPath()%>/login.me"
				method="post" onsubmit="return validate();">
				<table id="loginTable">
					<tr>
						<td><label>ID</label></td>
						<td><input type="text" name="userId" id="userId"></td>
					</tr>
					<tr>
						<td><label>PWD</label></td>
						<td><input type="password" name="userPwd" id="userPwd"></td>
					</tr>
				</table>
				<div class="loginBtns">
					<input type="submit" id="loginBtn" value="로그인">
					<input type="button" id="joinBtn" value="회원가입" onclick="memberJoin();">
				</div>
			</form>
		<%}else{ %>  <%--userLogin이 null이 아닐때 --%>
			<div id="userInfo" align="right">
				<label><%= loginUser.getUserName() %>님의 방문을 환영합니다.</label>
				<br clear="all">
				<div class="loginBtns">
					<input type="button" id="myPage" value="내 정보 보기" 
						onclick="location.href='<%=request.getContextPath() %>/myPage.me'">
						
						
					<input type="button" id="logout" value="로그아웃" onclick="logout();">
				</div>
			</div>
		<%} %>
	</div>
	<br clear="all">
	<br>
	
	
	<div class="wrap">
		<nav>
			<div class="menu" onclick="goHome();">Home</div>
			<div class="menu" onclick="goNotice();">공지사항</div>
			<div class="menu" onclick="goBoard();">게시판</div>
			<div class="menu" onclick="goThumbnail();">사진 게시판</div>
		</nav>
	</div>
	
	<script>
		function logout(){
			location.href="<%= request.getContextPath()%>/logout.me";
		}
		
		function validate(){
			var id=$('#userId');
			var pwd= $('#userPwd');
			if(id.val().trim().length==0){
				alert('아이디를 입력해주세요!');
				id.focus();
				return false;//로그인 실패
			}
			
			if(pwd.val().trim().length==0){
				alert('비밀번호를 입력해주세요!');
				pwd.focus();
				return false;//로그인 실패
			}
			
			return true; //로그인 성공
		}
		
		function memberJoin(){
			location.href="<%= request.getContextPath() %>/signUpForm.me";
		}
		
		//메시지
		let msg='<%= msg%>'; //null(메시지없음), not null(메시지 있음)
		$(function(){
			if(msg!='null'){
				alert(msg);
			}
		});
		
		
		function goHome(){
			location.href="<%= request.getContextPath() %>";
		}
		
		function goNotice(){ //공지사항 페이지로 이동 - 공지사항 페이지: /list.no
			location.href="<%= request.getContextPath()%>/list.no";
		}
		
		function goBoard(){
			location.href="<%= request.getContextPath()%>/list.bo";
		}
		
		function goThumbnail(){
			location.href="<%= request.getContextPath()%>/list.th";
		}
	</script>
</body>
</html>
