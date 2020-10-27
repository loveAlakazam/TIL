package com.kh.spring.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggerAspect1 {
	// bean등록하기
	// (1) AOP관련된 LoggerAspect를 만듭니다.
	private Logger logger= LoggerFactory.getLogger(LoggerAspect1.class);
	
	// (2)
	public Object loggerAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
		// 메소드 명/ 리턴타입을 반환
		
		// getSignatre(): AOP가 적용되는 메소드 정보를 반환한다.
		Signature signature=joinPoint.getSignature(); 
		
		logger.debug("signature: "+ signature);
		
		//메소드가 있는 클래스 풀네임을 반환한다.
		String type=signature.getDeclaringTypeName();
		
		
		
		//타겟 객체 메소드
		String methodName= signature.getName();
	
		//출력해보기
		logger.debug("Type: " + type);
		logger.debug("methodName: "+ methodName);
		
		String componentName="";
		
		//타겟 클래스가 컨트롤러가 존재한다면
		if(type.indexOf("Controller") > -1) {
			componentName= "Controller\t:  ";
			
		}else if(type.indexOf("Service")>-1){
			componentName="ServiceImpl		\t: ";
			
		}else if(type.indexOf("DAO")>-1){
			componentName="DAO		\t\t: ";
		}
		
		logger.debug("[Before] "+componentName + type + "." + methodName+ "()" );
		
		
		
		// Around Advice를 만든다. - proceedinjoin point를 만든다.
		Object obj=joinPoint.proceed();
		logger.debug("[After] "+ componentName + type+ "." + methodName + "()");
		return obj;
		
	}
}
