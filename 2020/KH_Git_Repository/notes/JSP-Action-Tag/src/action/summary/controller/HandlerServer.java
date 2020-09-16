package action.summary.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HandlerServer
 */
@WebServlet("/hadler.do")
public class HandlerServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HandlerServer() {
        super();
        // TODO Auto-generated constructor stub
    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 01_handler.jsp 에서 보낸 값들을 받아와서
		// 해당 view에다가 다시 전송 => input type hidden 에서
		// name이 view인 태그의 value값을 세팅
		
		//01_handler.jsp
		//<input type="hidden" name="view">
		//frm.view.value = "03_action.jsp";
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
