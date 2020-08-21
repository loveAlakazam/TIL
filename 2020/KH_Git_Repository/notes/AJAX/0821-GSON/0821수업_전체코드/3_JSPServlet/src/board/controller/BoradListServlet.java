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
import board.model.vo.PageInfo;

/**
 * (페이징 처리)
 * 페이징을 이용하여 여러게시물을 대해서
 * 몇개의 게시물마다 페이지를 만든다.
 */
@WebServlet("/list.bo")
public class BoradListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public BoradListServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//전체게시글 개수 => 해당 페이지에대한 게시글수만큼 가져온다
		//서비스를 두번 왔다갔다해야된다. (래퍼런스 변수에 담아서 진행한다)
		BoardService bService =new BoardService();
		
		int listCount;		//총 게시글 개수
		int currentPage;	//현재 페이지 번호(url에 드러난다 ex. &page=3)
		int pageLimit;		//한 페이지에 표시될 페이징 수(페이지네이션에서 보여지는 숫자)
		int boardLimit;		//한 페이지에서 보일 게시글의 최대개수
		int maxPage;		//전체페이지 중에서 가장 마지막페이지
		int startPage;		//페이징된 페이지 중에서 시작페이지
		int endPage;		//페이징된 페이지 중에서 마지막페이지
		
		listCount= bService.getListCount(); //getListCount(): 게시물개수를 불러온다.
		System.out.println("전체 게시글 수: "+ listCount);
		
		//현재 페이지속성이 없으면, 현재페이지의 기본값을 1로한다.
		currentPage=1;
		if(request.getParameter("currentPage")!=null) {
			// 페이지 번호 를 눌렀다면
			currentPage= Integer.parseInt(request.getParameter("currentPage"));
		}
		
		//한화면에 보여줄수있는 페이지는 10개로한다. 1~10, 11~20
		pageLimit=10;  //한페이지에서 표시될 페이징 수
		boardLimit=10; //한페이지에서 보일 게시글의 최대개수
		
		/*
		 	listCount=100, boardLimit=10
		 	100/10= 10 => 10개 페이지
		 	
		 	listCount=101, boardLimit=10 => 101/10=10.1 => 11페이지
		 	listCount=103,               => 103/10=10.3 => 11페이지
		 	listCount=109,               => 109/10=10.9 => 11페이지
		 	
		 	listCount=110,               => 110/10=11.0 => 11페이지
		 	listCount=111,               => 111/10=11.1 => 12페이지
		 	
		 	maxPage=listCount/boardLimit 결과값중 소수첫째자리에서 올림.
		 * */
		
		maxPage=(int)Math.ceil((double)listCount/boardLimit); //casting: double=> int
		/*
		 	1, 11, 21, 31 순으로 시작.
		 	( 첫화면/ n=0 ) 1, 2, 3, 4, 5,...,10
		 	( 다음버튼 1번누름/ n=1 ) 11, 12, 13, ..., 20
		 	( 다음버튼 2번누름/ n=2 ) 21, 22, 23, ..., 30
		 	
		 	페이징 시작페이지 수(start_page) 일반식=> pageLimit * n+1 (n>=0)
		 	페이징 끝페이지 수(end_page) 일반식 => pageLimit*(n+1) (n>=0)
		 								=>  (startPage + pageLmit)-1
		 								
		 								
		  	현재페이지 5를 누름 => 시작페이지는 1로 표기 (5/10=0, n=0)
		 	현재페이지 10을 누름=> 시작페이지는 1로표기  (10/10=0, 그런데 n=1이됨=> n=0나오려면 (10-1)/10으로 해야됨)
			
			n= (currentPage-1)/pageLimit
		 * */
		
		startPage=((currentPage-1)/pageLimit) * pageLimit+1;
		endPage=(startPage+ pageLimit)-1;
		if(maxPage<endPage) {
			endPage=maxPage;
		}
		
		PageInfo pi=new PageInfo(currentPage, listCount, pageLimit, boardLimit, maxPage, startPage, endPage);
		ArrayList<Board> list=bService.selectList(pi);
		
		String page =null;
		if(list!=null) {
			page="WEB-INF/views/board/boardList.jsp";
			request.setAttribute("list", list);
			request.setAttribute("pi", pi);
		}else {
			page="WEB-INF/views/common/errorPage.jsp";
			request.setAttribute("msg", "게시물 조회에 실패하였습니다.");
		}
		
		//page에 해당하는 페이지로 연결하여 페이지 이동을한다.(페이지를 뿌려준다)
		request.getRequestDispatcher(page).forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
