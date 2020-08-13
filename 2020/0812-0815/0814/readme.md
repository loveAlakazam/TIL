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


<hr>

# Oracle Database

> ## docker 설치

```
$brew install git
```

<br>

```
$docker run -d -p 80:80 docker/getting-started
```

> ## oracle-xe-11g 설치

```
$ docker pull deepdiver/docker-oracle-xe-11g
```

<br>

> ## docker에서 oracle-xe-11g를 실행

```
$ docker run -d -p 49160:22 -p 49161:1521 deepdiver/docker-oracle-xe-11g
```

[참고자료](
https://romeoh.tistory.com/entry/Oracle-docker%EC%97%90-Oracle-11g-%EC%84%A4%EC%B9%98%ED%95%98%EA%B8%B0)
