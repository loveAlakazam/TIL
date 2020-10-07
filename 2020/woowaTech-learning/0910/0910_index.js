import React from "react";
import ReactDOM from "react-dom";

import App from "./App";

const rootElement = document.getElementById("root");
const sessionList = [
  { id: 1, title: "1회차 오버뷰" },
  { id: 2, title: "2회차 리덕스 만들기" },
  { id: 3, title: "3회차 react만들기" },
  { id: 4, title: "4회차 컴포넌트 디자인 및 비동기" }
];

ReactDOM.render(
  <React.StrictMode>
    <App store={{ sessionList }} />
  </React.StrictMode>,
  rootElement
);
