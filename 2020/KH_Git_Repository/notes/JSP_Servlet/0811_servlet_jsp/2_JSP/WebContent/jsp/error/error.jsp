<%-- isErrorPage="true" => 에러페이지이다. --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" 
    isErrorPage="true"
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Page</title>
</head>

<body>
	<h1 style="color: red;">에러 발생</h1>
	<%-- 
		isErrorPage="true"가 있어야
		 exception 내장 객체를 사용이 가능하다. 
	--%>
	<%= exception %><br>
	<%= exception.getMessage() %><br>
	<%= exception.getClass().getName() %>
</body>
</html>