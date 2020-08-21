package member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;

/**
 * Servlet implementation class CheckIdServlet
 */
@WebServlet("/checkId.me")
public class CheckIdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public CheckIdServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String userId= request.getParameter("inputId");	
		String userId= request.getParameter("userId");	
		
		//아이디가 중복되는지 확인하기 위해서는 반환값을 int로 한다.
		int result=new MemberService().checkId(userId);
		
		//값을 보낸다. - 데이터 result, userId를 checkIdForm에 보낸다.
//		request.setAttribute("result", result);
//		request.setAttribute("checkedId", userId);
//		request.getRequestDispatcher("WEB-INF/views/member/checkIdForm.jsp").forward(request, response);
//		//view를 바꾼다.	
		PrintWriter out= response.getWriter();
		if(result>0) {
			out.append("fail");
		}else {
			out.append("success");
		}
		
		out.flush();
		out.close();
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
