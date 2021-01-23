# Maven

- 참고자료
  - [참고자료1- wikidocs](https://wikidocs.net/17298)
  - [참고자료2- velog](https://velog.io/@maigumi/Maven-%EC%A0%95%EB%A6%AC%ED%95%98%EA%B8%B0)
  - [참고자료3- boostcourse](https://www.boostcourse.org/web326/lecture/58937)


> # Maven 이 뭐지?

**소프트웨어 프로젝트 관리 툴**

다양한 라이브러리 파일들을 설치하고 관리해주는 프레임워크이다.

라이브러리를 직접 설치할 필요없이, 알아서 라이브러리를 관리한다.

- `Build`, `패키징 문서화`, `테스트`, `테스트 리포트`, `의존성 관리`, `형상관리`, `배포`작업을 손쉽게 할 수 있다.

- CoC (Convention over Configuration)
  - 일종의 관습
  - 파일 위치가 미리 정해짐: 프로그램의 소스파일의 위치, 컴파일된 파일의 위치가 미리 정해져있다.
  - 사용자는 이러한 관습을 지켜야한다.


<br>

> # Maven 의 목적

- Making the build process Easy

메커니즘을 알지 않아도 할 수 있다.

<br>

- Providing a uniform build system

`pom.xml` 을 이용하여 프로젝트를 관리하고 빌드한다.

<br>

- Providing quality project information

- Ecouraging better development practice

<br>

> # POM(Project Object Model) : pom.xml

- **라이브러리를 등록하고 관리** 할 수 있다.
- **프로젝트 버젼정보를 관리** 할 수 있다.

<br>

> # Maven의 기능

- 빌드 툴
  - 하나의 컴포넌트로 빌드된다.
  - 의존성을 관리한다.
  - 빌드 수행 후 리포트를 생성한다.

- 패키징
  - `*.war`, `*.jar`, `*.exe` 형식의 파일들을 배포가능한 형태로 생성한다.

- 테스트
  - 단위테스트를 수행한다.
  - 빌드 결과가 정상적인지를 점검한다.

- 배포
  - 실제 운영 서버 배포가 아니다.
  - 해당 프로젝트의 버젼관리를 위해 특정 원격 저장소에 배포한다.
  - 빌드 후 생성된 아티팩트(컴포넌트)를 로컬 혹은 원격저장소에 배포한다.

- 빌드 툴: 소스빌드 및 배포 라이브러리 관리를 지원하는 소프트웨어
  - 종류: Maven, Gradle, Jenkins

- 컴포넌트(Component) : 하나 이상의 클래스로 작성되는 실행코드 기반의 모듈

<br>

> # Maven의 이점

- 편리한 의존성 라이브러리 관리
  - lib폴더에 직접 라이브러리 파일을 import할 필요없음.
- Maven에 설정한 대로 개발자가 일관된 방식으로 빌드를 수행할 수 있음.

<br>

> # Maven의 기본 디렉토리 구조

```
maven은 크게 src와 test로 구성되어있다.
```

- `pom.xml` : 프로젝트의 root에 위치한다.
- `src` : 기본 소스코드(ex. *.java 코드)를 저장하는 디렉토리이다.
- `test` : 테스트 코드를 저장하는 디렉토리이다.
- `target` : 컴파일 결과를 저장하는 디렉토리이다.

<br>

> # Maven의 pom.xml 파일 구조

- #### `<project>` : 프로젝트 기본 정보를 나타내는 태그이다. `pom.xml` 최상단에 위치.
  - `<modelVersion>` : pom model 버젼이다.
  - `<groupId>`: 프로젝트 생성 조직의 고유아이디 도메인이름을 거꾸로 적는다.
  - `<artifactId>` : 프로젝트에 의해 생성되는 `artifact` 고유아이디.
  - `<name>`: 프로젝트 이름
  - `<url>` : 프로젝트 사이트의 URL을 등록한다.
  - `<packaging>`: 해당프로젝트를 어떠하나 형태로 패키징할것인지를 결정. (*.jar, *.war, *.ear)
  - `<version>`: 프로젝트의 현재 버젼 `SNAPSHOT` 을 접미사로 사용한다.


- #### `<properties>` : Maven 내부에서 반복적으로 사용될 상수값을 정의할 때 사용한다.

- #### `<repositories>` : 의존성을 다운로드 받을 위치의 repository를 나타낸다.

- #### `<dependencies>` : 의존성 라이브러리 정보를 나타낸다.

- #### `<build>` : 빌드 정보를 나타낸다.

- #### `<pluginRepository>` : Maven 플러그인을 다운로드 받을 수 있는 저장소 위치를 나타낸다.

<br>

- #### Goal : Maven이 동작하도록 수행하는 명령이다.
  - Maven은 **`clean` > `compile` > `package` > `install` > `deploy`** 순으로 수행한다.
  - Goal의 종류
    - **clean** : 컴파일 결과물인 `target` 디렉토리 삭제
    - **compile** : 모든 소스코드 컴파일, 리소스 파일을 `target/class` 디렉토리에 복사한다.
    - **package** : `compile` 수행 후에 테스트를 수행한다. `<packaging>` 정보에 따라 패키징을 수행한다.
    - **install** : `package`를 수행한 후에 local repod에서 install을 수행한다.
    - **deploy** : `install` 수행 후에 배포를 수행한다.
      - 배포는 웹서버에 배포하지 않고 repository에 배포한다.
      - `<distributionManagement>` 태그가 기술되어야 한다.
