package com.kh.spring.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.service.MemberServiceImpl;
import com.kh.spring.member.model.vo.Member;

/*controller로 가기위해서...
 
 사용자정의 클래스: Member.java
 API 사용 클래스: String, Date, DispatcherServlet
 
 XML을 통해서 만드는 방법
 - 기존에 있는 클래스 String, Date
 
 annotation 통해서 만드는 방법
 - 클래스가 있어야함
 - @(annotation)을 달아야한다.

 
 MemberController라는 클래스를 생성한다.
 
 
 제어의 반전: 
 프레임워크가 객체의 생성부터 모든 생명주기를 담당한다.
사용자가 아닌 프레임워크가 제어권을 갖는다.
 
 일반객체를 만들때는 @Component를 이용.
 
@Controller
: @Component의 확장판 =>(@Component + Controller의 성격추가)
: 
 
 * */
@Controller
public class MemberController {
	//의존성주입 - 내가 mService 참조변수에  MemberServiceImpl객체를 넣는다.
	//제어의 반전을 통해서 객체를 새로 생성필요없이 넣는다.
	//Autowired는 DI이다(의존성 주입)
	//=> 결과 계속 객체생성없다. mService에는 동일한주소로 함=> 결합도가 낮아짐.
	//=> 인터페이스에 implemented된 클래스이름을 바꾸더라도, 그대로 적용된다.
	@Autowired
	private MemberService mService;
	
	
	
	/*
	 [파라미터 전송방법]
	 1. HttpServletRequest을 통해 전송받기
	 	=> JSP/Servlet방식
	 	
	 2. requestAnnotation param
	 */
	
	// [JSP/Servlet 방식 ] HttpServletRequest
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public String login2(HttpServletRequest request) {
//		// JSP/Servlet 방법
//		String id= request.getParameter("id");
//		String pwd= request.getParameter("pwd");
//		
//		System.out.println("id: "+ id);
//		System.out.println("pwd: "+ pwd);
//		
//		return "redirect:home.do";
//	}
	
	
	// 2. @RequestParam annotation방식
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public String login(@RequestParam("id") String id, @RequestParam("pwd") String pwd) {
//		System.out.println("id: "+ id);
//		System.out.println("pwd: "+ pwd);
//		
//		return "redirect:home.do";
//	}
	
	// 3. @RequestParam annotation 생략
	// menubar.jsp의 input태그의 name중 id와 pwd인 것들을 가져옴.
	// RequestParam : 생략보다는 @RequestParam을 써주는게 좋다.
	// 다른사람들이 알아볼수있도록...! 읽기가 편함. 뷰에있는것을 전송했음을 가독성이 좋음.
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public String login(String id, String pwd) {
//			
//			System.out.println("id: "+ id);
//			System.out.println("pwd: "+ pwd);
//			
//			return "redirect:home.do";
//	}
	
	//4. @ModelAttribute Annotation방식
	//여러개의 값들을 받아야할 때 => 객체로 받는다.
	@RequestMapping(value="login.me", method=RequestMethod.POST)
	public String login(@ModelAttribute Member m) {
		
		//결합도가 높은 코드: 좋은코드가 될 수가 없다.
		//결합도가 낮추는게 좋다. 
		//=> Interface를 사용하는게 좋다.
		
		//인터페이스는 레퍼런스 변수 역할을 한다. - 인터페이스를 넣는다해도 새로운객체를 만든다...
		//결합도를 낮추기위해서는?
//		MemberService mService= new MemberServiceImpl();
//		System.out.println(mService);
		mService.memberLogin(m);
		return "redirect:home.do";
	}
	
	// 5. @ModelAttribute생략하기.
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public String login(Member m) {
//		System.out.println("id: "+ m.getId());
//		System.out.println("pwd: "+ m.getPwd());
//		System.out.println(m);
//		
//		return "redirect:home.do";
//	}
	
}
