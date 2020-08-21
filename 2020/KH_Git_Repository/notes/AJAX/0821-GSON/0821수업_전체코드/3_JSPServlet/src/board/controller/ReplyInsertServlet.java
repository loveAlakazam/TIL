package board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import board.model.service.BoardService;
import board.model.vo.Reply;

@WebServlet("/insertReply.bo")
public class ReplyInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ReplyInsertServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String writer = request.getParameter("writer");
		int bId= Integer.parseInt(request.getParameter("bId"));
		String content= request.getParameter("content");
		
		Reply reply= new Reply();
		reply.setReplyWriter(writer);
		reply.setRefBid(bId);
		reply.setReplyContent(content);
		
		ArrayList<Reply> list= new BoardService().insertReply(reply);	
		response.setContentType("application/json; charset=UTF-8");
		//new Gson().toJson(list, response.getWriter());
		Gson gson= new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		gson.toJson(list, response.getWriter());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
