package com.kh.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TestServlet2 extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//데이터를 받기전부터 post방식으로 받을 때는 인코딩을 먼저시작해야한다.
		request.setCharacterEncoding("utf-8"); //post방식에서 꼭!
		
		// 데이터를 받는다.
		String name = request.getParameter("name");
		String gender = request.getParameter("gender");
		String age = request.getParameter("age");
		String city = request.getParameter("city");
		String height = request.getParameter("height");
		String[] foods = request.getParameterValues("food");

		// post방식은 body에서 받기때문에
		// 받아온 데이터를 한번 더 encoding 해야된다.
		
			
		System.out.println("이름: " + name);
		System.out.println("성별: " + gender);
		System.out.println("나이: " + age);

		System.out.println("거주지역: " + city);
		System.out.println("키: " + height);

		System.out.print("좋아하는 음식: ");
		for (String food : foods) {
			System.out.print(food + " ");
		}
		System.out.println();

		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.println("<html>");
		out.println("<head>");
		out.println("<title>개인 정보 출력화면 post</title>");

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
		out.println("<h2> 개인 취향 테스트 결과(POST Method)</h2>");
		out.printf("<span class='name'>%s</span>님은 <br>", name);
		out.printf("<span class='age'>%s</span>이시며<br>", age);
		out.printf("<span class='city'>%s</span>에 거주하는<br>", city);
		out.printf("키 <span class='height'>%s</span> cm인<br>", height);
		out.printf("<span class='gender'>%s</span> 입니다.", gender);
		out.print("좋아하는 음식은 <span class='food'>");
		for (int i = 0; i < foods.length; i++) {
			if (i == 0) {
				out.printf("%s", foods[i]);
			} else {
				out.printf(", %s", foods[i]);
			}
		}
		out.println("</span>입니다.");
		out.println("</body>");
		out.println("</html>");

	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
