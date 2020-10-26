package com.kh.spring.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.spring.member.model.vo.Member;

// 로그인을 하지 않으면 게시판 요청을 했을 때 "로그인 후 이용하세요" 라는 경고메시지를 띄운후
// 메인화면으로 가게 만드는 Interceptor
public class BoardEnterInterceptor extends HandlerInterceptorAdapter{
	
	//preHandler - 요청이 들어가기 전에 띄워야하기때문에
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member loginUser= (Member)session.getAttribute("loginUser");
		
		if(loginUser==null) {
			request.setAttribute("msg", "로그인 후 이용하세요!");
			request.getRequestDispatcher("WEB-INF/views/home.jsp").forward(request, response);
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}
}
