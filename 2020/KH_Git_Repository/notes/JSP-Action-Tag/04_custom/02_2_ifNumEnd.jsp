<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>if Num</title>
</head>
<body>

	<%-- test: if문의 조건문을 넣는다. 
		num1과 num2를 가지고 와서 el로 비교
		
		c:if문은 else문이 없다.
	--%>
	<c:if test="${param.num1 > pararm.num2 }">
		${param.num1 }은 ${param.num2 }보다 크다.
	</c:if>
	
	<c:if test="${param.num1 < pararm.num2 }">
		${param.num1 }은 ${param.num2 }보다 작습니다.
	</c:if>
	
	<c:if test="${param.num1 == pararm.num2 }">
		${param.num1 }은 ${param.num2 }와 같습니다.
	</c:if>


	<c:if test="${ Integer.parseInt(param.num1) > Integer.parseInt(param.num2)}">
		${param.num1 }큽니다. ${param.num2 } 보다.
	</c:if>


	<c:if test="${ Integer.parseInt(param.num1) < Integer.parseInt(param.num2)}">
		${param.num1 }작습니다. ${param.num2 } 보다.
	</c:if>
	
		<c:if test="${ Integer.parseInt(param.num1) == Integer.parseInt(param.num2)}">
		${param.num1 }과 ${param.num2 } 는 같다.
	</c:if>
</body>
</html>