# 프로그램의 오류

- 정의
  - 비정상 종료 상황이 발생한다.
  - 프로그램 에러

- 오류의 종류
  - 컴파일 에러
    - 문법 에러

  - 런타임 에러
    - 입력값이 틀렸다.
    - 배열의 인덱스 범위를 벗어났다
    - 계산식의 오류

  - 시스템 에러

<HR>

# 예외처리 방법

> 1. Exception 처리를 호출한 메소드에게 위임
  - method선언시, throws Exception문을 추가하여
  - 호출한 상위 메소드에게 예외를 처리하도록 한다.
  - 계속 위임하게되면 main()메소드 까지 위임하게 되는데
    - main()메소드에서도 예외처리를 못하면, 비정상 종료가 이루어진다.

> 2. Exception이 발생한 곳에서 직접 처리
  - try ~ catch 문을 이용한 예외처리
    - try: exception이 발생할 가능성이 있는 코드 기술
    - catch: try 구문에서 예외가 발생하게되면 해당 예외처리를 담당한다.
    - finally: exception 발생여부와 관계없이 꼭 처리해야되는 기술.


> 3. 예외처리 주의사항
- 자식예외가 위/ 부모예외가 아래
- 부모예외가 위에 있으면 자식예외는 아래로 내려올 수 없다.


<hr>

# 예약어 throws vs throw
- throws
  : 호출한 메소드에게 예외를 위임한다.

- throw
  : 예외를 (강제로) 처리한다.


# 상속의 범위와 처리의 범위
  - 상속의 범위: 자식 >= 부모
    - 자식은 부모의 멤버들을 물려받는다.
    - 심지어 물려받은 메소드를 오버라이드 한다.

  - 처리의 범위: 부모 > 자식
    - <strong>다형성</strong>이 적용되어있다고 보면된다.
    - 상위 예외 클래스(부모예외)는 처리할 수 있는 범위가 넓다.
      - 부모는 하위 자식들 모두를 처리할 수 있기 때문이다.
      - 다형성에서도 부모의 래퍼런스변수가 자식객체를 받아들일 수 있는 개념과 유사하다.

    - 반면, 자식은 자식하나밖에 처리할 수 없다.


<br>


# 사용자 정의 예외처리

- MyException.java

```java
package com.kh.example.chap02_user.model.exception;
// 사용자 정의 예외 만들기

// 모든 예외의 조상인 Exception을 상속받아야한다.
public class MyException extends Exception{
	public MyException() {}
	public MyException(String msg) {
		super(msg);
	}
}

```
