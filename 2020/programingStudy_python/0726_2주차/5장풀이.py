def myaverage(a,b):
    return (a+b)//2

def solution5_1():
    myaverage(89,11)


def get_max_min(data_list):
    print('최댓값: ', max(data_list))
    print('최솟값: ', min(data_list))

def solution5_2():
    get_max_min([38,21, 44, 55])


def get_txt_list(path):
    import os
    # path 경로에있는 파일들을 리스트의 원소로 나타낸다.
    fileList=os.listdir(path)

    # path경로중 txt파일들만을 저장하는 리스트
    textFiles=[]

    for file in fileList:
        # 현재 파일의 확장자가 txt라면
        if file.endswith('txt'):
            textFiles.append(file)
    return textFiles
            

def solution5_3():
    # 절대경로를 입력받은 후
    # 해당경로에 있는 *.txt파일의 목록을
    # 파이선리스트로 반환하는 함수를 작성.
    import os

    # 현재 작업하는 디렉토리경로를 얻는다.
    currentDir=os.getcwd()
    print('현재 디렉토리 경로: ',currentDir)
    textFilesList=get_txt_list(currentDir)

    print('현재 디렉토리 경로에 들어있는 텍스트파일 개수: {}개'.format(len(textFilesList)))
    for text_file in textFilesList:
        print(text_file)


def solution5_4(weight, height):
    # 체중(weight)와 신장(height)를 받은후
    # bmi 값에 따른 '마른체형', '표준', '비만','고도비만' 중 
    # 하나를 출력하는 함수를 작성하세요.
    bmi= weight/(height**2)
    if bmi<18.5:
        return '마른체형'
    elif bmi<25.0:
        return '표준'
    elif bmi<30.0:
        return '비만'
    elif bmi>=30.0:
        return '고도비만'


def solution5_5():
    while True:
        height=float(input('키(cm): '))
        weight=float(input('몸무게(kg): '))
        
        #무한루프를 종료하는함수
        # height 또는 weight 가 0
        if height<=0 or weight<=0:
            return 
        solution5_4(weight, height)



def get_triangle_area(width, height):
    return 0.5*width*height

def solution5_6():
    width=float(input('밑변의 길이(cm): '))
    height=float(input('높이의 길이(cm): '))
    print('밑변이 {width}, 높이가 {height}인 삼각형 넓이: {area}'.format(
        width=width, height=height, area=get_triangle_area(width, height)         
    ))



def add_start_to_end(start, end):
    return sum(i for i in range(start, end+1))
#     return [i for i in range(start, end+1)]

def solution5_7():
    start=int(input('시작 숫자(정수): '))
    end=int(input('끝 숫자(정수): '))
    result=add_stat_to_end(start,end)
    print('합: %d' %result)
#     for e in add_start_to_end(start, end):
#         print(e, end=' ')
    



def solution5_8():
    # 각 문자열의 첫 세글자로만 구성된 
    # 리스트를 반환하는 함수를 작성.
    locations=['Seoul', 'Daegu', 'Kwangju', 'Jeju']
    for location in locations:
        if len(location)>=3:
            # 여기서는 운좋게도 길이가 3글자 이상이지만
            # 만약에 3글자 미만인경우에는 에러가 발생한다.
            print(location[:3])



def main():
    #   5장   #
    solution5_1()
    solution5_2()
    solution5_3()
    print('bmi에 따른 체형 분류 결과=>',solution5_4(46,160))
    
    solution5_5()
    solution5_6()
    solution5_7()
    solution5_8()
    
    
if __name__=='__main__':
    main()
