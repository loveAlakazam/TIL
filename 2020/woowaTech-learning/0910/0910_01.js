import React from "react";

const SessionItem = ({ title }) => <li>{title}</li>;

class ClassApp extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      displayOrder: "ASC"
    };
  }

  //arrow는 문맥중심의 컨텍스트이다.
  // this는 클래스의 인스턴스객체
  // 문맥상 있는 그대로 고정. binding이 필요없다. => arrow의 장점

  //상태를 갖게된다. render()로 인해 클래스 컴포넌트가 상태를 가지게 됨
  //함수호출과정을 알고있고 제어하고 있기때문에
  //함수도 상태를 갖는다. => 리액트 훅
  render() {
    return (
      <div>
        여기여기
        <button onClick={this.onToggleDisplayOrder}>정렬</button>
      </div>
    );
  }
}

const App = (props) => {
  const [displayOrder, toggleDisplayOrder] = React.useState("ASC");

  const { sessionList } = props.store;
  const orderedSessionList = sessionList.map((session, i) => ({
    ...session,
    order: i
  }));

  const onToggleDisplayOrder = () => {
    toggleDisplayOrder(displayOrder === "ASC" ? "DESC" : "ASC");
  };

  return (
    <div>
      <header>
        <h1>react and typescript</h1>
      </header>

      <button onClick={onToggleDisplayOrder}>재정렬</button>

      <p>전체 세션개수: 4개 {displayOrder}</p>

      <ul>
        {sessionList.map((session) => (
          <SessionItem title={session.title} />
        ))}
      </ul>
    </div>
  );
};

export default App;
