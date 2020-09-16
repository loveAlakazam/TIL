<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String[] nameArr={"김동석", "김민태", "박재성", "윤지수"};
		request.setAttribute("developers", nameArr);
		for(String name: nameArr){
	%>
		<%=name %>		
	<%		
		}
	%>
	
	<!--  
	내가 반복문을 돌리고자 하는 대상이 필요하다 그것을 items로 칭하자
	배열의 원소 하나하나를 탐색하기위한 매개변수 d가 필요. => var로 한다.
	 -->
	<c:forEach items="${developers}" var="d">
		${d }
	</c:forEach>

</body>
</html>