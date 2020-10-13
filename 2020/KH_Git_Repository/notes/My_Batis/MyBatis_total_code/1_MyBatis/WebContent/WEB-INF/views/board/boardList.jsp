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
	<c:if test="${!empty loginUser}">
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
				<%-- list찍어보기 
				${list}
				--%>
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
			<div class="pagingArea" align="center">
				<!--  
				[검색을 했는지 안했는지 확인]
					
					상세검색기능을 안했을 때, loc값을 '/selectList.bo'로 한다.
					loc: /selectList.bo가 아닌
				 -->
				<c:if test="${searchValue eq null} ">
					<c:set var="loc" value="/selectList.bo" scope="page"/>
				</c:if> 
				
				<!-- 상세검색 기능을 했을 때, loc값을 '/search.bo' 로 한다. -->
				<c:if test="${searchValue ne null} ">
					<c:set var="loc" value="/search.bo" scope="page"/>
				</c:if> 
				
			
				<!-- [이전] -->
				<!--현재 페이지가 <=1 : 비활성화-->
				<c:if test="${pi.currentPage <=1}">
					[이전]
				</c:if>
				
				<c:if test="${pi.currentPage >1 }">
					<%-- 
						<c:url>을 이용하여 url 링크연결 
						loc: 현재 location: /selectList.bo
						url: contextPath를 기본적으로 포함.
					--%>
					<c:url value="${loc }" var="blistBack">
						<%--현재 위치에서 -1 --%>
						<c:param name="currentPage" value="${pi.currentPage-1 }"></c:param>
					
						<!-- 검색결과가 존재한다면=> 이전 검색결과 유지하기위해서 -->
						<c:if test="${searchValue ne null }">
							<c:param name="searchCondition" value="${searchCondition }"/>
							<c:param name="searchValue" value="${searchValue }"/>
						</c:if>
					</c:url>
					<a href="${blistBack}">[이전]</a>
				</c:if>
				
				<%--이전과 다음 사이번호 --%>
				<c:forEach var="p" begin="${pi.startPage }"  end="${pi.endPage }">
					<c:if test="${p eq pi.currentPage }" >
						<font color='red' size="4"><b>[${p }]</b></font>
					</c:if>
					
					<c:if test="${p ne pi.currentPage }">
						<c:url var="blistCheck" value="${loc }">
							<c:param name="currentPage" value="${p }"/>
						
							<!-- 검색결과가 존재한다면=> 사이 페이징 검색결과 유지하기위해서 -->
							<c:if test="${searchValue ne null }">
								<c:param name="searchCondition" value="${searchCondition }"/>
								<c:param name="searchValue" value="${searchValue }"/>
							</c:if>
						
						</c:url>
						<a href="${blistCheck }">${p }</a>
					</c:if>
				</c:forEach>
				
				
				<%--다음 --%>
				<c:if test="${pi.currentPage >= pi.maxPage}">
					[다음]
				</c:if>
				<c:if test="${pi.currentPage < pi.maxPage }">
					<c:url value="${loc }" var="blistNext">
						<c:param name="currentPage" value="${pi.currentPage+1 }"/>
					
						<!-- 검색결과가 존재한다면=> 다음 검색결과 유지하기위해서 -->
						<c:if test="${searchValue ne null }">
							<c:param name="searchCondition" value="${searchCondition }"/>
							<c:param name="searchValue" value="${searchValue }"/>
						</c:if>
					</c:url>
					<a href="${blistNext }">[다음]</a>
				</c:if>
			</div>
			
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
			// searchCondition: 검색조건
			// searchValue: 검색값
			var searchCondition = $("#searchCondition").val();
			var searchValue = $("#searchValue").val();
			
			location.href="search.bo?searchCondition="+searchCondition+"&searchValue="+searchValue;
		}
	</script>
</body>
</html>