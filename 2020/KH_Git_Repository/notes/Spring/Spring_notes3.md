> # Logger와 Interceptor

> # Logger

<br>

Spring프로젝트를 시작하다보면 Console에 빨간색 글씨가 보일것이다. 수많은 로그들을 출력한다.

<br>

특히 HomeController.java 코드의 `logger.info("Welcome home! The client locale is {}.", locale);` 라는 메소드가 로그이다!

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
- <logger>나 <root>에 <appender-ref ref="console"/>이라함은, 이름이 console인 appender을 참고한다는 의미이다.

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

<br>


<br><br>
