# IO 복습
## 직렬화와 역직렬화 개념

- 직렬화(Serialization)
  - ```객체```를 ```데이터```로 변환
  - Serializable 인터페이스를 implements하여 구현한다.
  - 객체를 직렬화할때 private 필드를 포함한 모든 필드를 바이트로 변환한다.
  - ```transient``` 키워드를 사용하는 필드는 직렬화에서 제외된다.

- 역직렬화(DeSerialization)
  - ```데이터```를 ```객체```로 변환
  - 직렬화했을 때마다 같은 클래스를 사용해야한다.
  - <strong>단, 클래스 이름이 같더라도, 클래스 내용이 변경되면 역직렬화가 실패된다.</strong>


- serialVersionUID 필드
  - 직렬화한 클래스와 같은 클래스임을 알려주는 식별자 역할
  - 컴파일시 JVM이 자동으로 serialVersionUID 정적 필드를 추가해
  - 별도로 작성하지 않아도 오류는 나지 않지만
    - 자동생성시 역직렬화에서 예상하지 못한 InvalidClassException을 유발할 수있어서
    - serialVersionUID를 명시하는걸 권장한다.

<br>

<hr>

## 직렬화와 역직렬화 예제

- BufferDAO.java

```java
```

- Run.java
```java
```



-
