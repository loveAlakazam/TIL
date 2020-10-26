package com.kh.spring.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.spring.member.model.vo.Member;

public class MemberLoginInterceptor extends HandlerInterceptorAdapter{
	private Logger logger= LoggerFactory.getLogger(MemberLoginInterceptor.class);
	
	// afterCompletion메소드
	// login.me url 요청처리 과정을 마친뒤
	// view까지 모두 보여주는과정을 수행한 후에 
	//발생하는 Interceptor입니다.
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		//세션을 불러옵니다.
		HttpSession session= request.getSession();
		
		//세션계층에서 loginUser이름의 attribute를 불러옵니다.
		Member loginUser=(Member)session.getAttribute("loginUser");
		
		//여기에 로그 메시지를 보낸다.
		// MemberLoginInterceptor과 연결된 로거는
		//log4j.xml에서 name="com.kh.spring.common.interceptor.MemberLoginInterceptor인 logger와 연결된
		//appender에서 아래의 로그메시지를 파일로 출력합니다.
		if(loginUser!=null) {
			logger.debug("로그인 계정: "+loginUser.getId());
		}
		super.afterCompletion(request, response, handler, ex);
	}
}
