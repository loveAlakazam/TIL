package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SignUpFormServlet
 */
@WebServlet("/signUpForm.me")
public class SignUpFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SignUpFormServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// send redirect는 url도 아예 바뀌어짐.(url자체가 재작성됨)
		// 데이터를 가져갈 수 없으며 view만 전달.
//		 response.sendRedirect("WEB-INF/views/member/signUpForm.jsp"); //view 화면을 보내준다.
		// http://localhost:9180/3_JSPServlet/WEB-INF/views/member/signUpForm.jsp
		
		// 그러므로 forward를 이용한다.
		// signUpForm.jsp페이지에서 입력받은 아이디와 비밀번호 데이터를 가지고 간다
		request.getRequestDispatcher("WEB-INF/views/member/signUpForm.jsp").forward(request, response);
		//signUpForm.me 가 url주소가 있음.
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
