package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class InsertMemberServlet
 */
@WebServlet("/insert.me")
public class InsertMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public InsertMemberServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 회원정보는 post방식으로 넘겨야된다.
		request.setCharacterEncoding("UTF-8");

		String userId = request.getParameter("joinUserId");
		String userPwd = request.getParameter("joinUserPwd");
		String userName = request.getParameter("userName");
		String nickName = request.getParameter("nickName");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String address = request.getParameter("address");
		String ints[] = request.getParameterValues("interest");
		String interest = "";
		if (ints != null) {
			for (int i = 0; i < ints.length; i++) {
				if (i == ints.length - 1)
					interest += ints[i];
				else
					interest += ints[i] + ", ";
			}
		}

		// 입력한 정보를 바탕으로 객체를 만들고
		Member member = new Member(userId, userPwd, userName, nickName, phone, email, address, interest);

		// MemberService의 insertMember() 메소드를 수행
		int result = new MemberService().insertMember(member);

		System.out.println(result);
		if (result > 0) {
			// insert가 성공적으로 수행
			// 메인페이지로 넘어감 - 데이터입력을 요구하지 않기때문에, 단순 뷰로 넘기기~ => sendRedirect

			response.sendRedirect(request.getContextPath());

			// 회원가입 축하한다는 알림을 준다. - 세션에서 동작
			// 세션에 다 때려밖으면안됨...
			// 이동할때마다 세션을 공통으로 가지고 사용해야됨.
			// setAttribute()안에 값이 계속 바뀜 -중복
			// 관리가 어려움...
			// 어디서든지 변하는 값으로 사용.
			request.getSession().setAttribute("msg", "회원 가입에 성공하였습니다.");

		} else {
			// insert가 실패
			request.setAttribute("msg", "회원가입에 실패하였습니다."); // 영역이 다르기때문에 사용이 가능하다.
			request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
		}

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
