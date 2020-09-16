<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="action.model.vo.Person" %>
<%--
<%
	Person person= (Person)request.getAttribute("person");
	String beverage= (String) request.getAttribute("beverage");
	int year= (int)request.getAttribute("year");
	String[] products= (String[])request.getAttribute("products");
	String book=(String) request.getAttribute("book");
	String movie=(String) request.getAttribute("movie");
	
%>  
--%>  
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL - End page</title>
</head>

<style>
	.item{
		font-weight: bold;
		color: yellowgreen;
	}
</style>
<body>

<h2>scriptlet을 통해 request객체에 저장된 데이터를 출력한다.</h2>
<%--


<h4>개인정보: <%=year %></h4>
이름: <%=person.getName() %><br>
성별: <%=person.getGender() %><br>
나이: <%=person.getNai() %><br>
<h4> 취향정보 </h4>

<%String name=person.getName();  %>
<%=name %>님이 가장 좋아하는 음료: <%=beverage %><br>
<%=name %>님이 가장 좋아하는 물건: 
<%for(int i=0; i<3; i++){
	if(!products[i].trim().equals("")){
%>
		<%=products[i] %>
<% 	
	}
%>
<%
} %><br>
<%=name %>님이 가장 좋아하는 도서: <%=book %><br>
<%=name %>님이 가장 좋아하는 영화: <%=movie %><br>
--%>

<hr>
<p>
	scriptlet 표현식을 EL로 바꾼다.
</p>

<H2>EL 의 내장객체 XXXScope를 통해 저장된 데이터를 출력하기</H2>
<h4>개인정보: (${requestScope.year})</h4>

<%-- requestScope안에 있는 person객체의 nanme필드에 저장된 값을 추출.. --%>
이름: <span style="color: orangered;">${requestScope.person.name}</span><br> 
성별: <span style="color: orangered;">${requestScope.person.gender}</span><br>
나이: <span style="color: orangered;">${requestScope.person.nai}</span><br>
<h4> 취향정보 </h4>

<span style="color:green;">${requestScope.person.name}</span>님이 가장 좋아하는 음료: ${requestScope.beverage}<br>
<span style="color:green;">${requestScope.person.name}</span>님이 가장 좋아하는 물건: 

${requestScope.products[0] }, ${requestScope.products[1] }, ${requestScope.products[2] }


<br>
<%-- 값이 null일때는 공백으로 나타냄
	EL: 넣어준값을 확인해야함.
	session/ application에서 뽑아본다.
--%>

<span style="color:green;">${requestScope.person.name }</span>님이 가장 좋아하는 도서: <span style="color:blue">${requestScope.book }</span><br>
<span style="color:green;">${requestScope.person.name }</span>님이 가장 좋아하는 영화:<span style="color:blue">${ requestScope.movie}</span><br>

<%--
	MyElServlet(/myEL.do)에서 값을 setting할때
	scope가 어디냐에따라서 불러올때도 scope에 따라 다르다.
	
	book은 session scope에서 데이터를 받았고
	movie는 application scope에서 데이터를 받았다.
	
	
	위에서 scriptlet을 쓸필요 없이 바로 불러와서 사용할 수 있다.
	
--%>
<span style="color:green;">${requestScope.person.name }</span>님이 가장 좋아하는 도서: <span style="color:blue">${sessionScope.book }</span><br>
<span style="color:green;">${requestScope.person.name }</span>님이 가장 좋아하는 영화:<span style="color:blue">${ applicationScope.movie}</span><br>


<hr>

<h2>scope를 생략하여 저장된 데이터를 출력할 수 있다.</h2>
<p>
	el내장 객체 pageScope, requestScope, sessionScope, applicationScope는 모두 생략이 가능하다.
	el은 pageScope -> requestScope -> sessionScope -> applicationScope 순으로 있는지 찾고, 확인한다.
</p>

<h4>개인정보: (${requestScope.year})</h4>

이름: <span style="color: orangered;">${person.name}</span><br> 
성별: <span style="color: orangered;">${person.gender}</span><br>
나이: <span style="color: orangered;">${person.nai}</span><br>
<h4> 취향정보 </h4>

<span style="color:green;">${person.name}</span>님이 가장 좋아하는 음료: ${beverage}<br>
<span style="color:green;">${person.name}</span>님이 가장 좋아하는 음료: ${sessionScope.beverage}<br>
<span style="color:green;">${person.name}</span>님이 가장 좋아하는 음료: ${applicationScope.beverage}<br>

<span style="color:green;">${person.name}</span>님이 가장 좋아하는 물건: 

${products[0] }, ${products[1] }, ${products[2] }
<br>
<span style="color:green;">${person.name }</span>님이 가장 좋아하는 도서: <span style="color:blue">${book }</span><br>
<span style="color:green;">${person.name }</span>님이 가장 좋아하는 영화:<span style="color:blue">${ movie}</span><br>



</body>
</html>