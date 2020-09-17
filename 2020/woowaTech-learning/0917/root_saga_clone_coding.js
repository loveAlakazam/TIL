//rootsaga = middleware
//* : generator: 호출자와 핑퐁하는 것. yield에 들어갔다가 나갔다가.
function* rootSaga() {
  const resp = yield { action: 'api/users' };
  console.log(resp);
}
//done: 실행했는지 알려주는 역할=> done:true => 다음이 없다. 끝

const root = rootSaga();
console.log(root.next());

console.log(root.next('abcd'));

console.log(root.next(1000));

console.log(root.next());

console.log(root.next());
