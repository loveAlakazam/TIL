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

/**
 * Servlet implementation class NoticeUpdateServlet
 * 공지글 수정하기
 * 
 * /update.no url요청이 들어오면 이 서블릿에서 해결한다.
 */
@WebServlet("/update.no")
public class NoticeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public NoticeUpdateServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//수정한데이터를 post방식으로 전달받고, 한글이 포함될수 있으므로
		request.setCharacterEncoding("UTF-8");
		
		//수정대상 게시글 번호를 알아보자.
		int no=Integer.parseInt(request.getParameter("no")); // 모름... 여기서 어떻게 숫자값과 post데이터값을 같이 전달하지? - 여기서 null pointer exception이 뜸.
		// 변경하려는 데이터를 얻는다. - 작성자 외 나머지만
		String title= request.getParameter("title");
		String input_date= request.getParameter("date");
		String content= request.getParameter("content");
		
		System.out.println("=>"+title+"-"+input_date+"-"+content); // 모두 null로 나오면=> null pointer execption
	
		
		Date date= null;
		if(input_date!="") {
			String [] dateArr= input_date.split("-");
			int year= Integer.parseInt(dateArr[0]);
			int month= Integer.parseInt(dateArr[1])-1;
			int day=Integer.parseInt(dateArr[2])-1;
			
			date= new Date(new GregorianCalendar(year, month, day).getTimeInMillis());
		
		}else {
			date= new Date(new GregorianCalendar().getTimeInMillis());
		}
		
		//서비스영역으로 이동
		
		int result= new NoticeService().updateNotice(no, title, content, date);
		
		if(result>0) {
			//수정성공
			response.sendRedirect("list.no");
		}else {
			request.setAttribute("msg", "공지사항 수정에 실패하였습니다!");
			RequestDispatcher view = request.getRequestDispatcher("WEB-INF/views/common/errorPage.jsp");
			view.forward(request, response);
		}
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
