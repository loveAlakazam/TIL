> # 웹의 동작 방식

## (1) HTTP (Hypertext Trasfer Protocol)

- 서버와 클라이언트가 인터넷 상에서 **데이터를 주고받기 위한 프로토콜**

- 불특정 다수를 대상으로하는 서비스에 사용하는 프로토콜

<br>

## (2) 웹 서버 (Web Server)

- 웹서버 소프트웨어가 동작하는 컴퓨터
- 클라이언트가 요청하는 HTML문서나 각종 리소스(Resource)를 전달하는 것.
  - 리소스(Resource)
    - javascript
    - css
    - 이미지 파일

- 대표적인 웹서버 예
  - **Apache**
  - **Nginx**

<br>

## (3) WAS (Web Application Server)

- 웹 클라이언트(웹브라우저)의 요청중 웹 애플리케이션이 동작하도록 지원해주는 미들웨어.


<br>

## (4) Servlet

### Java Web Application

- WAS에 설치되어 동작하는 애플리케이션

<br>

### Servlet

- Java Web Application 구성요소 중 동적인 처리를 하는 프로그램.

- 서블릿은 `HttpServlet` 클래스를 상속받아야한다.

<br>

### 서블릿의 Life Cycle

#### `init()`

- Java Web Application이 처음 실행될 때
- 메모리에 요청받은 서블릿이 존재하지 않을 때
  - 메모리에 해당 서블릿을 로드한 후에 `init()`메소드를 수행.

#### `service(request, response)`

- 브라우저에서 웹어플리케이션에 있는 페이지를 불러올때 마다

#### `destroy()`

- WAS가 종료되거나, 새롭게 갱신됐을 때
- 자바웹어플리케이션의 코드를 수정 후에, 다시 run했을 때

<br>

### Request, Response 객체

#### `HttpServletRequest` 클래스

- HTTP 프로토콜의 request정보를 서블릿에 전달하기 위한 목적으로 사용되는 클래스
- 헤더정보, 파라미터, 쿠키, URI, URL 등의 정보를 읽는 메소드가 존재.
- 바디정보의 스트림(Stream)을 읽어들이는 메소드가 존재.

#### `HttpServletResponse` 클래스

- 요청한 클라이언트에게 응답을 보내주기 위한 클래스
- HttpServletResponse 객체를 생성하여 서블릿에게 전달하여, content type, 응답코드, 응답메시지등을 전송.

<br>

## (5) JSP (Java Server Page)

### JSP Life Cycle

- 브라우저가 웹서버에 JSP에 대한 요청 정보를 전달한다.
- 브라우저가 요청한 JSP가 최초로 요청했을 경우만 JSP로 작성된 코드가 서블릿으로 코드로 변환한다.
- 서블릿 코드를 컴파일해서 실행가능한 bytecode로 변환한다.
- 서블릿 클래스를 로딩하고 인스턴스를 생성한다.
- 서블릿이 실행되어 요청을 처리하고 응답정보를 생성한다.

<br>

### JSP 문법

|명칭|코드|사용 목적|
|:--:|:--:|:--:|
|선언문(Declaration)|`<%!  %>`|전역변수 & 메소드 선언|
|스크립틀릿(Scriptlet)|`<% %>|프로그래밍 코드(java코드) 작성할 때 사용|
|표현식(Expression)|`<%= %>`|화면에 출력할 특정값을 나타낼 때 사용|
