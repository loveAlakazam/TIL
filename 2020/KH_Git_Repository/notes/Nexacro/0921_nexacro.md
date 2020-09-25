> # XCSS

## selector Explorer
- 어떤 요소가 있는지 트리구조로 나타냄

## component preview

- 추가한 컴포넌트를 보여줌.

- XCSS 파일 추가하기 방법
  - File > New > Nexacro style sheet(.xcss) > target 체크
  - Application_Desktop(프로젝트ID) 오른쪽 마우스 클릭 > Add > Style

- 어떤 컴포넌트를 대상으로 할지 추가
  - 방법1: `Selector Explorer에서 오른쪽마우스 클릭 > Add Selector 클릭`
  - 방법2: `+{}` 클릭

> # XJS 실습 - 날짜 차이 알아보기

## test_js.xfdl

- Source
```xml
<?xml version="1.0" encoding="utf-8"?>
<FDL version="2.1">
  <Form id="test_js" width="1280" height="720" titletext="New Form">
    <Layouts>
      <Layout height="720" width="1280">
        <Static id="Static00" taborder="0" text="시작날짜" left="56" top="38" width="131" height="85" onclick="Static00_onclick"/>
        <Static id="Static00_00" taborder="1" text="끝 날짜" left="56" top="165" width="131" height="85" onclick="Static00_onclick"/>
        <Button id="Button00" taborder="2" text="계산하기" left="46" top="325" width="141" height="70" onclick="Button00_onclick"/>
        <Static id="Static00_01" taborder="3" text="계산 날짜는                일입니다." left="200" top="330" width="350" height="60" onclick="Static00_onclick" background="transparent"/>
        <Calendar id="Calendar00" taborder="4" left="196" top="40" width="341" height="82"/>
        <Calendar id="Calendar00_00" taborder="5" left="196" top="165" width="341" height="82"/>
        <Edit id="Edit00" taborder="6" left="350" top="338" width="80" height="44" readonly="true"/>
      </Layout>
    </Layouts>
  </Form>
</FDL>
```


- Script
```js
// 외부 js파일인 CommonUtil.xjs을 불러온다.
include "Work::CommonUtil.xjs";

this.Button00_onclick = function(obj:nexacro.Button,e:nexacro.ClickEventInfo)
{
	var result= this.dayDiff(this.Calendar00, this.Calendar00_00);
	this.Edit00.set_value(result);
};
```

- (외부 xjs파일) CommonUtil.xjs

```js
//날짜 바꾸기 함수

this.dayDiff= function(start, end){
	var startDate= new Date();
	var endDate= new Date();
	var calDate;
	var day= (60*60*24) *1000; //하루를 ms단위로 나타냄.

	startDate.setFullYear(start.getYear());
	startDate.setMonth(start.getMonth()-1);
	startDate.setDate(start.getDay());

	endDate.setFullYear(end.getYear());
	endDate.setMonth(end.getMonth()-1);
	endDate.setDate(end.getDay());

	calDate= startDate.getTime()- endDate.getTime();
	return Math.abs(calDate/day);
}
```


> # Frame
- 그동안 한 방법: SDI(Single Document Interface)


- file > 프로젝트생성 > Desktop(Application ID: `App_MDI`) > 프레임구조: TopLeft
- frame base: form이 들어있는 곳
- `seperatesize= 100,*`: top-frame의 높이를 100으로 하고 나머지(`*`)는 알아서
- top-frame은 `formurl`로 `frameBase::Form_Top.xfdl`과 연결됨. => 얘는 폼이다.
  - `*.xadl`=> 얘는 어플리케이션과 연결되어있다.

<br><br>

## Form_Top

- 메뉴 넣기
- 전역데이터셋: Application Variable에 Dataset이 존재하고 전역데이터셋을 만들 수 있다.
