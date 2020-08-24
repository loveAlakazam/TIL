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

import notice.model.service.NoticeService;
import notice.model.vo.Notice;


@WebServlet("/updateNoticeForm.no") 
public class NoticeUpdateFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public NoticeUpdateFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//데이터를 받아온다
		request.setCharacterEncoding("UTF-8");
		
		//수정하려는 공지게시글 번호를 알아낸다.
		int no= Integer.parseInt(request.getParameter("no"));
		
		Notice notice= new NoticeService().selectNotice(no); 
		//noticeUpdateForm.jsp의 scriptlet에서는 위의 세팅한 notice객체를 getAttribute()로 받아야한다.
		//수정하려는 게시글 번호가 몇번인지를 알아야하기 때문이다.
		
		
		String page=null;
		if(notice!=null) {
			//수정글이 존재한다면
			page= "WEB-INF/views/notice/noticeUpdateForm.jsp";
			request.setAttribute("notice", notice);
		}else {
			//수정글이 존재하지 않다면
			page="WEB-INF/views/common/errorPage.jsp";
			request.setAttribute("msg", "존재하지 않은 공지사항 입니다!");
		}
		
		//글 번호에 의해 뷰에 나타낼 페이지가 다르다.
		//입력 데이터는 없다. 그저 수정페이지만을 뿌려준다.(뷰만)
		//그래서 getRequestDispatcher(jsp파일경로).forward(request, response)함수를 사용한다.
		RequestDispatcher view= request.getRequestDispatcher(page);
		view.forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
