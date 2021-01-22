package guestBook.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.GsonBuilder;

import guestBook.model.service.GuestBookService;
import guestBook.model.vo.GuestBook;

/**
 * Servlet implementation class selectRecentGuestBookServlet
 */
@WebServlet("/recentGuestBook")
public class SelectRecentGuestBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SelectRecentGuestBookServlet() {
    
    	super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestBookService gService= new GuestBookService();
		ArrayList<GuestBook> glist=gService.selectRecentGlist();
		
		response.setContentType("application/json; charset=UTF-8");
		new GsonBuilder().setDateFormat("yyyy-MM-dd").create().toJson(glist, response.getWriter());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
