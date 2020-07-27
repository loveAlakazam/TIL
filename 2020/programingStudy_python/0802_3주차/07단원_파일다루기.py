def file_read_example():
    # 현재 디렉토리와 동일한 디렉토리에 위치한 "sampleTEXT.txt" 파일을 연다.
    # 디렉토리 구분자 : /

    # 'rt': 텍스트파일 읽기모드
    # 'r': 파일 읽기 모드
    # 't': 텍스트파일
    # open(): 파일에 대한 정보를 담고 있는 객체를 반환
    # file: 파일객체와 바인딩된 인스턴스변수
    file = open('./sampleTEXT.txt', 'rt')

    # lines: 열린파일에서 읽어올 데이터들을 의미함.
    # 리스트 형태로 저장됨.
    # readlines(): 열린파일에서 데이터를 읽어올때 사용되는 함수
    lines = file.readlines()
    print(lines)

    print('\n< 이스케이프 문자 \\n 소거 이전 >')
    for line in lines:
        print(line)

    # 그런데 리스트 lines의 원소에는 줄바꿈문자(이스케이프 문자)'\n'이 붙어있다.
    # 마지막에 붙어있는 이스케이프 문자('\n')을 없애보자.
    print('\n< 이스케이프 문자 \\n 소거 이후 >')
    for line in lines:
        print(line, end='')  # end=''로 인해서 이스케이프 문자가 소거됨.

def file_read_example2():
    # 파일이름을 입력해서, 파일의 내용을 조회한다.
    readFILE=input('읽으려는 파일의 이름을 입력해주세요: ')
    try:
        f= open(readFILE, 'rt')
        contents= f.readlines()
        for content in contents:
            print(content)
    except FileNotFoundError:
        print('파일을 찾을 수 없습니다!')
    except FileExistsError:
        print('파일이 존재하지 않습니다!')


def file_write_example():
    import os

    # 현재파일이 존재하는 파일인지를 try-catch문으로 확인하기
    nowPath = os.getcwd()
    print('현재 디렉토리 위치: ', nowPath)
    files = os.listdir(nowPath)
    for idx, f in enumerate(files, 1):
        print('파일{idx}: {file}'.format(idx=idx, file=f))

    try:
        fileName = input('원하는 텍스트 파일 이름을 입력해주세요: ')

        # 입력한 파일이름이 존재한다면 파일을 연다.
        # w: 쓰기모드 / wt: 텍스트파일 쓰기모드
        targetFILE = open(nowPath+'/'+fileName, 'wt')
        while True:
            content = input('원하는 내용을 입력하세요 (종료 시, "exit"을 입력): ')
            if content.lower() == 'exit':
                break
            targetFILE.write(content+'\n')
        # 파일을 닫는다.
        targetFILE.close()

    except FileNotFoundError:
        print('현재 파일은 존재하지 않은 파일입니다!')
    except Exception:
        print('예외가 발생했습니다.')


def chapter07_01_answer():
    import os
    # 1부터 10까지의 숫자를 각 라인 단위로
    # 파일에 출력하는 프로그램을 작성하세요.
    print('문제 7-1')
    try:
        # 텍스트파일에 출력을 해야하므로, wt 옵션을 사용한다.
        # 현재디렉토리에서 number.txt 파일을 연다(쓰기모드)

        # 옵션 w => 기존에 존재하는 파일이라면, 함수를 호출할때마다 이전에 존재하는 데이터는 삭제되고, 새로써진다. 즉, 이전 파일에 있는 내용이 덮어쓰게된다.
        # 옵션 a => 기존에 존재하는 파일이라면, 함수를 호출할때마다 이전에 존재하는 데이터를 유지하되, 이어쓴다.
        targetFILE = open('./number.txt', 'at')

        # 1~10까지의 숫자를 각 라인 단위로 파일에 출력
        for i in range(10):
            print('%d => %d' % (i, i+1))
            targetFILE.write(str(i+1)+'\n')

    except FileNotFoundError:
        print('현재 파일이 존재하지 않습니다.')
    print('\n')


def chapter07_02_answer():
    import os
    # 사용자에게 경로를 입력받은 후
    # 해당 경로에 있는 디렉토리와 파일목록을
    # flist.txt 라는 파일로 출력하는 함수를 작성하세요.
    print('문제 7-2')
    input_dir = input('경로를 입력해주세요: ')

    # 입력한 디렉토리 경로와, 입력한 경로의 파일목록을 파일에 저장.
    try:
        # 현재 디렉토리 경로의 number.txt파일에서 쓰기모드로 파일을 연다.
        # 파일이 존재하지 않으면, 새로운 파일을 만들어낸다.
        f = open('./flist.txt', 'wt')
        dir_lists = os.listdir(input_dir)
        for dir in dir_lists:
            f.write(dir+ '\n')
    except FileExistsError:
        print('파일이 존재하지 않습니다.')
    except FileNotFoundError:
        print('현재 파일을 찾을 수 없습니다!')
    finally:
        print('number.txt 파일 조회')
        # finally 예약어는 예외발생 상관없이
        # 항상 거친다.
        # 읽기모드로 다시연다.
        try:
            f = open('./flist.txt', 'rt')
            # readlines(): 텍스트 파일의 모든 내용을 한꺼번에 읽는다.
            # EOF(End Of File)이 나올때까지 모든 내용을 읽어들인다.
            contents = f.readlines()
            for content in contents:
                print(content)

        except FileNotFoundError:
            print('파일이 존재하지 않습니다.')


if __name__ == '__main__':
    # 파일 읽기
    # file_read_example()   # (결과파일이름) sampleTEXT.txt

    # 파일 쓰기
    # file_write_example()  # (결과파일이름) ssample2.txt

    # 입력한 파일명에 해당하는 파일을 열어서 파일내용 조회
    file_read_example2()

    # 연습문제
    # chapter07_01_answer() # (결과파일이름) number.txt
    # chapter07_02_answer()   # (입력예) /usr/local/bin 입력 => flist , (결과파일이름) flist.txt
