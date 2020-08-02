# java script

- css와 html과 다르게 logic이 있다.
- 화면에서 동작을 담당한다.
- html: 맨얼굴
- css: 화장
- java script  & jquery: 웃음과 같은 동작

- java script가 상당히 중요함 - 기능단 연결.

- url을 통해서 요청함.

> ## 정적페이지

- `정적페이지` : 항상똑같은 페이지
- 화면페이지는 웹서버에 담겨있다.
  - 누구한테나 공통적으로 똑같이 보여주는 페이지는 웹서버에 있다.
  - 처음에 있는 네이버 페이지 / 로그인 이후 네이버 페이지 모두 웹서버에있다.
  - 회원이 누구든지 상관없이 똑같이 출력되는데 데이터는 웹서버에있다.

<BR>

> ## 동적페이지

- `동적페이지` : 로그인 계정(사람)마다 다른정보를 갖고있다.
  - 메일 개수/ 블로그개수/ 알림개수 / 가입한 카페 ...

- WAS : 웹 애플리케이션 서버 (Apache Tomcat)
- WAS를 통해서 동적인 웹서버와 연결된 DB로부터 데이터를 갖고와야한다.
- 데이터를 정적인페이지에 전달하여, 계정마다 다르게 출력하도록.

<BR>

- JSP & Servlet
  - db접속하여 데이터를 갖고온다.
  - JSP(Java Server Page)
    - 운영체제에 영향을 받지 않음
    - 톰캣 컨테이너위에서 자바기반의 언어를 사용

  <br>

  - node.js
    - java script 라이브러리
    - 빠른속도를 자랑한다. 주로 채팅에서 사용한다.
    - 자바스크립트 라이브러리로 소켓을 이용하여 쉽게 실시간 서버를 구축가능하도록 함.

<br>


> # javascript 선언

- 위치에 제약을 받지 않는다.
  - `<head>`, `<body>` 안 어느 영역에나 작성 가능.
  - `<html>` 태그 영역 밖에서 작성도 가능하지만
  - 왠만하면 `<script>`태그는 맨밑에 있는게 좋다.

- 작성방식
  - inline방식 : 태그 안에 자바스크립/ 이벤트이름을 넣어서 같이 들어감
  - internal방식: html파일 안에서 `<head>`나 `<body>`안에 자바스크립트 소스작성
  - external방식: 외부파일로 저장하여 작성 `<script src="경로">` 태그를 이용해서 삽입한다.

- 실행방식: 인터프리터 방식
  - 인터프리터 방식
    - 웹브라우저에 내장되어있는 자바스크립트 파서가 소스코드를 한줄 씩 읽고 해석함.
  - 전체를 해석해놓은 컴파일언어와 차이가 있다.
  - 자바스크립트 실행은 작성된 html문서를 브라우저에서 읽으면 바로 실행할 수있음.


<hr>

> # 데이터 입출력

> ## 데이터 출력

- `document.write(내용);`: 브라우저 화면상의 페이지에 값을 출력.
- `innerHTML=내용;`: 태그 앨리먼트의 내용을 변경하여 출력
- `console.log(내용);`: 개발자도구 콘솔창에서 출력.
- `window.alert(내용);` : 알림창

> ## 데이터 입력