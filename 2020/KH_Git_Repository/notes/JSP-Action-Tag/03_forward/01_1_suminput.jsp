<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sum-input</title>
</head>
<body>
	<h2>입력한 2개의 수 사이의 값을들 더한 누적 값 구하기</h2>
	<form action="01_2_sumCalc.jsp">
		첫번째 수: <input type="text" name="firstNum"><br>
		두번째 수: <input type="text" name="secondNum"><br>
		<button>계산하기</button> <%-- 01_2_sumCalc.jsp로 넘어감 --%>
	</form>

</body>
</html>