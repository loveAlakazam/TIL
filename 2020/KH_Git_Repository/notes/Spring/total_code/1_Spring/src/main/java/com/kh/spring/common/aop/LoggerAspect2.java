package com.kh.spring.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component 	//bean을 등록하기 위해서.
@Aspect		//aspect를 만들겠다.
public class LoggerAspect2 {
	//annotation 방식
	
	private Logger logger= LoggerFactory.getLogger(LoggerAspect2.class);
	
	// Pointcut을 집어넣는다. - 실제 어디서부터 들어가야될지 시점을 넣는다.
	// 부를 이름이 없다.
	//@Pointcut("execution(* com.kh.spring.board..*(..))")
	//public void myPointcut() {} 
	//부를 이름을 부르기 위해서 존재하는 메소드
	//메소드 내용에는 아무것도 넣으면 안된다. (주석은 가능)
	//부를 이름을 만든다. bean의 이름(pointCut의 이름) myPointcut이야~
	
	
	//이 메소드를 양쪽끝에 들어갈게. - 들어갈 시점(point-cut)의 이름은 myPointcut이야.
	//@Around("myPointcut()")
	@Around("execution(* com.kh.spring.board..*(..))") //point-cut메소드 없이 한번에 ~
	public Object loggerAdvice(ProceedingJoinPoint joinPoint) throws Throwable {
		// 메소드 명/ 리턴타입을 반환
		
		// getSignature(): AOP가 적용되는 메소드 정보를 반환한다.
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
