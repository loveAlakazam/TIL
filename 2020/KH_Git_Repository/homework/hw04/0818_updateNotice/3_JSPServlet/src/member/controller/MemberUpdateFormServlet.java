package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateFormServlet
 */
@WebServlet("/updateForm.me")
public class MemberUpdateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateFormServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//마이페이지에서 데이터를 받아온다.
		request.setCharacterEncoding("UTF-8");
		
		//수정할 정보 - 없으면 문자열 NULL값으로 넘어온다.

		String myId= request.getParameter("myId");
		String myName= request.getParameter("myName");
		String myNickName= request.getParameter("myNickName");
		String myPhone= request.getParameter("myPhone");
		String myEmail= request.getParameter("myEmail");
		String myAddress= request.getParameter("myAddress");
		String myInterest= request.getParameter("myInterest");
		
		Member myInfo= new Member(myId, null , myName, myNickName, myPhone, myEmail, myAddress, myInterest);
		request.setAttribute("myInfo", myInfo);
		request.getRequestDispatcher("WEB-INF/views/member/memberUpdateForm.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
