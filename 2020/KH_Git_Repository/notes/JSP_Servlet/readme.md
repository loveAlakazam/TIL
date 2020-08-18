# 아파치 톰캣 맥북에서 설치 (tomcat version 9)

> ## tomcat 9버젼 설치

- zip파일로 설치
- java 프로젝트에 tomcat이라는 하위폴더를 만들어서, 여기에 저장함.
- [아파치 톰캣 맥북에서 설치하기](https://hyunah030.tistory.com/2)


<hr>

> ## eclipse 프로젝트 만들 때, 톰캣서버 설정하기

```
File > New > Dynamic Web Project
```


> ## 프로젝트에 톰캣서버 연결하기

```
1) Target runtime 영역 > "New Runtime" 버튼 클릭

2) apache tomcat 9.0 클릭 > Next 버튼 클릭

3) Browse 버튼클릭

4) 톰캣설치 경로를 넣은 후 Finish를 누르고, 아직 프로젝트 만들기 창에서는 `Finish`를 하지말고 `Next`를 눌러라

5) Default output folder 를 `WebContent/WEB-INF/classes` 로 변경한다.

6) Next버튼을 누른 후, `Generate web.xml deployement descriptor` 체크박스를 선택한다.

7) Finish 버튼을 누른다.
```

> ## 아파치 톰캣서버 서버포트 변경하기

```

1) 하단에 있는 탭메뉴 중 "Servers" 탭을 클릭한다.

2) Tomcat v9.0 Server at localhost [Stopped, Synchronized] 부분을 더블클릭

3) 새로운 창이 뜬다. 여러개의 메뉴가 있는데 그중 "Ports" 메뉴와 "Server Options"에 있는 내용만 변경한다.

- Ports 메뉴
  - 포트번호: 8005 => 8905 로 변경
  - HTTP/1.1: 8080 => 8985 로 변경
  - 포트번호는 다른 앱이 사용하는 포트번호와 중복되지 않게한다.

- Server Options 메뉴
  - "Serve modules without publishing" 부분의 체크박스를 클릭한다.

```

<br>

> ## 파일 뜯어보기

```
프로젝트를 실행했을 때

url 주소가 "http://localhost:9080/Sevlet_Practice01/" 인 것은
전체 프로젝트를 실행하는 것이고

url 주소가 "http://localhost:9080/Sevlet_Practice01/index.html"인 것은
해당 html파일을 본 것이라고 할 수 있다.

```


- ### 어떻게 index페이지를 먼저 보여줄 수 있을까?
- WEB-INF 폴더 안에 있는 web.xml코드에서 welcome-file이 서버에 접속했을 때 나타나는 페이지를 가리킨다.

```xml
<welcome-file-list>
    <welcome-file>index.html</welcome-file>
    <welcome-file>index.htm</welcome-file>
    <welcome-file>index.jsp</welcome-file>
    <welcome-file>default.html</welcome-file>
    <welcome-file>default.htm</welcome-file>
    <welcome-file>default.jsp</welcome-file>
</welcome-file-list>

```


> ## Get방식에서 페이지 연결하기

- testServlet1.html

```html
<!--
testServlet1.html
위치: WebContent/servlet/testServlet1.html
-->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Get방식 </title>
</head>
<body>
	<h1>GET방식 </h1>
	<form action="/Sevlet_Practice/testServlet1.do" method="get" name="testfrm">
		<ul>
			<li>
				<label>이름: </label>
				<input type="text" name="name" size="10">
				<br>
				<label>성별: </label>
				<input type="radio" name="gender" value="남자">
				<input type="radio" name="gender" value="여자">
			</li>
		</ul>
		<input type="submit" name="okBtn" id="okBtn" value="확인">

	</form>
</body>
</html>
```

<br>

- 실행했을 때 부딪히게 될 에러
  - 400번대 에러 브라우저관련 에러
    - 400 에러 : url에 대응되는 페이지가 유효하지 않거나, 데이터가 잘못됐거나
    - 404 에러 : `page not found`(페이지가 찾을 수 없다는 에러)
      - 페이지가 존재하지 않다거나
      - 뷰에서 url을 잘못 적었거
      - 경로를 잘 못적음.
      - 서블릿에서 받아준 것에서 잘못됨.

  - 500번대 에러 : 로직(logic)과 관련된 에러

<br>

- 서블릿 설계 규약
  - 서블릿은 HttpServlet 클래스를 상속받는다.

  - 서블릿 페이지와 연결할 자바코드 TestServlet1.java

  - doPost()는 doGet()을 먼저 실행한 후에 넘긴다.
  - doGet()메소드에서 웹페이지(.jsp, .html)에서 데이터를 받을 때 body내에서 표현을 하려면

  ```java
  // TestServlet1.java
    package com.kh.servlet;

    import java.io.IOException;

    import javax.servlet.ServletException;
    import javax.servlet.http.HttpServlet;
    import javax.servlet.http.HttpServletRequest;
    import javax.servlet.http.HttpServletResponse;

    public class TestServlet1 extends HttpServlet {

  	@Override
  	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

  	}

  	@Override
  	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

  	}
  }

  ```

  - `WebContent > WEB-INF > web.xml`에서 서블릿매핑을 한다.
    - `<strong>Sevlet Mapping</strong>`: 서블릿페이지와 url을 연결한다.

    - <b>`<servlet>`안에 `<servlet-name>`과 `<servlet-mapping>`안에 있는 `<servlet-name>`이 일치해야한다.</b>


  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <web app>


    <!--servlet 매핑
      : testServlet1.do와 TestServlet1.java를 연결한다.  
    -->
    <servlet>
      <servlet-name>TestServlet1</servlet-name>
      <servlet-class>com.kh.servlet.TestServlet1</servlet-class>
    </servlet>

    <servlet-mapping>
      <servlet-name>TestServlet1</servlet-name>
      <url-pattern>testServlet1.do</url-pattern>
    </servlet-mapping>
  </web app>
  ```

- ### 실행 순서
  - #### 웹서버 실행
  - #### `Servers > web.xml` 이실행
  - #### `WebContent > WEB-INF > web.xml`이 실행
    - `<welocome-file-list>`실행 : 시작페이지
    - `web.xml`에 기재된 url(`testServlet1.do`)을 본다.
    - url에 매핑된 서블릿네임(`<servlet-name>`)을 찾아서 연결된 <b>서블릿 클래스</b>를 찾는다.
    - 이 url을 처리하는 해당 서블릿 클래스를 찾아서 실행한다.(컴파일)

    - <strong>GET방식이라면 `doGet()` 함수가 실행되고</strong>
    - <strong>POST방식이라면 `doPost()`함수가 실행된다.</strong>

<br>

- ### `RequestDispatcher.forward()` 와 `response.sendRedirect()`
  - #### `RequestDispatcher.forward()`
    - <strong>뷰(view)한테 보낼 데이터가 존재할 때 사용</strong>

  - #### `response.sendRedirect()`
    - <strong>뷰만 띄운다. (보낼 데이터를 필요로하지 않을 때)</strong>

<hr>

# Oracle Database

> ## 1. 도커 계정 로그인

```
$ docker login
도커 계정 이름 (ek12mv2)
도커 비밀번호
```

> ## 2. 도커 이미지를 다운로드

```
$ docker pull deepdiver/docker-oracle-xe-11g
```

> ## 3. 이미지를 컨테이너로 생성한 뒤에 실행한다.

```
$ docker run -d -p 49160:22 -p 49161:1521 deepdiver/docker-oracle-xe-11g
```

> ## 4. 컨테이너 목록 출력

```
$ docker ps
```

> ## 5. 데이터베이스 (sql developer)


데이터베이스 생성하기 (**초록색 십자버튼**)

위에서부터 순서대로

```
Name: localhost 
사용자 이름: system 
비밀번호: oracle 
포트번호 :49161
```

## 비밀번호 만료기간이 7일이라서, 생성한뒤에 비밀번호를 변경한다.



<br>

> ## ojdbc 파일 얻기

- ojdbc를 다운로드한다.
  - [여기서 다운로드 하자](https://www.oracle.com/database/technologies/jdbcdriver-ucp-downloads.html)
  - 사용되는 ojdbc파일은 `ojdbc6.jar`이다.


[ojdbc6.jar파일 얻기-참고자료](https://seongjaemoon.github.io/database/2018/02/18/database-oracle6.html)

[도커로 xe설치 - 참고자료](https://clearstar0817.tistory.com/11)

[도커 개념정리](https://jungwoon.github.io/docker/2019/01/11/Docker-1/)

[도커 컨테이너/이미지 삭제](https://brunch.co.kr/@hopeless/10)
