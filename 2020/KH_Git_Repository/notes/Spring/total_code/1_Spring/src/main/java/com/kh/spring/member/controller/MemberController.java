package com.kh.spring.member.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kh.spring.member.model.exception.MemberException;
import com.kh.spring.member.model.service.MemberService;
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
@SessionAttributes("loginUser")
@Controller
public class MemberController {
	//의존성주입 - 내가 mService 참조변수에  MemberServiceImpl객체를 넣는다.
	//제어의 반전을 통해서 객체를 새로 생성필요없이 넣는다.
	//Autowired는 DI이다(의존성 주입)
	//=> 결과 계속 객체생성없다. mService에는 동일한주소로 함=> 결합도가 낮아짐.
	//=> 인터페이스에 implemented된 클래스이름을 바꾸더라도, 그대로 적용된다.
	@Autowired
	private MemberService mService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	
	
	/*
	 [파라미터 전송방법]
	 1. HttpServletRequest을 통해 전송받기
	 	=> HttpServletRequest 객체의 getParameter() 메소드를 이용.
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
	
//	//4. @ModelAttribute Annotation방식
//	//여러개의 값들을 받아야할 때 => 객체로 받는다.
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public String login(@ModelAttribute Member m) {
//		
//		//결합도가 높은 코드: 좋은코드가 될 수가 없다.
//		//결합도가 낮추는게 좋다. 
//		//=> Interface를 사용하는게 좋다.
//		
//		//인터페이스는 레퍼런스 변수 역할을 한다. - 인터페이스를 넣는다해도 새로운객체를 만든다...
//		//결합도를 낮추기위해서는?
////		MemberService mService= new MemberServiceImpl();
////		System.out.println(mService);
//		Member loginUser= mService.memberLogin(m);
//		System.out.println(loginUser);
//		return "redirect:home.do";
//		
//	}
	
	
	// 5. @ModelAttribute생략하기.
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public String login(Member m) {
//		System.out.println("id: "+ m.getId());
//		System.out.println("pwd: "+ m.getPwd());
//		System.out.println(m);
//		
//		return "redirect:home.do";
//	}

	
	
	// 2020.10.19
	
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public String login(@ModelAttribute Member m, HttpSession session) {
//		
//		Member loginUser= mService.memberLogin(m);
//		
//		if(loginUser!=null) {
//			session.setAttribute("loginUser",loginUser);
//		}
//		
//		return "redirect:home.do";
//		
//	}
	
	// 요청 후 전달하고자 하는 데이터가 있을 경우.
	// 1. Model 객체를 사용한다. 
	/*
	 Model => 값을 갖겠다
	 => map형식: (key, value)
	 => scope: request
	 * */
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public String login(@ModelAttribute Member m, HttpSession session, Model model) {
//		
//		Member loginUser= mService.memberLogin(m);
//		
//		//login.me 위치 : "/WEB-INF/views/member"
//		if(loginUser!=null) {
//			session.setAttribute("loginUser",loginUser);
//			return "redirect:home.do";
//		} else {
//			model.addAttribute("message", "로그인에 실패하였습니다.");
//			
//			return "../common/errorPage";
//		}
//	}
	
	//2. Model & View
	/*
	 내가 보내줄값(Model: map(Key, Value))과 
	 최종적으로 보여줄 뷰(View: RequestDispatcher.forward할 뷰페이지 정보를 담고있다.)
	 까지 같이 보내준다.
	 
	 반환타입은  ModelAndView
	 * */
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public ModelAndView login(@ModelAttribute Member m, HttpSession session, ModelAndView mv) {
//		
//		Member loginUser= mService.memberLogin(m);
//		
//		//login.me 위치 : "/WEB-INF/views/member"
//		if(loginUser!=null) {
//			session.setAttribute("loginUser",loginUser);
//			mv.setViewName("redirect:home.do"); //mv.setViewName: 뷰네임을 넘긴다.
//			
//		} else {
//			mv.addObject("message", "로그인에 실패하였습니다.");
//			mv.setViewName("../common/errorPage");
//		}
//		return mv;
//	}
	
	
	//3. session에 저장할 때 @SessionAttributes를 사용.
	// Model에 Attribute를 추가될때 자동으로 키를 찾아 세션에 등록하는 기능을 제공한다.
//	@RequestMapping(value="login.me", method=RequestMethod.POST)
//	public String login(@ModelAttribute Member m, Model model) {
//		
//		Member loginUser= mService.memberLogin(m);
//		
//		//login.me 위치 : "/WEB-INF/views/member"
//		if(loginUser!=null) {
//			//loginUser가 있으면 Session에 올린다.
//			// => key: "loginUser"
//			// => value: 래퍼런스변수명이 loginUser인 Member객체)
//			model.addAttribute("loginUser",loginUser);
//			return "redirect:home.do";
//			
//		} else {
//			model.addAttribute("message", "로그인에 실패하였습니다.");
//			return "../common/errorPage";
//		}
//	}
	
	//암호화 후 로그인
	@RequestMapping(value="login.me", method=RequestMethod.POST)
	public String login(@ModelAttribute Member m, Model model) {
		Member loginUser= mService.memberLogin(m);
		
		//bcryptPasswordEncoder.matches(rawPassword, encodedPassword)
		/*
		 * rawPassword :(m.getPwd()) 암호화되지 않은 패스워드
		 * encodedPassword: (loginUser.getPwd()) 암호화가 된 인코딩된 패스워드
		 * 
		 * 어떻게 매치되는지는 공개되어있지 않다.
		 * 맞으면 true / 틀리면 false => boolean타입으로 반환함.
		 * */
		boolean isPwdCorrect= bcryptPasswordEncoder.matches(m.getPwd(),  loginUser.getPwd());
		if(isPwdCorrect) {
			//비밀번호가 맞으면 넘어간다.
			model.addAttribute("loginUser", loginUser);
		}else {
			//비밀번호가 틀리면 exception을 발생
			throw new MemberException("로그인에 실패하였습니다.");
		}
		
		System.out.println(m);
		
		return "redirect:home.do";
	}
	
	// 로그아웃 컨트롤러
	//로그아웃 컨트롤러 1.
	//로그인 2번방법
//	@RequestMapping("logout.me")
//	public String logout(HttpSession session) {
//		session.invalidate();
//		return "redirect:home.do";
//	}
	
	//로그아웃 컨트롤러 2.
	//3번방법
	@RequestMapping("logout.me")
	public String logout(SessionStatus status) {
		status.setComplete();
		return "redirect:home.do";
	}
	
	//회원가입  페이지로 이동
	@RequestMapping("enrollView.me")
	public String enrollView() {
		return "memberJoin";
	}
	
	//회원가입하기
	@RequestMapping("minsert.me")
	public String insertMember(@ModelAttribute Member m, @RequestParam("post") String post,
														 @RequestParam("address1") String address1,
														 @RequestParam("address2") String address2) {
		//멤버를 어떻게 받을까? => 필드가 너무 많으니까.. 
		//					 ModelAttribute를 이용하여 한번에 멤버정보를 받자.
		//ContextLoaderListener: 서버를 돌아가고있는데, 백단(컨트롤러, 서비스, dao)수정할경우에 발생(업데이트 안된상태)
		//해결방법: 다시 서버를 시작하는게 좋다.
		
		//주소값 세팅
		m.setAddress(post+ " / " + address1 + " / " + address2);
//		System.out.println(m);

		
		//[암호화처리]
		// 암호화처리 - 비밀번호 평문이 보이므로, 암호화를 한다.
		//bcrypt 암호화 방식을 사용한다.
		/*[bcrypt]
		 => 1차로 암호화된 메세지를 수학적 연산을 통해 암호화 된 메시지인 digest를 생성.
		 => salt값 : "랜덤값(random value)"  
		 	값을 랜덤하게 생성하여 암호화가 계속 다르게 나오도록 함.
		 => 라이브러리 추가하기: pom.xml에서 추가한다.
		 * */
		String encPwd= bcryptPasswordEncoder.encode(m.getPwd());
		System.out.println("encPwd=>"+ encPwd);
		m.setPwd(encPwd);
		
		int result=mService.insertMember(m);
		//System.out.println(m);
		if(result>0) {
			return "redirect:home.do";
		}else {
			throw new MemberException("회원가입에 실패하였습니다");
		}
	}
	
	@RequestMapping("myinfo.me")
	public String myInfoView() {
		return "mypage";
	}
	
	@RequestMapping("mupdateView.me")
	public String updateFormView() {
		//회원정보 수정페이지를 불러온다.
		return "memberUpdateForm";
	}
	
	
	@RequestMapping("mupdate.me")
	public String updateMember(@ModelAttribute Member m, @RequestParam("post") String post,
														 @RequestParam("address1") String addr1,
														 @RequestParam("address2") String addr2, Model model) {
		m.setAddress(post + " / "+ addr1 + " / "+ addr2);
		int result=mService.updateMember(m);
		if(result>0) {
			//세션에 있는것도 같이 수정
			model.addAttribute("loginUser", m);
			return "mypage";
		}else {
			throw new MemberException("회원정보 수정에 실패하였습니다.");
		}
	}
	
	/*2020.10.19 homework - 비밀번호 수정  & 회원탈퇴*/
	//비밀번호 수정폼 페이지를 불러온다.
	@RequestMapping("mpwdUpdateView.me")
	public String updatePwdFormView() {
		//비밀번호 수정페이지를 불러온다.
		return "memberPwdUpdateForm";
	}
	
	//비밀번호 수정버튼을 누를때 -> 비밀번호 수정 기능을 수행한다.
	@RequestMapping("mPwdUpdate.me")
	public String updatePwd(@ModelAttribute Member m, Model model, SessionStatus status, @RequestParam("pwd") String pwd,
																						 @RequestParam("newPwd1") String newPwd1,
																						 @RequestParam("newPwd2") String newPwd2) 
	{
		// raw Member m
		// m.getPwd(): 암호화 되기 이전의 비밀번호를 출력한다.
		System.out.println("현재 계정의 비밀번호 m.getPwd() => "+ m.getPwd());
		
		// loginUser
		Member loginUser=(Member)model.getAttribute("loginUser");
		System.out.println("현재로그인 계정 loginUser: "+loginUser);
		
		//loginUser.getPwd(): 암호화된 이후의 비밀번호를 출력한다.
		System.out.println("loginUser.getPwd: "+loginUser.getPwd());
		
		//memberPwdUpdateForm.jsp에서 입력받은 비밀번호들을 불러온다.
		//함수의 매개변수인 매개변수의 @RequestParam()을 통해서 폼에서 입력받은 비밀번호 데이터들을 받는다.
		System.out.println("pwd => "+ pwd);
		System.out.println("newPwd1 => "+ newPwd1);
		System.out.println("newPwd2 => "+ newPwd2);
		
		//memberPwdUpdateForm.jsp 에서  입력받은 "현재 비밀번호"(pwd)를 구하자.
		//"현재 비밀번호"와 loginUser.getPwd()가 일치하는가?

		//bcryptPasswordEncoder.matches(rawPassword, encodedPassword)
		//	rawPassword: 암호화 되기 이전 비밀번호 => 입력받은 비밀번호(pwd)
		//	encodedPassword: 암호화 된 후의 비밀번호 => loginUser.getPwd()
		boolean isCorrectCurrentPwd=bcryptPasswordEncoder.matches(pwd, loginUser.getPwd());
		System.out.println("isCorrectCurrentPwd: "+ isCorrectCurrentPwd);
		
		if(isCorrectCurrentPwd) {
			//"현재 비밀번호"와 loginUser.getPwd()가 일치하다.
			//newPwd1과 newPwd2가 서로 일치하는가?
			boolean isEqualNewPwds= newPwd1.equals(newPwd2);
			if(isEqualNewPwds) {
				//새로운 비밀번호 2개 모두 일치
				
				//새로운 비밀번호를 암호화한다.
				String encNewPwd= bcryptPasswordEncoder.encode(newPwd2);
				
				//비밀번호를 새로운 비밀번호로 변경시킨다.
				m.setId(loginUser.getId());
				m.setPwd(encNewPwd);
				
				System.out.println(m);
				//서비스를 호출하여 비밀번호 변경기능 수행.
				int result=mService.updatePwd(m);
				if(result>0) {
					//비밀번호 수정이완료되면 로그아웃을 시키자.
					status.setComplete();
					return  "redirect:home.do";
				}else {
					throw new MemberException("비밀번호 변경에 실패하였습니다.");
				}
				
			}else {
				//새로운 비밀번호 2개 모두 불일치
				throw new MemberException("새로운 비밀번호가 서로 일치하지 않습니다!");
			}
		}else {
			//비밀번호가 일치하지 않다.=> 예외 발생
			throw new MemberException("입력한 비밀번호가 일치하지 않습니다.");
		}
		/*
		 //선생님 답
		 //아이디 얻기; 정보 수정만 했을 때 비밀번호가 없을 것을 예상하여 모든 정보를 새로 얻어오는 과정.
		 Member m= mService.memberLogin((Member) session.getAttribute("loginUser"));
		 if(bcryptPasswordEncoder.matches(pwd, m.getPwd()){
		 	String encNewPwd= bcryptPasswordEncoder.encode(newPwd);
		 	m.setPwd(encNewPwd);
		 	
		 	HashMap<String, String> map= new HashMap<>();
		 	map.put("id", m.getId());
		 	map.put("newPwd", encNewPwd);
		 	int result= mService.updatePwd(map);
		 	if(result>0){
		 		return "mypage";
		 	}else{
		 		throw new MemberException("비밀번호를 수정하였습니다.");
		 	}
		 }else{
		 	throw new MemberException("기존 비밀번호가 틀렸습니다.");
		 }
		 
		  
		 * */

	}
	
	//회원탈퇴
	@RequestMapping("mdelete.me")
	public String deleteMember(@ModelAttribute Member m, Model model, SessionStatus status) {
		
		Member loginMember=(Member)model.getAttribute("loginUser");
//		System.out.println("m=> "+ m);
		int result=mService.deleteMember(m);
		if(result>0) {
			//탈퇴 성공!
			status.setComplete(); //로그아웃 시키고
			return "redirect:home.do"; //원래 홈페이지로 돌아간다.
		}else {
			//탈퇴 실패!
			throw new MemberException("회원탈퇴하는데 실패하였습니다.");
		}
	}
	
	
	@RequestMapping("dupid.me")
	public void dupId(String id, HttpServletResponse response) throws IOException {
		int result= mService.checkIdDup(id);
		boolean isUsable= (result ==0)? true: false;
		
		//PrintWriter을 이용
		response.getWriter().print(isUsable);
		
	}
}
