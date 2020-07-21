# 문제6-1
class Point():
    # 생성자
    # 생성자를 통해 (x,y) 좌표를 입력받는다.
    def __init__(self,x,y):
        self.x=x
        self.y=y

    def setx(self,x):
        self.x=x

    def sety(self,y):
        self.y=y

    # get() 메소드를 호출하면 튜플로 구성된(x,y) 좌표를 반환한다.
    def get(self):
        return (self.x, self.y)
    
    def getx(self):
        return self.x

    def gety(self):
        return self.y

    def move(self,dx,dy):
        self.x+=dx
        self.y+=dy


# 문제 6-3 Stock 클래스
# 네임스페이스 : 변수가 객체를 바인딩할 때 그 둘 사이의 관계를
#             저장하고 있는 공간을 의미한다.
# a=2 => a라는 변수가 2라는 객체가 저장된 주소를 가지고 있는데

class Stock:
    # 공용변수 static
    market= 'kospi'

    def print_name_space(self):
        print(self.__dict__)      


# 문제 6-2
# 4개의 메소드를 사용하는 코드
def solution6_2():
    sample_point1= Point(1,1) #(1,1) 좌표를 구한다.
    print('현재 좌표: ',sample_point1.get()) #(1,1)


    beforeX=sample_point1.getx()
    
    #x좌표를 5로 설정
    sample_point1.setx(5)
    afterX=sample_point1.getx() # x좌표: 5
    print('이전 x좌표: {before}-> setx(5)이후 x좌표:{after}'.format(before=beforeX, after=afterX))

    #x축으로 -8만큼, y축으로 -2만큼 이동
    sample_point1.move(-8,-2)
    after_move=sample_point1.get()  # after_move=(-3,-1)
    print('x축으로 -8만큼, y축으로 -2만큼 이동 후 좌표: ', after_move)


# 문제 6-3
def solution6_3_4():
    a=Stock()
    print(a) # <__main__.Stock object at 0x7f84caa03d90>
    
    # 6-3 인스턴스 변수 a의 namespace
    print('인스턴스 변수 a에 바인딩된 객체의 name space')
    a.print_name_space() # {}

    # 6-4
    a.market='kosdaq'
    a.print_name_space() # {'market': 'kosdaq'}
    print(a.market) # kosdaq

    print('\n인스턴스 변수 b에 바인딩된 객체의 name space')
    b=Stock()
    print(b) # <__main__.Stock object at 0x7f84caa2ff40>
    
    # 6-3 인스턴스 변수 b의 namespace
    b.print_name_space() #{}

    b.market='nasdaq'
    b.print_name_space() #{'market': 'nasdaq'}
    print(b.market) # nasdaq

    # 객체를 생성하기 전, Stock에서 market에 초기화된 필드 내용확인.
    print('\nStock.market: ', Stock.market) #Stock.market: kospi


def main():
    solution6_2()
    solution6_3_4()



if __name__=='__main__':
    main()
