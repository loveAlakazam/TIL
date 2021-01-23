# Spring Core

> # Framework란 무엇인가?

- 엔터프라이즈 급 애플리케이션을 구축할 수 있는 가벼운 솔루션
- One Stop Shop
- 원하는 부분만 가져다 사용할 수 있도록 모듈화가 잘되어 있다.
- IoC(Inversion of Control) 컨테이너
- 선언적으로 트랜잭션을 관리할 수 있다.
- 완전한 기능을 갖춘 MVC Framework를 제공한다.
- AOP를 지원한다.

<br>

> # Spring Framework Module

![](./imgs/springModules.png)


- 20개의 모듈로 구성되어있다.
- 필요한 모듈만 가져다 사용할 수 있다.

<br>

> # Spring AOP 계층

- `spring-AOP` : AOP Alliance 와 호환되는 방법으로 AOP를 지원
- `spring-aspects` : AspectJ 와의 통합을 제공한다.
- `spring-instrument`
  - Instrumentation을 지원하는 클래스와 특정 WAS에서 사용하는 클래스로 구현체를 제공한다.
  - BCI(Byte Code Instrumentations): 런타임, 로드(load)할 때 클래스의 바이트 코드에 변경을 가하는 방법을 의미한다.


> # Messaging 계층

- `spring-messaging` : 메시지 기반 어플리케이션을 작성할 수 있도록 제공
  - 메시지 기반 어플리케이션 작성하는 `Message`, `MessageChannel`, `MessageHandler` 등을 제공
  - 메소드에 메시지를 매핑하기 위한 annotation(@)도 포함되어 있다.
  - Spring MVC annotation과 유사하다.


> # Data Access & Integration 계층

- JDBC, ORM, OXM, JMS 및 트랜잭션 모듈로 구성되어 있다.
- `spring-jdbc` : Java JDBC 프로그래밍을 쉽게 할 수 있도록 기능을 제공
- `spring-tx` : 선언적 트랜잭션 관리를 할 수 있는 기능을 제공
- `spring-orm` : JPA, JDO 및 Hibernate를 포함한 ORM API를 위한 통합레이어를 제공


> # Web 계층

- `spring-web`, `spring-webmvc`, `spring-websocket`, `spring-webmvc-portlet` 모듈로 구성
- `spring-web`
  - MultipartFile 업로드, Servlet Listener 등 웹 지향 통합기능을 제공
  - Http 클리아언트와 Spring의 원격지원을 위한 웹 관련 부분을 제공

- `spring-webmvc`
  - Web-Servlet 모듈
  - Spring MVC 및 REST 웹 서비스 구현을 포함

- `spring-websocket` : 웹소켓 지원
- `spring-webmvc-portlet` : portlet 환경에서 사용할 MVC 구현을 제공

<br>

> # Container

- 인스턴스 생명주기를 관리한다.
- 생성된 인스턴스에게 추가적인 기능을 제공한다.

> ### WAS (Web Application Server)

- WAS는 Servlet 컨테이너를 갖고 있다.

WAS는 웹브라우저로부터 서블릿 URL 요청을 받으면 해당 서블릿을 메모리에 올린 후에 실행한다.
개발자가 서블릿 클래스를 작성하지만, WAS의 Servlet 컨테이너는 서블릿 클래스를 메모리에 올리고 실행한다.

동일한 서블릿을 요청하면, 메모리에 올리지 않고 기존에 메모리에 올라간 서블릿을 실행하여
요청에 대한 결과를 웹브라우저에게 전달한다.

<br>

```
Spring 프레임워크의 가장 큰 특징은 IoC(Inversion of Control)과 DI(Dependency Injection) 이다.
```

> # IoC (Inversion of Control)

- **Inversion** : 역전
- 컨테이너가 코드 대신 오브젝트 제어권을 갖고 있다.
- **개발자가 만든 클래스나 메소드를 다른 프로그램이 대신 실행해주는 것**을 의미한다.

<br>

> # DI (Dependency Injection)

- 의존성 주입
- **클래스 사이의 의존관계를 Bean설정 정보를 바탕으로 컨테이너가 자동으로 연결해주는 것**을 의미한다.
- 직접 인스턴스를 생성하지 않고, 컨테이너가 자동으로 객체를 주입해주는 것.

<br>

> # Spring에서 제공하는 IoC 와 DI 컨테이너

- ### `BeanFactory` : IoC/DI 에 대한 기본 기능을 갖고 있다.
- ### `ApplicationContext`
  - BeanFactory의 모든 기능을 포함하고 있다.
  - 트랜잭션 처리, AOP 에 대한 처리를 할 수 있다.
  - `BeanPostProcessor`, `BeanFactoryPostProcessor` 등을 자동으로 등록 및 어플리케이션 이벤트 등을 처리

    - `BeanPostProcessor` : 컨테이너의 기본로직을 오버라이딩하여 인스턴스화와 의존성 처리 로직등을 개발자가 원하는 대로 구현할 수 있다.
    - `BeanFactoryPostProcessor` : 설정된 메타 데이터를 커스터마이징(상용화) 할 수 있다.


> ### Bean 클래스

- 기본생성자를 갖고 있다.
- 필드는 `private` 로 선언한다.
- getter(), setter() 메소드를 갖는다.
- getName(), setName() 메소드를 name 프로퍼티(property)라고 한다.

<br>

# XML 파일을 이용한 설정


<br>

# Java Config를 이용한 설정
