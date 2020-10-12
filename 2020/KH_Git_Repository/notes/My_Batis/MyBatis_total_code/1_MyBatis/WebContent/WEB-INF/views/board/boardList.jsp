<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<style type="text/css">
	.outer{
		width:900px; min-height:50px; padding-bottom: 50px;
		margin-left:auto; margin:auto; margin-top:50px; margin-bottom: 50px; 
	}
	#boardTable{text-align:center; margin: auto; width: 900px;}
	#boardTable th{border-bottom: 3px solid lightgray;}
	#boardTable td{border-bottom: 1px solid lightgray;}
</style>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
		
	<!------------- 0_1.로그인한 회원만 게시물 보기를 하기 위해 다음과같은 조건 추가  -------------->
	<c:if test="${empty loginUser}">
		<div class="outer">
			<br>
			<h1 align="center">게시판</h1>
						
			<!---------------- 1. 게시물 리스트 ------------------>
			<!-- 1_1. 게시물 리스트 보기  -->
			<table id="boardTable">
				<tr>
					<th>글 번호</th>
					<th>제목 </th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
				</tr>
				
				<!-- forEach를 통해 request에 담겨있는 list들을 하나씩 접근하여 출력 
					임시변수 : var
				-->
				<c:forEach items="${list }" var="board">
					<tr>
						<td>${board.bId }</td>				
						<td>${board.bTitle }</td>					
						<td>${board.nickName }</td>					
						<td>${board.bCount }</td>					
						<td>${board.bCreateDate }</td>						
					</tr>
				</c:forEach>
			</table>
			
			<!-- 1_2. 게시물 리스트 페이징 부분 -->
			<div class="pagingArea" align="center"></div>
			
			<!-----------  2. 상세보기 ------------->
			<script type="text/javascript">
				$(function(){
					$("#boardTable").find("td").mouseenter(function(){
						$(this).parents("tr").css({"background":"black", "color":"white", "cursor":"pointer"});
					}).mouseout(function(){
						$(this).parents("tr").css({"background":"none", "color":"black"});
					}).click(function(){
						var bId=$(this).parents().children("td").eq(0).text();
	
						location.href="selectOne.bo?bId="+bId;
					});
				});
			</script>
		</div>
	</c:if>
	
	<!-------------- 0_2. 로그인하지 않은경우 ---------------->
	<c:if test="${empty loginUser }">
		<!-- 로그인이 되어있지않으면 에러페이지를 포워드. -->
		<c:set var="message" value="로그인이 필요한 서비스입니다." scope="request"/>
		<jsp:forward page="../common/errorPage.jsp"/>
	</c:if>
	
	<!---------------- 3. 게시물 검색 ------------------>
	<div id="searchArea" align="center">
		<label>검색 조건</label>
		<select id="searchCondition" name="searchCondition">
			<option>-------</option>
			<option value="writer">작성자</option>
			<option value="title">제목</option>
			<option value="content">내용</option>
		</select>
		
		<input id="searchValue" type="search">
		<button onclick="searchBoard();">검색하기</button>
	</div>
	<script type="text/javascript">
		function searchBoard(){
			var searchCondition = $("#searchCondition").val();
			var searchValue = $("#searchValue").val();
			
			location.href="search.bo?searchCondition="+searchCondition+"&searchValue="+searchValue;
		}
	</script>
</body>
</html>