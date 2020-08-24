package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class LoginServlet
 * annotation => /login.me 요청이오면, 현재 서블릿과 연결하여 처리한다.
 * login.me 요청을 받아서 처리를 해주는 서블릿
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
		request.setCharacterEncoding("UTF-8"); //넘기는 값이 영어와 숫자밖에 없다면, 인코딩이 필요없다  (그러나 한글의 경우는 인코딩이필요함)
		String userId= request.getParameter("userId");
		String userPwd= request.getParameter("userPwd");
		
		System.out.println("LoginServlet userId: "+ userId);
		System.out.println("LoginServlet userPwd: "+ userPwd);
		
		//서비스 영역으로 보내야한다.
		Member member= new Member(userId, userPwd);
		Member loginUser=new MemberService().loginMember(member);
		
		if(loginUser!=null) {
			// 회원가입이 되어있는 회원이라면
			// 로그인은 session영역을 사용한다. => 요청할때마다 로그인을 할 수 없기때문에 => request보다 더넓고 브라우저안에서의 활동을 담당하는 session을 이용.
			// session은 브라우저를 이용하는 동안의 브라우저화면을 담당.
			// request영역: 딱한번의 요청을 받아야한다. => servlet
			
			// 로그인은 세션영역에서 한다.
			HttpSession session = request.getSession();
			
			//session의 유효시간은 기본적으로 30분이다.
			//로그인한 정보를 담는다.
			session.setMaxInactiveInterval(600); //session.setMaxInactiveInterval(600): 10분
			session.setAttribute("loginUser", loginUser); //loginUser이름으로 loginUser객체를 전달. 
			
			// sendRedirect로 view를 보여준다.
			/*
			 RequestDispatcher.forward() 와 response.sendRedirect()
			 [RequestDispatcher.forward()]
			 - 데이터를 뷰에 보낼때 사용
			 - 뷰에게 뿌려야할 데이터가 있을때 (필요할때)
			 - request에 setAttribute()를 이용하여 데이터를담음.
			 - request영역을 동시에 같이 사용하는 경우.
			 
			 [response.sendRedirect()]
			 - 보낼데이터가 없거나, 단순히 페이지를 보여줄 때 사용
			 - 시작하자마자 단순히 뷰(페이지)만 띄우기.
			 - 새로운 request를 만들어서 보낸다.
			 - request를 보낸다해도, 이전 request를 유지하는게 아니라, 새로운 request가 필요.
			 - 데이터를 받을 수 없다. 데이터가 똑같이 존재하지 않음.
			 - 새로운 request, response가 필요다.
			 * */
			
			/*로그인 뷰는 세션영역에 있기 때문에 
			 세션이 훨씬 넓은 영역
			 request가 새로만들어진다해도 영향을 받지 않는다.
			 sendRedirect()로 뷰를전달.
			 
			 
			 * */
			response.sendRedirect(request.getContextPath()); //*.jsp파일을 그대로 브라우저 url에 노출하면 안된다.
		}else {
			request.setAttribute("msg","로그인 실패");
			
			RequestDispatcher view= request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp");
			view.forward(request, response);
			/*
			 1) url에 파일명이 그대로노출됨! => 노출하면 안됨!
			 2) 로그인성공시 로그인화면그대로...
			 */
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
