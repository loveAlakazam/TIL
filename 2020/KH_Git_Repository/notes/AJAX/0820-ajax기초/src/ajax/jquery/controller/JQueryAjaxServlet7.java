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
@WebServlet("/jQueryTest7.do")
public class JQueryAjaxServlet7 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public JQueryAjaxServlet7() {
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
		
		// 입력한 숫자
		String userNo= request.getParameter("userNo");
		
		String [] ids= userNo.split(",");
		
		JSONArray userArr= new JSONArray();
		
		for(String id: ids) {
			for(int i=0; i<userList.size(); i++) {
				if(Integer.parseInt(id)== userList.get(i).getUserNo()) {
					//id와 현재 i번째 유저의 유저넘버와 같다면
					//해당 유저정보를 가져온다.
					User user= userList.get(i);
					JSONObject userObj= new JSONObject();
					userObj.put("userNo", user.getUserNo());
					userObj.put("userName", user.getUserName());
					userObj.put("userNation", user.getUserNation());
					
					userArr.add(userObj);
				}
			}
		}
		
		JSONObject result= new JSONObject();
		result.put("list", userArr );
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out= response.getWriter();
		out.println(result);
		out.flush();
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
