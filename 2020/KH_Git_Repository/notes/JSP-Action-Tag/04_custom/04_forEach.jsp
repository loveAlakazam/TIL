<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>for-each</title>
</head>
<body>

	<!-- for(int i=1; i<6; i++) {
			... 
		} 
	-->
	
	<!--  i라는 변수를 이용해서 반복을 한다.
		시작을 1로하고
		끝은 6으로 한다.
	 -->
	<c:forEach var="i" begin="1" end="6">
		${i }<br>
		
		<h<c:out value="${i}"/>> 
			나는 제목입니다
		</h<c:out value="${i}"/>>
		
		<h${i }>나는 반복문 입니다.</h${i }>
	</c:forEach>

	<!-- 간격(step)을 줄 수있다. -->
	<c:forEach var="i" begin="1" end="6" step="2">
		<h${i }>나는 반복문 입니다(${i })</h${i }>
	</c:forEach>
	
	<%-- 작은것부터 큰것으로 거꾸로 셋팅
	step은 0보다 작을 수 없다.
	
	<c:forEach var="i" begin="6" end="1" step="-1">
		<h${i }>나는 반복문 입니다(${i })</h${i }>
	</c:forEach>
	
	 --%>
	<c:forEach var="i" begin="1" end="6">
		<h${7-i }>너무 졸리다.(${7-i })</h${7-i }>
	</c:forEach>
	
	
	<c:forEach var="i" begin="1" end="6" varStatus="vs">
		vs.first: ${ vs.first}<br>
		vs.last: ${ vs.last}<br>
		vs.index: ${ vs.index}<br>
		vs.count: ${ vs.count}<br>
		vs.current: ${ vs.current}<br>
		<br><br>
	</c:forEach>
	
</body>
</html>