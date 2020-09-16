<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>01_2_sumCalc.jsp</title>
</head>
<body>
<%

	//reqeust는 요청 한번 일어날때마다 요구함. (01_1 에서 입력받은것을 저장.)
	//url이 그대로 유지되어있는 것을 확인.
	//url에 남아있는 queryString을 이용하여 getParameter을 이용하여 가져옴.
	int firsrt= Integer.parseInt(request.getParameter("firstNum"));
	int second= Integer.parseInt(request.getParameter("secondNum"));
	
	int result=0;
	for(int i=0; i<=second; i++){
		result+=i;
	}
	
	// forward: 페이지 이동 - result를 받아온다.
	// 페이지 이동 
	request.setAttribute("result", result);

%>

	
	<%--01_3_sumView.jsp 를 불러온다  --%>
	<jsp:forward page="01_3_sumView.jsp" />
</body>
</html>