import sys
input=sys.stdin.readline # input()보다 속도가 더 빠름.

# 1장
def answer_1():
    #1-2
    print('주식은 대박이다.')

    #1-3
    print('출력 키워드 : print / 출력함수: print()')

    #1-4
    print("I love 'you'")
    print("I like you")
    print('Korea')
    # print{Hello}
    # SyntaxError: invalid syntax

    #print[hello]
    #NameError: name 'hello' is not defined
    

# 2장
def price_calculator1(dprice, dcnt, nprice, ncnt):
    # dprice: 다음 주식 가격/ dcnt: 다음주식 개수
    # nprice: 네이버주식가격/ ncnt: 네이버 주식개수
    return int((dprice*dcnt)+(nprice*ncnt))

def fahrenheitToCelsius(F):
    C=(F-32)/1.8
    return C
    

def answer_2():
    # 2-1
    print('문제2-1')
    Daum_price=89000
    Naver_price=751000
    total=price_calculator1(Daum_price, 100, Naver_price, 20)
    print('주식의 총액: {total}원'.format(total= total))

    #2-2
    print('\n문제2-2')
    #다음, 네이버 주가 0.5%, 10% 하락
    Daum_price*=(1-0.005)
    Naver_price*=(1-0.1)
    lost_price=total-price_calculator1(Daum_price,100, Naver_price,20)
    print('손실액: {lost}원'.format(lost=lost_price))


    print('\n문제2-3')
    print('화씨온도가 50F일때 섭씨온도: {}C'.format(fahrenheitToCelsius(50)))

    print('\n문제2-4')
    for i in range(10):
        print('pizza')


    print('\n문제2-5')
    start_Naver_price= 100*(10**4) #100만원
    for day in range(3):
        start_Naver_price*=0.7    
    # 반올림 round()
    print('수요일 종가: {result}원'.format(result=round(start_Naver_price))) 

    print('\n문제2-6')
    print('이름: ', end=' ')
    name=input()
    
    print('생년월일: ', end=' ')
    birthday=input()
    
    print('주민등록번호: ', end=' ')
    pn=input()
    print()
    print('이름: {} / 생년월일: {} / 주민등록번호: {}'.format(name, birthday, pn))
    
    print('\n문제2-7')
    s='Daum KaKao'
    print(s[5:]+' '+s[:4])
    
    print('\n문제2-8')
    a='hello world'
    a='hi'+' '+a[6:]
    print(a)
    
    print('\n문제2-9')
    x='abcdef'
    x=x[1:]+x[0]
    print(x)

def answer_3():
    print('문제3-1')
    days=['월','화','수','목','금']
    naver_closing_price=[474500, 461500, 501000, 500500, 488500]
    for day,price in zip(days,naver_closing_price):
        print('{day}요일 종가=> {price}'.format(day=day, price=price))
    
    print('\n문제3-2,  3-3')
    max_price=max(naver_closing_price)
    print('3-2 최댓값: ',max_price)
    
    min_price=min(naver_closing_price)
    print('3-3최솟값: ', min_price)

    print('\n문제3-4')
    gap=abs(max_price-min_price) #abs()절댓값
    print('최댓값과 최솟값 차이: ', gap)

    print('\n문제3-5')
    print('수요일 종가 => ', naver_closing_price[2])

    print('\n문제3-6')
    naver_closing_price2={
        '09/07':{'요일':'월', '종가':474500},
        '09/08':{'요일':'화', '종가':461500},
        '09/09':{'요일':'수', '종가':501000},
        '09/10':{'요일':'목', '종가':500500},
        '09/11':{'요일':'금', '종가':488500}
    }

    print('\n문제 3-7')
    print(naver_closing_price2['09/09']['종가'])
    
def main():
    answer_1()
    answer_2()
    answer_3()
    
if __name__=='__main__':
    main()
    
