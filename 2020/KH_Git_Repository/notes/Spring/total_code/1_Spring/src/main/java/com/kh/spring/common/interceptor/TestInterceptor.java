package com.kh.spring.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class TestInterceptor extends HandlerInterceptorAdapter{

	private Logger logger= LoggerFactory.getLogger(TestInterceptor.class);
	
	/*
	 * preHandle:  Controller를 호출하기 전
	 * 항상 true를 리턴한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("========== START =============");
		logger.debug(request.getRequestURI());
		
		return super.preHandle(request, response, handler);
	}

	/*
	 * postHandle: Controller에서 DispatcherServlet으로 리턴되는 순간에 수행한다.
	 * */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		//super.postHandle(request, response, handler, modelAndView);
		logger.debug("=============== VIEW =============");
	}

	/*
	 * afterCompletion: 최종결과를 생성하는 일을 포함한 모든 작업이 완료된 후에 수행한다.
	 * */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		//super.afterCompletion(request, response, handler, ex);
		logger.debug("=============== END =============");
	}
	
}
