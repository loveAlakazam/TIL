# 아파치 톰캣 서버(port: 8080) 죽을 때 대처방법

- 상황

  ```
  Maven프로젝트를 만들었는데 아무것도손안댔는데 빨간엑스박스뜸.
  ```

- 오류메시지 : (해석) 8080포트를 이미 다른 프로세스가 사용하고 있음.

  ```
  Port 8080 required by Tomcat v8.5 Server at localhost is already in use.
  The server may already be running in another process,
  or a system process may be using the port.
  To start this server you will need to stop the other process
  or change the port number(s).
  ```

- 해결방법 참고자료
  - https://java119.tistory.com/96

  <br>

  - (방법) cmd에 접속해서 프로세스를 죽였다.
  - OS: Windows10

  - 8080포트를 사용하는 프로세스의 PID 찾기
  ```
  netstat -nao | findstr 8080
  ```

  <br>

  - PID에 해당하는 프로세스 죽이기.
  ```
  taskkill/f pid 입력PID
  ```
