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
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/update.me")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		//memberUpdateForm.jsp에서 입력한 값들을 가져온다.
		String myId= request.getParameter("myId");
		String myName=request.getParameter("myName");
		String myNickName=request.getParameter("nickName");
		String myPhone= request.getParameter("myPhone");
		String myEmail= request.getParameter("myEmail");
		String myAddress=request.getParameter("myAddress");
		
		String [] interests= request.getParameterValues("myInterest");
		
		String myInterests="";
		if(interests!=null) {
			for(int i=0; i<interests.length; i++) {
				myInterests+=interests[i];
				if(i<interests.length-1) {
					myInterests+=",";
				}
			}
		}
		System.out.println(myInterests);
		
		
		Member myInfo= new Member(myId, null, myName, myNickName, myPhone, myEmail, myAddress, myInterests);
		System.out.println(myInfo);
		
		//닉네임 중복여부 확인
		MemberService mService= new MemberService();
		int checkNickNameDuplicated=mService.checkNickName(myNickName);
		
		String page="";
		if(checkNickNameDuplicated>0) {
			//중복된 닉네임(이미 사용하고 있는 닉네임)
			page="WEB-INF/views/common/errorPage.jsp";
			request.setAttribute("msg", "[정보수정 실패] 중복된 닉네임을 사용하였습니다.");
			request.getRequestDispatcher(page).forward(request, response);
		}else {
			//사용가능한 닉네임이라면
			//회원정보 수정이 성공적으로 이뤄졌는지 확인.
			int updateResult=mService.updateMember(myInfo);
			if(updateResult>0) {
				//회원정보 수정이 성공했다면-마이페이지로 이동.
				response.sendRedirect("myPage.me");
			}else {
				//회원정보 수정 실패
				page="WEB-INF/views/common/errorPage.jsp";
				request.setAttribute("msg", "[정보수정 실패] 회원정보 수정 처리에서 오류가 발생하였습니다.");
				request.getRequestDispatcher(page).forward(request, response);
			}
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
