<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="action.model.vo.Person, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>EL - Operator</title>
</head>
<body>
<%

	String str1= "안녕";
	String str2= new String("안녕");
	
	int big=10;
	int small=3;
	
	Person p1= new Person("박신우", '여', 20);
	Person p2= new Person("박신우", '여', 20);
	
	
	//pageScope에 담기
	pageContext.setAttribute("str1", str1);
	pageContext.setAttribute("str2", str2);
	
	pageContext.setAttribute("big", big);
	pageContext.setAttribute("small", small);
	
	pageContext.setAttribute("p1", p1);
	pageContext.setAttribute("p2", p2);
	
	ArrayList<String> list= new ArrayList<String>();
	list.add(str1);
	pageContext.setAttribute("list", list);
%>

<h2>EL연산</h2>
<p>
EL을 가지고 어떠한 연산 처리를 하는 것이 아닌 속성값들을 화면에 뿌리는 용도
하지만 산술연산 및 논리 연산은 지원하므로 간단한 논리연산은 자주 사용.
</p>

<h2>산술연산</h2>
10 * 7 = ${10*7 }<br>
10/3 = ${10/3 }= ${10 div 3 }<br>
15%4 = ${15%4 }= ${15 mod 4 }<br>

<h2>비교연산</h2>
<b>str1==str2(eq)</b><br>
&emsp; 스크립팅: <%= str1==str2 %><br>
<!--  el은 문자열로 비교한다. scriptlet과 다르다. -->
&emsp; el: ${ str1 ==str2 }  = ${str1 eq str2 } <br>


<b>str1!=str2(ne)</b><br>
&emsp; 스크립팅: <%= str1!=str2 %><br>
&emsp; el: ${ str1 !=str2 }  = ${str1 ne str2 } <br>


<b>greater than(gt)</b><br>
&emsp; 스크립팅: <%= big>small %><br>
&emsp; el: big > small :  ${ big>small }  = ${big gt small } <br>


<b>less than(lt)</b><br>
&emsp; 스크립팅: <%= big<small %><br>
&emsp; el: big < small :  ${ big<small }  = ${big lt small } <br>


<b>greater or equal(ge)</b><br>
&emsp; 스크립팅: <%= big>=small %><br>
&emsp; el: big >= small :  ${ big>=small }  = ${big ge small } <br>


<b>less or equal(le)</b><br>
&emsp; 스크립팅: <%= big<=small %><br>
&emsp; el: big <= small :  ${ big<=small }  = ${big le small } <br>
<br>

<h2><b>객체 비교</b></h2>
&emsp; 스크립팅: <%= p1==p2 %><br>

<!--  new 연산자로 객체를 생성해서, 주소값이 서로 다르기때문에 다르다고 나옴. 
	String은 equals()를 오버라이드를 함.
	반면, 객체는 equals()를 오버라이드하지 않고, 주소값이 같은지 다른지에따라 결정됨.
	(아무리 필드의 내용이 같더라도 객체의 주소값이 다르기때문에) 
-->
&emsp; el: ${p1==p2 }= ${p1 eq p2 }


<br>객체가 null이거나(비어있는지) 체크</b>
&emsp; el: \${empty list } = ${empty list }<br>
<br>

<b> 논리 연산자/ 부정연산자 </b>
&emsp; ${ true and true }= ${ true && true }<br>
&emsp; ${ true or false }= ${ false ||true }<br>
&emsp; ${ !(big< small) }<br>
 
</body>
</html>