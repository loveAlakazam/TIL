import React, { useState } from "react";
import ReactDOM from "react-dom";

//Hello => 객체
// 객체가 소멸/파괴 되기 전까지는 객체의 속성을 유지할 수있다.
// 값을 바꿀수있다. render을통해서 상태값을 바꿀 수 있고
// 자체 상태를 갖도록 한다.

// 자체 상태를 갖는다. =>  클래스형 객체/컴포넌트
// 내부적으로 업데이트
// React에서  필요한 부분만 호출
// 라이프 사이클 메소드가 존재한다.
// 라이프 사이클 메소드를 만들면

//외부로부터 데이터를 받기만 한다 => 함수형 컴포넌트
// 함수형 컴포넌트는 호출밖에 없다. => 라이프 사이클이 없다.

//constructor 로 객체를 생성
// react component는 ui구성요소를 갖지 않는다.
// 여러가지 컴포넌트들에 대한 차이는 공식문서에 잘 정의되어있다 ^^
class Hello extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      count: 1
    };
  }

  //바깥쪽에서 리액트가 부르는 함수.
  //바깥쪽에서 부르거나, 상태를 불러올때
  render() {
    return <p>안녕하세요</p>;
  }

  componentDidMount() {
    this.state.count = 100; //랜더 호출 안됨 => 리엑트가 알지 못한다.

    //proxy => 객체안의 상태를 읽거나 업데이트
    //=> set state가 필요없다.
    this.setState({ count: this.state.count + 1 });
  }
}

// constructor 을 받아온다.
const hello = new Hello();
vdom = hello.render();
if (hello.hasOwnProperty("componentDidMount")) {
  hello.componentDidMount(); //deligator(델리게이터)
}

//App()은 함수
//=> 함수의 scope에 지역변수들이 만들어짐
//=> 함수형 컴포넌트는 상태를 변경할 수 없다.
//=> 왜냐면 호출할때마다 계속 변경해야함.

function App() {
  //배열형태 - 두번째 호출부터 초기값 넣는것을 무시한다.
  // react-hook 을 이용.
  // 컴포넌트를 key로하고 그 키값에 따라서 한다.(인덱스를 쭉쭉쭊 뽑아서함.)
  // 컴포넌트가 랜더링한 순서대로 인덱싱함.=> 순서대로안하면 엉뚱한 순서, 엉뚱한 데이터가 생김.
  // 일반함수에서 호출하면 될수없다.

  //리액트 훅(react-hook)은 리액트 컴포넌트 내에서만 호출한다.

  // 최상위에서만 Hook을 호출해야만한다.
  // 바벨이 무슨 메소드를 호출하는지를..
  // 그 메소드 내에서 무슨일 이 일어나는지 알고있어야지 이해할 수 있음.
  // hook의 메커니즘 이해하려면...
  const [counter, setCounter] = useState(1);

  //값을 담아서 값을 변하도록...=> 변수의 본질=> 상태
  let x = 10;

  //root요소가 필요하다.
  return (
    <div>
      <h1 onClick={() => setCounter(counter + 1)}>상태{counter}</h1>
      <Hello />
    </div>
  );
}

ReactDOM.render(<App />, document.getElementById("root"));
