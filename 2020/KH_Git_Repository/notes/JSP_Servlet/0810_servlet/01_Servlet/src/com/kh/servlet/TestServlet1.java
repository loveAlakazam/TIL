package com.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestServlet1 extends HttpServlet {

	//확인 버튼을 누르면 처리되야함.
	//화면과 서블릿이 매핑이 되야함.
	
	//1. web.xml을 가지고 매핑 => 이 방법을 이용함!
	//2. @(annotation)을 이용한 매핑
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("서블릿 실행");
		String name=request.getParameter("name"); //input태그의 name속성값이 "name"이다..
		String gender=request.getParameter("gender"); //input태그의 name속성값이 "gender"이다.
		String age= request.getParameter("age");
		
		String city=request.getParameter("city");
		String height= request.getParameter("height");
		// request.getParameter(name속성이름) => String
		
		String[] foods= request.getParameterValues("food");
		// 여러개: request.getParameterValues(name속성이름) => String[]
		// 선택한 여러개의 음식데이터를 가져옴.
		
		System.out.println("이름: "+ name);
		System.out.println("성별: "+ gender);
		System.out.println("나이: "+ age);
		
		System.out.println("거주지역: "+ city);
		System.out.println("키: "+ height);
		
		System.out.print("좋아하는 음식: ");
		for(String food: foods) {
			System.out.print(food+" ");
		}
		System.out.println();
		
		//결과페이지를 같이 넣어준다.
		// 결과페이지는 HTML형태의 텍스트이다./ 문자인코딩방식은 UTF-8이다. => 응답페이지에 대한 정보를 적는다.
		response.setContentType("text/html;charset=UTF-8");
		
		// PrintWriter을 통해서 응답페이지를 만들어줌.
		PrintWriter out= response.getWriter();
		out.println("<html>");
		out.println("<head>");
		out.println("<title>개인정보 출력화면</title>");
		
		out.println("<style>");
		out.println("h2{color: red;}");
		out.println("span.name{color: orange; font-weight: bold;}");
		out.println("span.gender{ color: yellow; font-weight: bold; background-color: black;}");
		out.println("span.age{color: green; font-weight: bold;}");
		out.println("span.city{color: blue; font-weight: bold;}");
		out.println("span.height{color: navy; font-weight: bold;}");
		out.println("span.food{color: purple; font-weight: bold;}");
		out.println("</style>");
		out.println("</head>");
		
		out.println("<body>");
		out.println("<h2> 개인 취향 테스트 결과(GET Method)</h2>");
		out.printf("<span class='name'>%s</span>님은 <br>", name);
		out.printf("<span class='age'>%s</span>이시며<br>", age);
		out.printf("<span class='city'>%s</span>에 거주하는<br>", city);
		out.printf("키 <span class='height'>%s</span> cm인<br>", height);
		out.printf("<span class='gender'>%s</span> 입니다.", gender);
		out.print("좋아하는 음식은 <span class='food'>");
		for(int i=0; i<foods.length; i++) {
			if(i==0) {
				out.printf("%s", foods[i]);
			}else {
				out.printf(", %s", foods[i]);
			}
		}
		out.println("</span>입니다.");
		out.println("</body>");
		out.println("</html>");
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
