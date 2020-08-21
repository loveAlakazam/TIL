<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SignUp Page</title>
</head>

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

#idCheck, #nickCheck {
	border-radius: 15px;
	color: white;
	background: #FFD8D8;
}

#joinForm td {
	text-align: right;
}

#joinForm tr:nth-child(1)>td:nth-child(3), #joinForm tr:nth-child(5)>td:nth-child(3)
{
	text-align: left;
}

#signUpBtn {
	background: #D1B2FF;
	color: white;
}

#goMain {
	background: #B2CCFF;
	color: white;
}

td>.must {
	color: red;
	font-weight: bold;
}

#signUpBtns {
	text-align: center;
}
</style>

<body>
	<%@ include file="../common/menubar.jsp"%>

	<div class="outer">
		<br>
		<h2 align="center">회원가입</h2>

		<form action="<%=request.getContextPath()%>/insert.me" method="post"
			id="joinForm" name="joinForm" onsubmit="return validate();">
			<table>
				<tr>
					<td width="200px">
						<label class="must">*</label> 아이디
					</td>
					<td>
						<input type="text" maxlength="13" name="joinUserId" id="joinUserId" required>
					</td>
					
					<td width="200px">
						<!-- <input type="button" id="idCheck" value="중복확인" onclick="checkId();"> -->
						<label id="idResult"></label>
					</td>
				</tr>
				<tr>
					<td><label class="must">*</label> 비밀번호</td>
					<td>
						<input type="password" maxlength="13" name="joinUserPwd" required>
					</td>
				</tr>
				<tr>
					<td><label class="must">*</label> 비밀번호 확인</td>
					<td><input type="password" maxlength="13" name="joinUserPwd2"
						required></td>
					<td><label id="pwdResult"></label></td>
				</tr>
				<tr>
					<td><label class="must">*</label> 이름</td>
					<td><input type="text" name="userName" required></td>
				</tr>
				<tr>
					<td><label class="must">*</label> 닉네임</td>
					<td>
						<input type="text" maxlength="15" name="nickName" required>
					</td>
					<td width="200px">
						<input type="button" id="nickCheck" value="중복확인" onclick="checkNickName();" >
						
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td><input type="tel" maxlength="11" name="phone"
						placeholder="(-없이)01012345678"></td>
				</tr>
				<tr>
					<td>이메일</td>
					<td><input type="email" name="email"></td>
					<td></td>
				</tr>
				<tr>
					<td>주소</td>
					<td><input type="text" name="address"></td>
					<td></td>
				</tr>
				<tr>
					<td>관심분야</td>
					<td>
						<input type="checkbox" id="sports" name="interest" value="운동"> 
						<label for="sports">운동</label> 
						
						<input type="checkbox" id="climbing" name="interest" value="등산">
						<label for="climbing">등산</label> 
						
						<input type="checkbox" id="fishing" name="interest" value="낚시"> 
						<label for="fishing">낚시</label> <input type="checkbox" id="cooking" name="interest" value="요리">
						
						
						<label for="cooking">요리</label>
						<input type="checkbox" id="game" name="interest" value="게임">
						
						<label for="game">게임</label>
						<input type="checkbox" id="etc" name="interest" value="기타"> 
						<label for="etc">기타</label>
					</td>
					<td></td>
				</tr>
			</table>

			<br clear="all">

			<div class="btns" id="signUpBtns">
				<input id="signUpBtn" type="submit" value="가입하기" > 
				<input type="button" id="goMain" onclick="goMain();" value="메인으로">
				<script>
					function goMain(){
						location.href="<%= request.getContextPath()%>";
						console.log(location.href);
					}
					
					/* function checkId(){
						//팝업창 ( url매핑이름, 팝업url아이디, 가로, 세로)
						// checkIdForm.me url에 매핑된 서블릿을 호출한다 => CheckIdFormServlet.java
						window.open("checkIdForm.me", "idCheckForm", "width=300, height=200");
					}
					 */
					
					function checkNickName(){
						//팝업창을 띄운다.
						//1번째 항: checkNickNameForm.me url에 매핑된 서블릿을 호출한다 => CheckNickNameFormServlet.java
						//2번째 항: 서블릿에서 뿌려주는 연결페이지의 폼태그의 아이디
						window.open("checkNickNameForm.me", "nickNameCheckForm", "width=300, height=200");
					}
					 
					 
					 let isUsable=false; //아이디가 사용가능한지, 안했는지 확인
					 let isIdChecked=false; //아이디가 중복체크됐는지 확인
					 //변경되거나 복사하거나 입력이 완성되면
					 $('#joinUserId').on('change paste keyup', function(){
						isIdChecked=false; 
					 });
					
					 $('#joinUserId').change(function(){
						//아이디가 변경되면, 변경된 아이디값을가져온다.
						 let userId= $('#joinUserId');
						 if(!userId || userId.val().length<4){
							 //아이디가  false or id길이가 4자리이하
							 alert('아이디는 최소 4자 이상입니다!');
							 userId.focus();
						 }else{
							 $.ajax({
								 url:'<%=request.getContextPath()%>/checkId.me',
								 type: 'post',
								 data: {userId: userId.val()},// 입력한 아이디를 넘긴다.
								 success: function(response){ //url통신이 성공하면
									 
									console.log(response); //success/fail
									
									if(response=='success'){
										$idResult=$('#idResult');
										$idResult.text('사용가능 합니다.');
										$idResult.css({'color':'green', 'float':'left', 'display': 'inline-block'});
										isUsable=true;
										isIdCheck=true;
									} else{
										$idResult=$('#idResult');
										$idResult.text('사용 불가능 합니다.');
										$idResult.css({'color':'red', 'float':'left', 'display': 'inline-block'});
										isUsable=false;
										isIdCheck=false;
									}
								 }
								 
							 });
						 }
					 });
				</script>
			</div>
		</form>
	</div>
</body>


</html>