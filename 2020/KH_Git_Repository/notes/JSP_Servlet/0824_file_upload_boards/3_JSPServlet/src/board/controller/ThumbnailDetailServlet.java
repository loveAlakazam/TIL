package board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.service.BoardService;
import board.model.vo.Attachment;
import board.model.vo.Board;

/**
 * Servlet implementation class ThumbnailDetailServlet
 */
@WebServlet("/detail.th")
public class ThumbnailDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ThumbnailDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int bId= Integer.parseInt(request.getParameter("bId"));
		System.out.println("bId: "+ bId);
		
		BoardService service= new BoardService();
		Board board= service.selectBoard(bId);
		ArrayList<Attachment> fileList= service.selectThumbnail(bId);
		
		
		String page=null;
		if(fileList!=null) {
			request.setAttribute("board", board);
			request.setAttribute("fileList", fileList);
			page="WEB-INF/views/thumbnail/thumbnailDetail.jsp";
		}else {
			request.setAttribute("msg", "사진게시판 상세보기에 실패하였습니다.");
			page="WEB-INF/views/common/errorPage.jsp";
		}
		
		request.getRequestDispatcher(page).forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
