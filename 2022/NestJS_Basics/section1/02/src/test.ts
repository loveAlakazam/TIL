import { response } from 'express';
import { resolve } from 'path';

type SomeFunctionReturnString = () => string;

function delay(f: SomeFunctionReturnString, seconds: number): Promise<string> {
  // 해당 함수 내부를 구현해 주세요
  return new Promise((resolve, reject) => {
    // 2초를 대기한다.
    setTimeout(() => {
      try {
        // 2초 후, 해당함수의 콜백함수 f를 불러와 정상동작하는지 체킹한다.
        resolve(f());

        console.log(`after ${seconds} seconds`);
      } catch (error) {
        // 에러가 있으면, 해당 에러를 매개변수가 e로 전달하여 콜백함수를 불러온다.
        reject(error);
      }
    }, seconds * 1000);
  });
}

const success = () => {
  return 'successfully done';
};

const fail = () => {
  throw new Error('failed');
};

delay(success, 2)
  .then((res) => console.log(res))
  .catch((e) => console.log(e));

delay(fail, 2)
  .then((res) => console.log(res))
  .catch((e) => console.log(e));
