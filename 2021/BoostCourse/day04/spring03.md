# Spring JDBC

## DTO (Data Transfer Object)

- VO(Value Object) 와 같은 역할.
- 계층간 데이터 교환을 위한 java beans 이다.
  - 계층의 구조
    - View 계층
    - Controller 계층
    - Business 계층
    - Persistance 계층

- 필드, getter, setter 메소드를 갖는다.
- `toString()`, `equals()`, `hashCode()` 등의 Object 클래스가 가진 메소드를 오버라이딩 한다.
  - 모든 객체의 부모클래스는 Object 객체이기 때문에 모든 객체는 Object클래스가 가진 메소드를 상속받을 수 있으며, 오버라이드가 가능하다.

<br>

## DAO(Data Access Object)

- 데이터 조회, 데이터 조작 기능을 담당하는 객체
- 데이터베이스를 조작하는 기능을 담당한다.

<br>

## Connection Pool

- Connection 객체를 이용하여 DB와 연결이 필요할 때마다 사용할 수 있으며 사용이 끝나면 반드시 반납을 한다.
- Connection 객체를 반납을 하지 않으면, 다른 클라이언트가 사용할 때 DB와 연결할 수 없게된다.

- Connection 반납이 필요한 이유

![](./imgs/s3.jpg)


<br>

## DataSource

- Connection Pool 을 관리하는 목적으로 사용되는 객체이다.
- DataSource를 이용하여 Connection객체를 얻어오고 반납하는 작업을 수행한다.


- [tutorials points - Data Access Object Pattern](https://www.tutorialspoint.com/design_pattern/data_access_object_pattern.htm)


<hr>

> # Spring JDBC 실습 1

## Maven 프로젝트 생성

- GroupId: **org.apache.maven.archetypes**
- ArtifactId : **maven-archetype-quickstart**

<br>

## pom.xml 에 라이브러리 추가

- **spring-context**
- **spring-jdbc**
- **spring-tx**
- **MySQL Connector/J** (MySQL JDBC Driver/ MySQL 8.0.23 ver 사용.)
- **commons-dbcp2** (DataSource - DB Connection Pooling 을 관리/ 2.8.0 버젼)

```xml
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.exam.boostcourse</groupId>
  <artifactId>dao</artifactId>
  <version>0.0.1-SNAPSHOT</version>

  <name>dao</name>
  <!-- FIXME change it to the project's website -->
  <url>http://www.example.com</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.7</maven.compiler.source>
    <maven.compiler.target>1.7</maven.compiler.target>

    <!--spring version 프로퍼티 추가-->
    <spring.version>5.2.12.RELEASE</spring.version>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>

    <!-- https://mvnrepository.com/artifact/org.springframework/spring-context -->
	<dependency>
	    <groupId>org.springframework</groupId>
	    <artifactId>spring-context</artifactId>
	    <version>${spring.version}</version>
	</dependency>

    <!-- spring jdbc 라이브러리 추가 -->
    <!-- https://mvnrepository.com/artifact/org.springframework/spring-jdbc -->
	<dependency>
	    <groupId>org.springframework</groupId>
	    <artifactId>spring-jdbc</artifactId>
	    <version>${spring.version}</version>
	</dependency>

    <!--  spring tx 라이브러리 추가 -->
    <dependency>
	    <groupId>org.springframework</groupId>
	    <artifactId>spring-tx</artifactId>
	    <version>${spring.version}</version>
	</dependency>

	<!--Mysql JDBC Driver(MySQL Connector J) -->
	<!-- https://mvnrepository.com/artifact/mysql/mysql-connector-java -->
	<dependency>
	    <groupId>mysql</groupId>
	    <artifactId>mysql-connector-java</artifactId>
	    <version>8.0.23</version>
	</dependency>

	<!-- DataSource (DB connection pooling)  -->
	<!-- https://mvnrepository.com/artifact/org.apache.commons/commons-dbcp2 -->
	<dependency>
	    <groupId>org.apache.commons</groupId>
	    <artifactId>commons-dbcp2</artifactId>
	    <version>2.8.0</version>
	</dependency>
  </dependencies>

  (아래 생략)
</project>
```

<br>

## ApplicationConfig.java

```java
package com.exam.boostcourse.dao.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement //Transaction(sql문 수행 및 처리)을 수행하는데 필요하다.
public class DBConfig {
	//드라이버 정보
	private String driverClassName= "com.mysql.cj.jdbc.Driver";

	//어떤 데이터베이스에 접속할 것인지 url 정보 => connectdb에 접속하겠다.
	private String url="jdbc:mysql://localhost:3306/connectdb?serverTimezone=UTC";

	//접속 계정 정보
	private String userName="connectuser";
	private String password= "connect123!@#";


	// @Bean 을 이용하여 객체를 등록하기(불러오기)
	// 이미 작성된 객체를 사용.
	// DataSource를 생성하는 객체를 등록.
	@Bean
	public DataSource dataSource() {
		BasicDataSource dataSource= new BasicDataSource();
		dataSource.setDriverClassName(driverClassName);
		dataSource.setUrl(url);
		dataSource.setUsername(userName);
		dataSource.setPassword(password);
		return dataSource;
	}
}
```

<br>

## DBConfig.java

```java
package com.exam.boostcourse.dao.config;

import javax.sql.DataSource;

import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement //Transaction(sql문 수행 및 처리)을 수행하는데 필요하다.
public class DBConfig {
	//드라이버 정보
	private String driverClassName= "com.mysql.cj.jdbc.Driver";

	//어떤 데이터베이스에 접속할 것인지 url 정보 => connectdb에 접속하겠다.
	private String url="jdbc:mysql://localhost:3306/connectdb?serverTimezone=UTC";

	//접속 계정 정보
	private String userName="connectuser";
	private String password= "connect123!@#";


	// @Bean 을 이용하여 객체를 등록하기(불러오기)
	// 이미 작성된 객체를 사용.
	// DataSource를 생성하는 객체를 등록.
	@Bean
	public DataSource dataSource() {
		BasicDataSource dataSource= new BasicDataSource();
		dataSource.setDriverClassName(driverClassName);
		dataSource.setUrl(url);
		dataSource.setUsername(userName);
		dataSource.setPassword(password);
		return dataSource;
	}
}
```

<br>

## DataSourceTest.java

```java
package com.exam.boostcourse.dao.main;

import java.sql.Connection;

import javax.sql.DataSource;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.exam.boostcourse.dao.config.ApplicationConfig;

public class DataSourceTest {

	public static void main(String[] args) {
		//ApplicationConfig 클래스를 불러와서 ApplicationContext 객체를 불러온다.
		//사용자가 직접 객체를 생성하지 않고 프레임워크가 객체의 생성부터 소멸까지 관리하도록 해주는 객체이다.
		ApplicationContext ac= new AnnotationConfigApplicationContext(ApplicationConfig.class);

		//객체를 얻어낸다.
		DataSource ds= ac.getBean(DataSource.class); //DataSource를 얻어온다.

		//DataSource를 통해서 Connection객체를 얻어온다.
		Connection conn=null;
		try {
			// connection객체를 얻어온다.
			conn=ds.getConnection();

			if(conn!=null) {
				System.out.println("접속 성공");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(conn!=null) {
				try{
					//커넥션을 닫는다.
					conn.close();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

}

```

`접속 성공`이 콘솔에 출력되면, JDBC Connection객체가 잘 생성됐음(DataBase와 연결이 됐음)을 나타낸다.

<hr>

> # Spring JDBC 실습 2 - SELECT

## Role.java

```java
package com.exam.boostcourse.dao.DTO;

public class Role {
	private int roleId;
	private String description;

	public Role() {}

	public Role(int roleId, String description) {
		this.roleId= roleId;
		this.description=description;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public String toString() {
		return "Role [roleId=" + roleId + ", description=" + description + "]";
	}
}

```

<br>

## RoleDAOSqls.java

```java
package com.exam.boostcourse.dao.DAO;

public class RoleDAOSqls {
	public static final String SELECT_ALL="SELECT ROLE_ID, DESCRIPTION FROM ROLE ORDER BY ROLE_ID";
}

```

<br>

## RoleDAO.java

```java
package com.exam.boostcourse.dao.DAO;

import java.util.Collections;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.EmptySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import com.exam.boostcourse.dao.DTO.Role;
import static com.exam.boostcourse.dao.DAO.RoleDAOSqls.*;

@Repository //DAO는 저장소 역할을 한다.
public class RoleDAO {
	private NamedParameterJdbcTemplate jdbc; //이름을 이용해서 바인딩하거나 결과값을 이용.
	private RowMapper<Role> rowMapper= BeanPropertyRowMapper.newInstance(Role.class);

	//기본생성자가 없다면 자동으로 객체를 주입.
	public RoleDAO(DataSource dataSource) {
		this.jdbc=new NamedParameterJdbcTemplate(dataSource);
	}

	public List<Role> selectAll(){
		//2번째 파라미터 - Collections.emptyMap() : 바인딩할 값이 있을 때 바인딩할 값을 전달.
		//3번째 파라미터 - : select 한건을 DTO에 담는다.;
		//내부적으로 반복하여 dto를 생성하여 리스트를 만들어서 리스트를 반환
		return jdbc.query(SELECT_ALL, EmptySqlParameterSource.INSTANCE, rowMapper);
	}
}

```

<br>

## SelectAllTest.java

```java
package com.exam.boostcourse.dao.main;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;

import com.exam.boostcourse.dao.DAO.RoleDAO;
import com.exam.boostcourse.dao.DTO.Role;
import com.exam.boostcourse.dao.config.ApplicationConfig;

public class SelectAllTest {

	public static void main(String[] args) {
		ApplicationContext ac= new AnnotationConfigApplicationContext(ApplicationConfig.class);
		RoleDAO roleDAO= ac.getBean(RoleDAO.class);
		List<Role> rList= roleDAO.selectAll();
		for(Role role: rList) {
			System.out.println(role);
		}

	}

}

```

<hr>

> # Spring JDBC 실습 3
