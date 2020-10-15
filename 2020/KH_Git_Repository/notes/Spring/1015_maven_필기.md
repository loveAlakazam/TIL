# Maven

- 해당프로젝트의 버젼정보 및 라이브러리 정보들을 통합
- 라이브러리를 계속 다운로드한다.
- 라이브러리 종속성
  - 그동안은 일반적인 프로젝트는 개발자가 필요한 라이브러리를 직접 찾아서 다운받아서 넣었었다.
  - Spring Maven은 라이브러리를 알아서 추가하여 사용할 수 있다.

  - ### `pom.xml` : **라이브러리 정보**(라이브러리 등록 및 관리), **프로젝트 버젼정보 관리**


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
|Spring AOP(Aspect Oriented Programming)||
|POJO(Plain Old Java Object)|<b>프레임워크에서 사용되는 객체</b><br>vo, bean(객체)<br>|
