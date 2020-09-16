<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 라이브러리 fmt를 이용한다. </title>
</head>
<body>

	<h2>jstl, fmt</h2>
	<p>
		날짜 , 시간, 숫자 데이터를 출력형식을 지정하고 싶을 때 사용한다.
	</p>
	
	<h3>숫자 데이터 포맷 지정: formatNumber 태그</h3>
	숫자 그대로 출력(천단위 구분): <fmt:formatNumber value="123456789"/><br>
	<%-- 기본적으로 groupingUsed:true를 기본값으로 한다. --%>
		
	자리수가 그대로 (,)없이 나타내고 싶다면=> <fmt:formatNumber value="123456789" groupingUsed="false" /><br>
	<br>
	
	
	<b>실수값 소수점 아래 자리수 지정: pattern사용</b><br>
	<p>소수점 아래 4번째 자리에서 반올림.</p>
	<fmt:formatNumber value="1.234567"/>
	
	#을 사용하는 경우: <fmt:formatNumber value="1.234567" pattern="#.##"/><br>
	#을 사용하는 경우: <fmt:formatNumber value="1.2" pattern="#.##"/><br>
	0을 사용하는 경우: <fmt:formatNumber value="1.2" pattern="#.00"/><br>
	
	<br>
	<b>type속성을 통해서 백분률/ 통화기호 표시</b>
	<fmt:formatNumber value="0.12" type="percent"/><br>
	<fmt:formatNumber value="123456789" type="currency"/><br>	
	<fmt:formatNumber value="123456789" type="currency" currencySymbol="$" /><br>

	
</body>
</html>