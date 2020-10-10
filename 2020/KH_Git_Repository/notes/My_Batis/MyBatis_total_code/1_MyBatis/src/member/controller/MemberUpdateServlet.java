package member.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.exception.MemberException;
import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/mupdate.me")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userId= ((Member) request.getSession().getAttribute("loginUser")).getUserId();
		String userName= request.getParameter("userName");
		String nickName= request.getParameter("nickName");
		String email=request.getParameter("email");
		
		int year= Integer.parseInt(request.getParameter("year"));
		int month=Integer.parseInt(request.getParameter("month"));
		int date=Integer.parseInt(request.getParameter("date"));
		
		Date birthday=new Date(new GregorianCalendar(year, month-1, date).getTimeInMillis());
		
		String gender= request.getParameter("gender");
		String phone=request.getParameter("phone");
		String address=request.getParameter("address");
		
		Member m=new Member(userId, null, userName, nickName, email, birthday, gender, phone, address);
		try {
			new MemberService().updateMember(m);
			response.sendRedirect(request.getContextPath()+"/info.me"); //내정보 페이지 불러온다.
			
		} catch (MemberException e) {
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
