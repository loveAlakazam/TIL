<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> URL</title>
</head>
<body>

<h2> 주문내역</h2>

<%-- url에 제시된 쿼리스트링에 대응하는 값으로 들어간다. 

07_2_urlEnd.jsp?pname=lg그램&pcount=30&option=ssd&option=gpu
pname=> param.pname으로
pcount => param.pcount으로...
--%>
상품명: ${param.pname }<br>
수량: ${param.pcount }<br>
옵션1: ${paramValues.option[0] }<br>
옵션2: ${paramValues.option[1] }<br>

</body>
</html>