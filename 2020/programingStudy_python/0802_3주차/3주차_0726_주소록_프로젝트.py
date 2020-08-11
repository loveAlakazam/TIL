# 클래스 작성
class Contact:
    # def __init__(self, 필드명1, 필드명2, ...) => 객체 생성자
    def __init__(self, name, phone_number, email, addr):
        # 매개변수에 있는 값들을 받아와서
        # Contact객체의 필드 name, phone_number, email, addr을 초기화
        self.name = name
        self.phone_number = phone_number
        self.email = email
        self.addr = addr

    # 메소드
    # self가 붙어있는 메소드는 객체를 생성해야만 사용할 수 있는 메소드이다.
    def print_info(self):
        print('name: ', self.name)
        print('phone number: ', self.phone_number)
        print('email: ', self.email)
        print('address: ', self.addr)

    def return_info(self):
        return self.name+'/'+self.phone_number+'/'+self.email+'/'+self.addr+'\n'


def set_contact():
    # 사용자로부터 입력을받은 정보를 가지고 객체를 생성하여, 그 객체의 정보를 갖고온다.
    # 즉, 사용자로부터 객체의필드인 name, phone_number, email, addr을 직접 입력받아서
    # 입력받은 필드로 새로운 Contact 객체를 생성한다.
    name = input('이름: ')
    phone_number = input('전화번호: ')
    email = input('이메일 주소: ')
    addr = input('집주소: ')
    contact = Contact(name, phone_number, email, addr)
    contact.print_info()
    return contact # 생성한 객체의 주소를 리턴. (인스턴스변수 contact에는 바인딩된 Contact객체 주소값이 저장.)


def print_menu():
    print('1. 연락처 입력')
    print('2. 연락처 출력')
    print('3. 연락처 삭제')
    print('4. 종료')
    menu = input('선택: ')  # 여기서 주의해야할게 Input에 입력한 숫자의 type은 str(문자열)임을 주의한다.
    return int(menu)

# (8-1)
def ex8_1():
    # Contact 객체를 만든다.
    # c는 오른쪽에 객체를 바인딩한다.(연결)
    c = Contact('최은강', '010-1111-7777', 'dmsrkd1216@gmail.com', '서울시 성동구')

    # 메소드 호출
    c.print_info()  # 지역변수: 함수호출후 함수안의 문장이 끝나면 자동으로 사라짐.


# (8-2)
def ex8_2():
    # set_contact() 함수를 호출
    set_contact()


# (8-3)
def ex8_3():
    while 1: # 무한루프 - 조건의 결과 상관없이 모두 참=> 항상 실행
        menu=print_menu()
        
        # menu가 4라면 무한루프를 벗어난다.
        if menu==4:
            break

        elif menu<1 or menu>4: #1미만 또는 4초과인 숫자를 입력했다면(print_menu에서 엉뚱한 숫자를 입력했다면)
            print('잘못입력하셨습니다. 다시 입력해주세요!\n\n')
            continue # continue는 바로 다음으로 넘어가지않고 조건문으로 진입한다.

# (8-4) 연락처 동작시키기
# 아쉽게도 python에서는 switch case 문이 존재하지 않다.
# java- switch case  
# public static void main(){
#     Scanner sc= new Scanner(System.in);
#     int menu;
#     while(true){
#         menu = Integer.parseInt(sc.nextLine());
#         switch(menu){
#             case 1: 
#                 System.out.println("연락처 입력 페이지로 이동합니다.");
#                 set_contact();
#                 break;
#             case 2: 
#                 System.out.println("연락처 출력 페이지로 입력합니다.");
#                 print_contact();
#                 break;
#             case 3:
#                 System.out.println("연락처 삭제합니다.");
#                 remove_contact();
#                 break;
#             case 4:
#                 System.out.println("프로그램을 종료합니다.");
#                 return; //함수를 호출한 곳으로 리턴함으로써 종료문
#             default:
#                 System.out.println("잘못입력하셨습니다. 다시 입력해주세요.");
#         }
#     }
# }

def store_contacts(contact_list):
    # 연락처 데이터를 저장
    try:
        # 08_contact_db.txt 파일을 쓰기모드로 연다.
        f=open('./08_contact_db.txt', 'wt')
        f.write('이름\t / 전화번호\t / 이메일\t / 집주소+\n')
        if len(contact_list)>0:
            for contact in contact_list:
                f.write(contact.return_info())
        f.close() #파일을 닫는다.
    except FileNotFoundError:
        print('파일이 존재하지 않습니다!')


# 8-4(연락처 입력 동작), 8-5(연락처 출력), 8-6(연락처삭제) 모두 포함
def ex8_4():
    contact_list=[]
    while 1:
        menu=print_menu() # 메뉴를 선택한다.
        print()

        # 1번 메뉴를 선택하면 => 1.연락처 입력=> set_contact함수를 호출
        if menu==1:
            # 사용자로부터 입력받은 필드로 구성된 Contact객체를 생성하고
            # set_contact()함수를 통해서 객체(바인딩된 객체의 주소)를 받아서 contact 변수에 저장한다.
            # 이때, ex8_4()함수 안의 지역변수 contact도 객체의 주소를 저장하므로, 생성한 객체를 가리킨다.(바인딩됨.)
            contact=set_contact()
            contact_list.append(contact) # 객체를 리스트에 추가시킨다.

        elif menu==2: #연락처 출력
            #contact_list안에 저장된 연락처객체의 print_info()메소드를 호출하여 정보를 출력
            if len(contact_list)>0:
                for contact in contact_list:
                    contact.print_info()
                    print()
            else:
                print('[실패] 연락처가 비었습니다.')

        elif menu==3: #연락처 삭제
            remove_idx=0
            if len(contact_list)>0:
                try:
                    remove_idx=int(input('몇번째 인덱스의 연락처를 삭제할까요?: '))
                    if remove_idx>=0 and remove_idx<len(contact_list):
                        del contact_list[remove_idx] #contact_list에서 인덱스번호가 remove_idx인 원소를 지운다.
                        
                    else:
                        # remove_idx<0 or remove_idx>=len(contact_list)
                        # 예외를 발생시킨다.
                        raise IndexError
                except IndexError:
                    print('올바르지 않은 인덱스번호입니다!')
            else:
                print('[실패] 연락처가 비어있습니다.')


        # 4번메뉴를 선택하면=> 무한반복문을 벗어난다. => 그이후에는 프로그램 종료.
        elif menu==4:
            # 종료하기전에 contact_list에 있는 객체의 이름만 조회해보자.
            if len(contact_list)>0:
                for contact in contact_list:
                    print(contact.name)

            print('프로그램을 종료합니다.')
            break
        
        else: # menu<1 or menu>4
            print('잘못 입력하셨습니다. 다시입력해주세요!\n\n')
            continue

        #연락처 저장함수
        store_contacts(contact_list)
        print()

# 연락처 파일을 불러온다.
def read_contact_db():
    try:
        f=open('./08_contact_db.txt','rt')
        contents=f.readlines()
        for idx, content in enumerate(contents):
            if idx>0: #컬럼이름을 출력하지 않는다.
                print(content)
        f.close()
    except FileNotFoundError:
        print('파일을 찾을 수 없습니다!')
    except FileExistsError:
        print('파일이 존재하지 않습니다!')


def run():
    # (8-1) Contact클래스 만들기 및 사용해보기
    # ex8_1()

    # (8-2) 사용자로부터 데이터 입력받기
    # ex8_2()

    # (8-3) 메인 메뉴 구성하기
    # ex8_3()

    # (8-4) ~(8-7-1. 연락처 저장함수 작성하기)
    ex8_4()

    # (8-7-2. 연락처 불러오기)
    read_contact_db()


if __name__ == '__main__':
    # 현재 python 파일이 시작되면 run()메소드를 호출한다.
    run()
