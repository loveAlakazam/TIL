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
