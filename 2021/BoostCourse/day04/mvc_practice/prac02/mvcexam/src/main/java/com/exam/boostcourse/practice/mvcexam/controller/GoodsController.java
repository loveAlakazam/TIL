package com.exam.boostcourse.practice.mvcexam.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;

@Controller
public class GoodsController {
	//PathVariable: {id}를 pathVariable로 받겠다.
	@GetMapping("/goods/{id}")
	public String getGoodsById(@PathVariable (name="id") int id,
		@RequestHeader (value="User-Agent", defaultValue="myBrowser") String userAgent, //헤더에서 넘어오는 정보를 꺼낼 수 있음.
		HttpServletRequest request,
		ModelMap modelMap) 
	{
		String path= request.getServletPath(); //서블릿 경로값을 얻는다.
		System.out.println("id: "+ id);
		System.out.println("user_agent: "+ userAgent);
		System.out.println("path: "+ path);
		
		//모델맵에 넣는다.
		modelMap.addAttribute("id", id)
		.addAttribute("userAgent", userAgent)
		.addAttribute("path", path);
		return "goodsById";
	}
}
