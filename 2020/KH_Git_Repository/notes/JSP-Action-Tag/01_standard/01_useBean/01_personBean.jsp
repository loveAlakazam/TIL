<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSTL</title>
</head>
<body>
	<h2>jsp표준 액션 태그중 useBean을 사용하여 vo클래스의 객체 정보 불러오기</h2>
	
	<%-- 
	scriptlet으로 객체를 불러오기
	p: 인스턴스변수
	<% action.model.vo.Person p = new action.model.vo.Person(); %>
	
	jsp:useBean을 이용하여 객체를 불러오기
	객체이름: 인스턴스변수: 객체주소를 저장.
	
	scope: request / session/ page / application 
	해당 scope에서 person1이 가리키는 객체가 존재하지 않으면, 객체를 생성한다.
		존재하면, 그대로 가져온다.
	--%>
	<jsp:useBean id="person1" class="action.model.vo.Person" scope="request"/>
	
	<%-- getProperty(): getter --%>
	이름: <jsp:getProperty property="name" name="person1"/><br>
	나이: <jsp:getProperty property="gender" name="person1"/><br>
	
	<%-- property="age" 는 Person클래스의  getAge()를 호출. --%>
	<%-- property="nai" 는 Person클래스의 getNai()를 호출 --%>
	성별: <jsp:getProperty property="nai" name="person1"/><br>
	
	<%-- 필드이름의 규칙을 지켜야한다. 필드이름은 소문자로표기한다. --%>

	<h2>person2객체 만들기</h2>
	
	
	<jsp:useBean id="person2" class="action.model.vo.Person"/>
	<%-- setProperty --%>
	<jsp:setProperty property="name" name="person2" value="loveAlakazam"/>
	<jsp:setProperty property="age" name="person2" value="21"/>
	<jsp:setProperty property="gender" name="person2" value="f"/>
	
	<%-- getProperty --%>
	이름: <jsp:getProperty property="name" name="person2"/>		<%-- null --%>
	성별: <jsp:getProperty property="gender" name="person2"/>	<%--  --%>
	나이: <jsp:getProperty property="nai" name="person2"/>		<%-- 0 --%>
	
</body>
</html>