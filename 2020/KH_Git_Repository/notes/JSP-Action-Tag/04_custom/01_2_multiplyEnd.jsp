<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%-- 태그 라이브러리를 가져온다. --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>01_2_multiplyEnd.jsp </title>
</head>
<body>
	<h1> JSTL - Core Library</h1>
	<p>
		사용할 태그 라이브러리를 선언하기 : 태그 라이브러리(taglib) 지시자를 이용
		
		prefix: 앞 첨자, 다른 태그와 구별할 수 있는 name space를 제공한다.
		
		uri: 
		- 실제 웹상의 주소가 아니다.
		- 태그 라이브러리에 나타내는 식별자를 도메인 형식으로 나타냄.
	</p>
	
	<%--[ c:set ] 	 = Core Tag
	
	- 변수를 선언한다.
	- 기본적인 scope: page
	
	01_1_multiply.html에서 값을 받아온뒤에 결과값을 출력 => el param ${}을 통해서 받는다.
	--%>
	
	<%-- 500에러 발생 
	첫번째 수: ${ param.num1 }<br>
	두번째 수: ${ param.num2 }<br>
	--%>
	
	<h3> 변수 생성</h3>
	<h2>c:set 태그</h2>
	<!--  변수 선언 / 기본 scope는page -->
	<c:set var="no1" value="${param.num1 }"></c:set>
	<c:set var="no2" value="${param.num2 }"></c:set>
	
	<!-- param으로 받아와서 출력하기 -->
	${param.num1 } x ${ param.num2} = ${param.num1 * param.num2 }<br>
	
	<!-- var를 이용하여 출력하기 -->
	${no1 } x ${no2 }= ${ no1 * no2 }<br>
	
	<!--  결과값을 var에 저장하여 나타내기 -->
	<c:set var="result" value="${no1 * no2 }"/>
	${no1 } x ${no2 }의 값은 ${result }<br>
	
	
	
	<hr>

	<h3>변수 삭제</h3>
	<h2> c:remove 태그 </h2>
	<!--  지정한 변수를 모든 scope에서 검색해서 삭제하거나 지정한 scope에서 삭제 
	
	scope에 지정된 값에서는 기본 범위는 page이다 한다.
	-->
	<c:set var="result" value="9999" scope="request"/>
	
	삭제 전 \${result } : ${result }<br> <%--(scope: page)  9999가 아닌 15가 나옴. --%>
	삭제 전 \${requestScope.result } : ${requestScope.result }<br> <%--(scope: request) 
	 result의 scope는 page보다 한단계 위인 request이기때문에 
	--%> 
	
	<br><br>

	<p>
	 c:remove var="result" 태그 적용 => 모든 scope에서 정의된 변수 삭제<br>
	 c:remove var="result" scope="request" => scope가 request에서 정의된 변수 삭제.
	</p>	
	
	
	<!--  모든 scope에서 result라는 이름을 가진 변수를 삭제 -->
	<%-- <c:remove var="result"/>--%>
	
	<c:remove var="result" scope="request"/>
	삭제 후 \${result } : ${result }<br>
	삭제 후 \${requestScope.result } : ${requestScope.result }<br> 
	
	
	
	
</body>
</html>