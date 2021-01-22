<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러페이지</title>
</head>
<body>

<div>
	<h1>에러페이지</h1>
	<p>에러내용: ${msg }</p>
	<button onclick="history.back()">이전 페이지로 돌아가기</button>
	<button onclick="location.href='<%=request.getContextPath() %>'">홈으로 돌아가기</button>
</div>

</body>
</html>