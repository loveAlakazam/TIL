<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비교3</title>
</head>
<body>

<c:if test="${param.str1 == param.str2 }">
	${param.str1 }와 ${param.str2 }는 같다.
</c:if>


<c:if test="${param.str1 != param.str2 }">
	${param.str1 }와 ${param.str2 }는 다르다.
</c:if>


<h3> equals() 이용</h3>
<c:if test="${param.str1.equals(param.str2) }">
	${param.str1 }와 ${param.str2 }는 같다.
</c:if>


<c:if test="${!param.str1.equals(param.str2) }">
	${param.str1 }와 ${param.str2 }는 다르다.
</c:if>


<br><br>
<h3> eq, ne 사용</h3>

<c:if test="${param.str1 eq param.str2 }">
	${param.str1 }와 ${param.str2 }는 같다. (eq이용)
</c:if>


<c:if test="${param.str1 ne param.str2 }">
	${param.str1 }와 ${param.str2 }는 다르다.(ne 이용)
</c:if>

</body>
</html>