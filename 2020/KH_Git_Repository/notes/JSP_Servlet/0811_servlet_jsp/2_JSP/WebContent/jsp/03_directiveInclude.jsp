<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"

	import="java.util.Date"    
%>

<%--
	Date now= new Date();
	String today= String.format("%tY년%tm월%td일%tA", now, now, now, now);
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오늘날짜 표시</title>
</head>
<body>
	<h2>오늘 날짜
		<span style="color: lightgray">
			<%--<%= today %>--%>
			
			<%-- today: 중복된 지역변수 --%>
			<%@ include file="today.jsp" %>
		</span>
	</h2>
	
	<%
	//겹쳐서 안됨.
	//	String today="호우주의보";
	%>
</body>
</html>