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

@WebServlet("/jQueryTest6.do")
public class JQueryAjaxServlet6 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public JQueryAjaxServlet6() {
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
		
		int userNo=Integer.parseInt(request.getParameter("userNo"));
		User user=null;
		
		for(int i=0; i<userList.size(); i++) {
			if(userList.get(i).getUserNo()==userNo) {
				user=userList.get(i);
				break;
			}
		}
		
		
		JSONArray userArr= new JSONArray();
		JSONObject userObj= null;
		
		if(user!=null) {
			//userNo에 해당하는 사람이 있으면 => 해당자의 정보만 출력.
			userObj= new JSONObject();
			userObj.put("userNo", user.getUserNo());
			userObj.put("userName", user.getUserName());
			userObj.put("userNation", user.getUserNation());
			
			userArr.add(userObj);
		}else {
			//userNo에 해당하는 사람이 없으면=> 리스트에있는 모든 회원정보를 전부다 출력
			for(User userInfo: userList) {
				userObj=new JSONObject(); //객체생성
				userObj.put("userNo", userInfo.getUserNo());
				userObj.put("userName", userInfo.getUserName());
				userObj.put("userNation", userInfo.getUserNation());
				
				userArr.add(userObj); //추가
			}
		}
		
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out= response.getWriter();
		out.println(userArr);
		out.flush();
		out.close();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
