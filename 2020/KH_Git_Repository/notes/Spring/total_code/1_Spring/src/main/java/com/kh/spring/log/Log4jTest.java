package com.kh.spring.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Log4jTest {
	
	// org.slf4j.Logger
	// Logger 자기자신에 대한 클래스 정보를 전달해야 해당클래스에 맞는 로그를 출력할 수 있다.
	private Logger logger=LoggerFactory.getLogger(Log4jTest.class);
	
	public static void main(String [] args) {
		new Log4jTest().test();
	}
	
	public void test() {
		/*
		[log4j.xml]
			<logger name="com.kh.spring">
				<level value="info" />
			</logger>
		
		 info로 설정했기때문에
		 logger은 info/ warn/ error만 출력.
		 
		 
		 
		 * */
		//test()호출
		logger.trace("trace 로그 출력");
		logger.debug("debug 로그 출력");
		logger.info("info 로그 출력");
		logger.warn("warn 로그 출력");
		logger.error("error 로그 출력");
		
		//faltal() 메소드는 logger에서 지원하지 않는다.
		//logger.fatal("fatal 로그 출력");
	}
}
