package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

/**
 * Servlet implementation class CheckNickNameMyPageServlet
 */
@WebServlet("/checkNickNameMyPage.me")
public class CheckNickNameMyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CheckNickNameMyPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//checkNickNameForm.jsp에서 입력한 닉네임 데이터를 받는다.
		String nickName= request.getParameter("inputNickName");
		
		//닉네임이 중복되는지 확인하기위한 int로 반환 => select문 => (중복) 1개 / (중복x) 0개
		int result=new MemberService().checkNickName(nickName);
		
		request.setAttribute("result", result); //nickName이 중복됐는지 쿼리결과를 세팅
		request.setAttribute("checkedNickName", nickName); //입력한 nickName 값을 세팅
		request.getRequestDispatcher("WEB-INF/views/member/checkNickNameFormMyPage.jsp").forward(request, response); //세팅한값을 dispatcher가 가리키는 페이지에게로 보냄.
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
