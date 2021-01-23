# 내장 객체

> ## JSP 내장 객체

JSP 페이지에서 객체를 생성하는 과정 없이 바로 사용할 수 있는 객체

JSP가 서블릿 파일로 변환될 때, 서블릿 컨테이너가 자동으로 생성을 해준다.

<br>

> ## 내장객체 종류

|내장객체 종류|내장객체|
|:--:|:--:|
|입/출력 내장객체|request|
||response|
||out|
|서블릿 관련 내장객체|page|
||config|
|외부환경 정보 제공 내장객체|session|
||application|
||pageContext|
|예외관련 객체|exception|


<br>

> ## out 내장 객체 - 출력 내장 객체

- 서버에서 클라이언트로 열려있는 출력 스트림
- 서블릿 요청을 수행한 결과를 클라이언트로 출력하기 위해 사용되는 객체

```java
PrintWriter out = response.Writer();
```

<br>

> ## request 내장 객체 - 클라이언트 요청 정보를 갖는 내장객체

- ### 1. 클라이언트 요청과 관련된 정보를 저장한 내장 객체
  - 클라이언트에서 서버로 전송되는 데이터를 알 수 있다.

|메소드 명|반환 타입|리턴 대상 설명|
|:--:|:--:|:--:|
|**getRemoteAddr()**|String| 웹서버에 연결한 클라이언트의 IP주소|
|**getContentLength()**|long| 클라이언트가 전송한 요청정보의 길이|
|**getCharacterEncoding()**|String| 클라이언트가 요청정보를 전송할 때 사용한 CharacterSet(인코딩 형식)|
|**getContentType()**|String|클라이언트가 요청정보를 전송할 때 사용한 content 타입|
|**getProtocol()**|String| 클라이언트가 요청한 프로토콜 정보|
|**getMethod()**|String| 데이터 전송 방식|
|**getRequestURL()**|String| 요청 URL|
|**getContextPath()**|String| JSP페이지가 속한 웹어플리케이션의 contextPath(루트)|
|**getServerName()**|String| 연결할 때 사용한 서버이름|
|**getServerPort()**|int| 서버의 포트번호를 구함|

<br>

- ### 2. 요청 파라미터 관련 메소드

|메소드 명|반환 타입| 리턴 대상 설명|
|:--:|:--:|:--:|
|**getParameter(String name)**|String|`name`에 해당하는 파라미터가 있을 경우 첫번째 파라미터값을 리턴 |
|**getParameterValues(String name)**|String[]|`name`에 해당하는 파라미터가 있을 경우, 모든 파라미터의 값들을 구하여 배열형식으로 리턴|
|**getParameterNames()**|Enumeration|모든 파라미터의 이름을 구함|
|**getParameterMap()**|Map|전송한 파라미터를 Map(Key & Value) 형식으로 구함|

<br>

> ## response 내장 객체 - 클라이언트 요청에 대한 응답을 처리

- 실행결과를 브라우저(클라이언트)로 리턴할 때 사용.
- 응답결과 페이지를 브라우저에 나타낼 때 사용.

- ### 페이지 이동 메소드

|메소드 명|설명|
|:--:|:--:|
|response.sendRedirect()|request, response 객체가 유지되지 않는다.<br>브라우저의 URL을 변경하여 페이지를 이동|
|response.getDispatcher(반환페이지경로).forward(request, response)|forwarding: 브라우저의 URL을 유지하면서 문서의 내용(페이지)만 이동하는 방식<br>request,response객체가 그대로 유지|
