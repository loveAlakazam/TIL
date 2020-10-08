# 운영체제의 개념

## 1. 운영체제(OS) 정의

**운영체제**란, 컴퓨터 시스템의 자원들을 효율적으로 관리하고
사용자가 컴퓨터를 편리하고 효과적으로 사용할 수 있도록 환경을 제공해주는
여러 프로그램들의 집합

<br><br>

An **operating system** is a program that manages a computer's hardware.<br>

It also provides a basis for application programs and acts as an intermediary between the computer user and the computer hardware.

<br>

## 2. 운영체제 목적


- 컴퓨터 시스템의 **처리량**과 **신뢰성**을 최대화 한다.
- 컴퓨터 시스템의 **반환시간**, **응답시간**, **처리시간**, **대기시간**, **경과시간**을 최소화한다.

- `컴퓨터를 구성하고 있는 자원을 효율적으로 운영하고 제어한다.`
- `사용자와 컴퓨터 시스템의 인터페이스를 제공한다.`
- 제한된 자원(CPU 와 Memory)을 효율적으로 공유하기 위해 스케줄링을 한다.
- 데이터를 공유한다.
- 주변 장치를 관리한다.
- 시스템의 이식성(호환성)을 높인다.


- 운영체제 성능 평가 기준
    - `처리 능력(Throughput)` : 일정 시간 내에 시스템이 처리하는 일의 양

    - `반환 시간(Turn around time)` : 시스템 작업을 의뢰한 시간부터 처리가 완료될 때까지 걸리는 시간

    - `사용 가능도(availability)` : 시스템을 사용할 필요가 있을 때 즉시 사용 가능한 정도

    - `신뢰도(reliability)` : 시스템이 주어진 문제를 정확하게 해결하는 정도


<br>

## 3. 운영체제 역할

- 운영체제는 스스로 어떤 기능도 수행하지 않고 `다른 응용프로그램이 유용한 작업을 할 수 있도록 환경을 마련`해준다.

- 하드웨어와 사용자 사이에 내부 및 외부 인터페이스를 제공한다.
    - **`인터페이스`**: 서로 다른 두 시스템 또는 사용자와 컴퓨터를 소프트웨어로 이어주는 부분이나 장치

- 컴퓨터 자원을 여러 사용자가 효율적으로 나누어 사용할 수 있도록 자원을 관리한다.

- 프로세서(처리기, CPU) 프로세스, 기억장치(주/보조 기억 장치), 입출력 장치, 파일 및 정보등의 자원들을 관리한다.

- 컴퓨터를 초기화 시켜 작업을 수행할 수 있는 상태로 유지시키는 역할

- 소프트웨어나 하드웨어에 오류가 발생하면 회복을 위해 활동.

- 시스템 사용 도중 발생하는 내/외 부적인 오류로부터 시스템을 보호

- 응용 프로그램들이 컴퓨터의 제한된 자원들을 공유할 수 있도록 자원을 관리.

- 자원을 효율적으로 관리하기 위해서 자원의 `스케줄링` 기능을 제공한다.
    - **`스케줄링(scheduling)`**: 어떤 자원을 `누가`, `언제`, `어떤 방식`으로 사용할지를 결정하는 것이다.

- 데이터를 관리하고 데이터 및 자원의 공유기능, 자원을 보호하는 기능을 제공

<br>

- 운영체제의 주요 자원 관리

|자원|기능|
|:--:|:--:|
|프로세스 관리| - 프로세스 스케줄링 및 동기화 관리 담당<br>- 프로세스 생성과 제거 / 시작과 정지/ 메시지 전달 등의 기능을 담당|
|기억장치 관리|프로세스에게 메모리 할당 및 회수 관리 담당|
|주변장치 관리|입출력 장치 스케줄링 및 전반적인 관리 담당|
|파일 관리|파일의 생성과 삭제, 변경, 유지 등의 관리 담당|


## 4. 운영체제의 특징

- 사용자에게 편리한 인터페이스 환경을 제공
- 컴퓨터 시스템의 자원을 효율적으로 관리

- **하드웨어**
    - **중앙처리 장치(CPU)**: 컴퓨터 장치를 제어 및 데이터를 처리
    - **기억 장치**: 데이터를 저장
    - **통신 장치**: 외부와의 통신을 담당
    - **입출력 장치**: 데이터의 입력과 출력을 담당

<br>

- **커널(kernel)**
    - 운영체제 핵심기능(**`프로세스 관리`**, **`메모리 관리`**, **`파일 관리`**)을 모아 놓은 것.
    - `운영체제 성능에 중요한 역할.`
    
- 운영체제 종류
    - 컴퓨터 운영체제
        - windows
        - mac OS
        - Linux
        - UNIX

    - 모바일 운영체제
        - Android
        - iOS
        - Tizen

    - 개인용 / 서버용 운영체제
        - 개인용 PC
            - Windows
            - MS DOS
            - Mac OS
        - 서버용 PC
            - Linux
            - UNIX

        


## 5. 운영체제의 종류

1. Windows

- GUI(Graphic User Interface)
- 선점형 멀티태스킹 (Preemptive multi-tasking)
    - 동시에 여러개의 프로그램을 실행하는 멀티태스킹을 한다.
    - OS가 각 작업의 CPU 이용시간을 제어한다.
    - 응용프로그램 실행 중 문제가 발생하면, 해당프로그램을 강제종료시키고 모든 시스템자원을 반환한다.

    

- PnP(Plug and Play, 자동감지기능)
    - 컴퓨터 시스템에 하드웨어(프린터, 사운드카드 등)를 설치했을 때, 해당 하드웨어를 사용하는데 필요한 시스템 환경을 운영체제가 자동으로 구성해주는 기능.
    - 운영체제가 하드웨어의 규격을 자동으로 인식하여 동작하게 한다.
    - PC 주변 장치를 연결할 때 사용자가 직접 환경을 설정하지 않아도 된다.
    - 하드웨어와 소프트웨어 모두 지원해야 PnP기능을 활용할 수 있다.

- OLE(Object Linking and Embedding)
    - `linking`: 다른 여러 응용프로그램에서 작성된 문자, 그림 등의 개체(object)를 현재 작성 중인 문서에 자유롭게 연결
    - `embedding`: 문자, 그림과 같은 개체를 삽입하여 편집할 수 있다.

- 255자의 긴 파일명
- Single user system
    - 컴퓨터 한대를 한사람만이 독점해서 사용한다.



2. UNIX

- 시분할 시스템(Time Sharing System)
    - 여러명의 사용자가 사용하는 시스템에서 컴퓨터가 사용자들의 프로그램을 번갈아가며 처리
    - 각 사용자에게 독립된 컴퓨터를 사용하는 느낌을 준다.
    - RR(Round Robbin)방식 
        - 라운드 로빈 방식은 선점형 스케줄링방식이다.

- 대화식 운영체제
- 개방형 시스템(Open System): 소스가 공개된 시스템
- 이식성이 높다
- 프로세스 간의 호환성이 높다.
- 대부분 C언어로 작성되어 있다.
- 크기가 작고 이해하기 쉽다.
- 다중 사용자(multi-user), 다중 작업(multi-tasking)을 지원한다.
- 트리구조(tree structure)의 파일시스템을 갖는다.
- 다양한 유틸리티 프로그램들이 존재한다.

- ### 커널(kernel)
    - Unix의 가장 핵심부분
    - 컴퓨터가 부팅될 때 주기억장치에 적재된 후 상주하면서 실행
    - 하드웨어를 보호하고, 프로그램과 하드웨어 간의 인터페이스 역할을 담당
    - `프로세스(cpu scheduling) 관리`, `기억장치 관리`, `파일 관리`, `입출력 관리`, `프로세스간 통신`, `데이터 전송 및 변환` 등 여러기능을 수행.

- ### 쉘(shell)
    - 사용자의 명령어를 인식하여 프로그램을 호출
    - 명령어 해석기
    - 시스템과 사용자 간의 인터페이스를 담당
    - 주기억장치에 상주하지 않고, 명령어가 포함된 파일 형태로 존재하며, 보조 기억장치에서 교체 처리가 가능하다.
    - 파이프라인 기능을 지원하고 입/출력 재지정을 통해 출력과 입력의 방향을 변경할 수 있다.
    - 공용 shell(bourne shell, c-shell, korn-shell, bash-shell)이나 사용자 자신이 만든 shell을 사용할 수 있다.
