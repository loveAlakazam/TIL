var x= 10;
let y=10;
const z=10;

let x={
    a: 'a'
}

function foo(){

}

let y=foo;

new foo()


const bar =x=> x*2; //x를 받아서 x*2를 bar에 넣을래. 


function foo(x){
    // return bar(){}
    return function bar(){
        return x;
    }
}

const f =foo(10);

f();

