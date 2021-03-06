> # Logger와 Interceptor

> # Logger

<br>

Spring프로젝트를 시작하다보면 Console에 빨간색 글씨가 보일것이다. 수많은 로그들을 출력한다.

<br>

특히 HomeController.java 코드의 `logger.info("Welcome home! The client locale is {}.", locale);` 라는 메소드가 로그이다!

<br>

> ### HomeController.java

```java
package com.kh.spring;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	//클래스에 대한 정보를 같이 보내줘야 로그출력이 가능하다.
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping(value = "/home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		return "home";
	}
}
```

<br>

로그를 관리하는 파일은 **`src/min/resources/log4j.xml`** 이다.

<br>

`log4j.xml` 파일에는 크게보면 `<appender>`와 `<logger>`, `<root>` 로 구성되어있다.

> ### log4j.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE log4j:configuration PUBLIC "-//APACHE//DTD LOG4J 1.2//EN" "log4j.dtd">
<log4j:configuration xmlns:log4j="http://jakarta.apache.org/log4j/">

  <!--appender 태그 -->
  <appender name="console" class="org.apache.log4j.ConsoleAppender">
		<param name="Target" value="System.out" />

		<layout class="org.apache.log4j.PatternLayout">

			<param name="ConversionPattern" value="%-5p: %c 테스트입니다. - %m%n" />
		</layout>
	</appender>

  <!-- logger태그 -->
  <logger name="com.kh.spring">
		<level value="info" />
		<appender-ref ref="console"/>
	</logger>

  <!-- 3rdparty Loggers -->
  <logger name="org.springframework.core">
    <level value="info" />
  </logger>

  <logger name="org.springframework.beans">
    <level value="info" />
  </logger>

  <logger name="org.springframework.context">
    <level value="info" />
  </logger>

  <logger name="org.springframework.web">
    <level value="info" />
  </logger>



  <!-- Root Logger -->
  <root>
    <priority value="warn" />
    <appender-ref ref="console" />

  </root>
</log4j:configuration>

```

<br><br>

> ### <root> (root Logger) : 모든 자식 logger들의 출력은 root로거를 거쳐서 이뤄진다.

```xml
<root>
	<priority value="warn" />
	<appender-ref ref="console" />
</root>
```

<br>

여기서 보면, `appender-ref ref="console"`인 것을보아, 루트로거는 `name="console"`인 appender을 참조한다.

```xml
<appender name="console" class="org.apache.log4j.ConsoleAppender">
  <param name="Target" value="System.out" />

  <layout class="org.apache.log4j.PatternLayout">
    <param name="ConversionPattern" value="%-5p: %c - %m%n" />
  </layout>
</appender>
```

<br>

위의 이름이 console인 로그를 뜯어보자.

`<appender name="console" class="org.apache.log4j.ConsoleAppender">`

- 이름이 **console**이다.
- `<logger>`나 `<root>`에 `<appender-ref ref="console"/>`이라함은, **이름이 console인 appender을 참고한다**는 의미이다.

<br>

- 이름이 console인 appender은 org.apache.log4j 패키지에 위치한  **ConsoleAppender이라는 객체를 불러온다.**

<br>

<layout class="org.apache.log4j.PatternLayout">안에 있는 **`<param name="ConversionPattern" value="%-5p: %c - %m%n" />`** 은 우리가 프로젝트를 실행했을 때 (home.do url을 호출했을때) 나타내는 로그이다.

<br>

우리는 프로젝트를 실행할때마다, 페이지를 이동할때마다 아래와 같은 로그들을 봤다.

```
INFO : org.springframework.web.context.ContextLoader - Root WebApplicationContext initialized in 10280 ms

INFO : org.springframework.web.servlet.DispatcherServlet - Initializing Servlet 'boardServlet'
```

<br>

이렇게 출력할 수 있는것은 바로 **`<param name="ConversionPattern" value="%-5p: %c - %m%n" />`** 포맷터를 적용해서 콘솔에 출력했기 때문이다.

그러면 어디 코드에서 콘솔에 출력하라고 명시해놨을까?

<br>

그에 대한 답은 **`<param name="Target" value="System.out" />`** 의 value에 해당한다. 즉 value에 해당하는 부분은 `System.out.print()`는 자바를 시작한 우리에게 아주 익숙한 콘솔 출력문이다.

<br>

다시 name="console"인 appender을 정리해보자.

```xml
<appender name="console" class="org.apache.log4j.ConsoleAppender">
  <param name="Target" value="System.out" />
  <layout class="org.apache.log4j.PatternLayout">
    <param name="ConversionPattern" value="%-5p: %c - %m%n" />
  </layout>
</appender>
```

<br>

그러면 <appender>태그가 어떤역할을 하는지 모르고 우리는 한번 코드를 뜯어봤다. 그렇다면  <appender>태그는 어떤 역할을 하는 걸까?

> ## appender : 로그가 전달 됐을 때, **전달된 로그를 어디에 출력**할 지를 결정

<br>

> ## appender를 이용하여 **어디서** 로그를 출력하는지?

|종류|설명|
|:--:|:--:|
|ConsoleAppender|로그를 콘솔에 출력한다.|
|JDBCAppender|로그를 Database에 출력한다.|
|FileAppender|로그를 파일에 출력한다.|
|RollingFileAppender|파일에 로그 출력하는 FileAppender을 보완한다.<br>일정 조건후, 기존 파일을 백업파일로 바꾸 다시 처음부터 시작한다. (예: DailyRollingFileAppender)|
|DailyRollingFileAppender|이전에 기록된 로그를 백업으로 하고, 다시 처음부터 시작한다.|

<br><br>

> ## 로그 출력 포맷터에 대한 제어문자

|제어문자 종류|설명|
|:--:|:--:|
|%p|로그 레벨(debug< info< warn < error< fatal)을 출력|
|%m|로그 내용을 출력|
|%d|로깅 이벤트가 발생한 시간을 출력|
|%t|로그 이벤트가 발생한 스레드 이름을 출력|
|%%|%를 출력|
|%n|엔터=개행문자 를 출력|
|%c|package(카테고리)를 출력|
|%c{n}|n(숫자)만큼의 package를 가장 하단부턴 역으로 출력<br>패키지가 a.b.c로 되어있다면, %c{2}의 경우에는 b.c를 출력한다.|
|%C|호출자의 클래스명을 출력한다.<BR>클래스 구조가 a.b.c처럼 되어있다면, %C{2}의 경우에도 b.c로 출력한다.|
|%F|로깅이 발생한 프로그램 파일명을 출력한다.|
|%l|로깅이 발생한 caller의 정보를 출력한다.|
|%L|로깅이 발생한 caller의 라인수를 출력한다.|
|%M|로깅이 발생한 메소드이름을 출력한다.|
|%r|애플리케이션 시작 이후부터 로깅이 발생한 시점의 시간(단위: milliseconds, ms)를 출력한다.|

<br><br>

> ## logger (Application logger)

```xml
<logger name="com.kh.spring">
  <level value="info"/>
  <appender-ref ref="console"/>
</logger>
```

<br>

- ### `<level value="info"/>` : 로그를 출력할 수 있는 레벨을 의미한다.

- ### `<appender-ref ref="console">` : 이름이 console인 `<appender>`을 참고한다.

- ### `<logger name="com.kh.spring" additivity="false">` : 중복출력을 중지한다. `<root>`(루트로거)를 거치지 않음을 의미한다.

<br><br>

> ## 로그 레벨

- 로그 레벨에서 debug < info < warn < fatal 순으로 되어있다.
- 오른쪽위치(아래 표에서 아래로 갈 수록) 주의를 해야하는 레벨이다.
- 만약에 `<logger>`태그에서 설정한 레벨이 **info**라면
  - 이전인 debug레벨은 로그를 출력하지 않고
  - info이후의 레벨인, info, warn, fatal일때만 로그를 출력한다.

<br>

|로그 레벨|설명|
|:--:|:--:|
|trace|debug의 레벨이 광범위하기 때문에 자세한 이벤트를 나타낼때나 정보를 추적할 때 사용된다.|
|debug|개발시 디버그 용도로 사용되는 메시지이다.|
|info|상태변경을 나타내는 정보성 메시지이다.|
|warn|에러가 발생할 수 있다는 경고성 메시지이다.<br>프로그램 실행중에는 문제가 없지만, 나중에 에러의 원인이 될 수있다는 경고성 메시지이다.|
|error|심각한 에러는 아니지만, 어떤 요청을 처리할때 발생하는 에러를 나타내는 메시이다.|
|fatal|아주 심각한 에러일 때 발생하는 메시지이다.|

<br><br>

<hr>

> ## Logger 실습하기 1 - 콘솔에 로그를 출력하기.

```
DEBUG: MemberController.enrollView{300} - 회원등록페이지
라는 로그를 콘솔에 출력해보자.

- {300} 안의 300은 라인수를 나타낸다.
- 조건: 새로운 Appender를 추가하여 중복 로그를 출력하지 않도록한다.
```
<br>

> ## 풀이 과정

### 1. MemberController.java 에서 enrollView()메소드에서 로거를 호출

- (1-1) LoggerFactory객체를 호출하여 logger을 호출한다.

```java
private Logger logger= LoggerFactory.getLogger(MemberController.class);
```

<br>

- (1-2) enrollView() 메소드에서 로거를 호출한다.

```java
//회원가입  페이지로 이동
@RequestMapping("enrollView.me")
public String enrollView() {

  // 현재 logger가 debug레벨인지 확인한다.
  if(logger.isDebugEnabled()) {
    // debug레벨이라면, 해당 로그를 출력한다. (콘솔에!)
    logger.debug("회원 등록 페이지");
  }
  return "memberJoin";
}
```

<br>

- MemberController.java

```java
@SessionAttributes("loginUser")
@Controller
public class MemberController{
  @Autowired
  private MemberService mService;

  @Autowired
  private BcryptPasswordEncoder bcryptPasswordEncoder;

  // 1. LoggerFactory객체로부터 logger을 갖고온다.
  private Logger logger= LoggerFactory.getLogger(MemberController.class);

  //중략//

  @RequestMapping("enrollView.me")
  public String enrollView() {

  	// 디버그 레벨인지 확인한다.
  	if(logger.isDebugEnabled()) {
      //2. 디버그 레벨의 로그를 콘솔에 출력한다.
  		logger.debug("회원 등록 페이지");
  	}
  	return "memberJoin";
  }
}
```

<br><br>

### 2. log4j.xml 에서 `<appender>` 와 `<logger>`을 추가한다.

### (2-1) `<appender>`을 추가한다.

```xml
<appender name="myConsole" class="org.apache.log4j.ConsoleAppender">
		<param name="Target" value="System.out" />
		<layout class="org.apache.log4j.PatternLayout">
			<param name="ConversionPattern" value="%-5p: %c{1}.%M{%L} - %m%n" />
		</layout>
	</appender>
```

<br>

- #### **`<appender name="myConsole" class="org.apache.log4j.ConsoleAppender">`**
  - `name=myConsole` : appender이름을 myConsole로 한다.
  - `class="org.apache.log4j.ConsoleAppender"`
    - 콘솔에서 로그를 출력한다
    - ConsoleAppender은 org.apache.log4j 패키지에 존재한다.

- #### **`<param name="Target" value="System.out"/>`**
  - System.out.print 을 이용하여 콘솔에 출력한다.

- #### **`<param name="ConversationPattern" value="%-5p: %c{1}.%M{%L} - %m%n">`**
  - **`%-5p`** : 왼쪽정렬하여, 로그레벨(debug/ info/ warn / fatal)를 출력한다
    - 위에서 MemberController의 enrollView()메소드에서 logger.info()로 로거를 호출했으므로
    - **enrollView()메소드를 호출할 때마다, 로그레벨 info, warn, fatal에 대한 로그만 출력을 한다.**

  - **`%c{1}`**: 클래스 패키지(카테고리) 중 가장 오른쪽에 있는 것을 출력
    - `%c` : com.kh.spring.member.controller.MemberController
    - `%c{1}` : MemberController

  - **`%M`** : 로그가 발생한 메소드 이름을 출력
    - `%M` : enrollView

  - **`%L`** : caller의 라인수를 출력

  - **`%m`** : 로거에서 전송하려는 메시지를 출력
    - 위의 컨트롤러를 참고하면, `회원등록 페이지` 를 의미한다.

  - **`%n`** : 개행문자.

<br>

### (2-2) 위의 appender을 참고하는 `<logger>`을 추가한다.

```xml
<logger name="com.kh.spring.member.controller.MemberController" additivity="false">
  <level value="debug"/>
  <appender-ref ref="myConsole"/>
</logger>
```

<br><br>


> ### log4j.xml

```xml
<appender name="myConsole" class="org.apache.log4j.ConsoleAppender">

  <param name="Target" value="System.out">
  <layout class="org.apache.log4j.PatternLayout">
    <param name="ConversionPattern" value="%-5p: %c{1}.%M{%L} - %m%n"/>
  </layout>
</appender>

<logger name="com.kh.spring.member.controller.MemberController" additivity="false">
  <level value="debug"/>
  <appender-ref ref="myConsole"/>
</logger>

```

<br><br><br>

<hr>

> ## Logger 실습하기 2 - 파일에 로그를 저장하기

```
MemberController.java에서
로그인을 할때마다 로그파일을 만들어서
파일에 로그를 기록하도록 해보자.
```

- ### (1) MemberController.java의 로그인(login.me)할 때마다 로그를 불러옵니다.

```java
@SessionAttributes("loginUser")
@Controller
public class MemberController{
  @Autowired
  private MemberService mService;

  @Autowired
  private BcryptPasswordEncoder bcrytPasswordEncoder;

  //1. logger 추가하기
  private Logger logger= LoggerFactory.getLogger(MemberController.class);


  @RequestMapping(value="login.me", method=RequestMethod.POST)
  public String login(@ModelAttribute Member m, Model model) {
    Member loginUser= mService.memberLogin(m);
    boolean isPwdCorrect= bcryptPasswordEncoder.matches(m.getPwd(),  loginUser.getPwd());

    if(isPwdCorrect) {
      model.addAttribute("loginUser", loginUser);

      //2. 로그를 호출하여, info레벨부터 로그를 파일에 출력한다.
      // 이때 출력되는 로그는 로그인한 회원아이디이다.
      logger.info(loginUser.getId());

    }else {
      throw new MemberException("로그인에 실패하였습니다.");
    }

    System.out.println(m);
    return "redirect:home.do";
  }
}
```

<br>

- ### (2) `log4j.xml`파일에서  logger을 등록합니다.
```xml
<logger name="com.kh.spring.member.controller.MemberController" additivity="false">
	<level value="debug"/>

  <!--myConsole 이란 이름의 appender을 참조한다. -->
	<appender-ref ref="myConsole"/>

  <!--(logger등록) myDailyRollingFile 이란 이름의 appender을 참조한다. -->
	<appender-ref ref="myDailyRollingFile"/>
</logger>
```

<BR>

- ### (3) (2)에서 등록한 logger을 참조하는 appender을 만듭니다!

```xml
<!-- DailyRollingFileAppender은 파일에 로그기록을 출력하도록 하는 객체입니다.-->
<appender name="myDailyRollingFile" class="org.apache.log4j.DailyRollingFileAppender">
	<!--로그 파일 위치를 정한다. -->
  <!--로그파일 login.log의 위치는: C드라이브의 logs/member에 있습니다.-->
	<param name="File" value="/logs/member/login.log"/>
	<param name="Append" value="true"/>

	<!--로그파일 인코딩 설정 -->
	<param name="encoding" value="UTF-8"/>
	<param name="DataPattern" value="'.'yyyyMMdd"/>

  <!--로그 출력 형식을 나타낸다.-->
	<layout class="org.apache.log4j.PatternLayout">
		<param name="ConversionPattern" value="%d{yy-MM-dd HH:mm:ss} [%p] %c{1}.%M{%L} - %m%n"/>
	</layout>
</appender>
```

<br><br>

- ### (2), (3) 전체 코드 - log4j.xml

```xml
<!--appender -->
<appender name="myDailyRollingFile" class="org.apache.log4j.DailyRollingFileAppender">
	<!--로그 파일 위치를 정한다. -->
	<param name="File" value="/logs/member/login.log"/>
	<param name="Append" value="true"/>

	<!--로그파일 인코딩 설정 -->
	<param name="encoding" value="UTF-8"/>
	<param name="DataPattern" value="'.'yyyyMMdd"/>

  <!--로그 출력 형식을 나타낸다.-->
	<layout class="org.apache.log4j.PatternLayout">
		<param name="ConversionPattern" value="%d{yy-MM-dd HH:mm:ss} [%p] %c{1}.%M{%L} - %m%n"/>
	</layout>
</appender>

<!-- logger -->
<logger name="com.kh.spring.member.controller.MemberController" additivity="false">
		<level value="debug"/>
		<appender-ref ref="myConsole"/>

    <!--myDailyRollingFile 이란 이름의 appender을 참조한다. -->
		<appender-ref ref="myDailyRollingFile"/>
</logger>
```

<br>

- ### login.log 파일

![](./login_log.PNG)

<br><br>

<hr>

> ## Controller을 기준으로, Interceptor과 AOP 과정을 포함한 요청처리과정


![](./spring3_pattern01.png)

<br>

![](./spring3_pattern02.png)

<br><br>

- 컨트롤러(Controller)를 기준으로 보내는 값과 받는 값을 처리
- 컨트롤러에 관한 요청이나 응답에 대한 처리가 필요한 경우에는 Interceptor을 이용한다.
  - Interceptor은 DispatcherServlet에서 호출했느냐의 관점을 컨트롤러로 할 수 있다.

  - Interceptor을 구성하는 3개의 메소드가 있다.
    - 컨트롤러를 실행하기 전: **preHandler()**
    - 컨트롤러를 실행한 후: **postHandler()**
    - 모든 작업을 완료시킨 후: **afterCompletion()**

<BR>

<hr>

> ## Interceptor을 이용하여 로그를 출력하자.

- Interceptor 클래스는 **`common.kh.spring.interceptor`** 패키지에 위치한다.

- ### 1. TestInterceptor.java

```java
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
	 * preHandle:  Controller를 호출하기 전에 수행한다.
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
		logger.debug("=============== VIEW =============");
	}

	/*
	 * afterCompletion: 최종결과를 생성하는 일을 포함한 모든 작업이 완료된 후에 수행한다.
	 * */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
    logger.debug("=============== END =============");
	}
}
```

<br>

- ### 2. log4j.xml

```xml
<!--아래 TestInterceptor이 참고하는 logger은 이름이 myConsole인 appender이다. -->
	<appender name="myConsole" class="org.apache.log4j.ConsoleAppender">
	<param name="Target" value="System.out" />
	<layout class="org.apache.log4j.PatternLayout">
		<param name="ConversionPattern" value="%-5p: %c{1}.%M{%L} - %m%n" />
	</layout>
</appender>

<logger name="com.kh.spring.common.interceptor.TestInterceptor" additivity="false">
	<level value="debug"/>
	<appender-ref ref="myConsole"/>
</logger>
```

<br>

- ### 3. servlet-context.xml 에서 interceptor을 등록합니다.

- (3-1)

```
web.xml에서는 웹애플리케이션 전체에 대한 정보를 나타냅니다.

web.xml에서 spring과 관련된 정보를 가진 servlet-context.xml 파일을 불러옵니다.

```

<br>

- (3-2) **`servlet-context.xml`** 에서 Interceptor을 등록합니다.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<beans:beans xmlns="http://www.springframework.org/schema/mvc"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:beans="http://www.springframework.org/schema/beans"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="http://www.springframework.org/schema/mvc https://www.springframework.org/schema/mvc/spring-mvc.xsd
		http://www.springframework.org/schema/beans https://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd">
	<annotation-driven />

	<resources mapping="/resources/**" location="/resources/" />
	<beans:bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<beans:property name="prefix" value="/WEB-INF/views/" />
		<beans:property name="suffix" value=".jsp" />
	</beans:bean>

	<context:component-scan base-package="com.kh.spring" />



	<!--  interceptor을 등록합니다. -->
	<interceptors>
		<interceptor>
      <!--
        전체 url을 요청할때마다 TestInterceptor을 호출합니다.
     -->
			<mapping path="/**"/>
			<beans:bean id="testInterceptor" class="com.kh.spring.common.interceptor.TestInterceptor"/>
		</interceptor>
	</interceptors>

</beans:beans>
```

<br>

- ### 수행결과

```
DEBUG: TestInterceptor.preHandle{22} - ========== START =============
DEBUG: TestInterceptor.preHandle{23} - /spring/home.do
INFO : com.kh.spring.HomeController 테스트입니다. - Welcome home! The client locale is ko_KR. => 루트로거 호출
INFO : com.kh.spring.HomeController 테스트입니다. - Welcome home! The client locale is ko_KR. => 루트로거 호출
DEBUG: TestInterceptor.postHandle{35} - =============== VIEW =============
INFO : org.springframework.web.servlet.DispatcherServlet 테스트입니다. - Completed initialization in 2158 ms => 루트로거 호출
DEBUG: TestInterceptor.afterCompletion{45} - =============== END =============
```

<br>

위의 수행결과는 home.do url을 호출했을 때 콘솔에 출력된 로그들이다.

TestInterceptor의 수행결과를 볼 수 있다.

```
// preHandle() 메소드 호출: Controller을 수행하기 이전
DEBUG: TestInterceptor.preHandle{22} - ========== START =============

// postHandle() 메소드 호출: Controller을 수행한 이후
DEBUG: TestInterceptor.postHandle{35} - =============== VIEW =============

// afterCompletion() 메소드 호출: 모든 과정이 완료한 경우
DEBUG: TestInterceptor.afterCompletion{45} - =============== END =============
```

<br>

TestInterceptor은 모든 url요청에 대하여 호출하게 되므로

`member-context.xml` 과 `board-context.xml` 에도 Interceptor을 등록하면된다.

<br>

> ### member-context.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>

<!--  xmlns: 주로 사용함. -->
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xsi:schemaLocation="http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.3.xsd
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context-4.3.xsd">
	<mvc:annotation-driven/>
	<mvc:resources mapping="/resources/**" location="/resources/"/>

	<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<property name="prefix" value="/WEB-INF/views/member/"/>
		<property name="suffix" value=".jsp"/>
	</bean>
	<context:component-scan base-package="com.kh.spring"/>



	<!--inerceptor을 등록합니다-->
	<mvc:interceptors>
    <!-- TestInterceptor을 등록합니다.-->
		<mvc:interceptor>
			<mvc:mapping path="/**"/>
			<bean id="testInterceptor" class="com.kh.spring.common.interceptor.TestInterceptor"/>
		</mvc:interceptor>
	</mvc:interceptors>
</beans>
```

<br>

> ### board-context.xml

- 코드 뜯어보기

```xml
<mvc:interceptors>
  <!-- TestInterceptor을 등록합니다 -->
  <mvc:interceptor>

    <!-- 모든 url 요청을 받으면 TestInterceptor을 수행합니다.-->
    <mvc:mapping path="/**"/>
    <bean id="testInterceptor" class="com.kh.spring.common.interceptor.TestInterceptor"/>
  </mvc:interceptor>
</mvc:interceptors>
```

- board-context.xml 코드

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.3.xsd
		http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.3.xsd">

	<mvc:annotation-driven/>
	<mvc:resources location="/resources/" mapping="/resources/**"/>
	<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<property name="prefix" value="/WEB-INF/views/board/"/>
		<property name="suffix" value=".jsp"/>
	</bean>

	<context:component-scan base-package="com.kh.spring"/>


  <!-- interceptor을 등록합니다 -->
  <mvc:interceptors>
    <!-- TestInterceptor을 등록합니다 -->
  	<mvc:interceptor>
  		<mvc:mapping path="/**"/>
  		<bean id="testInterceptor" class="com.kh.spring.common.interceptor.TestInterceptor"/>
  	</mvc:interceptor>
  </mvc:interceptors>
</beans>
```

<br><br>

<hr>

> ## Interceptor을 이용한 실습 1

<br>

```
게시판은 로그인을 해야 이용할 수 있도록해보자.

즉, 로그아웃 상태에서 게시판 조회(blist.bo) 할 때

"로그인후 이용해주세요!" 라는 메시지를 출력해주는 Interceptor을 만들어보자.

로그아웃 상태에서는 게시판에 입장을 못하게 하자.
```

<br>

- ### 1. Interceptor 클래스를 만듭니다.
  - BoardEnterInterceptor.java 를 만듭니다.
  - Interceptor 클래스는 `src/main/java` > `com.kh.spring.common`에 위치한다.

> ### BoardEnterInterceptor.java

```java
package com.kh.spring.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.spring.member.model.vo.Member;

// 로그인을 하지 않으면 게시판 요청을 했을 때 "로그인 후 이용하세요" 라는 경고메시지를 띄운후
// 메인화면으로 가게 만드는 Interceptor
public class BoardEnterInterceptor extends HandlerInterceptorAdapter{

	//preHandler - blist.bo 요청이 들어가기 전에 요청을 수행하는 Controller을 수행하기 이전에!
  //컨트롤러에 url요청을 하기전에 경고성메시지를 띄워야하기때문에 preHandle을 사용한다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		Member loginUser= (Member)session.getAttribute("loginUser");

    //로그인이 안됐을 때만, 경고성 메시지를 띄우도록한다.
		if(loginUser==null) {
			request.setAttribute("msg", "로그인 후 이용하세요!");

      // home.jsp로 이동한다.
			request.getRequestDispatcher("WEB-INF/views/home.jsp").forward(request, response);
			return false;
		}

		return super.preHandle(request, response, handler); //항상 true를 반환한다.
	}
}

```

<br>

- ### 2. home.jsp에서 경고성메시지를 javascript의 alert()로 나타낸다.

> ### home.jsp

```jsp
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<style>
		#tb{margin: auto; width:700px;}
	</style>
</head>
<body>
	<c:import url="common/menubar.jsp"/>

  <%-- 경고성 메시지를 표현.--%>
	<script>
		$(function(){
			var msg='${msg}';
			if(msg!=''){
				alert(msg);
			}
		});
	</script>


	<h1 align="center">게시글 TOP5목록</h1>
	<table id="tb" border="1">
		<thead>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
				<th>첨부파일</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

	<script>
		function topList(){
			$.ajax({
				url: 'topList.bo',
				success: function(data){
					$tableBody=$('#tb tbody');
					$tableBody.html(''); //이미들어온것들을 더 추가못하게함.

					for(var i in data){
						var $tr =$('<tr>');
						var $bId= $('<td>').text(data[i].bId);//글번호
						var $bTitle=$('<td>').text(data[i].bTitle);//제목
						var $bWriter=$('<td>').text(data[i].bWriter);//작성자
						var $bCreateDate=$('<td>').text(data[i].bCreateDate);//날짜
						var $bCount=$('<td>').text(data[i].bCount);//조회수
						var $bFile=$('<td>').text(" ");//첨부파일
						if(data[i].originalFileName !=null){
							$bFile=$('<td>').text("O");
						}
						$tr.append($bId);
						$tr.append($bTitle);
						$tr.append($bWriter);
						$tr.append($bCreateDate);
						$tr.append($bCount);
						$tr.append($bFile);
						$tableBody.append($tr);
					}
				}
			});
		}

		$(function(){
			topList();
			setInterval(function(){
				topList();
			},5000);
		});
	</script>
</body>
</html>
```

<br>

- ### 3. board-context.xml 에서 interceptor을 등록합니다.
  - 1단계에서 만든 BoardEnterInterceptor을 등록합니다.

> ### board-context.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.3.xsd
		http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.3.xsd">

	<mvc:annotation-driven/>
	<mvc:resources location="/resources/" mapping="/resources/**"/>
	<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<property name="prefix" value="/WEB-INF/views/board/"/>
		<property name="suffix" value=".jsp"/>
	</bean>

	<context:component-scan base-package="com.kh.spring"/>


	<!--  interceptor을 등록합니다. -->
	<mvc:interceptors>

    <!-- TestInterceptor을 등록합니다. -->
		<mvc:interceptor>
			<mvc:mapping path="/**"/>
			<bean id="testInterceptor" class="com.kh.spring.common.interceptor.TestInterceptor"/>
		</mvc:interceptor>

    <!--BoardEnterInterceptor 을 등록합니다 -->
		<mvc:interceptor>
			<mvc:mapping path="/blist.bo"/>
			<bean id="boardEnterInterceptor" class="com.kh.spring.common.interceptor.BoardEnterInterceptor"/>
		</mvc:interceptor>
	</mvc:interceptors>

</beans>
```

<br>

- ### BoardEnterInterceptor 등록 xml코드 분석하기

```xml
<!--BoardEnterInterceptor 을 등록합니다 -->
<mvc:interceptor>
  <!--
    BoardEnterInterceptor이 어떤 url을 요청했을때만, 나타낼것인지를 정합니다.

    여기서는 "/blist.bo" 라는 url을 요청할때 BoardEnterInterceptor객체를 불러옵니다.
  -->
  <mvc:mapping path="/blist.bo"/>

  <!--BoardInterceptor 클래스에 대한 정보를 등록합니다-->
  <bean id="boardEnterInterceptor" class="com.kh.spring.common.interceptor.BoardEnterInterceptor"/>
</mvc:interceptor>
```

<br>



<br><br>

<hr>

> ### login.log 파일

![](./login_log.PNG)

<br>

enrollView()메소드를 호출할때도 login.log 파일에서 기록되고

MemberController에서 login() 메소드를 호출할때도 login.log파일에서 기록된다.

왜 같이 기록될까?


<br>

> ### log4j.xml

```xml
<!--appender  -->
<appender name="myDailyRollingFile" class="org.apache.log4j.DailyRollingFileAppender">
	<param name="File" value="/logs/member/login.log"/>
	<param name="Append" value="true"/>

	<param name="encoding" value="UTF-8"/>
	<param name="DataPattern" value="'.'yyyyMMdd"/>

	<layout class="org.apache.log4j.PatternLayout">
		<param name="ConversionPattern" value="%d{yy-MM-dd HH:mm:ss} [%p] %c{1}.%M{%L} - %m%n"/>
	</layout>
</appender>

<!-- logger-->
<logger name="com.kh.spring.member.controller.MemberController" additivity="false">
	<level value="debug"/>
	<appender-ref ref="myConsole"/>

  <!-- 파일에서 로그를 출력하는 appender -->
	<appender-ref ref="myDailyRollingFile"/>
</logger>

```

<br>

`log4j.xml` 파일을 보면 위의 logger은 `MemberController`에 대해서

이름이 "myDailyRollingFile" appender을 참고하고 있다.

즉 MemberController 안에 있는 모든 메소드에서(url요청) 따라서

로그파일 login.log에 로그를 출력하고 있다는 것이다.

그렇다면, Interceptor을 이용하여 분리시킬 수 없을까?

즉, login() 메소드를 호출할 때만 login.log파일에 저장할 수 없을까?

<br>

<hr>

> ## Interceptor을 이용한 실습2 - 숙제!


> ### 1. MemberLoginInterceptor.java 를 만듭니다.

```java

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

```

<br>

> ### 2. **`member-context.xml`** 에서 MemberLoginInterceptor을 등록합니다.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:context="http://www.springframework.org/schema/context"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xsi:schemaLocation="http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.3.xsd
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd
		http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context-4.3.xsd">


	<mvc:annotation-driven/>
	<mvc:resources mapping="/resources/**" location="/resources/"/>

	<!--beans가 기본이라서 태그 맨앞에 bean: 을 붙이지 않아도 바로 불러올 수 있다. -->
	<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<property name="prefix" value="/WEB-INF/views/member/"/>
		<property name="suffix" value=".jsp"/>
	</bean>
	<context:component-scan base-package="com.kh.spring"/>


	<mvc:interceptors>
		<mvc:interceptor>
			<mvc:mapping path="/**"/>
			<bean id="testInterceptor" class="com.kh.spring.common.interceptor.TestInterceptor"/>
		</mvc:interceptor>



		<!-- MemberLoginInterceptor을 등록합니다. -->
		<mvc:interceptor>

			<!-- login()메소드 호출은 login.me url을 호출할때 멤버컨트롤러에서 수행되므로 -->
			<mvc:mapping path="/login.me"/>

			<!-- login.me url호출할때 발생하는 Interceptor 입니다. -->
			<bean id="memberLoginInterceptor" class="com.kh.spring.common.interceptor.MemberLoginInterceptor"/>
		</mvc:interceptor>
	</mvc:interceptors>

</beans>
```

<br>

> ### 3. **`log4j.xml`** 에서 appender와 logger을 등록합니다.

- #### (1) MemberController에 접근할때마다, 파일에 저장하는 appender와의 연결을 해제합니다.
  - appender이름이 "myDailyRollingFile"은 접근할때마다 login.log 파일에 저장했기때문입니다.


- #### (2) 새로운 Logger을 등록합니다.
  - logger의 이름(name)은 **"com.kh.spring.common.interceptor.MemberLoginInterceptor"** 입니다.
    - 즉, 로거의 이름은 내가만든 Interceptor 클래스를 의미합니다.

  - 이 logger은 "onlyLogin" 이란 이름의 appender을 참조합니다.


- #### (3) (2)에서 Logger가 참조하는 appender을 새로 만듭니다.
  - MemberLoginInterceptor과 연결된 logger가 참조하는 appender의 이름은 "onlyLogin"입니다.
  - 이 appender은 파일을 이용하여 출력을 합니다.
    - 이전기록을 같이 백업하면서, 파일에 로그를 출력하는 클래스 `org.apache.log4j.DailyRollingFileAppender`을 사용합니다.

```xml

<!--(3) MemberLoginInterceptor가 참조하는 appender을 만듭니다.-->
<appender name="onlyLogin" class="org.apache.log4j.DailyRollingFileAppender">
	<param name="File" value="/logs/member/login.log"/>
	<param name="Append" value="true"/>

	<param name="encoding" value="UTF-8"/>
	<param name="DataPattern" value="'.'yyyyMMdd"/>

	<layout class="org.apache.log4j.PatternLayout">
		<param name="ConversionPattern" value="%d{yy-MM-dd HH:mm:ss} [%p - onlyLogin] %c{1}.%M - %m%n"/>
	</layout>
</appender>


<!--(2) 새로운 Logger을 등록합니다. -->
<logger name="com.kh.spring.common.interceptor.MemberLoginInterceptor" additivity="false">
	<level value="debug"/>

	<!-- 이름이 onlyLogin인 appender을 참조합니다. -->
	<appender-ref ref="onlyLogin"/>
</logger>



<logger name="com.kh.spring.member.controller.MemberController" additivity="false">
		<level value="debug"/>
		<appender-ref ref="myConsole"/>
    <!--(1) MemberController에 접근할때마다 수행하는 myDailyRollingFile과의 연결을 해제 -->
		<!-- <appender-ref ref="myDailyRollingFile"/> -->
</logger>


```

<br>

- #### login.log 파일을 살펴보자

```
20-10-26 23:36:33 [DEBUG - onlyLogin] MemberLoginInterceptor.afterCompletion - 로그인 계정: user01
20-10-26 23:50:06 [DEBUG - onlyLogin] MemberLoginInterceptor.afterCompletion - 로그인 계정: user02
```

<br><br>

> ## 숙제 해답
