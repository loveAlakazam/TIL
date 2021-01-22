package guestBook.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import guestBook.model.service.GuestBookService;
import guestBook.model.vo.GuestBook;

/**
 * Servlet implementation class InsertGuestBookServlet
 */
@WebServlet("/insertGuest")
public class InsertGuestBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertGuestBookServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		GuestBook gb= new GuestBook();
		String name= request.getParameter("name");
		String content=request.getParameter("content");
		if(name==null) {
			request.setAttribute("msg", "이름을 입력해주세요!");
			request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
			return;
		}
		
		if(content==null) {
			request.setAttribute("msg", "내용을 입력해주세요!");
			request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
			return;
		}
		
		gb.setContent(content);
		gb.setName(name);
	
		int result= new GuestBookService().insertGuestBook(gb);
		if(result>0) {
			response.sendRedirect(request.getContextPath());
		}else {
			request.setAttribute("msg", "방명록 등록에 실패하였습니다.");
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
