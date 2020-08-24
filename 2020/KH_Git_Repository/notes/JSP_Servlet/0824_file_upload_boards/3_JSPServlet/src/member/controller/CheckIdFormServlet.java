package member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/checkIdForm.me")
public class CheckIdFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CheckIdFormServlet() {
        super();
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// checkIdForm.jsp를 연다. (데이터 입력이 필요로하다)
		request.getRequestDispatcher("WEB-INF/views/member/checkIdForm.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
