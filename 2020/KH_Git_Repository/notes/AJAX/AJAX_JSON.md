# Ajax 이용하기

- ### jquery를 임포트 해야한다.
  - 파일을 직접 다운로드하여 넣는 방법
  - 아래와 같이 CDN방식으로 import할 수 있다.

```html
<head>
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
```

<br>
<hr>

- ### ajax구조

```javascript
$.ajax({
  url: '요청url', //요청한 url과 매핑된 서블릿을 호출
  data: {파라미터이름:값},
  success:function(response){
    //요청url로 통신이 성공했을 때 실행하는 함수
  }
})
```

- success영역의 response값
  - 서블릿에서 처리된 response객체이다.
  - 그렇다면 controller영역(서블릿)에서 view(jsp파일)로 데이터를 전달하려면 어떻게 해야할까?

> ## controller에서 view로 응답데이터 전달.

- 텍스트 데이터를 응답 데이터로 전달할 때

```java
// 데이터값: 문자열, 숫자 등 텍스트로 된 데이터.
response.getWriter().println(데이터값);
```

<br>
<hr>

# JSON

- object 객체를 주고받을 때 편리하다.

- map 체계를 갖추고있음.
  - map
    - 순서유지 x
    - key와 value가 한쌍으로 묶여있다.
    - key는 set방식 (중복저장x)
    - value는 list방식 (key만다르다면 value는 같아도 무관)

<br>
<hr>

- ## JSON 라이브러리를 이용하기
  - [json-simple-1.1.1.jar 파일 다운받는 곳](https://code.google.com/archive/p/json-simple/downloads)

  - 이클립스의 Dynamic Web Project에서 `WebContent/WEB-INF/lib` 디렉토리에 `json-simple-1.1.1.jar`파일을 저장해야 JSON을 이용하여 객체타입으로 저장이 가능하다.

<br>
<hr>

- ## json 을 이용한 객체 데이터를 응답데이터로 받기


  - `JSONObject` : JSON형태를 갖추어서 데이터타입이 객체(object)이다.

  - `jsonObj`가 JSONObject타입의 객체의 reference variable이라면

    - `jsonObj.put("속성이름", 속성값)`
      - "속성이름"에 해당하는 속성에 "속성값"을 넣는다.
      - 예를들어 personObj.put("name", 'Alakazam');
        - 사람객체의 속성 name에 대응되는값이 'Alakazam'이다.

  - `response.setContentType('application/json; charset=utf-8')`
    - 응답객체 response의 타입은 json객체이고, 인코딩방식은 utf-8이다.

  - `PrintWriter out= response.getWriter()`
    - 응답객체를 뷰로 보내는 객체이다
    - `out.println(JSON객체 데이터)` : JSON객체 데이터를 보낸다. view의 ajax의 success영역에서 데이터를 받는다.
