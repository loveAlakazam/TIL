# 아파치 톰캣 맥북에서 설치 (tomcat version 9)

> ## tomcat 9버젼 설치

```
brew install tomcat@9
```

> ## tomcat 설치후 다시시작

```
brew services start tomcat 
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
