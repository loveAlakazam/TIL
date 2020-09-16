# JSTL

- JSP Standard Tag Library
- JSP에서 사용하는 커스텀 태그
- 공통으로 사용하는 코드의 집합을 사용하기 쉽게 태그화하여 표준으로 제공한 것.
- 라이브러리를 선언해야 사용 할 수 있다.

```jsp
<%--
  라이브럴리 url에 명시된 core를 사용한다. => (prefix)얘의 별칭을 c라고 할것이다.
--%>

<%@taglib uri="https://java.sun.com/jsp/jstl/core" prefix="c" %>

<%--   prefix c = c로 사용. --%>
<c:out value="${'welcome to javaTpoint'}" />
```


- jstl 라이브러리 등록
  - [https://www.javapoint.com/jsppages/src/jstl-1.2.jar](https://www.javapoint.com/jsppages/src/jstl-1.2.jar)

- Core Tags: 변수와 url, 조건문, 반복문등 로직과 관련된 JSTL문법 제공

- Formatting Tags:
  - 메시지 형식이나 숫자, 날짜 형식과 관련된 포맷 방식을 제공한다.
  - 출력하고자하는 모든것들을 처리한다.

- Function Tags:
  - 문자열과 관련된 모든것들을 처리한다.
  - 문자열 처리 함수를 제공한다.

- XML tags
  - 데이터의 XML 파싱 처리등 XML문서를 화면으로 읽어오는 데 필요한 라이브러리

- SQL tags
  - 페이지 내에서 데이터베이스를 연동하여 필요한 쿼리를 실행할 수 있는 라이브러리



# apache tomcat에서 jar파일 다운로드

[http://tomcat.apache.org/download-taglibs.cgi](http://tomcat.apache.org/download-taglibs.cgi)

- jar파일 4개 모두 다운로드 후

- WEB-INF의 lib폴더에 4개의 jar파일을 넣는다.
