> # 자바스크립트 - Uncaught type Error


- ### (에러 발생 이유) 함수명과 id속성 명이 동일하기 때문에, 어디를 선택해야될지 몰라서이다.

- ### (해결방안) id를 지우거나, id를 함수명과 다르게 했다.

<br>

- [js 해결 참고 사이트 - Uncaught Type Error: Object is not a function (onclick)](https://stackoverflow.com/questions/15620620/js-uncaught-typeerror-object-is-not-a-function-onclick)

<br>

> ## 에러발생 상황

```
회원가입 페이지에서 메인화면으로 돌아가게하려고

"메인으로" 돌아가기 버튼의 onclick 속성에 goMain() 함수를 만들었고

goMain()에는 메인페이지로 이동하는 링크로 걸었다.

내가 배운바로는 servlet에서 메인페이지가

location.href="<%request.getContextPath()%>" 인걸로 알고 있고, 다른페이지에서는 적용이 됐는데


왜 이 페이지에서만 메인으로 돌아가지 않고

누르는 횟수만큼 Uncaught type Error이 뜬다.

```


- ### jsp 파일

```jsp

<input type="button" value="메인으로" id="goMain" onclick="goMain();">
```

<br>

- ### script 블록

```javascript
function goMain(){
  location.href="<%=request.getContextPath()%>";
}
```
