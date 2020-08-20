<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<title>AJAX 페이지</title>

<style>
	.test{
		width: 300px;
		min-height: 50px;
		border: 1px solid pink;
	}
</style>
</head>
<body>
	<h1>JQuery를 통한 Ajax구현</h1>
	<h3>1. 버튼 선택시 전송값을 서버에 출력</h3>
	이름: <input type="text" id="myName">
	<button id="nameBtn">이름 전송</button>
	<script>
	$('#nameBtn').click(function(){
		let nameVal =$('#myName').val();
		console.log(nameVal);
		
		// 콘솔창 개발자 도구에서 확인.
		$.ajax({
			url: 'jQueryTest1.do',	//url요청 - jQueryTest1.do와 연결된 서블릿을 만든다.
			data: {name: nameVal}, 	// 서버에 보낼 데이터 - name파라미터값에 nameVal값을 보낸다.
			type: 'GET', 			// 타입: GET/POST
			
			success: function(data){// 요청에대한 통신이 성공할 때 실행하는 함수
				console.log('통신 성공');
			},
			
			error: function(data){// 요청에 대한 통신이 실패할때 실행
				console.log('통신 실패');
			},
			complete: function(data){// 요청성공/실패 상관없이 실행.
				console.log('통신여부 상관없이 실행되는 함수');
			}
			
		});
	});
	
	</script>
	
	<h3>2. 버튼선택 시 서버에서 보낸값을 사용자가 수신</h3>
	<button id="getServerTextBtn">서버에서 보낸값 확인</button>
	<p class="test" id="p1"></p>
	<script>
		$('#getServerTextBtn').click(function(){
			$.ajax({
				url:'jQueryTest2.do',
				type:'GET',
				data:{}, //서버로 보낼값이 없다.
				success:function(data){
					// response가 어떤형식으로 들어왔는지 확인을 위해
					// 출력을 해서 확인해보는게 좋다.
					console.log(data);
					
					$('#p1').text(data);
					
				},
				error: function(data){
					console.log(data);
				}
				
			});
			
		});
	</script>
	
	<h3>3. 서버로 기본형 전송값이 있고 결과로 문자열을 받아서 처리</h3>
	<h4>두개의 값을 더한 결과를 받아옴</h4>
	1번째 숫자: <input type="text" id="firstNum"><br>
	2번째 숫자: <input type="text" id="secondNum"><br>
	<button id="plusBtn">더하기</button>
	<p class="test" id="p2"></p>
	<script>
		$('#plusBtn').click(function(){
			let firstNum=$('#firstNum').val();
			let secondNum=$('#secondNum').val();
			
			$.ajax({
				url:'jQueryTest3.do',
				type: 'get',
				data: {firstNum: firstNum, secondNum: secondNum},
				success: function(response){
					console.log(response);
					console.log(typeof response); //String
					$('#p2').text(response);
				},
				error : function(response){
					console.log(response);
				}
			});
			
		});
	</script>
	
	<h3>4. Object형태의 데이터를 서버에 전송 - 서버에서 처리후 console.log로 출력</h3>
	학생1: <input type="text" id="student1"><br>
	학생2: <input type="text" id="student2"><br>
	학생3: <input type="text" id="student3"><br>
	<button id="studentTest">결과확인</button>
	<script>
		//버튼을 클릭했을 때 각 학생들의 이름이 서버에 전송되고
		//서버콘솔에는 학생1 이름, 학생2 이름, 학생3 이름
		$('#studentTest').click(function(){
			let student1= $('#student1').val();
			let student2= $('#student2').val();
			let student3= $('#student3').val();
			
			
			let students={
				student1: student1,
				student2: student2,
				student3: student3
			};
			
			$.ajax({
				url: 'jQueryTest4.do',
				type: 'get',
				data: students,
				success: function(response){
					console.log("통신 성공!");
				}
			});
		});
	</script>
	
	<h3>5. 서버로 기본데이터 전송, 서버에서 객체 반환</h3>
	<h4>유저번호 보내서 해당 유저정보 가져오기</h4>
	유저번호<input type="text" id="userNo"><br>
	<button id="getUserInfoBtn">정보가져오기</button>
	<p class="test" id="p3"></p>
	<textarea class="test" id="textarea3" cols="40" rows="5"></textarea>
	<script>
		$('#getUserInfoBtn').click(function(){
			let userNo= $('#userNo').val();
			$.ajax({
				url: 'jQueryTest5.do',
				type: 'get', // 타입 기본값: get (생략이 가능하다.)
				data:{userNo:userNo},
				success: function(response){
					console.log(response);
					console.log(typeof response);
					
					let resultStr='';
					if(response!=null){
						//response의 값이 object타입의 형태라면
						resultStr= '['+ response.userNo +'] 이름:'+ response['userName']+' / 국가: '+response['nation'];
					}else{
						resultStr= '해당회원이 존재하지 않습니다.';
					}
					
					$('#p3').text(resultStr);
					$('#textarea3').val(resultStr);
				}
			});
		});
	</script>
	
	<h3>6. 서버로 기본값 전송, 서버에서 리스트 객체반환</h3>
	<h4>유저번호 요청 후 해당 유저가 있으면 유저정보 반환, 없으면 전체 반환</h4>
	유저번호: <input type="text" id="userNo2">
	<button id="getUserInfoBtn2">정보 가져오기</button>
	<br>
	<br>
	<div class="test" id="p4"></div>
	<script>
		$('#getUserInfoBtn2').click(function(){
			let userNumber= $('#userNo2').val();
			
			$.ajax({
				url:'jQueryTest6.do',
				data:{userNo: userNumber},
				success: function(response){
					
					let resultStr='';
					for(let r in response){
						let now= response[r]; //object타입
						console.log(now);
						resultStr+= '['+now.userNo +'] '+ now.userName +"-"+ now.userNation;
						
						if(r< response.length-1){
							resultStr+='<br>';
						}
						
					}
					
					$('#p4').html(resultStr);
				}
				
			});
		});
	</script>
	
	
	<h3>7. 서버로 데이터를 여러개 전송할때, 서버에서 리스트 객체로 반환</h3>
	<h4>유저번호를 전송하면 현재 있는 유저 정보만 모아서 출력한다.</h4>
	<h4>10이상인 숫자는 ','로 쓸 수 없다고 설정한다.</h4>
	유저정보(번호,번호,번호): <input type="text" id="userNo3">
	<button id="getUserInfoBtn3">정보 가져오기</button><br><br>
	<textarea class="text" id="textarea5" cols="40" rows="5"></textarea>
	
	<script>
		$('#getUserInfoBtn3').click(function(){
			$.ajax({
				url:'jQueryTest7.do',
				data:{userNo: $('#userNo3').val()},
				success: function(response){
					console.log(response);
					
					let resultStr="";
					for(let r in response.list){
						let user= response.list[r];
						
						resultStr+= user.userNo + ", "+ user.userName+", "+ user.userNation;
						if(r<response['list'].length-1){
							resultStr+='\n';
						}
					}
					
					$('#textarea5').val(resultStr);
				}
			});
		});
	</script>

	<h3>8. 서버로 데이터 여러개 전송, 서버에서 맵형태의 객체 변환</h3>
	<h4>유저 번호를 전송하면 현재 있는 유저정보만을 모아서 출력한다.</h4>
	<h4>10이상의 숫자는 ','로 쓸수 없다고 가정한다.</h4>
	유저정보(이름,이름,이름): <input type="text" id="userName">
	<button id="getUserInfoBtn4">정보가져오기</button><br>
	<textarea class="test" id="textarea6" cols="40" rows="5"></textarea>
	<script>
		$('#getUserInfoBtn4').click(function(){
			$.ajax({
				url:'jQueryTest8.do',
				data: {userName: $('#userName').val()},
				success: function(response){
					console.log(response);
					
					let resultStr='';
					for(let key in response){
						//key를 가지고 데이터를 구한다.
						let user= response[key];
						resultStr+=user.userNo+', '+user.userName+', '+user.userNation;
					}
					
					$('#textarea6').val(resultStr);
				}
			});
		});
	</script>
</body>
</html>