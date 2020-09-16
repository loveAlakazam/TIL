package action.el.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.model.vo.Person;

/**
 * Servlet implementation class MyElServlet
 */
@WebServlet("/myEL.do")
public class MyElServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MyElServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String name= request.getParameter("name");
		char gender= request.getParameter("gender").charAt(0);
		int age= Integer.parseInt(request.getParameter("age"));
		String beverage= request.getParameter("beverage");
		String products[]= request.getParameterValues("product");
		String book= request.getParameter("book");
		String movie= request.getParameter("movie");
		
		Person person= new Person(name, gender, age);
		request.setAttribute("person", person );
		request.setAttribute("beverage", beverage);
		request.setAttribute("year", 2020);
		request.setAttribute("products", products);
		
		//세션에서 받아온다.
		HttpSession session = request.getSession();
		session.setAttribute("book", book);
		
		ServletContext application =request.getServletContext();
		application.setAttribute("movie", movie);
		
		//먼저 발견한 것을 그대로 사용.
		request.setAttribute("beverage", "코카콜라");
		session.setAttribute("beverage", "환타 오렌지");
		application.setAttribute("beverage", "사이다");
		
		request.getRequestDispatcher("/02_el/01_2_elEnd.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
