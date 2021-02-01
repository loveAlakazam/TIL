# React.js 를 배워보자

> ## WebPack 은 무엇일까?
> ## React Hook은 뭐지?
> ## GraphQL은 무엇일까?
> ## Apollo를 알아보자

> ## Django와 연결을 한다면?
> ## Spring Boot와 연결을 한다면?

<hr>

> # How to starting ReactJS right now?

- The first of all, Install `npm`, `nodeJS`, `yarn`


- Install `npm` in Mac OS
  - [reference: Mac 에서 Homebrew를 통해 Node, Npm, Yarn 설치하기 -코딩도비](https://butter-ring.tistory.com/17)

- node 설치

```shell
brew install node
```

<br>

- `yarn` 설치

```shell
brew install yarn --ignore-dependencies
```

<br>

- 설치 확인

```shell
node -v
npm -v
yarn -v
```

<br>

- hombrew 최신버젼 업데이트

```shell
brew update
```

<br>

- node, yarn 업그레이드

```shell
brew upgrade node brew upgrade yarn
```

<br>

- 현재 터미널 계정을 관리자 권한 부여하기
  - [참고자료 - 맥북OS 터미널 관리자 권한 부여하기 ](https://h-glacier.tistory.com/entry/Mac-%EB%A7%A5%EB%B6%81-Mac-OS-X-%ED%84%B0%EB%AF%B8%EB%84%90-%EA%B4%80%EB%A6%AC%EC%9E%90-%EA%B6%8C%ED%95%9C-Root-Permission-%EB%B6%80%EC%97%AC%ED%95%98%EA%B8%B0-%ED%8C%8C%EC%9D%B4%EC%8D%AC-pip-%EC%97%85%EB%8D%B0%EC%9D%B4%ED%8A%B8)

```shell
dsenableroot
```

<br>

현재 터미널 계정 - 사용 OS 유저계정 비밀번호 입력

<br>

```shell
# 관리자권한을 부여받은 관리자 계정으로 접속
su -
```

<br>

- npx설치 (관리자권한 필요.)

```shell
npm install npx -g
```


<hr>

> # 노마드코더 - ReactJS로 웹 영화 서비스 만들기

<br>

- creating your first ReacApp (관리자 권한 해제.)

```shell
npx create-react-app 프로젝트이름
```
- [참고자료 - react 프로젝트 생성 에러 해결법](https://dydrlaks.medium.com/npm-err-cb-apply-is-not-a-function-checkpermissions-file-exists-e93f4bedd89c)

<br>


- Running React Project

```shell
npx start
```
