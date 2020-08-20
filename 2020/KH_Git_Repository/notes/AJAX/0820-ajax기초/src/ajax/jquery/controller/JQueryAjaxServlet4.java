package ajax.jquery.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ajax.jquery.model.vo.Student;

/**
 * Servlet implementation class JQueryAjaxServlet4
 */
@WebServlet("/jQueryTest4.do")
public class JQueryAjaxServlet4 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JQueryAjaxServlet4() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name1=request.getParameter("student1");
		String name2=request.getParameter("student2");
		String name3=request.getParameter("student3");

		String names[]= {name1, name2, name3};
		for(int i=0; i<names.length; i++)
			System.out.println(names[i]);

	}

protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
