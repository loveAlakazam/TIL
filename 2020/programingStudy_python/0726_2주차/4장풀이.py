# 문제4-1
def solution4_1():
    for _ in range(5):
        print('*', end='')

def solution4_2():
    for _ in range(5):
        for _ in range(5):
            print('*', end='')
        print()

def solution4_3():
    for r in range(1,6):#1,2,3,4,5
        for _ in range(r):
            print('*', end='')
        print()


def solution4_4():
    for r in range(5,0,-1):#r=5,4,3,2,1
        for _ in range(r):
            print('*', end='')
        print()

def solution4_5():
    for r in range(1,6):# r=1,2,3,4,5
        for c in range(5):#c=0,1,2,3,4
            if c>=5-r: 
                print('*',end='')
            else:
                print(' ',end='')
        print()
    # 풀이
    # r=1, c=4일때 *을 찍는다.
    # r=2, c=3,4 일때 *을 찍는다.
    # r=3, c=2,3,4 일 때 * 을 찍는다.
    # r=4, c=1,2,3,4 일때 * 을 찍는다
    # r=5, c=0,1,2,3,4 일때 *을 찍는다.
    # 일반식: c>=5-r 을 만족시킬때 *을 찍는다.

def solution4_6():
    for r in range(5):
        for c in range(5):
            if c>=r:
                print('*',end='')
            else:
                print(' ',end='')
        print()
    # r=0, c=0,1,2,3,4
    # r=1, c=1,2,3,4
    # r=2, c=2,3,4
    # r=3, c=3,4
    # r=4, c=4



def solution4_7(row):
    half=int(row//2)
    for r in range(half+1):# r=0,1,2,3,4
        for c in range(row): 
            if (c>=half-r) and (c<=half+r):
                print('*', end='')
            else:
                print(' ', end='')
        print()
    # row=9, half=int(4.5)=4
    # *을 찍는 위치
    # r=0, c=4 (c=4-0~4+0)
    # r=1, c=3,4,5 (c=4-1=3~4+1=5)
    # r=2, c=2,3,4,5,6
    # r=3, c=1,2,3,4,5,6,7
    # r=4, c=0,1,2,3,4,5,6,7,8


def solution4_8(row):
    half= int(row//2)
    for r in range(half+1):# r=0,1,2,3,4
        for c in range(row+1):
            if c>=r and c<row-r:
                print('*', end='')
            else:
                print(' ',end='')
        print()
    # row=9, half=4
    # r=0, c=0,1,2,3,4,5,6,7,8
    # r=1, c=1,2,3,4,5,6,7
    # r=2, c=2,3,4,5,6
    # r=3, c=3,4,5
    # r=4, c=4

def solution4_9():
    aparts = [[101, 102, 103, 104],
            [201, 202, 203, 204],
            [301, 302, 303, 304], 
            [401, 402, 403, 404]]
    
    arrears=[apart[0] for apart in aparts]
    print(arrears)



def main():
    #   4장   #
    solution4_1()
    solution4_2()
    solution4_3()
    solution4_4()
    solution4_5()
    solution4_6()
    solution4_7(9)
    solution4_8(9)
    solution4_9()


if __name__=='__main__':
  main()
