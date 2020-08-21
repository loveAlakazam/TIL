package board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;
import board.model.vo.Board;
import board.model.vo.Reply;

/**
 일반 게시판 글 상세페이지
 */
@WebServlet("/detail.bo")
public class BoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public BoardDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bId=Integer.parseInt(request.getParameter("bId"));
		
		
		//bId에 해당한 게시글을 불러온다.
		Board board=new BoardService().selectBoard(bId);
		ArrayList<Reply> list= new BoardService().selectReplyList(bId);
		
		String page=null;
		if(board!=null) {
			//게시글이 존재한다면
			page="WEB-INF/views/board/boardDetail.jsp";
			request.setAttribute("board", board);
			request.setAttribute("list", list);
		}else {
			//게시글이 존재하지 않는다면
			page="WEB-INF/views/common/errorPage.jsp";
			request.setAttribute("msg", "게시글 상세 조회에 실패하였습니다!");
		}
		request.getRequestDispatcher(page).forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
