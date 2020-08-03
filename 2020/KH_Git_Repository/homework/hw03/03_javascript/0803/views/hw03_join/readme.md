> # python flask 웹서버 만들기

- 가상환경 만들기
  - 가상환경: 프로젝트별로 요구하는 환경 버젼이 달라져서 충돌을 막기위해서 만들어졌음.

  - 가상환경 설치 명령어 (windows OS)
  ```
  python -m venv myvenv(가상환경 이름)
  ```

  - 가상환경 설치 명령어 (mac OS)
  ```
  python3 - m venv myvenv(가상환경 이름)
  ```

- 가상환경을 만들면, 가상환경에서 사용하는 라이브러리를 다운로드받아야한다.

  - flask 라이브러리 설치
  ```
  pip install flask
  ```

  - flask 실행
  ```python
  from flask import Flask, render_template
  app=Flask(__name__)

  @app.route('/')
  def home():
    return render_template('./join_member.html')
  ```

  - pymongo 라이브러리 설치
  ```
  pip install pymongo
  ```

  - 터미널에 명령어 입력
  ```
  mongod
  ```


  - 설치확인 - 웹브라우저에서 확인한다.
  ```
  localhost:27017
  ```
  - 브라우저에서 다음과 같은 메시지가 있으면 연결성공함!
  ```
  It looks like you are trying to access MongoDB over HTTP on the native driver port.
  ```

  - 몽고디비(NoSQL)와 연결

  ```python
  from pymongo import MongoClient
  client = MongoClient('localhost', 27017)
  ```
