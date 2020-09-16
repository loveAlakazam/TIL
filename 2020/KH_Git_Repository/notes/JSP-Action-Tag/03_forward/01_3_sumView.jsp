<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>01_3_sumView.jsp</title>
</head>
<body>
	<%
		
		String firstNum= request.getParameter("firstNum");

		String secondNum= request.getParameter("secondNum");
		
		int result= (int) request.getAttribute("result");
	%>
	
	<%=firstNum %> 부터 <%=secondNum %>까지의 합은?
	결과값: <span style="color: pink;"><%=result %> </span>

</body>
</html>