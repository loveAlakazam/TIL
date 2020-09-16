<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Choose end</title>
</head>
<body>

	<c:choose>
		<c:when test="${ Integer.parseInt(param.num1) % 5==0 }">
			인형을 뽑았습니다.
		</c:when>
		
		
		<c:when test="${ Integer.parseInt(param.num1)%5==1 }">
			오토바이 장난감 를 뽑았습니다.
		</c:when>
		
		
		<c:when test="${ Integer.parseInt(param.num1)%5==2 }">
			라이터를 뽑았습니다.
		</c:when>
		
		<c:otherwise>
			<%-- 아무조건이 없다 (조건절을 제외한 나머지)
			switch-case문에서 default와 같다. --%>
			꽝입니다.
		</c:otherwise>
		
	</c:choose>
</body>
</html>