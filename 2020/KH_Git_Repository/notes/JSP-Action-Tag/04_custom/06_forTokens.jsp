<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tokens</title>
</head>

<body>
	<c:set var="developers">김동석, 김민태, 박재성, 윤지수</c:set>

	<!--  어떤걸 돌릴 것인가 
		dlims: 구분자
	-->
	<c:forTokens items="${ developers}" delims=", " var="d">
		${d }
	</c:forTokens>
	<br>
	
	<c:set var="familiesMultiDelimeter">
		신형만,봉미선/신짱구.신짱아,둘리 도우너.또치/희동이,고길동
	</c:set>
	
	<c:forTokens items="${familiesMultiDelimeter}" delims=", ./" var="f">
		${f }
	</c:forTokens>
	
</body>
</html>