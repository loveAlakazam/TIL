package notice.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.GregorianCalendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import notice.model.service.NoticeService;
import notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeInsertServlet
 * 
 * 공지사항 게시판 "글쓰기"버튼을 클릭할때
 * 즉, 공지사항 게시글을 작성하고 작성버튼을 클릭했을 때
 * 
 * 
 * 게시글을 db에등록하는 역할이다.
 */
@WebServlet("/insert.no")
public class NoticeInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeInsertServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8"); //UTF-8로 변환시킨다. (BODY 내에서 데이터가 전달되도록하는 역할)
		
		// 입력한 데이터를 String 형태로 받아야된다.
		String title= request.getParameter("title");
		String userId= ((Member) request.getSession().getAttribute("loginUser")).getUserId();
		String input_date= request.getParameter("date");
		String content= request.getParameter("content");
		
		Date date= null;
		if(input_date!="") {
			String [] dateArr= input_date.split("-");
			int year= Integer.parseInt(dateArr[0]);
			int month= Integer.parseInt(dateArr[1])-1;
			int day= Integer.parseInt(dateArr[2])-1;
			
			date= new Date(new GregorianCalendar(year, month, day).getTimeInMillis());
		}else {
			date= new Date(new GregorianCalendar().getTimeInMillis());
		}
		
		Notice n= new Notice(title, content, userId, date);
		
		int result= new NoticeService().insertNotice(n);
		if(result>0) {
			response.sendRedirect("list.no");
		}else {
			request.setAttribute("msg", "공지사항 등록에 실패하였습니다.");
			RequestDispatcher view= request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp");
			view.forward(request, response);
		}	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
