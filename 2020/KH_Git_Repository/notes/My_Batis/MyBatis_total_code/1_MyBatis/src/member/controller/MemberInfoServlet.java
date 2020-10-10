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
 * Servlet implementation class MemberInfoServlet
 */
@WebServlet("/info.me")
public class MemberInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//session영역에서 로그인한 회원정보를 불러온다.
		//session에서 "loginUser" 이름의 객체를 불러온다.
		HttpSession session=request.getSession();
		Member member=(Member) session.getAttribute("loginUser");
	
		try {
			//존재하는 회원이라면
			Member myInfo=new MemberService().selectMember(member);
			
			//request영역에서 member객체를 "member"이름으로 연결하고
			request.setAttribute("member", myInfo);
			
			//memberInfo.jsp를 불러온다.
			request.getRequestDispatcher("WEB-INF/views/member/memberInfo.jsp").forward(request, response);
			
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
