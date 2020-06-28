from flask import Flask, request, jsonify, render_template
import requests
from urllib.parse import urlparse
from selenium import webdriver
from bs4 import BeautifulSoup
import time
import platform


# pymongo
from pymongo import MongoClient
from collect_naver_blogs import update_db_data
client = MongoClient('localhost', 27017)
db= client.db_cek_final # db_cek_final 이라는 데이터베이스를 생성 및 호출.

app = Flask(__name__)


#메인페이지
@app.route('/')
def mainPage():
    return render_template('main.html')

# 시간대별로 아침/점심/저녁/야식 로 나타낸다.
@app.route('/now', methods=['POST'])
def get_now():
    receive_time = int(request.form['give_time'])
    meal_time = None

    # 5시 ~ 11시 : 아침
    if(receive_time >= 5 and receive_time <= 11):
        meal_time = '아침'
    elif(receive_time >= 12 and receive_time <= 16):
        meal_time = '점심'
    elif(receive_time >= 17 and receive_time <= 21):
        meal_time = '저녁'
    elif((receive_time >= 22 and receive_time < 24) or (receive_time >= 0 and receive_time < 5)):
        meal_time = '야식'

    return jsonify({'result': 'success', 'meal_time': meal_time})


# 네이버 블로그 데이터를 계속 업데이트 하도록한다.
@app.route('/update/blog', methods=['POST'])
def update_blog_data():
    #클라이언트쪽에서 서버로 전달한 데이터(메뉴리스트)를 받는다.
    menus_receive= request.form.getlist('menus_give[]') 
    print(menus_receive)

    # 0번에 해당하는 옵션은 '메뉴선택'이므로 키워드에 알맞는 블로그 검색에 제외된다.
    # 1번부터 마지막에 해당하는 메뉴옵션만을 collect_naver_blogs 의 update_db_data()함수를 호출
    update_db_data(menus_receive[1:]) #업데이트 모두 완료.
    return jsonify({'result': 'success'})


# 네이버 블로그 맛집 후기 보고 결정할래! #
# 메뉴선택에서 선택한 메뉴에 대한 데이터베이스 정보를 가져온다.
@app.route('/search/blogs/restaurant', methods=['POST'])
def search_blogs_data():
    # 클라이언트로부터 받은 메뉴데이터
    select_menu=request.form['give_menu']
    print(select_menu)

    if(select_menu=='메뉴선택'):
        # 모든 메뉴의 결과를 가져온다.
        blogs=list(db.naver_blogs.find({}))
    else:
        #몽고디비에서 선택한 메뉴와 관련된 블로그를 찾는다.
        # mongodb 의 _id, menu를 제외한 나머지 필드를 가져온다.
        blogs=list(db.naver_blogs.find({'menu':select_menu}, {'_id':False}))
        
    print(len(blogs))

    return jsonify({'result':'success', 'blogs': blogs})



## 유튜브 크롤링 ##



## 맛집방송에서 찾아볼래! ##
# 생방송투데이
@app.route('/search/famous/flavor/today', methods=['GET'])
def find_famous_today():
    try:
        headers = {'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36'}
        html= requests.get('http://www.onlmenu.com/', headers=headers)

        soup=BeautifulSoup(html.text, 'html.parser')

        # 생생정보통 식당 데이터
        proList= soup.select('.widget-box > .basic-post-gallery > .post-row')
        restaurants=[]
        for pro in proList:
            img_url=pro.select_one('.post-list > .post-image > a > div.img-wrap > div.img-item > img')
            name=pro.select_one('.post-content > div:nth-child(2) > font > b')
            menu=pro.select_one('.post-content > div:nth-child(3) > font')
            address= pro.select_one('.post-content > div:nth-child(4)')

            data={
                'img_url': img_url['src'],
                'name': name.text,
                'menu': menu.text,
                'address': address.text
            }

            restaurants.append(data)
    except Exception as e:
        print('Exception occurred => ', e)


    print('생방송투데이 맛집 스크래핑 완료!')
    return jsonify({'result': 'success', 'restaurants': restaurants})


# 생활의 달인 - 맛의 달인
@app.route('/search/famous/flavor/master', methods=['GET'])
def find_famous_master():
    # selenium 을 활용한 web page crawling
    options = webdriver.ChromeOptions()
    options.add_argument('headless')
    driver = webdriver.Chrome('./chromedriver', chrome_options=options)
    
    driver.get('http://matstar.sbs.co.kr/program.html?programs=S01_V0000305532')

    # Beautiful soup를 이용하여, 내가원하는 부분을 웹스크래핑
    html = driver.page_source
    soup = BeautifulSoup(html)
    proList = soup.select('ul.restaurant_list > div')

    restaurants = []
    for pro in proList:
        try:
            img_url = pro.select_one('div > li.rl_cont > div > a > div.box_module_image_w > img.box_module_image')
            name = pro.select_one('div > li.rl_cont > div > a > div.box_module_cont > div > strong')
            menu = pro.select_one('div > li.rl_cont > div > a > div.box_module_cont > div > div > div.mil_inner_kind > span.il_text')
            address = pro.select_one('div > li.rl_cont > div > a > div.box_module_cont > div > div > div.mil_inner_spot > span.il_text')

            data = {
                'img_url': img_url['src'],
                'name': name.text,
                'menu': menu.text,
                'address': address.text
            }

            restaurants.append(data)
        except Exception as e:
            print('exception occurred=> ', pro, '\n=>', e)

    print('생활의달인 - 오늘의 맛집페이지 스크래핑 완료!')
    driver.close()
    return jsonify({'result': 'success', 'restaurants': restaurants})



# 생생정보통
@app.route('/search/famous/flavor/info', methods=['GET'])
def find_famous_info():
    headers = {'User-Agent' : 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.86 Safari/537.36'}
    html= requests.get('https://menutong.com/', headers=headers)

    soup=BeautifulSoup(html.text, 'html.parser')

    # 생생정보통 식당 데이터
    proList = soup.select('.widget-box > .basic-post-gallery > .post-row')
    
    restaurants=[]
    for pro in proList:
        try:
            img_url = pro.select_one('.post-list > .post-image > a > div.img-wrap > div.img-item > img')
            name= pro.select_one('.post-content > div:nth-child(2) > font > b')
            menu= pro.select_one('.post-content > div:nth-child(3) > font')
            address= pro.select_one('.post-content > div:nth-child(4)')
        
            data={
                'img_url': img_url['src'],
                'name': name.text,
                'menu': menu.text,
                'address': address.text
            }
            restaurants.append(data)
        except Exception as e:
            print('Execption occurred => ', e)
    print('생생정보통 - 오늘의 맛집 스크래핑 완료!')
    return jsonify({'result': 'success', 'restaurants': restaurants})


if __name__ == '__main__':
    app.run('0.0.0.0', 6500, debug=True)
