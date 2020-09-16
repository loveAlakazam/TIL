<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>URL </title>
</head>
<body>

<a href="07_2_urlEnd.jsp?pname=lg그램&pcount=30&option=ssd&option=gpu">07_2_urlEnd.jsp (쿼리스트링)</a>
<hr>
 
 
<!--  17~33번째 라인 사이의 모든 것을 통틀어서  u라는 변수에 저장한다. -->
<c:url value="07_2_urlEnd.jsp" var="u">

	<%-- param은  query string의 역할을 한다.
		url에 제시되어있는 쿼리스트링 역할을하며
		데이터를 출력할페이지(07_2_urlEnd.jsp)에서는 이를 통해서 데이터를 가져와서 출력.
		
		쿼리스트링 name=> pname, pcount, option ...
		쿼리스트링 name에 대응되는 값 => value속성의 값.
	 --%>
	<c:param name="pname" value="LG gram"/>
	
	<c:param name="pcount" value="50"/>
	
	<c:param name="option" value="ssd"/>
	
	<c:param name="option" value="cpu icore7"/>
</c:url>

<a href="${u }">07_2_urlEnd.jsp(jstl)</a>

</body>
</html>