package ajax.jquery.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import ajax.jquery.model.vo.User;

@WebServlet("/jQueryTest5.do")
public class JQueryAjaxServlet5 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JQueryAjaxServlet5() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		ArrayList<User> userList=new ArrayList<User>();
		userList.add(new User(1,"박신우", "한국"));
		userList.add(new User(2, "ek12mv2", "독일"));
		userList.add(new User(3, "csk", "일본"));
		userList.add(new User(4, "hyp", "미국"));
		userList.add(new User(5, "샘 해밍턴", "호주"));
		
		int userNo=Integer.parseInt(request.getParameter("userNo"));
		User user=null;
		for(int i=0; i<userList.size(); i++) {
			if(userList.get(i).getUserNo()==userNo) {
				user=userList.get(i);
				break;
			}
		}

//		response.setCharacterEncoding("UTF-8");
//		response.getWriter().println(user); //보낸다.
		JSONObject userObj= null;
		if(user!=null) {
			userObj=new JSONObject();
			userObj.put("userNo", user.getUserNo());
			userObj.put("userName", user.getUserName());
			userObj.put("userNation", user.getUserNation());
		}
		
		System.out.println(userObj); //키값 순서 유지가 안되어있음
		
		//json방식으로 보내고있다는걸 알린다.
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out= response.getWriter();
		
		//요청에대한 응답결과로 보낸다.
		// 즉 success의 function response에 값을 보냄.
		// 즉, 객체형태의 데이터를 요청에대한 응답데이터로 보내줌.
		out.println(userObj); 
		
		out.flush();//PrintWriter 버퍼를 비운다.
		out.close();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
