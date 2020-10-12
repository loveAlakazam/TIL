<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%--
	[jstl 라이브러리를 넣어야한다.]
	저장위치: WebContent/WEB-INF/lib
	
	taglibs-standard-compat-1.2.5.jar
	taglibs-standard-impl-1.2.5.jar
	taglibs-standard-jstlel-1.2.5.jar
	taglibs-standard-spec-1.2.5.jar
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<title>menubar.jsp</title>
<style>
	#welcome{background: black; text-shadow: -1px -1px 0 red, 1px -1px 0 white, -1px 1px 0 white, 1px 1px 0 white;}
	.login-area {height:100px;}
	.btn-login {height:50px;}
	.loginTable{text-align: right; float: right;}
	#logoutBtns>a{text-decoration: none; color: black;}
	#logoutBtns>a:hover{text-decoration: underline; font-weight: bold;}
	.nav-area{background: black; height: 50px;}
	.menu{
       display: table-cell; width: 250px; height: 50px; text-align: center;
       vertical-align: middle; font-size: 20px; background: black; color: white;
   	}
   	.menu:hover{background: orangered; cursor: pointer;}
</style>
</head>


<body>
	<%--
	 [변수형 태그 alias설정 ]
	 
	 ${pageContextPath.servletContext.contextPath} 값을 contextPath로 별칭을 만들겠다.
	 
	 이 contextPath를 사용할 수 있는 범위는 application(애플리케이션 전체)로 한다.
	--%>
	<c:set var="contextPath" value="${pageContext.servletContext.contextPath }" scope="application"/>
	<h1 id="welcome" align="center">Welcome to MyBatis World!!</h1>
		<br>
		
		
		<!-- ----------------------1. 회원 관련 서비스(로그인이 안된 상태) -------------------------- -->
		<div class="login-area">
			
			<!--  
			[session영역에서 로그인이 안된 상태] 
			LoginServlet.java에서 loginUser이름에 해당하는 Attribute가 null이라면 -->
			<c:if test="${empty sessionScope.loginUser}">
				<!-- 1_1. 로그인 관련 폼 만들기 -->
				<!-- post방식일 때, 매번 모든 서블릿마다 하나씩 인코딩을 해야함. => Filter -->
				<form action="${ contextPath }/login.me" method="post">
					<table class="loginTable">
						<tr>
							<td>아이디 : </td>
							<td>
								<input type="text" name="userId">
							</td>
							<td rowspan="2">
								<button id="login-btn" class="btn btn-login">로그인</button>
							</td>
						</tr>
						<tr> 
							<td>비밀번호 : </td>
							<td>
								<input type="password" name="userPwd">
							</td>
						</tr>
						<tr>
							<td colspan="3" id="logoutBtns">
								<a href="${ contextPath }/memberInsertForm.me">회원가입</a>
								<a href="${ contextPath }/findMemberForm.me">아이디/비밀번호 찾기</a>
							</td>
						</tr>
					</table>
				</form>
			</c:if>
			
			<!-- 
			[로그인 된 상태]
			로그인 user가 존재한다면 -->
			<c:if test="${!empty sessionScope.loginUser }">
				<table class="loginTable">
					<tr>
						<td colspan="2"><h3>${loginUser.userName }님, 환영합니다!</h3></td>
					</tr>
					<tr>
						<td><button onclick="location.href='${contextPath }/info.me'">내 정보 보기</button></td>
						<td><button onclick="location.href='${contextPath}/logout.me'">로그아웃</button></td>
					</tr>
				</table>
			</c:if>	  
			
		</div>
		
		<div class="nav-area" align="center">
           <div class="menu" onclick="home();">HOME</div>
           <div class="menu">공지사항</div>
           <div class="menu" onclick="board();">게시판</div>
           <div class="menu">etc.</div>
      	</div>
		
		<script>
			function home(){
				location.href="${ contextPath }";
			}
		</script>
</body>
</html>