package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;


@WebServlet("/updateForm.me")
public class MemberUpdateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberUpdateFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//회원정보 수정페이지에서 입력받은 데이터를 받아온다.
		//memberUpdateForm.jsp에서 입력폼태그로부터 데이터를 받아오는데
		//각 폼태그에서 name에 대응되는 input태그들의 value값을 불러온다.
		
		//예를 들면 String myId= request.getParameter("myId");
		//입력태그의 name 속성값이 myId에서 입력값을 가져온다.
		request.setCharacterEncoding("UTF-8");
		
		//수정할 정보 - 없으면 문자열 NULL값으로 넘어온다.
		
		String myId= request.getParameter("myId");
		String myName= request.getParameter("myName");
		String myNickName= request.getParameter("nickName");
		String myPhone= request.getParameter("myPhone");
		String myEmail= request.getParameter("myEmail");
		String myAddress= request.getParameter("myAddress");
		String myInterest= request.getParameter("myInterest");
		
		// myPage.jsp에서 입력한 데이터를 가지고 Member객체를 만들어놓는다.
		Member myInfo= new Member(myId, null , myName, myNickName, myPhone, myEmail, myAddress, myInterest);
		System.out.println(myInfo);
		
		
		// 현재 멤버정보를 담은 멤버객체를 만들어서 setting한다.
		request.setAttribute("myInfo", myInfo);
		
		// memberUpdateForm.jsp 페이지를 불러오고, 세팅한 myInfo객체를 보낸다.
		request.getRequestDispatcher("WEB-INF/views/member/memberUpdateForm.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
