# Maven

- 해당프로젝트의 버젼정보 및 라이브러리 정보들을 통합
- 라이브러리를 계속 다운로드한다.
- 라이브러리 종속성
  - 그동안은 일반적인 프로젝트는 개발자가 필요한 라이브러리를 직접 찾아서 다운받아서 넣었었다.
  - Spring Maven은 라이브러리를 알아서 추가하여 사용할 수 있다.

  - ### `pom.xml` : **라이브러리 정보**(라이브러리 등록 및 관리), **프로젝트 버젼정보 관리**
  - ### `spring-context.xml`: **spring컨테이너가 실행해야하는 내용을 설정**, **spring이 하는 전체적인 것들을 관리**

<br>

# POM (Project Object Model)

- ## 라이브러리를 어디에 집어 넣는가?
  - ## 다운받은 라이브러리를 저장하는 곳: `apache-maven/repository`

- [maven페이지](http://maven.apache.org/)

<br>

# Spring 프레임워크 특징

|특징|설명|
|:--:|:--:|
| <b>IoC</b> (Inversion of Control)|제어의 반전= 제어권이 반전되어있다.<br>(Spring 배우기 이전) 개발자가 주도권을 가졌다<br>규칙아래에서 만들어져있어야만 활용할 수 있다.=> **프레임워크가 제어권을 가짐**<br>**객체생성부터 모든 생명주기의 관리까지 프레임워크(spring)가 주도한다.** |
| <b>DI</b> (Dependency Injection)|제어의 반전이 있기때문에<br>프레임워크가 알아서 생성하기 때문에 개발자가 직접 객체를 생성할 필요없다.<br>설정파일이나 어노테이션을 통해 객체간의 의존관계를 설정하여 개발자가 직접 의존하는 객체를 생성할 필요없음.<br>|
|Spring AOP(Aspect Oriented Programming)|분리해서 관리한다.<br>filter와 비슷함.<br>중간에 필요한 부분만 추가 및 변경<br>
filter은 내가 요청전(후)에 들어가서 처리, 여러시점에서 요청을 설정할 수 있다. 그래서 시점(point-cut) 설정이 필요하다.|
|POJO(Plain Old Java Object)|<b>프레임워크에서 사용되는 객체</b><br>vo, bean(객체)<br>|
|Spring JDBC|MyBatis나 Hibernate등의 데이터베이스를 처리하는 영속성 프레임워크와 연결할 수있는 인터페이스 제공|
|Spring MVC|MVC 디자인 패턴을 통해 웹 애플리케이션의 Model, View, Controller 사이의 의존관계를 DI컨테이너에서 개발자가 아닌 서버가 객체들을 관리하는 웹 애플리케이션 구축|
|PSA(Portable Service Abstraction)|추상화를 제공. 서비스 하나에 대해서 추상화를 한다.<br>|


<br>

> # Spring - Data계층

- JDBC, Transaction, ORM 등 데이터베이스에 연결하는 모듈
- 영속성 프레임워크(MyBaits, Hibernate)의 연결담당.

<br>

> # Spring - MVC계층

- 웹 구현 기술과의 연결점을 Spring MVC구성으로 지원하기 위해 제공되는 모듈 계층
- MVC계층에서 Servlet과 같은 웹구현 기능을 대상으로 지원해준다.
- controller을 이용.

<br>

> # Spring - Core Container계층

- 스프링의 핵심부분
- 객체 관리 => 객체 생성, 주기 표시.
- DI, IOC 기능을 지원


<br>

> # Spring의 구성모듈

|모듈이름|내용|
|:--:|:--:|
|||

<br>


webapp: WebContent와 같은 역할.

`com.kh.spring` : `spring`은 context path이다.

spring은 `home.jsp`를 `index.jsp`와 같은 welcome파일로 하나보다...

dispatcher servelet
- 내가 들어온 요청중에서 누가 들어왔는지를 컨트롤러에서 찾아주는 역할.


```
Dispatcher servlet
=> requestMapping 요청처리(핸들러매핑)
=> 비즈니스 로직 실행후 return
=> dispatcherServlet이 다시 받음
=> servlet-context.xml에서 ViewResolver실행
```
