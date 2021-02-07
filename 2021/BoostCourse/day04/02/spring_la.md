# 스프링 mvc 패턴 복습

![](../imgs/spring_mvc_web.png)

<br>

# 레이어드 아키텍쳐 (Layered Architecture)

> ## Controller에서 중복되는 부분을 처리하려면?

- 별도의 객체로 분리
- 별도의 메소드로 분리
- 모든 페이지가 공통 메뉴바(로그인, 회원정보 조회)를 갖는 경우
  - 예를들어서, 쇼핑몰에서
    - 쇼핑몰 게시판에서도 회원정보를 보여주거나
    - 상품목록 보기 페이지에서도 회원정보를 보여줘야할 때
    - 회원정보를 읽어오는 코드를 공통으로 갖게하려면?
      - 컨트롤러를 중복적으로 호출할 경우에는 **서비스**를 이용

<br>

- **서비스** (Service)
  - 비즈니스 로직(Business Logic)을 수행하는 메소드를 갖는 객체
  - 보통 **하나의 비즈니스 로직은 하나의 트랜잭션으로 동작**한다.
    - **트랜잭션**(Transaction)
      - 정의: 하나의 **논리적인 작업**
      - 트랜잭션의 4가지 특징
        - **원자성**(Atomicity)
          - 전체가 성공하거나 전체가 실패하는 것을 의미한다.
            - rollback :  원래대로 복원
            - commit : 반영

        - **일관성**(Consistency)
          - 트랜잭션 작업 처리 결과가 항상 일관성이 있어야한다.
          - 진행되는 동안 데이터가 변경되더라도, 업데이트된 데이터로 트랜잭션을 진행하는게 아니라 처음 트랜잭션을 진행하기 위해 참조한 데이터로 진행.
        - **독립성**(Isolation)
          - 어느 하나의 트랜잭션이더라도 트랜잭션의 연산을 끼어들 수 없다.
          - 하나의 특정 트랜잭션이 완료될때까지 다른트랜잭션이 특정 트랜잭션의 결과를 참조할 수 없다.
        - **지속성**(Durability)
          - 트랜잭션이 성공적으로 완료되었을 때 결과는 영구적으로 반영.


  - 업무와 관련된 메소드(비즈니스 메소드)를 가짐.
  - 서비스객체를 따로 만들어놓고 여러개의 컨트롤러가 하나의 서비스객체를 사용하도록 설정.


- JDBC 프로그래밍에서 트랜잭션 처리 방법
  - Connection객체의 `setAutoCommit()`를 false로 한다. (setAutoCommit의 기본값은 true로 설정되어있다.)

  - 입력, 수정, 삭제 SQL이 실행한 후에 모두 성공하면 `commit()`메소드를 수행하고, 실패할 경우에는 `rollback()`(원래상태로 복원)메소드를 수행한다.


<br>

> # @EnableTransactionManagement

- **spring java config 파일에서 트랜잭션을 활성화**할때 사용하는 어노테이션이다.

- java Config를 사용하게 되면 **`PlatformTransactionManager`구현체를 모두 찾아서 그중 하나를 매핑해서 사용** 한다.

- 특정 트랜잭션 매니저를 사용하고자한다면 **`TransactionManagementConfigurer`를 Java Config 파일에서 구현** 하고 **원하는 트랜잭션 매니저를 리턴**하도록한다.

- 특정 트랜잭션 매니저 객체를 생성했을 때는 **@Primary** 어노테이션을 지정한다.


- 서비스 객체에서 중복으로 호출되는 코드의 처리
  - 서비스객체마다  비즈니스 메소드를 갖고있다.
  - 하나의 비즈니스 메소드는 트랜잭션 단위로 작업을 처리할 수있다.
  - 하나의 트랜잭션에는 여러개의 데이터베이스 작업이 수행될 수 있다.
    - 예) 게시글 상세페이지 방문 => 해당 게시글번호가 있는지 확인하여 페이지 이동 + 조회수 증가

  - 비즈니스 메소드마다 중복되는 기능을 호출할 수 있다.
  - 서비스 객체에서 중복되는 기능을 처리할 때, 별도의 객체로 분리하거나 별도의 메소드로 분리해서 사용한다.

  - 데이터 엑세스 메소드를 별도의 Repository(DAO) 객체에서 구현하도록 한다.
  - 서비스는 Repository 객체를 사용하도록 한다.


<br>

> # Layered Architecture

![](../imgs/la01.png)

- Presentation Layer: Controller 객체가 동작
- Service Layer : 비즈니스 메소드를 갖는 서비스 객체동작
- Repository Layer : DB접근, DAO객체를 활용

<br>

> # 설정의 분리

- Spring 설정파일을 프레젠테이션 레이어쪽과 나머지(Service, Repository)를 분리할 수 있다.

- web.xml 파일에서 프레젠테이션 레이어에 대한 스프링 설정은 DispatcherServlet이 읽도록 한다.

- 프레젠테이션 이외의 설정은 ContextLoaderListener를 통해서 읽도록 한다.

<br>

> # (실습) 방명록 만들기

[방명록 만들기 - 전체코드](../guestBookPractice)

<br>

- Guestbook 테이블

```sql
create table guestbook(
  id int unsigned not null auto_increment,
  name varchar(255) not null,
  content text,
  regdate datetime,
  primary key(id)
);
```

<br>

- Log 테이블
  - 방명록에 글 등록, 삭제 시 로그테이블에 클라이언트 정보를 저장한다.
    - 클라이언트 IP주소
    - 등록/삭제 시각
    - 등록/삭제 메소드 칼럼 정보

```sql
create table log(
	id int unsigned not null auto_increment,
  ip varchar(255) not null,
  method varchar(10) not null,
  regdate datetime,
  primary key (id)
);
```

<br>

- Maven 프로젝트 만들기
  - GroupId: **org.apache.maven.archetypes**
  - ArtifactId: **maven-archetype-webapp**

<br>

- pom.xml
  - 추가 라이브러리
    - jstl
    - spring-context
    - spring-jdbc
    - spring-tx
    - servlet.jsp-api
    - mysql
    - (datasource) - common-dbcp2
    - jackson

```xml
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.exam.boostcourse.mvcprac</groupId>
  <artifactId>guestBook</artifactId>
  <version>0.0.1-SNAPSHOT</version>
  <packaging>war</packaging>

  <name>guestBook Maven Webapp</name>
  <!-- FIXME change it to the project's website -->
  <url>http://www.example.com</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.7</maven.compiler.source>
    <maven.compiler.target>1.7</maven.compiler.target>

    <!--  spring version  -->
    <spring.version>5.2.12.RELEASE</spring.version>

  	<!--  jackson  version (json) -->
  	<jackson2.version>2.8.6</jackson2.version>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>

    <!-- SPRING-CONTEXT -->
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-context -->
	<dependency>
	    <groupId>org.springframework</groupId>
	    <artifactId>spring-context</artifactId>
	    <version>${spring.version}</version>
	</dependency>

	<!--  spring-webmvc -->
	<dependency>
	    <groupId>org.springframework</groupId>
	    <artifactId>spring-webmvc</artifactId>
	    <version>${spring.version}</version>
	</dependency>

	<!-- jstl -->
	<!-- https://mvnrepository.com/artifact/javax.servlet/jstl -->
	<dependency>
	    <groupId>javax.servlet</groupId>
	    <artifactId>jstl</artifactId>
	    <version>1.2</version>
	</dependency>


	<!-- javax.servlet.jsp-api -->
	<!-- https://mvnrepository.com/artifact/javax.servlet.jsp/javax.servlet.jsp-api -->
	<dependency>
	    <groupId>javax.servlet.jsp</groupId>
	    <artifactId>javax.servlet.jsp-api</artifactId>
	    <version>2.3.3</version>
	    <scope>provided</scope>
	</dependency>


	<!-- javax.servlet-api -->
	<!-- https://mvnrepository.com/artifact/javax.servlet/javax.servlet-api -->
	<dependency>
	    <groupId>javax.servlet</groupId>
	    <artifactId>javax.servlet-api</artifactId>
	    <version>3.1.0</version>
	    <scope>provided</scope>
	</dependency>


	<!--  jdbc & driver & connection pool -->
	<!-- spring jdbc -->
	<!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
	<dependency>
	    <groupId>org.springframework</groupId>
	    <artifactId>spring-jdbc</artifactId>
	    <version>${spring.version}</version>
	</dependency>

	<!-- spring-tx(transaction) -->
	<!-- https://mvnrepository.com/artifact/org.springframework/spring-tx -->
	<dependency>
	    <groupId>org.springframework</groupId>
	    <artifactId>spring-tx</artifactId>
	    <version>${spring.version}</version>
	</dependency>


	<!-- mysql driver -->
	<!--Mysql JDBC Driver(MySQL Connector J) -->
	<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
	<dependency>
	    <groupId>mysql</groupId>
	    <artifactId>mysql-connector-java</artifactId>
	    <version>8.0.23</version>
	</dependency>

	<!-- datasource -->
    <!-- DataSource (DB connection pooling)  -->
	<!-- https://mvnrepository.com/artifact/org.apache.commons/commons-dbcp2 -->
	<dependency>
	    <groupId>org.apache.commons</groupId>
	    <artifactId>commons-dbcp2</artifactId>
	    <version>2.8.0</version>
	</dependency>
  </dependencies>

  <build>
    <finalName>guestBook</finalName>
    <pluginManagement><!-- lock down plugins versions to avoid using Maven defaults (may be moved to parent pom) -->
      <plugins>
        <plugin>
          <artifactId>maven-clean-plugin</artifactId>
          <version>3.1.0</version>
        </plugin>
        <!-- see http://maven.apache.org/ref/current/maven-core/default-bindings.html#Plugin_bindings_for_war_packaging -->
        <plugin>
          <artifactId>maven-resources-plugin</artifactId>
          <version>3.0.2</version>
        </plugin>


        <plugin>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.8.0</version>
          <configuration>
          	<source>1.8</source>
          	<target>1.8</target>
          </configuration>
        </plugin>



        <plugin>
          <artifactId>maven-surefire-plugin</artifactId>
          <version>2.22.1</version>
        </plugin>
        <plugin>
          <artifactId>maven-war-plugin</artifactId>
          <version>3.2.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-install-plugin</artifactId>
          <version>2.5.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-deploy-plugin</artifactId>
          <version>2.8.2</version>
        </plugin>
      </plugins>
    </pluginManagement>
  </build>
</project>

```

<br>

- (설정파일 1) WebMvcContextConfiguration.java

```java
package com.exam.boostcourse.mvcprac.guestbook.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;


@Configuration	//Config파일 (설정파일)
@EnableWebMvc	//EnavleWebMvc는 웹에 필요한 빈들을 자동으로 설정한다.
@ComponentScan(basePackages= {"com.exam.boostcourse.mvcprac.guestbook.controller"}) //basePackage에 기재된 패키지안에있는 @가 붙은 클래스를 찾아서 스프링이 관리할수 있도록함.

public class WebMvcContextConfiguration implements WebMvcConfigurer {
	// 모든 요청이 들어왔을 때 서블릿을 실행.
	// 컨트롤러에서 URL 매핑된 요청뿐만아니라, 정적파일들도 요청할 수 있다.
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/assets/**").addResourceLocations("classpath:/META-INF/resources/webjars/").setCachePeriod(31556926);
        registry.addResourceHandler("/css/**").addResourceLocations("/css/").setCachePeriod(31556926);
        registry.addResourceHandler("/img/**").addResourceLocations("/img/").setCachePeriod(31556926);
        registry.addResourceHandler("/js/**").addResourceLocations("/js/").setCachePeriod(31556926);

        //예:  /js/** (js파일) 을 요청할 경우에는 /js/디렉토리 에서 찾아요.
        //예: /css/** (css파일) 을 요청할 경우에는 /css/ 디렉토리에서 찾아요.
	}

	//default servlet 핸들러를 사용하도록 한다.
	@Override
	public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
		configurer.enable(); //DefaultServletHandler를 사용하도록함.
		// 매핑정보가 없는 url DefaultServletHttpRequestHandler가 처리한다.
		// DefaultServletHttpRequestHandler는 WAS의 DefaultServlet에게 요청을 넘긴다.
		// WAS는 DefaulServlet이 static한 자원을 읽어서 보여주게한다.
	}


	// 특정 url에 대한 처리를 controller클래스를 작성하지 않고 매핑할 수 있도록함.
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		System.out.println("addViewControllers가 호출된다.");
		registry.addViewController("/").setViewName("index");
		// url /을 요청했을 때 main 이름의 뷰를 불러온다.
		//뷰이름을 알고있는 상태. ViewResolver을 통해서 해당이름의 뷰화면을 리턴하여 응답페이지로 랜더링.

	}

	@Bean
	public InternalResourceViewResolver getInternalResourceViewResolver() {
		InternalResourceViewResolver resolver= new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/"); //리턴할 뷰의 저장경로
		resolver.setSuffix(".jsp");	//리턴할 뷰의 확장자
		return resolver; // 뷰이름에 해당하는 뷰를 불러옴으로써 응답뷰로 클라이언트한테 보냄.
	}
}

```

<br>

- (설정파일 2) DBConfig.java

```java
package com.exam.boostcourse.mvcprac.guestbook.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.TransactionManagementConfigurer;


@Configuration
@EnableTransactionManagement //트랜잭션관련된 설정을 자동으로 처리해도록 함.
public class DBConfig implements TransactionManagementConfigurer {

	private String driverClassName="com.mysql.cj.jdbc.Driver";
	private String url="jdbc:mysql://localhost:3306/connectdb?serverTimezone=UTC";
	private String userName="connectuser";
	private String password="connect123!@#";

	//해당메소드에서 트랜잭션을 처리할 플랫폼트랜잭션매니저를 반환해야한다
	@Override
	public TransactionManager annotationDrivenTransactionManager() {
		return transactionManager();
	}

	//데이터베이스연결
	@Bean
	public DataSource dataSource() {
		BasicDataSource dataSource =new BasicDataSource();
		dataSource.setDriverClassName(driverClassName);
		dataSource.setUrl(url);
		dataSource.setUsername(userName);
		dataSource.setPassword(password);
		return dataSource;
	}

	@Bean
	public PlatformTransactionManager transactionManager() {
		return new DataSourceTransactionManager(dataSource());
	}
}

```

<br>

- (설정파일 3)ApplicationConfig.java

```java
package com.exam.boostcourse.mvcprac.guestbook.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;

@Configuration
@ComponentScan(basePackages= { "com.exam.boostcourse.mvcprac.guestbook.dao",
							   "com.exam.boostcourse.mvcprac.guestbook.service"} )
@Import({DBConfig.class} ) // 데이터베이스 설정파일을 불러온다.
public class ApplicationConfig {

}

```

<br>

- web.xml (주석은 모두 제거한다.)

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd" version="3.1">
    <display-name>Spring JavaConfig Sample</display-name>

    <context-param>
    	<param-name>contextClass</param-name>
    	<param-value>org.springframework.web.context.support.AnnotationConfigWebApplicationContext</param-value>
    </context-param>

    <!-- ApplicationConfig 설정파일 등록 -->
    <context-param>
    	<param-name>contextConfigLocation</param-name>
    	<param-value>com.exam.boostcourse.mvcprac.guestbook.config.ApplicationConfig</param-value>
    </context-param>


    <!--listener은 나눠진 설정파일들을 읽을수있도록 도와주는 객체이다.
    	특정이벤트가 일어났을때 동작한다.
    	ContextLoaderListener :컨텍스트가 로딩될때 읽어서 수행한다.

    	DispaterServlet이 실행될때 contextParam에 등록된 설정파일들을 실행한다.
    -->
    <listener>
    	<listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>


	<!--DispatcherServlet을 FrontController로 등록하기 -url(/)에 대한 요청이 들어올때 실행.-->

	<servlet>
		<servlet-name>mvc</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>

		<init-param>
			<param-name>contextClass</param-name>
			<param-value>org.springframework.web.context.support.AnnotationConfigWebApplicationContext</param-value>
		</init-param>

		<!-- context 설정파일 : WebMvcContextConfiguration -->
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>com.exam.boostcourse.mvcprac.guestbook.config.WebMvcContextConfiguration</param-value>
		</init-param>

		<load-on-startup>1</load-on-startup>
	</servlet>

	<servlet-mapping>
		<servlet-name>mvc</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>


	<!-- 필터등록: 요청수행전, 응답수행전에 등록해서 사용할 수 있다. -->
	<filter>
		<!-- 한글 인코딩 처리 -->
		<filter-name>encodingFilter</filter-name>
		<filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>

		<init-param>
			<param-name>encoding</param-name>
			<param-value>UTF-8</param-value>
		</init-param>
	</filter>
	<filter-mapping>
		<filter-name>encodingFilter</filter-name>

		<!-- 모든 요청에 대해서 적용. -->
		<url-pattern>/*</url-pattern>
	</filter-mapping>
</web-app>

```
