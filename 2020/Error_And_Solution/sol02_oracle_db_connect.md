# 오라클 데이터베이스 계정 연결 문제 해결방법

- 상황

  ```
  어제까지만 해도 SQL-DEVELOPER에 등록된 계정으로 계정접속이 잘 됐는데
  오늘은 비밀번호를 정확히 입력했는데도 계정접속이 안된다.
  문제가 무엇일까?
  ```

- 사항
  - OS : `Windows10`
  - ORACLE SQL-DEVELOPER
  - ORACLE SQL VER: `ORACLE DATABASE 11g Express Edition`

- 에러메시지

  ```
  계정 비밀번호 입력 이후

  (오류발생) 요청한 작업을 수행하는 중 오류 발생

  IO 오류: The Network Adapter could not establish the connection

  업체 코드 17002
  ```

- 참고자료
  - https://m.blog.naver.com/blogpyh/40209232034


- 해결과정
  - 1. 윈도우창에 `컴퓨터 관리` 입력하여 실행한다.
  - 2. `서비스 및 응용프로그램` 선택
    - `서비스` 선택

  - 3. `OracleServiceXE`와 `OracleXETNSListener` 을 선택한다.
    - 두개 모두 실행시킨다.
      - 마우스 우클릭 => `시작`

> 덤) 불필요한 서비스 삭제하는 방법

- 참고자료
  - https://blog.naver.com/PostView.nhn?blogId=harry5313&logNo=221436536930

- 과정
  - CMD창 연다 (관리자 권한 모드 적용)
  - `sc delete 삭제할서비스이름`
  - 서비스 마다 서비스 이름이 다를 수 있으니
    - 마우스 우클릭해서 `속성` 에서 기록된 `서비스 이름`을 본 뒤에
      정확한 서비스 이름을 알고서 삭제하자.
      
      
      
- ## 해결방안 2: 웹서버 설정에서 포트번호를 바꾼다.
