## ReactJS를 UI로 나타내고, Spring Boot로 Server API를 만들기

- 사용 데스크톱 OS : Mac OS

- 개발 목표
  - 프론트엔드/백엔드 작업환경 모두 VSCode로 한다.
  - 프론트엔드는 JSP가 아닌 React로 한다.
  - 백엔드는 Spring이 아닌 Spring Boot로 한다.

<br>

- 참고자료
  - VSCode로 작업환경 만들기
    - https://parkdream.tistory.com/95
    - https://kim6394.tistory.com/226
    - https://esaek.tistory.com/20
    - [spring tool 설치](https://spring.io/tools)
  - React와 Spring Boot 연동하기
    - https://kim6394.tistory.com/226

<hr>

> ## 1. VSCode를 Spring Boot 개발환경 만들기

- 프로젝트 세팅 참고자료
  - https://parkdream.tistory.com/95
  - https://esaek.tistory.com/20


- 먼저 Spring과 Java Extension을 설치해놓습니다.

> ### 1-1. JDK 설정

- 상단메뉴 Code > Preferences > Settings
- `jdk` 검색 > `Java: Home` > `Edit in settings.json` 링크 클릭

- `java.home`에 설치된 JDK 위치를 넣어서, settings.json 파일을 저장시킵니다.
  - JDK는 기본적으로 `/Library/Java/JavaVirtualMachines` 에 저장됩니다.

- 명령 팔레트(shortcut: `command` + `shift` + `p`)에서 **spring maven**을 검색합니다.
  - 선택언어는 **Java**로 합니다.
  - 배포파일 형태는 *.war, *.jar가 있는데 저는 *.jar를 선택했습니다.
  - JDK버젼은 설치된 JDK버젼과 똑같이 맞췄습니다.
  - 스프링부트 버젼은 가장 최근버젼으로 했습니다.

<br>

> ### 1-2. 서버 포트 변경하기

- spring boot도 기본포트번호가 8080인데 오라클과 겹치기때문에 다른포트번호로 변경해야합니다.
  - [참고자료 - vsCode에서 Spring Boot프로젝트 시작하기](https://esaek.tistory.com/20)

- `command` + `p` > `application.properties` 검색하여 파일을 오픈합니다.

- `server.port=9001`을 추가합니다.
  - *main/resources/application.properties*에서 변경하려는 서버포트번호를 추가합니다.
  - 서버포트번호는 다른 프로세스와 겹치지 않도록 합니다.

<br>

> ## 2. React와 연동하기
