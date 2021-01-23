<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
	import="java.util.*, guestBook.model.vo.GuestBook"    
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%

ArrayList<GuestBook> glist= (ArrayList<GuestBook>)request.getAttribute("glist");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 방명록 조회하기</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/allGuestBook.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.2/css/all.css" integrity="sha384-vSIIfh2YWi9wW0r9iZe7RJPrKwp6bG+s9QZMoITbCckVJqGCCRhc+ccxNcdpHuYu" crossorigin="anonymous">

</head>
<body>




<div id="vContainer">
<h1>전체 방명록 조회하기</h1>

<c:if test="${glist eq null || fn:length(glist)==0}">
	방명록이 존재하지 않습니다.
	<br>
</c:if>
<c:if test="${glist ne null }">
	<c:forEach var="v" items="${glist }">
		<table class="vTable">
			
			<tr>
				<th class="label">번호</th>
				<td class="input">${v.gid }</td>
			</tr>
			<tr>
				<th class="label">등록 날짜</th>
				<td class="input">
					<fmt:formatDate value="${v.uDate }" pattern="yyyy년 MM월 dd일 E요일 HH시 mm분"/>
				</td>
			</tr>
			<tr>
				<th class="label">이름</th>
				<td class="input">${v.name }</td>
			</tr>
			<tr>
				<th class="label">내용</th>
				<td class="input content">${v.content }</td>
			</tr>
		</table>
	</c:forEach>
</c:if>


<c:url var="goMain" value="goMainPage"/>
<button id="goMainBtn" onclick="location.href='<%=request.getContextPath() %>/${goMain}'">메인 페이지로</button>
</div>

<div id="goToTop">
	<i id="goToTopBtn" class="fas fa-sort-up"></i>
</div>
<script>
$(function(){
	let scrollBtn=$('#goToTop');
	let upBtn= $('#goToTopBtn');

	$('#goToTop').on({
		mouseover:function(){
			$(this).css('background-color', '#315e5b');
			$(this).css('cursor', 'pointer');
			upBtn.css('color', '#fff');
			
		},
		mouseout:function(){
			$(this).css('background-color', '#b6dedb');
			$(this).css('cursor', 'none')
			upBtn.css('color','#111');
		}
	});
	
	
	$(window).scroll(function(){
		//현재 스크롤의 위치
		let topPos=$(this).scrollTop();
		
		//스크롤 위치가 100을 넘으면
		if(topPos>100){
			scrollBtn.css('opacity', 1); //화면에 나타남
		}else{
			scrollBtn.css('opacity', 0); //화면에 숨김
		}
	});
	
	// 버튼 클릭시, 페이지 최상단으로 올라감
	$(scrollBtn).click(function(e){
		$('html, body').animate({
			scrollTop:0
		}, 800);
		return false;
	});
});

</script>

</body>
</html>
