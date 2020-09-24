# 넥사크로 플랫폼 구성요소

- 넥사크로는 ui/ux와 관련된, 화면을 만들기 위한 플랫폼
- 만들어진 화면은 js로 변환되어 js코드로 바뀔수있다. 이를 제너레이터(generator)이라 한다.

- 넥사크로
  - 프로젝트를 만든다
  - 서비스를 만든다.
  - 서비스안에 폼을 집어넣는다.
  - 원하는 위치에 컴포넌트들을 넣는다.
  - 데이터를 집어넣거나/ 이벤트를 넣는다.
  - 이벤트를 넣는방법
    - 컴포넌트 더블클릭
    - Property의 이벤트태그를 클릭하여 각 이벤트에 따라 함수를 설정
    - Container역할하는 component => `div`
      - div는 다른 컴포넌트와 다르게 다른 컴포넌트를 넣을 수 있다.

- 자바스크립트 기반의 코드로 변환되어 실제 실행 환경에서는 변환된 자바스크립트 코드로 실행

- unified javascript framework 기반의 OSMU(One source multi use)

- 위지웍(WYSIWYG)

- 자바스크립트 기반의 코드로 변환되어 실제 실행환경에서는 변환된 자바스크립트 코드를 실행한다.

- Environment: 실행환경 정보를 가지고 있는 파일

- TypeDefinition: 물리적인 파일, 오브젝트, 경로

- Application Information
  - 공통으로 사용하는 데이터를 저장하는 공간

- Application Desktop

- 기본 서비스 그룹: `Base`
- 서비스 그룹 추가하기
  - ### `TypeDefinition > Services> 마우스 우클릭 Edit/ Services 더블클릭`
  - `Services` 더블클릭 ==> + 클릭 ==> form 클릭 ==> Work로 이름변경
  - 서비스그룹 안에 폼 만들기
    - Work 서비스 그룹 클릭 => 상단메뉴 File => new => form 클릭

<HR>

# A_Test
- `Work` 서비스 그룹에 `A_Test.xfdl` form 생성 됨.

- Static => 요소를 만들면서 자동적으로 id를 생성
- Action
  - text: 안에 있는 내용

- `Generate Application`: `Generate`: 자바스크립트 코드로 변환한다.
- Generate상단메뉴 => Quick View => Run
- 화면에 보이려면 Generate를 거쳐야 한다.

- Tools > Project > Generate > Generate path 에서
  - path: `C:\Users\USER\Documents\nexacro\17.1\outputs\testNexacro17`
  - Work 서비스단에 저장된 자바스크립트 코드로 변환된 폼을 조회할 수 있다.

- 넥사크로 실행 단축키
  - 퀵뷰(돋보기 번개) 아이콘
  - Ctrl + F6

- A_Test.xfdl.js

```javascript
(function()
{
    return function()
    {
        if (!this._is_form)
            return;

        var obj = null;

        this.on_create = function()
        {
            this.set_name("A_Test");
            this.set_titletext("New Form");
            if (Form == this.constructor)
            {
                this._setFormPosition(1280,720);
            }

            // Object(Dataset, ExcelExportObject) Initialize


            // UI Components Initialize
            obj = new Static("Static00","110","210","120","60",null,null,null,null,null,null,this);
            obj.set_taborder("0");
            obj.set_text("내용입니다.");
            this.addChild(obj.name, obj);

            // Layout Functions
            //-- Default Layout : this
            obj = new Layout("default","",1280,720,this,function(p){});
            obj.set_mobileorientation("landscape");
            this.addLayout(obj.name, obj);

            // BindItem Information

        };

        this.loadPreloadList = function()
        {

        };

        // User Script
        this.registerScript("A_Test.xfdl", function() {

        this.Static01_onclick = function(obj,e)
        {

        };

        });

        // Regist UI Components Event
        this.on_initEvent = function()
        {

        };

        this.loadIncludeScript("A_Test.xfdl");
        this.loadPreloadList();

        // Remove Reference
        obj = null;
    };
}
)();

```

<br>

# 버튼 만들기

- 메뉴 손(:hand:) 옆에 있는 회색버튼
- 이벤트 만들(오른쪽 프로퍼티창 번개 :zap:  모양 아이콘 클릭)

```javascript
// 버튼을 더블클릭 => 스크립트영역으로 이동.
//onclick: 버튼클릭 함수 이름.
//Button00_onclick이벤트가 걸려있다.
this.Button00_onclick = function(obj:nexacro.Button,e:nexacro.ClickEventInfo)
{

};
```

- B_Static.xfdl
  - 버튼의 프로퍼티중 onclick에서 `myEvent`로 변경한다.
  - 폼(this)내의 `myEvent` 변수에 저장된 함수를 호출하여 버튼이 클릭하면 해당함수(myEvent변수에 저장된 익명함수)를 실행되도록한다.

```js


this.Button00_onclick = function(obj:nexacro.Button,e:nexacro.ClickEventInfo)
{
	//버튼 클릭할때 발생하는 이벤트내용.

	//this: 현재 작업중인 form을 의미한다.
	//Button00_onclick: 함수 이름
	// Button00: 클릭한 버튼의 id (변경가능)

	// function: 클릭 시 작동되는 콜백함수
	// obj     : 클릭한 버튼 객체
	// e       : 이벤트 정보를 가진 객체

	//콘솔 출력문
	//java      : System.out.println();
	//vanilla js: console.log();
	nexacro.getApplication().trace(obj);
	nexacro.getApplication().trace(e);

	//출력결과:
	// nexacro (33376)> UD 2:13:43:405  [object Button]
	// nexacro (33376)> UD 2:13:43:414  [object ClickEventInfo]

	//scope: 현재폼
	this.alert('클릭하였습니다.'); // this=> 현재폼에서만 사용

	// nexacro.getApplication() => 어플리케이션 전체에서 사용.
	nexacro.getApplication().trace('버튼 onclick 이벤트 동작');
};


this.myEvent= function(){
	alert("나의 이벤트 동작");

	//myEvent 동작 Output클릭
	nexacro.getApplication().trace('마이 이벤트 동작');
}
```

```
[콘솔 출력 결과 메세지]

nexacro (24328)> UD 2:19:47:749  마이 이벤트 동작
nexacro (24328)> UD 2:20:0:667   마이 이벤트 동작

```

<br>

# 입력창(edit) 만들기 / 입력창의 입력내용 가져오기 & 변경하기

- `edit` : 왼쪽에서 다섯번째 컴포넌트
  - `<input type="text">`와 같다.
  - `value` : 입력창에서 사용자로부터 입력한 값을 나타낸다.

- [실습] 입력창에 입력한 값을 alert()로 띄우기  
  - 버튼에 연결된 함수를 `editFunc()`로 한다.

```js
//사용자 정의 함수2
this.editFunc=function(){
	// id가 Edit00인 (텍스트 입력창) value값을 가져와서
	// 변수 str에 저장한다.
	// id가 Edit00인 입력창에 값을 입력할때마다 alert까 띄움.
	var str= this.Edit00.value;
	alert(str);
}
```


- 추가: id가 `Edit00`인 텍스트 입력창에 입력된 값을 변경해보기.

```js
//사용자 정의 함수2
this.editFunc=function(){
	// id가 Edit00인 (텍스트 입력창) value값을 가져와서
	// 변수 str에 저장한다.
	// id가 Edit00인 입력창에 값을 입력할때마다 alert까 띄움.
	var str= this.Edit00.value;
	alert(str);

  this.Edit100.set_value('넥사크로 별거아니네~');
}
```

<br>

# C_Div.xfdl - `div` 영역 만들기

- 왼쪽에서 9번째 컴포넌트를 가져온다.
- java.swing 의 JPanel과 같은 역할이다.
  - JPanel: 패널 안에있는 패널과 컴포넌트를 넣을 수 있다.
  - 컴포넌트를 div에 넣으면 알아서 넣어진다.

```xml
<?xml version="1.0" encoding="utf-8"?>
<FDL version="2.1">
  <Form id="C_Div" width="1280" height="720" titletext="New Form">
    <Layouts>
      <Layout height="720" mobileorientation="landscape" width="1280">

        <Div id="Div00" taborder="0" text="Div00" left="8" top="3" width="222" height="215" color="aqua" border="3px solid black" background="aqua">
          <Layouts>
            <Layout>
              <!-- div내부에 있는 컴포넌트-->
              <!--static -->
              <Static id="Static00" taborder="0" text="Static00" left="1" top="5" width="212" height="33" onclick="Div00_Static00_onclick"/>

              <!-- button(div안에 있는 버튼) -->
              <Button id="Button00" taborder="1" text="Button00" left="11" top="46" width="192" height="48"/>

              <!-- edit -->
              <Edit id="Edit00" taborder="2" left="9" top="107" width="195" height="38"/>
            </Layout>
          </Layouts>
        </Div>

        <!-- div밖 버튼-->
        <Button id="Button00" taborder="1" text="div밖 버튼" left="267" top="62" width="70" height="36"/>
      </Layout>
    </Layouts>
  </Form>
</FDL>

```

<hr>

# D_Edit.xfdl

- edit(`<input type="text">`)
  - 속성
    - `maxLength`: 입력을 허용하는 최대길이
      - 기본값: 0
      - 값설정: 설정한 길이가 입력할 수 있는 최대길이가 된다.

    - `autoskip`: 바로 다음 입력창으로 커서가 이동.
      - 기본값: false
      - true로 변경하면 => maxLength길이만큼 입력 후에는 바로 아래의 입력창으로 커서가 이동된다.

    - `taborder`: 탭키를 눌렀을 때 이동되는 순서
      - taborder 숫자가 클수록, 이동되는 순서가 가장나중이되고, 반대로 숫자가 작을 수록 먼저 입력할 수 있게끔 커서가 깜빡인다.

      - 즉, taborder가 0일때 가장 먼저 사용자로부터  입력을 받는다.

    - `displaynulltext`: html의 input태그의 속성인 `placeholder` (ex. 입력예시문구)와 같다.

    - `readonly` :입력 못하게끔 함.
    - `password`: 입력형태가 비밀번호 형식으로 바뀜.
      - `<input type="password">`

<hr>

# E_MaskEdit.xfdl

- 맨 왼쪽에서 `edit` 바로 오른쪽 컴포넌트(`maskEdit`)
- mask: filter가 있다.
  - 값을 입력받을 때 규격을 정한다.
  - javascript에서의 정규표현식과 같다.
  - 해당 `maskEdit` 의 `Properties에서` `format`과 `type`을 설정해줘야한다.

  - **문자열 maskEdit 1**

    - format을 "@@@@@@@@@"을 했고 해당 maskedit에 문자열을 입력해봤는데 문자열(영어/ 한글/ 특수문자) 입력이 안됨
    - 숫자입력은 가능함.
    - `Action`의 `type`을 `number`로 했다.

  - **문자열 maskEdit 2**
    - format을 "\*\*\*\*\*\*\*\*\*\"로(길이) 했다.
    - `type`을 `string`으로 한다.
    - 알파벳만 입력이 가능하다.

  - **문자열 maskEdit 3**
    - format을 "999999999"로 했다.
    - `type`을 `string`으로 했다.


  - **숫자 maskEdit**
    - format에 "#######"을하고
    - `type`을 `number`로 한다.

    - `type`이 `string`인 상태에서 `format`은 `######`일때 결과는 숫자만 입력이 가능하게 되어있다.

    - 특정 형태의 숫자 입력 폼만들기
      - 예) `15000`=> `15,000`
      - fomat을 `#,###`으로하면
        - 각 자리수마다 `,`가 알아서 찍힌다.

    - 핸드폰 번호 형식으로 입력폼 폼만들기
      - 예) `01012345678`=> `010-1234-5678`
      - format을 `###-####-####` 으로 한다.
      - type을 `string`으로 한다.

<br>

# 넥사크로 다시 열기

- 프로젝트 저장소 > nexacro17 > `testNexacro17.xprj` 파일을 선택

<br>

# F_CheckBox_Radio.xfdl

- `CheckBox`를 선택 (div의 오른쪽에서 3번째)
- 체크하고 싶다면 해당 CheckBox의 Property에서 `value`를 `true`로 한다.

- `Radio`를 선택 (div의 오른쪽에서 2번째)
  - 처음에 RadioBox버튼이 보이지 않는다.
  - 그 이유는 Property의 `Binding의 innerdataset`이 무엇인지를 설정하지 않았기 때문이다..
    - 종류만 따로 만든다.
    - 컬럼/ datacolumn(radio버튼에 표현될 라벨값)
