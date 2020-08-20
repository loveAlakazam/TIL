package ajax.jquery.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import ajax.jquery.model.vo.User;

/**
 * Servlet implementation class JQueryAjaxServlet7
 */
@WebServlet("/jQueryTest8.do")
public class JQueryAjaxServlet8 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JQueryAjaxServlet8() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ArrayList<User> userList=new ArrayList<User>();
		userList.add(new User(1,"박신우", "한국"));
		userList.add(new User(2, "ek12mv2", "독일"));
		userList.add(new User(3, "csk", "일본"));
		userList.add(new User(4, "hyp", "미국"));
		userList.add(new User(5, "kjh", "호주"));
		userList.add(new User(6, "cdj","이탈리아"));
		
		// 입력한 이름
		String userName= request.getParameter("userName");
		String [] names= userName.split(",");
		
		User user= null;
		JSONObject userObj=null;
		JSONObject userMap= new JSONObject();
		
		for(String name: names) {
			for(int i=0; i<userList.size(); i++) {
				if(userList.get(i).getUserName().equals(name)) {
					user=userList.get(i);
					userObj= new JSONObject();
					userObj.put("userNo", user.getUserNo());
					userObj.put("userName", user.getUserName());
					userObj.put("userNation", user.getUserNation());
					
					userMap.put("user-"+name, userObj );
				}
			}
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out= response.getWriter();
		out.println(userMap);
		out.flush();
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
