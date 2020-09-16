<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Info</title>
</head>
<body>

	<div style="text-align: center;">
		<h3>신간 소개</h3>
		도서명: 돈의 속성<br>
		저자: 김승호<br>
		가격: 16,800원<br>
		페이지 수: 283페이지<br>
		
		<hr>
		<%-- 파일 불러오기 (기존방법) --%>
		<%@ include file="01_1_bookCopyWright.jsp" %>
			
		<%--  jsp:include로 파일을 불러오기 --%>
		<jsp:include page="01_1_bookCopyWright.jsp"></jsp:include>
	</div>
</body>
</html>