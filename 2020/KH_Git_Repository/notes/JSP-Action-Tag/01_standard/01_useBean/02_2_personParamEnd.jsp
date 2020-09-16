<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//02_1_personParam.jsp에서 폼에서 입력받은 데이터를 여기서 가지고온다. 
	request.setCharacterEncoding("UTF-8");
	String name= request.getParameter("name");
	String nai= request.getParameter("nai");
	String gender= request.getParameter("gender");
	
	System.out.println(name);
	System.out.println(nai);
	System.out.println(gender);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>param 실습하기: 데이터 전송</title>
</head>
<body>



<%-- 
* view => view로 넘어감
* view => servlet으로 넘어감
이는,  getParameter()을 이용해서 데이터를 받아온다.

02_1_personParam.jsp에서 입력한 데이터를 전달받아서 여기에 표현
 --%>
 
 <h2>JSP표준액션 태그중 useBean의 param속성 이용하기</h2>
 <jsp:useBean id="person" class="action.model.vo.Person">
 	<%-- scriptlet에 정의된 name을 person의 name필드에 사용. --%>
<%--
	<jsp:setProperty property="name" name="person" param="name"/>
 	<jsp:setProperty property="gender" name="person" param="gender"/>
 	<jsp:setProperty property="nai" name="person" param="nai"/> 


	2. 부분필드를 setting/ param을 생략하고 표현
	param 속성을 기입하지 않더라도 param을 통해서 알아서 기입
	name에 해당하는 객체(person)의 property에 해당 객체의 속성을 넣는다.
	굳이 param 필요하지 않음. 
	
	setProperty는 setter()와 같으므로
	필드 nai에 대한 setter()인 setNai()를 호출한다.
	<jsp:setProperty property="name" name="person" />
	<jsp:setProperty property="gender" name="person"/>
	<jsp:setProperty property="nai" name="person"/>

	3. 모든 필드를 한꺼번에 setting
	* : 모든 필드들을 나타냄.
---%>
	<jsp:setProperty property="*" name="person"/>
	
	
 </jsp:useBean>
 
 이름: <jsp:getProperty property="name" name="person"/><br>
 성별: <jsp:getProperty property="gender" name="person"/> <br>
 나이: <jsp:getProperty property="nai" name="person"/> <br>

</body>
</html>