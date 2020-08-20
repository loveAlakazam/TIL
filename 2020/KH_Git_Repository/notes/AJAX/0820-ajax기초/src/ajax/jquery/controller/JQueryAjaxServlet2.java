package ajax.jquery.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/jQueryTest2.do")
public class JQueryAjaxServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JQueryAjaxServlet2() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8"); //인코딩 - 서버로부터 값을 받을 때 브라우저화면에서 유니코드를 나타낼때 꼭 필요함.
		
		// method-chaining
		response.getWriter().println("서버에서 전송한 값입니다.\n");
		response.getWriter().append("append를 사용했습니다.");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
