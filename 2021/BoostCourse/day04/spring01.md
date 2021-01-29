<details>
  <summary>요약</summary>
  - XML 파일을 이용한 설정 [:link:](#XML-파일을-이용한-설정)

  - 싱글톤패턴 [:link:](#싱글톤-패턴-singleton)
  
  - Java Config를 이용한 설정 [:link:](#Java-Config를-이용한-설정)
</details>

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
ß
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

- DI는 내가 원하는 객체(클래스)를 스프링프레임워크가 자동으로 생성해주는 것이다.
  - 사용자가 프레임워크한테 자동 주입을 해주는 곳을 Annotation(@)을 이용하여 표기해야한다.
- 스프링이 자동으로 만들어줄 객체를 bean이라고 한다.
- 일반적인 자바 클래스이다.

<br>

- 기본생성자를 갖고 있다.
- 필드는 `private` 로 선언한다.
- getter(), setter() 메소드를 갖는다.
- getName(), setName() 메소드를 name 프로퍼티(property)라고 한다.


<br>

# XML 파일을 이용한 설정

[강의자료 - XML파일을 이용한 설정1](https://www.boostcourse.org/web326/lecture/258525)

[강의자료 - XML파일을 이용하나 설정2](https://www.boostcourse.org/web326/lecture/258526/)

<br>

> ## 프레임워크는 어떤 객체를 자동 주입할까?

- `기본생성자`를 갖고있다.
- 모든 필드들은 private 접근지시자를 갖는다.
- 각 필드의 getter, setter 메소드가 존재해야한다. (name프로퍼티를 갖는다.)
  - `name 프로퍼티` : name이란 이름의 필드가 있다면, getName(), setName()과 같은 메소드를 일컫는다.

<br>

> ## 프레임워크는 어떤과정으로 객체를 자동으로 생성할까?

- 한개의 beans 스프링 설정파일은 *.xml 확장자의 파일이며, 여러개의 클래스들을 등록할 수 있다.
- beans 스프링 설정파일에 등록된 클래스(bean)이 여러개가 있다면, 설정 파일에 들어있는 모든 bean의 정보를 읽어 들이고 생성해서 메모리에 올린다.

- 프레임워크는 등록된 beans 설정파일에 있는 특정 클래스(객체, bean) 불러올 때, `id`로  구분하여 불러온다.
- 프레임워크는 `싱글톤(singleton design pattern)` 디자인 패턴을 이용하여 객체를 생성한다.

<br>

> ## 싱글톤 패턴 (singleton)

- 딱 한번만 객체를 생성한다.
  - 생성자를 호출할 때마다 새로운 객체를 생성하지 않는다. 생성된 객체 한개를 계속 이용하는 것이다.

- 클래스 외부에서 new 연산자로 생성자를 호출할 수 없도록 해야한다.
- 객체의 기본생성자의 접근제한자를 private로 한다.

<br>


사용자 정의 객체 UserBean.java 를 만들었다.

- UserBean.java

```java
package kr.or.connect.diExam01;

public class UserBean {
	private String name;
	private int age;
	private boolean gender;

	public UserBean() {}

	public UserBean(String name, int age, boolean gender) {
		this.name=name;
		this.age=age;
		this.gender =gender;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public boolean isGender() {
		return gender;
	}

	public void setGender(boolean gender) {
		this.gender = gender;
	}
}

```

## 1. 사용자가 객체를 직접 생성하여 사용하는 경우

```java
package kr.or.connect.diExam01;

import kr.or.connect.diExam01.UserBean;
public class ApplicationContextExam01 {

	public static void main(String[] args) {
    UserBean userBean =new UserBean();
    userBean.setName("ek12mv2");

    UserBean userBean2= new UserBean();
    userBean.setName("ek12mv2");

		if(userBean==userBean2)
			System.out.println("같은 객체입니다.");
    else
      System.out.println("다른 객체입니다."); //userBean과 userBean2는 다른 객체이다.

    //왜냐하면 객체의 생성자를 호출했고, 필드의 값이 같더라도 객체 인스턴스의 주소값이 서로 다르기때문에 다르는 것으로 한다.
  }
}
```

<br>

## 2. Spring Framework의 DI(Dependency Injection)

> ### applicationContext.xml - Beans 스프링 클래스 설정파일을 만든다.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">


<!--
스프링 컨테이너는 객체를 딱 한개만 갖고 있는 싱글톤패턴 을 이용한다.
* java코드에서 사용자가 직접 객체를 생성할 때 코드인 아래코드와 유사하다.

<bean>등록은 아래의 코드를 xml형식으로 나타낸 것이다.

kr.or.connect.diexam01.UserBean userBean = new kr.or.connect.diexam01.UserBean();
-->
	<bean id="userBean" class="kr.or.connect.diExam01.UserBean"></bean>
</beans>
```

<br>

> ### 직접생성하지 않아도 스프링에서 객체를 불러오게한다.

- `ApplicationContext`
- `resources` 폴더: 리소스 폴더에서 생성한 xml파일은 자동으로 classpath를 지정한다.

- beans 스프링 설정파일(xml)을 불러오려면 `ClassPathXMLApplicationContext` 객체를 생성해서 불러와야한다. 불러오게 되면 등록한 bean 인스턴스를 모두 생성하여 메모리에 올린다.


```java
package kr.or.connect.diExam01;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class ApplicationContextExam01 {

	public static void main(String[] args) {
		ApplicationContext ac= new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
		System.out.println("초기화 완료");

    // getBean() 메소드는 스프링 객체 설정파일(beans)의 id값은 해당 객체의 래퍼런스를 반환시킨다.
    //Object타입으로 리턴하기때문에 형변환을 해야한다.
		UserBean userBean=(UserBean)ac.getBean("userBean");
		userBean.setName("ek12mv2");
		System.out.println("userBean name: "+ userBean.getName()); //userBean name: ek12mv2

		UserBean userBean2= (UserBean)ac.getBean("userBean");
		if(userBean==userBean2)
			System.out.println("같은 객체입니다."); //userBean과 userBean2가 같은 객체로 나옴.
    // getBean() 메소드 요청을 여러번 수행할 때
    // 새로운 bean객체를 아니라, 생성된 하나의 bean객체를 계속 이용하는 것을 의미한다.

    // 이는 프레임워크가 싱글톤 패턴을 이용하여 객체를 자동으로 생성하고 주입하고 있음을 의미한다.
	}
}
```

<br>

- 스프링프레임워크는 타입이 클래스인 필드를 갖는 클래스도 바로 생성할 수 있다.


- Car.java

```java
package kr.or.connect.diExam01;

public class Car {
	private Engine v8; // 클래스 타입의 필드
	public Car() {
		System.out.println("Car 생성자 호출");
	}

	public void setEngine(Engine e) {
		this.v8 = e;
	}

	public void run() {
		System.out.println("엔진을 이용하여 달립니다.");
		v8.exec();
	}
}
```

<br>

> ### 사용자가 직접 객체를 생성할 때

- `Car.java` 클래스를 사용자가 직접 생성해야한다면 클래스 필드 객체도 직접 생성해야된다.

- 사용자는 필요한 객체만 생성할 수 있도록 한다!
- Spring은 `annotation`과 `java config`를 사용하여 객체를 자동으로 생성할 수 있다.


```java
Engine e= new Engine(); //필드의 클래스 인스턴스를 만든다.
Car c =new Car();
c.setEngine(e);
c.run();
```

<br>

> ### 스프링 프레임워크가 객체를 자동으로 생성할 때

- XML파일에서 bean을 등록하고, 클래스 필드의 bean도 같이 등록하면 된다. 그러면 직접 객체를 생성하지 않아도 자동으로 객체를 생성할 수 있다.

- 객체(bean) 등록

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">

	<bean id="userBean" class="kr.or.connect.diExam01.UserBean"></bean>


	<!-- Engine 객체를 등록한다. -->
	<bean id="engine" class="kr.or.connect.diExam01.Engine"/>

  <!-- Car 객체를 등록한다 -->
  <bean id="car" class="kr.or.connect.diExam01.Car">
		<!-- Car객체의 필드 engine은 타입이 클래스타입이다. 프레임워크에서 property는 객체의 필드를 의미한다.

    필드 타입에 해당하는 클래스가 bean파일에 등록되어있다면 그 클래스 파일을 참조하도록 한다.

    ref는 참조할 객체(bean)를 가리키는 id를 의미한다.
    -->
		<property name="engine" ref="engine"></property>
	</bean>
</beans>
```

<br>

- 객체 bean을 불러와서 자동으로 주입하는 방법

```java
package kr.or.connect.diExam01;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ApplicationContextExam02 {

	public static void main(String[] args) {
		ApplicationContext ac= new ClassPathXmlApplicationContext("classpath:applicationContext.xml");

		// 스프링프레임워크가 자동으로 객체를 생성하여 주입시킨다.
		// id가 "car"인 객체를 꺼낸다.
		Car car =(Car) ac.getBean("car");
		car.run(); // 사용할 클래스를 알더라도, 연관 클래스를 직접 호출할 필요가 없다.

	}
}

```

<br>

# Java Config를 이용한 설정
