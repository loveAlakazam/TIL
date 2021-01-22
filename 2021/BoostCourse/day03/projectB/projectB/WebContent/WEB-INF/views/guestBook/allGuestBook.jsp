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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/allGuestBook.css">
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

</body>
</html>