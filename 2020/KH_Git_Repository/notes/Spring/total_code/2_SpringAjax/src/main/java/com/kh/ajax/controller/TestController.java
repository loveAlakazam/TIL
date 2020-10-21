package com.kh.ajax.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.ajax.model.vo.Sample;
import com.kh.ajax.model.vo.User;

@Controller
public class TestController {
	
	@Autowired
	private Sample sam;
	
	@RequestMapping("testtest.do")
	public void test() {
		System.out.println(sam);
	}
	
	
	// ServletOutputStream을 이용한다 - PrintWriter
	@RequestMapping("test1")
	public void test1Method(@RequestParam("name") String name, 
							  @RequestParam("age") int age, HttpServletResponse response) {
		
		
		try {
			PrintWriter out= response.getWriter();
			
			//뷰로 이동하지 않기에, 리턴할 필요가 없다.
			if(name.equals("최은강") && age==21) {
				out.append("success");//전달성공
				
			}else {
				out.append("fail"); //전달실패
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("test2")
	public void test2Method(HttpServletResponse response) {
		//string 그대로 보내면 깨지므로
		//utf-8 로 인코딩시킨다.
		response.setContentType("application/json; charset=UTF-8");
		
		JSONObject job= new JSONObject();
		job.put("number", 123);
		job.put("title", "test json object");
		job.put("writer", "최은강");
		job.put("content", "JSON객체 리턴하기");
		
		
		try {
			PrintWriter out = response.getWriter();
			out.println(job);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	@RequestMapping("test3")
	@ResponseBody //response객체의 바디로 보낸다.
	public String test3Method(HttpServletResponse response) {
		//ajax에서 dataType도 같이명시해야만 깨지지 않는다. 
		//@ResponseBody가 붙어있을때는 아래의 response.setContetType에 대한 인코딩이 효과없다.
		response.setContentType("application/json; charset=UTF-8");
		
		JSONObject job= new JSONObject();
		job.put("number", 123);
		job.put("title", "test json object");
		job.put("writer", "최은강");
		job.put("content", "JSON객체 리턴하기");
		
		//PrintWriter을 쓰지 않구 리턴으로 할수 없니?
		// @ResponseBody를 붙이지 않고 단순 스트링형태로 보내면 뷰형태(jsp)로 보내게된다.
		return job.toJSONString();  
		
	}

	@RequestMapping("test4")
	public void test4Method(HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		
		ArrayList<User> list= new ArrayList<User>();
		list.add(new User("u111", "p111", "홍길동", 25, "m111@kh.or.kr", "010-1111-2222"));
		list.add(new User("u222", "p222", "홍길순", 25, "m111@kh.or.kr", "010-2222-3333"));
		list.add(new User("u333", "p333", "홍길말", 25, "m111@kh.or.kr", "010-3333-4444"));
		list.add(new User("u444", "p444", "홍길이", 25, "m111@kh.or.kr", "010-4444-5555"));
		list.add(new User("u555", "p555", "홍길미", 25, "m111@kh.or.kr", "010-5555-6666"));
		list.add(new User("u666", "p666", "홍길랑", 25, "m111@kh.or.kr", "010-6666-7777"));
		
		JSONArray jArr= new JSONArray();
		for(User user : list) {
			JSONObject jUser= new JSONObject();
			jUser.put("userId", user.getUserId());
			jUser.put("userPwd", user.getUserPwd());
			jUser.put("userName", user.getUserName());
			jUser.put("age", user.getAge());
			jUser.put("email", user.getEmail());
			jUser.put("phone", user.getPhone());
			
			jArr.add(jUser);
		}
		
		try {
			//jsp로 객체를 보내준다.
			PrintWriter out= response.getWriter();
			out.println(jArr);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	
}
