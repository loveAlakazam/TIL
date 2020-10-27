# AOP - rough한 필기노트

- ### 관점지향
- ### 공통코드 부분을 별도의 영역으로 분리
- ### 관점이란?
  - 무엇을 넣을 것인가?
  - 어디에 넣을 것인가?
```
어떤 관점으로 집어넣을 지를 뽑아서 넣는다. 각각의 관점을 바라보면서 어떤 코드를 넣겠다.
```


공통부분(로깅/트랜젝션)을 넣는다.

코드의 중복을 줄이고 필요할 때마다 가져다 쓸 수있도록 한다.

<br>

> ## advice

- 너 ~ 해야돼.
- 공통된 부분을 따로 빼서 작성하는 클래스

<br>

> ## join point

- 어느시점에 넣어야 될지를 나타내는것
- 로그인을 하기전에 advice를 넣을건지

<br>

> ## weaving

- 어느 시점에 넣어야되는 행동 자체를 의미한다.


<br>

> # spring 용어 정리


## Aspect = advice + point-cut

- 부가 기능을 정의한 코드인 어드바이스
- 어드바이스를 어디에 적용할지를 결정하는 포인트컷을 합친 개념
- AOP개념을 적용하면 핵심 기능코드 사이에 끼어있는 부가기능을 독립적인 요소로 구분할 수 있고
- 구분된 부가기능 Aspect는 런타임시 필요한 위치에 동적으로 참여기능


<br>


## spring aop 핵심 용어

- aspect
- join-point : advice를 실행시키는 시점
  - point cut의 부분집합
  - => point cut이 모여서 join-point가 됨.

- advice
  - **advice가 적용되는 시점.**
  - before advice
  - around advice : 전에 한번 나타나고, 후에 나타냄 => 양옆에 나타냄
  - after advice : 내가 호출되고 나서
  - after returning advice : 내가 반환이 된 후에, 정상적으로 다 끝날때에 실행.
  - after throwing advice : 예외가 발생했을때만 실행

- weaving : 공통코드를 끼워넣는 행위 자체
  - 정적: 지정한 시점에만 행위를 실행
  - 동적
    - compile 시 위빙(weaving)
    - run time 시 위빙(weaving) => 돌아가고 나서 시점
      - 클래스를 변경하지 않고

<br>

- ### `프록시 서버` = `가짜 액터` = `프록시 엑터`
  - 중간다리 역할
  - 엘레베이터 버튼 역할.

- 타겟 object에 있어야되는데
- 중간에 가짜를 만들어서 경유해서 지나가겠다.
- advice가 적용된 후 생성되는 객체

<br>


> ## target object

- advice를 삽입해야할 대상 객체  - 코드 삽입

<br>

> ## spring aop 구조 정리 (참고)

- primary concern
- cross-cutting concern
- aspcet: 포인트 컷과 부가기능 (보안/인증/ 시스템 전반에 걸쳐 사용되는 코드)이 합쳐진 것


<br><br>

<hr>

> # spring aop 특징 및 구현 방식

- ### spring은 프록시 기반 aop를 지원한다
  - 대상 객체(target object)에 대한 프록시를 만들어서 제공
  - 타겟을 감싸는 프록시는 서버 런타임 시에 생성된다
  - 생성된 프록시는 대상 객체를 호출할 때 먼저 호출되어 어드바이스의 로직을 처리 후에 대상 객체 호출

- ### 프록시는 대상 객체의 호출을 가로챈다(intercept)
  - 프록시는 그 역할에 따라 대상 객체에 대한 호출을 가로챈 다음에 advice의 부가 기능 로직을 수행하고 난 후에 타겟의 핵심 기능 로직을 호출(전처리 어드바이스)
  - 타겟의 핵심 기능 로직 메소드를 호출한 후에 advice의 부가 기능 수행(후처리 어드바이스)

- ### 스프링 aop 특징
  - **스프링 aop는 메소드 조인 포인트만 지원한다.**
    - 자잘하고 작게 만들 수 있다. (세분화)
    - 덩어리 자체가 아니라, 메소드 마다마다 지원한다. => 자잘하게 내가 원하는 것들만 선택해서 적용 할 수 있다.
    - spring은 동적 proxy를 기반으로 aop를 구현하기 때문에 메소드 조인 포인트만 지원
    - 핵심기능(대상객체)의 메소드가 호출되는 런타임 시점에만 부가기능(advice)적용 가능
    - 하지만 aspectj와 같은 고급aop프레임워크를 사용하면
       - 객체 생성 /필드값 조회와 조작 / static 메소드 호출 및 초기화 등의 다양한 작업에 부가기능 적용 가능.


- ### aop 구현방식
  - xml방식
    - `<aop:config>`
  - annotation(@)방식
    - `@Aspect` 클래스 작성
    - xml 설정 파일에 `<aop:aspect-autoproxy />` 설정


- ### spring aop 구현 방식 xml
   - <aop: before / around / after / after-returning / after-throwing>

- ### spring aop 구현 방식 @(annotation)
  - @Before/ Around / After  ("pointcut")
  - @AfterReturning(Pointcut="", Returning="") / AfterThrowing()


<br><br>

> # join- point : 코드가 적용되는 시점

- aspectj에서 aop의 부가 기능을 지닌 코드가 적용되는 지점
- 모든 advice는 org.aspect.lang.JoinPoint 타입의 파라미터
- around advice => joint point의 하위클래스인 proceeding join point 타입의 파라미터를 필수적으로 선언.

<br>

> # join-point interface 메소드

- getArgs()
- getThis()
- getTarget()
- getSignature()


<br>
