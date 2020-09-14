/*@jsx createElement*/
import React from "react";

const list = [
  { title: "react에 대해 알아봅시다~" },

  { title: "Redux 대해 알아봅시다~" },

  { title: "Typescript에 대해 알아봅시다~" }
];

/*
웹앱, 웹어플리케이션
어떠한 데이터를 어떠한 모양으로 어디에 꽂아넣는다.
html, css가 다 해준다.

데이터와 ui가 많아지면 어떨때 ui를 보여준다. => routing(라우팅)
보통은 코드는 서버에 있다보니
api호출을 통해서 비동기적으로 땡겨온다.
필요한 적재적소를 땡겨오고
api는 예외가 발생한다.(에러와 같은 여러가지 상황)

예외사항에 대응하는 코드가 많다.

코드는 끊임없이 변한다.
생각이 빨리 나오는 구조. 
빨리 고칠 수 있는 코드 구조 는 무엇인가?

어떤 것이 좋은 아키텍쳐인가?

대원칙은 어떻게 지킬것인가?
어떻게 같은것이고 어떻게 다른것인가? => 지식의 수준에 따라서 다르다.


같은것과 다른것의 분리하는 
이름만 잘지어도 좋은 코드가 될 수있는 70%~80% 성공를 했다고 보면된다.
나머지 20%~30%


dom 요소 
real dom
=> 안정성이 많이 떨어진다.
=> real dom api가 너무 low level의 api이다.
=> 필연적으로 복잡도가 올라간다. => 수정하는데 용이하지 않다.


dom tree 
=> 다루기 어려운 문자열(html 태그코드)를 쉽게 다룰 수있다.
=> 다루기 쉬운구조로 해준다.

dom -tree도 실제로는 low-level이다.


virtual dom => 자바스크립트로 다뤄서 쉬운구조로 한다.
=> 나머지는 알아서 real-dom에서 다룸
쉬운상태로 일관성있는 구조로 만들어준다.


=> react 는  real-dom을 v-dom형태로 만들어준다.

=> v-dom(virtual dom)을 만들어보자.


real-dom === v-dom === js
v
v-dom == js : 쉬운 구조로 한다.
=> 마크업하듯이 편하게 코딩할 수있는 jsx가 있음.


개발자는 편한거 좋아한다~


*/

/*
const rootElement = document.getElementById("root");
function app(items) {
  rootElement.innerHTML = `<ul>
    ${items.map((item) => `<li>${item.title}</li>`).join("")}
  </ul>`;
}

app(list);

*/

let age = 10; //의미를 부여받는다.

/*태그컴포넌트들 => 목록을  */

// import ReactDOM from "react-dom";

// react는 virtual-dom이 한개밖에 없다.
// virtual-dom은 간단하다.
/*
const vdom = {
  type: "ul",
  props: {},
  children: [
    { type: "li", props: { className: "item" }, children: "React" },
    { type: "li", props: { className: "item" }, children: "typescript" },
    { type: "li", props: { className: "item" }, children: "redux" },
    { type: "li", props: { className: "item" }, children: "mobx" }
  ]
};
*/

//v-dom을 받는다.
function renderElement(node) {
  if (typeof node === "string") {
    return document.createElement(node);
  }

  //재귀일 수 밖에없다. - 디버그 걸어보고 한줄씩 뜯어보기.
  const el = document.createElement(node.type);
  node.children.map(renderElement).forEach((element) => {
    el.appendChild(element);
  });

  return el; //node(element)를 만든다.
}

function Row(props) {
  return <li>{props.label}</li>;
}

// render => 화면에 뿌려준다.
function render(vdom, container) {
  //vdom을 real-dom으로 바꾼다.
  //let vdom;
  // vdom vs newVdom 인지 검사하여 비교로직이 들어간다.
  container.appendChild(renderElement(vdom));
}

// babel이 transfiling 태그처럼 생긴애들을 함수호출로 바꾼다.
// 태그는 타입과 속성객체를 넣고, 하위요소들은 children구성요소로 바꾼다.

function createElement(type, props = {}, ...children) {
  if (typeof type === "function") {
    // apply() => children과 같은 배열을 받아온다.
    return type.apply(null, [props, ...children]);
  }
  return { type, props, children };
}

function StudyList(props) {
  // React.createElement()를 virtual-dom을 만든다.
  React.createElement("ul", {});
  return (
    <ul>
      <Row label="하하하 음메" />
      <li class="item">React</li>
      <li class="item">Typescript</li>
      <li class="item">mobx</li>
      <li class="item">redux</li>
    </ul>
  );
}

function App() {
  const vdom = createElement("ul", {}, createElement("li", {}, "React"));
  console.log(vdom);
  return (
    //jsx 문법: babel
    /*
      babel=> create element()함수를 통해서 virtual-dom을 만든다.
      virtual-dom을 통해 real-dom을 만든다.

      쉽게 컴포넌트를 기술할 수 있게 jsx문법을 만든다.


      자바스크립트는 객체가 다루기 쉽다.

      dom은 까다로운 문자열을 객체로 바꿀수있다.

     */
    <div>
      <h1>Hello?</h1>

      {/* 마크업이 가능하다. => 고치기가 쉽다. 
        전역을 먹으면 안되요.. 전역을 먹으면 살쪄요 ... 싫어요 전역!

      */}
      <StudyList item="abcd" id="hoho" />
    </div>
  );
}

console.log(<App />, document.getElementById("root"));

const ul = document.createElement("ul");
document.body.appendChild(ul);
// real-dom에 converting함. : virtual-dom을 따라다니면서 converting
// ReactDOM.render(<App />, document.getElementById("root"));
