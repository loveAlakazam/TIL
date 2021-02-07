package com.exam.boostcourse.practice.mvcexam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.exam.boostcourse.practice.mvcexam.DTO.User;

@Controller
public class UserController {

	@RequestMapping(path="/userForm", method=RequestMethod.GET)
	public String userForm() {
		return "userForm";
	}

	
	@PostMapping(path="/regist")
	public String regist(@ModelAttribute User user) {
		//DTO를 통해서 한꺼번에 받아낼수있다. - ModelAndView : 객체를 받는다.
		//스프링컨테이너는 객체를 생성하여, 그 객체를 파라미터에 주입해놓음.
		System.out.println("사용자 입력 user정보 입니다.");
		System.out.println(user);
		return "regist";
	}
}
