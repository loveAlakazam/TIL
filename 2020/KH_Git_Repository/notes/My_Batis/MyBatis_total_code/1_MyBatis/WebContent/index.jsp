<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mybatis 실습-Index JSP</title>
</head>
<body>
	<%--표준 액션태그 --%>
	<%--기본위치: WebContent를 기준으로 위치함. --%>
	<jsp:include page="WEB-INF/views/common/menubar.jsp"/>
	<h1 align="center">Hello, MyBatis!</h1>
	<div align="center">
	
		<!--  
			contextPath: pageContext.servletContext.contextPath  
			이미지 경로: WebContent/resources/images/mybatis.png
		-->
		<img src="${pageContext.servletContext.contextPath }/resources/images/mybatis.png">
	</div>
</body>
</html>