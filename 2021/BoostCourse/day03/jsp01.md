# Servlet과 JSP

- 참고자료
  - [lifecycle-of-jsp](https://www.studytonight.com/jsp/lifecycle-of-jsp.php)

> ## JSP의 실행 순서

1. 브라우저가 웹서버에 JSP에 대한 요청 정보를 전달한다.

2. 브라우저가 요청한 JSP가 최초로 요청했을 경우에만, **JSP로 작성된 코드가 Servlet코드로 변환한다.(*.java파일 생성)**

3. 서블릿 코드를 컴파일해서 실행사능한 byteCode로 변환한다 (*.class 파일 생성)

4. 서블릿 클래스를 로딩하고 인스턴스를 생성한다.

5. 서블릿이 실행되어 요청을 처리하고 응답정보를 생성한다.

  - `jspInit()` 메소드를 호출한다.
  - `_jspService()` 메소드를 호출하여 요청처리를 수행한다.
  - 서블릿 내용이 수정되거나 삭제되었을 때, `jspDestroy()` 메소드를 호출하여 종료한다.

<br>

> # JSP파일을 Servlet으로 변환됐을 때

- JSP 파일 (hello.jsp)
  - `<% %>` (scriptlet) 은 JSP코드를 서블릿 형태로 변환시켜준다.

```html
<html>
    <head>
        <title>My First JSP Page</title>
    </head>
    <%
       int count = 0;
    %>
    <body>
        Page Count is:  
        <% out.println(++count); %>
    </body>
</html>
```

<br>

- ### Servlet 코드로 JSP파일의 형태를 나타내보기

```java
public class hello_jsp extends HttpServlet
{
  public void _jspService(HttpServletRequest request, HttpServletResponse response)
                               throws IOException,ServletException
   {
      PrintWriter out = response.getWriter();
      response.setContenType("text/html");
      out.write("<html><body>");
      int count=0;
      out.write("Page count is:");
      out.print(++count);
      out.write("</body></html>");
   }
}
```


<br>

# Scope

> # 4가지 Scope

- ### 1. Page
  - 페이지 내에서 **지역변수** 처럼 사용된다.
  - `PageContext` 내장 객체로 사용이 가능하다.
  - `forward()`가 될 경우 PageScope에 지정된 변수는 사용할 수 없다.
  - jsp에서 pageScope에 값을 저장한 후, 해당 값을 EL표기로 나타낼 때 사용된다.
  - 해당 jsp나 서블릿이 실행되는 동안에만 **정보를 유지**하기위해 사용된다.

<br>

- ### 2. Request
  - HTTP 요청을 WAS가 받아서 웹브라우저에게 응답할 때까지 변수가 유지되는 경우에 사용된다.
  - `HttpServletRequest` 객체를 사용한다.
  - JSP에서는 request 내장변수를 사용한다.

  - **`request.setAttribute()`** : 값을 저장할 때 사용
  - **`request.getAttribute()`** : 값을 읽어들일 때 사용.

  - `forward()` 되는 동안에 값을 유지한다.

  - 단, `response.sendRedirect()` 할 때는 request 영역에서는 정보 유지가 안된다.
    - 새로운 request로 바뀌기 때문에 request영역의 정보가 새로 바뀐다.

<br>

- ### 3. Session
  - 웹브라우저별로 변수가 관리되는 경우에 사용된다.
  - 주로 로그인에 많이 사용된다.
  - 장바구니 내역과 같은 사용자별로 유지되어야할 정보가 있을 때 사용된다.

  - 웹 브라우저의 탭들은 세션정보가 공유되기 때문에 각각의 탭에서 같은 세션정보를 사용할 수 있다.
  - JSP에서는 session 내장변수를 사용한다.

  - 서블릿에서는 `HttpServletRequest`의 `getSession()`을 이용하여 session객체를 얻을 수 있다.
  - `session.setAttribute()` : 세션영역에서 값을 저장
  - `session.getAttribute()` : 세션영역에서 값을 불러옴

<br>

- ### 4. Application
  - 웹 어플리케이션이 시작되고 종료될 때까지 변수가 유지되는 경우에 사용된다.
  - 모든 클라이언트가 공통으로 사용해야할 값들이 있을 때 사용한다.

  - ServletContext 인터페이스를 구현한 객체를 사용한다.
  - JSP에서는 application 내장 객체를 이용한다.
  - `getServletContext()` 메소드를 이용하여 application 객체를 생성한다.
  - 웹 어플리케이션 한 개당 하나의 application 객체를 갖는다.

  - `application.setAttribute()` : application 영역에서 값을 저장
  - `application.getAttribute()` : application 영역에서 값을 불러옴.
