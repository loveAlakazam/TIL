package board.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.model.exception.BoardException;
import board.model.service.BoardService;
import board.model.vo.Board;
import board.model.vo.PageInfo;
import board.model.vo.SearchCondition;
import common.Pagination;

/**
 * Servlet implementation class BoardSearchServlet
 */
@WebServlet("/search.bo")
public class BoardSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 검색조건/ 검색값을 받아온다
		String condition= request.getParameter("searchCondition");
		String value= request.getParameter("searchValue");
		
		
		
		//검색조건: 작성자, 제목, 내용
		SearchCondition sc= new SearchCondition();
		if(condition.equals("writer")) {
			sc.setWriter(value);
		}else if(condition.equals("title")) {
			sc.setTitle(value);
		}else if(condition.equals("content")){
			sc.setContent(value);
		}
		
		System.out.println(condition+ value);
		
		BoardService service= new BoardService();
		int currentPage =1;
		if(request.getParameter("currentPage")!=null) {
			currentPage= Integer.parseInt(request.getParameter("currentPage"));
		}
		
		try {
			
			// 검색 결과의 개수
			int listCount= service.getSearchResultListCount(sc);
			
			// 개수로 인해서 페이징처리
			PageInfo pi=Pagination.getPageInfo(currentPage, listCount);
			
			// 검색결과에 해당하는 게시물들을 갖고온다.
			ArrayList<Board> list=service.selectSearchResultList(sc,pi);
			request.setAttribute("list", list);
			request.setAttribute("pi", pi);
			request.setAttribute("searchCondition", condition);
			request.setAttribute("searchValue", value);
			request.getRequestDispatcher("WEB-INF/views/board/boardList.jsp").forward(request, response);
			
			
		} catch (BoardException e) {
			request.setAttribute("message", e.getMessage());
			request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp").forward(request, response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
