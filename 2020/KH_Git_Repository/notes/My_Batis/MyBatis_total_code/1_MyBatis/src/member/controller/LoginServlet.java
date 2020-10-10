package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.exception.MemberException;
import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login.me")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//menubar.jsp에서 form태그에 입력된 아이디와 비밀번호를 받는다.
		String userId= request.getParameter("userId");
		String userPwd= request.getParameter("userPwd");
		
		Member m= new Member();
		m.setUserId(userId);
		m.setUserPwd(userPwd);
		
		try {
			Member member=new MemberService().selectMember(m);
			
			// 로그인 세션 수행
			HttpSession session= request.getSession();
			session.setAttribute("loginUser", member);
			session.setMaxInactiveInterval(600);
			response.sendRedirect(request.getContextPath());
			
		} catch (MemberException e) {
			//로그인 실패
			request.setAttribute("message", e.getMessage());
			request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
