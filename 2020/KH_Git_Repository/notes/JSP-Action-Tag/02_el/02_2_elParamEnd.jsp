<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String pname=request.getParameter("pname");
String pcount=request.getParameter("pcount");
String []options= request.getParameterValues("option");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL- Param end</title>
</head>
<body>

<h2>주문 내역 (scriptlet으로 표현)</h2>
상품명: <%=pname %><br>
수량: <%=pcount %><br>
옵션1: <%=options[0] %><br>
옵션2: <%=options[1] %><br>


<hr>

<h2>주문 내역 (EL 으로 표현)</h2>
<%-- 
	각 SCOPE를 뒤져서 가져온다. 
	param: parameter을 통해서 값을 가져왔음을 명시한다.
	
	getParameter("pname"); 
	pname이름에 대응되는 값을 불러옴.
--%>
상품명: ${param.pname}<br>
수량: ${param.pcount }<br>

<%--
options는 getParameterValues()로 가져왔으므로..
	paramValues 로 해야한다.
	
	getParameterValues("option")
	paramValues의 option 이름에 대응되는 값들을 불러옴.
--%>
옵션1: ${paramValues.option[0] }<br>
옵션2: ${paramValues.option[1]}<br>




</body>
</html>