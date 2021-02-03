# 도커로 Mac OS에서 Oracle SQL Developer 실행하기

- 참고자료
  - [Mac OS에서 Oracle-11g-xe 설치하기](https://devtagebuch.tistory.com/12)


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

  - 이름을 `oracle`로 하였습니다.

```shell
docker run --name oracle -d -p 9090:9090 -p 1521:1521 jaspeen/oracle-xe-11g
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

> ## 6. SQL-PLUS 시작하기 - SQL PLUS 를 처음 설치할 때만 해당

```shell
docker exec -it oracle sqlplus
```

```shell
docker exec -it 컨테이너이름 sqlplus
```

- 시스템 id를 `system`, 비밀번호를 `oracle` 로 하였습니다.

- SQL Developer는 Java 8에서만 실행됩니다.
  - 그러나 JDK 11이상이면 SQL Developer가 실행이 안될 수 있습니다. 저는 JDK 11이라서.. SQL Developer 사용을 포기합니다 ㅠ_ㅠ

<br>

- [SQL Developer 설치 및 실행하기](https://khstu-98.tistory.com/20)


<br>

> ### 부록. 도커에 이미 이미지가 있는 경우 -> 기존의 이미지를 삭제하고 다시 등록해야합니다.

- 이미지 실행 중지 시키기 (만약에 삭제하려는 이미지가 이미 실행중일 때)

```shell
docker stop 컨테이너아이디
```


- 해당 이미지 삭제하기.

```shell
docker rm 컨테이너아이디
```

<br>

- 다시 등록하기
  - 등록을 성공하면, 새로운 컨테이너 id를 제공합니다.

```shell
docker run --name oracle -d -p 9090:9090 -p 1521:1521 jaspeen/oracle-xe-11g
```

<br>


> ## 부록. 내가 갖고있는 이미지 확인하는 명령어

```shell
docker images
```
