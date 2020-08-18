package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

/**
 * Servlet implementation class CheckIdServlet
 */
@WebServlet("/checkId.me")
public class CheckIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckIdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId= request.getParameter("inputId");
		
		//아이디가 중복되는지 확인하기 위해서는 반환값을 int로 한다.
		int result=new MemberService().checkId(userId);
	
		
		//값을 보낸다. - 데이터 result, userId를 checkIdForm에 보낸다.
		request.setAttribute("result", result);
		request.setAttribute("checkedId", userId);
		request.getRequestDispatcher("WEB-INF/views/member/checkIdForm.jsp").forward(request, response);
		
		//view를 바꾼다.
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
