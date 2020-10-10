package member.controller;

import java.io.IOException;
import java.util.HashMap;

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
 * Servlet implementation class MemberPwdUpdateServlet
 */
@WebServlet("/mPwdUpdate.me")
public class MemberPwdUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberPwdUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId= ((Member)request.getSession().getAttribute("loginUser")).getUserId();
		String userPwd= request.getParameter("userPwd");
		String newPwd= request.getParameter("newPwd");
		
		//여기서 넘겨야하는 값이 id, 기존pwd, 새pwd 총 세 개.
		//이를 받아주는 생성자를 만들어도 되지만 계속 사용하지 않기 때문에 간단하게 HashMap으로 받아 넘긴다.
		
		HashMap<String, String> map= new HashMap<String, String>();
		map.put("userId", userId);
		map.put("userPwd", userPwd);
		map.put("newPwd", newPwd);
		
		try {
			new MemberService().pwdUpdate(map);
			Member m =new Member();
			m.setUserId(userId);
			m.setUserPwd(newPwd);
			
			Member member= new MemberService().selectMember(m);
			HttpSession session= request.getSession();
			session.setAttribute("loginUser", member);
			response.sendRedirect(request.getContextPath());
			
		} catch (MemberException e) {
			// 존재하지 않은 회원이면 -> 에러페이지 불러온다.
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
