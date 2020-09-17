# G_ComboBox.xfdl

- HTML의 `<select>` 와 `<option>`같다.
- `Binding`의 `Innerdataset`을 이용하여 콤보박스 내용을 넣는다.


# H_ImageViewer.xfdl

- 이미지 넣기
- 이미지뷰어: 달력모양 아이콘의 오른쪽에 있음.
- `Property`의 `Appearance`에 `image`에 사진을 넣는다.
- `Appearance`의 `stretch`를 `fit`으로하면 사진의 크기가 이미지뷰어에 딱맞게 조정된다.

- `fixaspectRatio`: 사진의 비율을 유지한채로 이미지뷰어에 최대한 맞게 조정하고 싶을 때 사용.

- Project Explorer > Resource Explorer > Image Resource 우클릭 > Import Image Resource

- 버튼을 클릭하면 해당 버튼에 대한 이미지 뷰어에 이미지를 불러오기(이벤트 코드 작성)

```js

this.Button00_onclick = function(obj:nexacro.Button,e:nexacro.ClickEventInfo)
{
//hellfire
//현재 폼에서 id가 ImageViewer01인 이미지뷰어 컴포넌트에서
//이미지를 넣는다(set_image)
//imager::(ImageResource안에 있는 이미지파일)
this.ImageViewer01.set_image("imagerc::helfire.JPG");
};

this.Button01_onclick = function(obj:nexacro.Button,e:nexacro.ClickEventInfo)
{
//andromedik
this.ImageViewer01.set_image("imagerc::hawling.JPG");

};

```

- 이벤트 코드 작성 후 버튼의 이벤트(번개모양 :zap:) Property에서 `onclick`부분에서 함수를 위에서 정의한 함수명으로 변경한다.(만일 연결함수가 사용자 정의함수일때는 해야됨.)


- 코드 수정2

```js

this.Button00_onclick = function(obj:nexacro.Button,e:nexacro.ClickEventInfo)
{
//hellfire
//현재 폼에서 id가 ImageViewer01인 이미지뷰어 컴포넌트에서
//이미지를 넣는다(set_image)
//imager::(ImageResource안에 있는 이미지파일)
this.ImageViewer01.set_image("imagerc::helfire.JPG");
this.ImageViewer01.set_stretch("fit");
};

this.Button01_onclick = function(obj:nexacro.Button,e:nexacro.ClickEventInfo)
{
//andromedik
this.ImageViewer01.set_image("imagerc::hawling.JPG");
this.ImageViewer01.set_stretch("fixaspectratio");
};

```

<br>

# I_Calendar.xfdl

# J_Dataset.xfdl

- 데이터를 관리/ 저장
- 원기둥모양(맨오른쪽에서 두번째)
- 화면에 보이지 않다
- 하얀색 화면안에 있다(invisible object에 있다.)
- Invisible Object에 있는 Dataset을 두번클릭
- Rows 입력한 데이터를 집어넣는다. (인스턴스를 저장.)

- 데이터셋에 직접 데이터 넣기
- form레벨이다.
- Application 레벨에서 dataset을 불러오기
  - `Project Explorer` > `Application Variables` > `Datasets`
  - `+`버튼 클릭
  - 처음에 불러온 데이터셋의 컬럼과 컬럼타입을 맞춘다.

- 다시 폼(J_Dataset)에서 데이터셋을 표현할 수 있는 컴포넌트는 `Grid`이다.

- Invisible Object안에 있는 데이터셋을 그리드에 드래그해서 넣는다.
  - 그러면 보이지않던 데이터를 볼 수 있다.

- Grid더블클릭 => 그리드의 크기에 대해서 수정할 수 있다.

```xml
<ColumnInfo>
  <Column id="name" type="STRING" size="256"/>
  <Column id="age" type="INT" size="256"/>
</ColumnInfo>
<Rows>
  <Row>
    <Col id="name">강건강</Col>
    <Col id="age">22</Col>
  </Row>
  <Row>
    <Col id="name">남나무</Col>
    <Col id="age">21</Col>
  </Row>
  <Row>
    <Col id="name">도대담</Col>
    <Col id="age">44</Col>
  </Row>
  <Row>
    <Col id="name">류승호</Col>
    <Col id="age">35</Col>
  </Row>
</Rows>
```

- scope(범위)에 따른 데이터셋의 접근범위
  - 전역레벨/ 전체 application 모든 곳
    - 전역레벨 컴포넌트는 어디에있는가?
    - Application Variables에 있다.
  - form : 현재 있는 곳(폼)

  - innerdataset: radio, CheckBox
    - 해당 컴포넌트에서만 접근이 가능하다.


# 실습1
- 이미지뷰어/ 콤보박스/ 데이터셋
- 데이터셋(Invisible Object)안에 있음 더블클릭!
  - 데이터셋 추가하기
  - 데이터를 넣는다.
  - 만든 데이터셋을 드래그하여 콤보박스에 넣는다.
    - `Bind Inner dataset`
  - code column(화면에 안보임): url/ data column(화면에 보임): name
  - binding: 데이터셋과 컴포넌트를 서로 묶는다.
  - 동적바인딩: 실제로 어느 객체에 묶여있는지를 나타낸다.


- 나는 콤보박스의 `id`를 `image_dataset`으로 했다.

- 자바스크립트 파일 - 콤보박스누르면 내부 이미지 변화코드

```js

this.image_dataset_onitemchanged = function(obj:nexacro.Combo,e:nexacro.ItemChangeEventInfo)
{
var url= this.image_dataset.value; //내안에 있는 콤보안에있는 값을 가져와야한다.
	this.ImageViewer00.set_image(url);
	this.ImageViewer00.set_stretch("fit");

};

```


- xml파일

```xml
<?xml version="1.0" encoding="utf-8"?>
<FDL version="2.1">
  <Form id="Practice1_DataSetBinding" width="1280" height="720" titletext="New Form">
    <Layouts>
      <Layout height="720" width="1280">
        <ImageViewer id="ImageViewer00" taborder="0" text="ImageViewer00" left="31" top="26" width="130" height="158" onclick="ImageViewer00_onclick"/>
        <Combo id="image_dataset" taborder="1" text="" left="181" top="77" width="154" height="44" innerdataset="Dataset00" codecolumn="url" datacolumn="name" onitemchanged="image_dataset_onitemchanged"/>
      </Layout>
    </Layouts>
    <Objects>
      <Dataset id="Dataset00">
        <ColumnInfo>
          <Column id="name" type="STRING" size="256"/>
          <Column id="url" type="STRING" size="256"/>
        </ColumnInfo>
        <Rows>
          <Row>
            <Col id="name">atlas</Col>
            <Col id="url">imagerc::ATLAS.JPG</Col>
          </Row>
          <Row>
            <Col id="name">dogged</Col>
            <Col id="url">imagerc::dogged.JPG</Col>
          </Row>
          <Row>
            <Col id="name">hawling</Col>
            <Col id="url">imagerc::hawling.JPG</Col>
          </Row>
          <Row>
            <Col id="name">helfire</Col>
            <Col id="url">imagerc::helfire.JPG</Col>
          </Row>
        </Rows>
      </Dataset>
    </Objects>
  </Form>
</FDL>
```
