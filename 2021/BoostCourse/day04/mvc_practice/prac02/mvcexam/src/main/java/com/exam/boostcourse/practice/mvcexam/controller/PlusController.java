package com.exam.boostcourse.practice.mvcexam.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class PlusController {
	
	//plusForm 페이지를 보여준다. - 뷰네임을 리턴.
	//get방식으로 받아온다.
	@GetMapping(path="/plusForm")
	public String plusForm() {
		return "plusForm";
	}
	
	@PostMapping(path="/plus")
	public String plus(@RequestParam(name="value1", required=true) int value1,
			@RequestParam(name="value2", required=true) int value2,
			ModelMap modelMap) {
		
		int result= value1+value2;
		
		//spring이 알아서 request scope에서 값들을 name태그와 매핑시켜 세팅하여 응답뷰정보를 리턴.
		modelMap.addAttribute("value1", value1)
		.addAttribute("value2", value2)
		.addAttribute("result", result);
		
		return "plusResult"; //plusResult 뷰를 리턴하여, viewResolver를 통해서 이름에 맞는 응답뷰를 클라이언트에게 리턴
	}


}
