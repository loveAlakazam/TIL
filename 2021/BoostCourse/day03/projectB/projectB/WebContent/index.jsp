<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="guestBook.model.vo.*, java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 등록하기 메인페이지</title>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/mainPage.css">
</head>

<body>

<div class="container">
	<h1>방명록 등록하기</h1>
	
	<div class="sub-container">
		<form action="<%=request.getContextPath() %>/insertGuest" method="post" id="insertGuestForm">
			<table id="visitorInfoTable">
				<tr class="row">
					<td class="infoLabel">이름</td>
					<td class="infoInput">
						<input type="text" name="name" id="name" placeholder="이름을 입력해주세요(ex.홍길동)">
					</td>
				</tr>
				
				<tr class="row">
					<td class="infoLabel">내용</td>
					<td class="infoInput">
						<textarea name="content" id="content" placeholder="내용을 입력해주세요." ></textarea>
					</td>
				</tr>
				<tr style="position:relative;width:350px; text-align:right">
					<td  colspan="2" style="position:absolute; right:10px;">
						<span><span id="contentLen">0</span>/100</span>
					</td>
				</tr>
			</table>
			
			<input type="button"  value="방명록 등록" id="insertBtn"/>
		</form>
	</div>


	<hr style="margin: 30px 0;">

	<h1>최근에 등록한 방명록</h1>
	
	<div class="sub-container">
		<table id="recentVisitors">
			<thead>
				<tr>
					<th class="visitDate rvh">날짜</th>
					<th class="visitorName rvh">이름</th>
					<th class="visitorContent rvh">내용</th>
				</tr>
			</thead>
			
			<tbody>
			</tbody>
		</table>
	</div>

</div>
<script>
$(function(){
	function recentGuestBook(){
		$.ajax({
			url:'recentGuestBook',
			success:function(response)
			{
				$tableBody=$('#recentVisitors tbody');
				$tableBody.html('');
				if(response==null|| response.length==0 ){
					var $tr=$('<tr>');
					var $td=$('<td colspan="3">').text('방명록이 존재하지 않습니다!');
					$tr.append($td);
					$tableBody.append($tr);
					
				}else{
					console.log(response);
					var max_len=Math.max(5, response.length);
					for(var r in response){
						var $tr='<tr>'
						$tr+='<td class="visitDate">'+response[r].date+'</td>';
						$tr+='<td class="visitorName">'+response[r].name+'</td>'
						$tr+='<td class="visitorContent">'+response[r]['content']+'</td></tr>'
						
						$tableBody.append($tr);
					}
					
					var $btn='<tr>';
					$btn+='<td colspan="3">';
					$btn+='<input type="button" value="전체 방명록 보기" id="goAll"/>'
					$btn+='</td>';
					$btn+='</tr>';
					$tableBody.append($btn);
				}
			}
		});
	}
	

	
	function cntLen(){
		let content=$('#content').val();
		if(content.length>100){
			$('#content').val(content.substring(0,100));
		}
		len.text($('#content').val().length);		
	}
	
	function nameLen(){
		let name=$('#name').val();
		if(name.length>5){
			alert('이름은 최대 5글자 입니다.');
			$('#name').val('');
		}
	}
	
	
	recentGuestBook();

	let len=$('#contentLen');
	
	$('#content').on({
		'keypress':function(e){
			cntLen();

		},'keydown':function(e){
			e.key;
			cntLen();
			//len.text($(this).val().length);

		},'keyup':function(e){
			cntLen();
		}
	});
	
	$('#name').on({
		'keypress':function(e){
			nameLen();
		},'keydown':function(e){
			nameLen();
		},'keyup':function(e){
			nameLen();
		}
	})
	
	
	$('#insertBtn').click(function(e){
		// 자바스크립트 POST 방식으로 전달하기.
		// 이름,내용 입력폼에서 글자수가 0자인 경우에 에러메시지를 나타냅니다.
		let form=$('#insertGuestForm');
		let name=$('#name');
		let content=$('#content');
		
		if(name.val().length==0){
			alert('이름을 입력해주세요.');
			return;
		}else if(name.val().length>5){
			alert('5자 이내로 다시 입력해주세요');
			name='';
			return;
		}
		
		if(content.val().length==0){
			alert('내용을 입력해주세요.');
			return;
		}
		
		form.submit();
	});
	
	
	$(document).on('click','#goAll',function(){
		location.href='<%=request.getContextPath()%>/goAllGuestBookPage';
	});

	
});
</script>
</body>
</html>