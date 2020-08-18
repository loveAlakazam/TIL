
# MVC패턴
view => controller => (service => vo => dao ) => db

- ## view
  - 화면
  - 사용자에게 화면을 보여주는 역할
  - 사용자로부터 값을 받는 역할

- ## controller
  - view와 model단 연결
  - view에서 가지고 온 값을 가공처리

- ## model
  - service / dao/ vo / exception(예외처리)
  - model: 비즈니스 로직을 구현
  - 비즈니스 로직 : 실제 서비스를 구현
  - 트랜젝션 구현 & db와 연결
  - 데이터와 직접적 관계가 있는 것만 모아놓은다. => 그 데이터로 비즈니스 로직을 함.


  - vo
    - 데이터를 저장하는 임시 자료형 (객체)
    - 객체를 만들어서 데이터를 담는 변수의 역할 (생성자의 매개변수를 통해서 저장.)

  - dao
    - 실제 데이터를 저장하는 공간과 연결하고 값을 보내는(받는) 역할
      - 데이터베이스/ 파일에 데이터를 저장

  - service
    - 데이터공간(db/file)과 연결
    - 트랜젝션 처리(commit, rollback)
    - 자원반납


- # jdbc 순서
  - view -> controller -> service -> vo -> dao -> DB
  - view <- controller <- service <- vo <- dao <- DB

- # request 와 response
  - request: `요청`
  - response: `응답`

- request: 뷰를 보여주세요 => 응답을 그대로 하는게 아님.
  - 들어와서 가공처리하고
  - 따로 요청하는게 또있음
    - 그래서 request를 하는것.
    - `request`, `session` : 요청을 받아주는 곳
    - response: 응답해주는 곳 (응답x)
    - 꼭 request, response 짝맞춰야할필요 없다.


    - response: 응답의 역할 => sendRedirect() => 확인하는 역할 (들어왔어? 알았어~ )
      - request(값을 보내거나 다른 요청역할이 request역할)은 안함.
      - `sendRedirect()`는 response중 하나
        - => 새로운 request를 만든다.


- 보낼 데이터가 없을 때 sendRedirect()와 RequestDispatcher()
  - RD=> request.getRequestDispatcher()
    - 데이터 보내는게 가능하다.
    - `url을 유지`한다.
    - 현재 url을 유지한다.


  - SR=> response()
    - request영역을 새로 만든다.
    - 값을 담아봤자 보내봤자 의미없다.
    - request.setAttribute()해봤자 의미없음
    - URL을 재작성한다. => 다시 호출(REQUEST를 새로 만듦.)
    - `insert.no url`을 볼 수 없고 list.no로 바뀜.

  - 프로젝트단위로 실행하는게 좋다.
    - 프로젝트의 root context를 불러온다.

  - 내가 아무것도 안해도, index를 열어준다.(web.xml)
    - 내 context-root만 요청해도, 실행시키기위한 web-application
  - WEB-INF 폴더 : 웹서버가 관리하는 파일.


  - getParmeter() : 시작이 view
  - setAttribute()/ setAttribute(): 시작이 servlet
    - (setAttribute) => getAttribute()는 받는다.

<hr>

# Error

- ## 400번대 에러: Browser
  - ### 404(page not found)
    - view
      - `form`태그의 `action`
      - `a`태그의 `href`
      - `script`안에 `location.href`

    - servlet
      - `@`(annotation)
      - `sendRedirect`, `requestDispatcher` 파일 경로

  - ## 400
    - 데이터 전송과정

- ## 500번대 에러 : Logic
  - null pointer exception
  - sql ~ exception : 데이터베이스와 관련된 에러
    - query문
      - sql developer에서 실행해봐야함.
      - `insert`/`delete`/`update` 할 때 `commit()`을 꼭!
    - properties
    - `executeQuery()`, `executeUpdate()` => ()안에 값을 넣은경우
    - DAO 부분 ( 다찍어봐야됨. : 서비스에서, 컨트롤러, 뷰에서 값이 잘 넘어가는지 확인)
    - WEB-INF Classes를 보라...?

- ## 에러가없다? 안보인다? => 브라우저 개발자 도구의 콘솔을 봐야한다!

- # 에러를 읽고 이해한뒤에 (내용을 보자.), 내가 작성한 파일의 에러발생코드로 간다.

- 여러에러가 나왔을 때, 밑에서부터 쭉봐야한다.
- url-mapping을 잘못했을 때 => alert창이 뜸.
  - => 이클립스 콘솔창에 있는 에러를 확인.
