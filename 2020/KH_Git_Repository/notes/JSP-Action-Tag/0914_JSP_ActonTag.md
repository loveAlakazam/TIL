# JSTL

## JSP Action Tag

- JSP문법을 확장하는 매커니즘을 제공하는 태그
- 태그를 이용하여 반복문/IF문과 같은 로직 처리를 하는 태그문.

- `**액션태그 접두어**` : ㅇㅇㅇ형식으로 제공하는 태그의 그룹을 지정하는 것을 뜻한다.

> ## 표준 액션 태그

- 별도의 라이브러리를 필요하지 않음
- jsp페이지에서 있는 그대로 바로 쓸 수 있음.
- 태그앞에 jsp접두어가 붙어 있음.

- 사용예시

```jsp
<jsp:include page="./sample.jsp"/>
```

<br>

> ## 커스텀 액션태그

- 라이브러리를 가지고와서 바로 이용함. (예: `jQuery` : 라이브러리를 가져와야 사용가능.)
- 별도의 라이브러리 설치가 필요
- 라이브러리 선언에 맞는 접두어가 붙음

```jsp
<c:set var="count" value="0"/>
```

<hr>

# 표준 액션 태그

- `jsp:include` : 현재 페이지에 특정 페이지를 포함할 때 사용
- `jsp:forward`:
  - `requestDispatcher()`와 동일 페이지로 이동. 현재 페이지 접근 시 특정 페이지로 이동.

  - 전달하는 페이지에서 request, response 를 같이 전달한다.



- `jsp:param`:
  -  `<jsp:include>`, `<jsp:forward>`의 하위요소로 사용된다.
  - 페이지에서 페이지를 이동할 때 보내주는 값들을 담는다.
  - 해당 페이지에 전달할 값을 기록할 때 사용.

- `jsp:useBean`
  - vo와 같은 거다.
  - Bean은 객체이다.
  - 객체를 프레임워크단에서 사용하기 위해서 쓰인다..

- `jsp:setProperty`
  - `setter()` 와 같다.

- `jsp:getProperty`
  - `getter()` 와 같다.

- scriptlet뿐만아니라 표준액션태그에서 표현할 수 있다.
- JSTL은 Spring, MyBatis에서 사용된다.

<hr>

## `jsp:include`

- `<%@ include file="파일명" %>`과 쓰임이 동일하다
- `<%@ include%>` :  jsp파일이 java파일로 변환될 때 사용된다.
- `jsp:include`: jsp파일이 java파일로 바뀌고 컴파일 완료되고 난 후 실행을 할 때 삽입된다..
- 예

```jsp
<jsp:include page="파일명" flush="true"/>

<jsp:include page="./header.html">
  <%-- 넘겨야할 값이 존재할 때, str이름에서 "안녕하세요" 데이터를 전달--%>
  <jsp:param name="str" value="안녕하세요">
</jsp:include>
```


## `jsp:forward`

- 하나의 jsp페이지에서 다른 jsp페이지에서 요청처리를 전달할 때 사용.
- 전달하는 페이지에서 request, response 객체가 같이 전달.
- url이변경되지 않는다.

- 즉, url변경없이 페이지이동 요청처리를 수행한다.

```jsp
<jsp:forward page="파일명" />

<%--예시 : 사용자가 어떤걸 클릭했느냐에 따라 페이지가 바뀐다.--%>
<% if(str.equals("A")){ %>
  <jsp:forward page="./A_Class.jsp">
<%}else{%>
  <jsp:forward page="./B_Class.jsp">
<%}%>
```


## `jsp:useBean`

- java class를 참조하여 빈 객체를 생성
- setProperty(setter)/ getProperty(getter) => 값 저장 및 조회 가능
- 이미 같은 이름의 객체가 생성된 경우 기존 객체를 참조한다.

```jsp
<jsp:useBean id="객체이름" class="패키지명.클래스이름" scope="범위지정자"/>


<%-- 예시 id와 name은 객체에대한 이름, 클래스는 패키지명포함해서 사용, scope: --%>
<jsp:useBean id="m" class="member.model.vo.Member" scope="reqeust">
  <jsp:setProperty name="m" property="member_name" value="김유신"/>
  <jsp:setProperty name="m" property="member_age" value="79"/>
</jsp:useBean>
```

<hr>

## Standard Action Tags (표준 액션 태그) 만들기

- 서버 만들기
1. project explorer
2. 오른쪽마우스 클릭
3. new > Other > server
4. Server runtime environment Apache Tomcat v9.0 옆에 `Add` 클릭
- 서버이름: ELJSTLServer

- 웹프로젝트 만들기 (Dynamic Web Project)
- next클릭후, default output folder: `WebContent/WEB-INF/classes` 로 변경
- next클릭후, `Generate web.xml deployment descriptor` 체크박스 체크!


```jsp

<%-- jsp:useBean의 id(person1) = jsp:getProperty의 name(person1) 이 서로 동일. 같은 객체를 가리킴. --%>
<jsp:useBean id="person1" class="action.model.vo.Person" scope="request"/>

이름: <jsp:getProperty property="name" name="person1"/><br>
나이: <jsp:getProperty property="gender" name="person1"/><br>
성별: <jsp:getProperty property="age" name="person1"/><br>
```


- #### property는 해당객체의 필드를 의미하며, getProperty는 객체클래스의 해당 property에 명시된 getter()를 불러온다.

- 클래스의 *필드이름*은 *소문자*로 표기한다.
- 즉 getter()/setter()은 이름 규칙이 정해져있으며

```jsp
<jsp:useBean id="person1" class="action.model.vo.Person" scope="request"/>

<%-- getProperty(): getter --%>
<%-- property="nai" 는 Person클래스의 getNai()를 호출 --%>
나이: <jsp:getProperty property="nai" name="person1"/><br>
```


# EL (Expression Language)

- `<%= %>`, `out.print()`와 같이 JSP에 쓰이는 JAVA코드를 간결하게 사용하는 방법
- 화면에 포현하고자 하는 코드를 `${value}` 형식으로 표현하여 작성.

- 예시
```jsp
${value}


<%=request.getParameter("name") %>
${param.name}
```

## EL 연산자 기호

- (좌)연산자 => (우) EL표기
  - `/` => `div`
  - `%` => `mod`
  - `||` => `or`
  - `!` => `not`
  - `<` => `lt`(less than)
  - `<=` => `le`(less or equal)
  - `>` => `gt`(greater than)
  - `>=` => `ge`(greater or equal)
  - `==` => `eq`
  - `!=` => `ne`
  - `null` => `empty`

- page/ request / session / application Scope => scope영역에 해당하는 객체에 접근하다.

- param : 전달된 파라미터 값을 받아올 때 사용
- paramValues: 전달된 파라미터들을 배열로 받아올 때 사용
