# 넥사크로 플랫폼 구성요소

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
- 이벤트 만들(오른쪽 프로퍼티창 번개:thunder: 모양 아이콘 클릭)

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
