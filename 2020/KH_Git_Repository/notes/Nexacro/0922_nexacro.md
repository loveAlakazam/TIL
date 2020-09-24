> # Frame 설정하기

## Frame을 이용한 화면 배치

- ### `MainFrame`: 최상위 프레임
- ### `ChildFrame`
  - `ChildFrame`에 화면(Form)을 배치한다.
  - **기본적으로 제공하는 하위프레임**
  - 하위로 **하나의 폼만 가질 수 있다.**

- 기본 제공되는 프레임은 `MainFrame`, `ChildFrame`으로 나뉜다.

- ### NodeFrame
  - ##### FrameSet
    - 특별한 형태없이 하위 프레임을 배치한다.
    - 2개 이상의 하위 프레임이 추가되면 계단식으로 배치하며 위치 속성값을 지정하면 해당 위치에 배치
    - 하위로 Node Frame 또는 ChildFrame을 가질 수 있다.

  - ##### VFrameSet
    - `세로` 형태로 하위 프레임을 배치
    - seperatesize속성으로 하위 프레임 배치 비율을 지정
    - 하위로 Node Frame 또는 ChildFrame을 가질 수 있다.

  - ##### HFrameSet
    - `가로` 형태로 하위 프레임을 배치
    - seperatesize속성으로 하위 프레임 배치 비율을 지정
    - 하위로 Node Frame 또는 ChildFrame을 가질 수 있다.
    
  - ##### TileFrameSet
    - 바둑판(표)형태로 하위 프레임을 배치
    - seperatetype, seperatecount 속성으로 가로, 세로 방향에 배치될 하위 프레임을 지정
    - 하위로 Node Frame 또는 ChildFrame을 가질 수 있다.
