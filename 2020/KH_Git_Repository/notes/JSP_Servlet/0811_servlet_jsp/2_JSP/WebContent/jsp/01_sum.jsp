<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>01-sum.jsp</title>
</head>
<body>
	<!-- HTML 주석 
		(개발자도구나 소스보기에서는 보인다/ 중요한정보는 기입하지 말것.) 
		클라이언트(웹브라우저)한테 전달이 되기때문에 보인다.
	-->
	
	<%-- JSP주석
		(개발자도구나 소스보기에서는 안보인다)
		jspwork: 작업한 자바파일
		Servers/JSPServer-config/context.xml 을 META-INF에 복사
	--%>
	
	<%
		//자바코드 기술
		int total=0;
		for(int i=1; i<=10; i++){
			total+=i;
		}
		
		System.out.println("덧셈 종료!"); //console창에 출력.
		
	%>
	
	
	
	<%
	total=0;
	for(int i=1; i<=10; i++){
		total+=i;
	%>
		반복할 문장을 입력합니다~ :)<br>
	<%	
	}
	
	System.out.println("덧셈 끝!"); //콘솔창에 입력.
	%>
	
	expression출력: 1부터 10까지의 합은
	<%--표현식에서는 ;(새미콜론)을 넣으면 안됨 --%>
	<span style="color:red; font-size:16pt;"><%=total %></span>입니다.<br>
	 
	scriptlet 출력: 1부터 10까지의 합은
	<%--scriptlet에서는 ;(새미콜론)을 넣어야함. --%>
	<span style="color: blue; font-size: 16pt;"><% out.println(total); %></span>입니다.<br>
</body>
</html>