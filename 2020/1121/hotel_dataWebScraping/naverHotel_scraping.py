from bs4 import BeautifulSoup
from selenium import webdriver

import getHotelKeys
import time


global local, hotels

localCode = {
    '강원도': 1,
    '경기도': 2,
    '경상남도': 3,
    '경남': 3,
    '경상북도': 4,
    '경북': 4,
    '광주': 5,
    '광주광역시': 5,
    '대구': 6,
    '대전': 7,
    '부산': 8,
    '부산광역시': 8,
    '서울': 9,
    '서울특별시': 9,
    '세종': 10,
    '세종특별시': 10,
    '세종특별자치시': 10,
    '인천': 11,
    '인천광역시': 11,
    '울산': 12,
    '울산광역시': 12,
    '전라남도': 13,
    '전남': 13,
    '전라북도': 14,
    '전북': 14,
    '제주도': 15,
    '제주': 15,
    '제주특별자치도': 15,
    '충청남도': 16,
    '충남': 16,
    '충청북도': 17,
    '충북': 17
}


global options
options = webdriver.ChromeOptions()
options.add_argument('headless')
options.add_argument('window-size=1920x1080')
options.add_argument('disable-gpu')
options.add_argument("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.66 Safari/537.36")
    

def get_hotel_info(key):
    one_hotel_info = {}

    driver = webdriver.Chrome('chromedriver.exe', options=options)
    
    # 호텔디테일 페이지 url
    url = 'https://hotel.naver.com/hotels/item?hotelId='+key
    driver.get(url)
    time.sleep(1) #페이지 로드까지 1초 대기
    
    req = driver.page_source
    soup = BeautifulSoup(req, 'html.parser')

    # 호텔이름
    hotel_name = soup.select_one('div.info_wrap > strong.hotel_name').text
    one_hotel_info['BO_TITLE'] = hotel_name

    # 호텔등급
    hotel_rank = soup.find('span', class_='grade').text
    if hotel_rank in ['1성급', '2성급', '3성급', '4성급', '5성급']:
        one_hotel_info['HOTEL_RANK']=int(hotel_rank[0])
    else:
        one_hotel_info['HOTEL_RANK']=None
        
    # 호텔주소
    hotel_addr_list= [addr for addr in soup.select_one('p.addr').text.split(', ')]
    one_hotel_info['HOTEL_ADDRESS']=hotel_addr_list[0]
    one_hotel_info['HOTEL_LOCAL_CODE']=localCode[hotel_addr_list[-2]]
    
    # 호텔소개
    driver.find_element_by_class_name('more').click()  # 더보기 버튼을 누른다.
    time.sleep(1)  # 예약페이지 로드 1초 대기
    
    hotel_content = soup.select_one('div.desc_wrap.ng-scope > p.txt.ng-binding')
    one_hotel_info['BO_CONTENT'] = hotel_content.text

    # 호텔옵션
    hotel_options = [option.text for option in soup.select('i.feature')]
    one_hotel_info['HOTEL_REAL_OPTIONS'] = hotel_options
    
    driver.quit()
    return one_hotel_info


def main():
    hotel_keys = getHotelKeys.main()
    print(len(hotel_keys))


if __name__ == '__main__':
    main()
