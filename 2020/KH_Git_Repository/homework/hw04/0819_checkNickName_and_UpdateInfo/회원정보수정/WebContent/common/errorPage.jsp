<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
%>
    
<%
	// scriptlet : 자바소스코드 작성할 수 있다.
	String msg= (String) request.getAttribute("msg");
%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error Page</title>
</head>
<body>
	<h1 align="center"><%= msg %></h1>
	<div align="center">
		<button onclick="history.back()">이전 페이지</button>
		<button onclick="location.href='<%= request.getContextPath() %>'">홈으로 돌아가기</button>
	</div>
</body>
</html>