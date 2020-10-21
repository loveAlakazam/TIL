<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
	<h1 align="center">Spring에서의 Ajax 사용 테스트 페이지</h1>
	<button onclick="location.href='testtest.do'">안녕~? Hi dude?</button>

	<ol>
		<li>서버쪽 컨트롤러로 값 보내기
			<button id="test1">테스트1</button>
			<script>
				$('#test1').on('click', function(){
					$.ajax({
						url: 'test1',
						data: {name:'최은강', age: 21},
						success: function(response){
							if(response=='success'){
								alert('전송성공');
							}else{
								alert('전송실패');
							}
						}
					});
				});
			</script>
		</li>
		
		<li>컨트롤러에서 리턴하는 json객체 받아서 출력하기 1
			<button id="test2">테스트2</button>
			<div id="d2">
			
			</div>
			<script>
			$('#test2').on('click', function(){
				$.ajax({
					url: 'test2',
					success:function(response){
						console.log(response);
						$('#d2').html('번호: '+ response.number + '<br>'
										+ '제목: ' + response.title+ '<br>'
										+ '작성자: ' + response.writer+ '<br>'
										+ '내용: '+ response.content + '<br>');
					}
				});
			});
			</script>
		</li>
		
		<li>
		컨트롤러에서 리턴하는 json객체를 받아서 출력하기 2
		<button id="test3">테스트3</button>
		<div id="d3"></div>
		<script>
			$('#test3').on('click', function(){
				$.ajax({
					url:'test3',
					dataType: 'json', //데이터타입을 명시하고 보내야만, 깨지지 않는다.
					success:function(response){
						console.log(response);
						$('#d3').html('번호: '+ response.number + '<br>'
								+ '제목: ' + response.title+ '<br>'
								+ '작성자: ' + response.writer+ '<br>'
								+ '내용: '+ response.content + '<br>');
					}
				});
			});
		</script>
		</li>
		
		<li>
		컨트롤러에서 리턴하는 json배열을 받아서 출력하기
		<button id="test4">테스트4</button>
		<div id="d4"></div>
		<script>
			$('#test4').on('click', function(){
				$.ajax({
					url: 'test4',
					success:function(response){
						console.log(response);
						
						var values= $('#d4').html();
						for(var i in response){
							values+= response[i].userId+', '
									+ response[i].userPwd+', '
									+ response[i].userName+', '
									+ response[i].age+', ' 
									+ response[i].email+', '
									+ response[i].phone+'<br>';
						}
						$('#d4').html(values);
					}
				});
			});
		</script>
		</li>
		
	</ol>
	
</body>
</html>
