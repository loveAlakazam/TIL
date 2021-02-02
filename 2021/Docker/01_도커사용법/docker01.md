# 도커로 Mac OS에서 Oracle SQL Developer 실행하기

> ## 1. `homebrew` 로 도커 설치

```shell
brew install git

docker run -d -p 80:80 docker/getting-started
```


<br>

> ## 2. Docker 계정 로그인

```shell
docker login
도커 계정이름
도커 비밀번호
```

<br>

> ## 3. 도커 이미지 다운로드 - ORACLE XE 11g가 없는 경우에만 해당

- `oracle-xe-11g` 에 해당하는 이미지가 있는지 검색.

```shell
docker search oracle-xe-11g
```

<br>

```shell
docker pull jaspeen/oracle-xe-11g
```

<br>

- Oracle.java 에서 포트번호 8080을 사용하고 있기 때문에, 9090으로 했습니다.
  - 정상적으로 설치가 완료되면, 해당명령어 바로 밑에 줄에 출력된 컨테이너 아이디를 꼭 기억해놓으세요!

```shell
docker run -d -p 9090:9090 -p 1521:1521 jaspeen/oracle-xe-11g
```

<br>

> ## 4. 컨테이너 목록 확인하기

```shell
docker ps
```

<br>

> ## 5. 컨테이너 시작하기

```shell
docker start 컨테이너아이디
```


<br>

> ### 부록. 도커에 이미 이미지가 있는 경우 -> 기존의 이미지를 삭제하고 다시 등록해야합니다.

- 해당 이미지 삭제하기.

```shell
docker rm 컨테이너아이디
```

<br>

- 다시 등록하기
  - 등록을 성공하면, 새로운 컨테이너 id를 제공합니다.

```shell
docker run -d -p 9090:9090 -p 1521:1521 jaspeen/oracle-xe-11g
```

<br>
