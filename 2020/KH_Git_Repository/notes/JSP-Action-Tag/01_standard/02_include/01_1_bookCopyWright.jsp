<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Copy Write 실습</title>
</head>
<body>
	<h2>copyRight: 이페이지의 저작권은 {}에게 있습니다.</h2>

	<%
		java.util.Date now= new java.util.Date();
		String today= String.format("%tY년 %tm월 %td일 %tA", now, now, now, now);
	%>
	
	<span style="color: yellowgreen; font-weight:bold;">
	<%= today%>
	</span>


</body>
</html>