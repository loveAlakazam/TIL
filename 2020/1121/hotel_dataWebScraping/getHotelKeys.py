from bs4 import BeautifulSoup
from selenium import webdriver
import time

# location: 지역
global local_url
local_url = {
    '서울': 'https://hotel.naver.com/hotels/list?destination=place:Seoul',
    '부산': 'https://hotel.naver.com/hotels/list?destination=place:Busan_Province',
    '속초': 'https://hotel.naver.com/hotels/list?destination=place:Sokcho',
    '경주': 'https://hotel.naver.com/hotels/list?destination=place:Gyeongju',
    '강릉': 'https://hotel.naver.com/hotels/list?destination=place:Gangneung',
    '여수': 'https://hotel.naver.com/hotels/list?destination=place:Yeosu',
    '수원': 'https://hotel.naver.com/hotels/list?destination=place:Suwon',
    '제주': 'https://hotel.naver.com/hotels/list?destination=place:Jeju_Province',
    '인천': 'https://hotel.naver.com/hotels/list?destination=place:Incheon_Metropolitan_City',
    '대구': 'https://hotel.naver.com/hotels/list?destination=place:Daegu_Metropolitan_City',
    '전주': 'https://hotel.naver.com/hotels/list?destination=place:Jeonju',
    '광주': 'https://hotel.naver.com/hotels/list?destination=place:Gwangju_Metropolitan_City',
    '울산': 'https://hotel.naver.com/hotels/list?destination=place:Ulsan_Metropolitan_City',
    '평창': 'https://hotel.naver.com/hotels/list?destination=place:Pyeongchang',
    '군산': 'https://hotel.naver.com/hotels/list?destination=place:Gunsan',
    '양양': 'https://hotel.naver.com/hotels/list?destination=place:Yangyang',
    '춘천': 'https://hotel.naver.com/hotels/list?destination=place:Chuncheon',
    '대전': 'https://hotel.naver.com/hotels/list?destination=place:Daejeon_Metropolitan_City',
    '천안': 'https://hotel.naver.com/hotels/list?destination=place:Cheonan',
    '세종': 'https://hotel.naver.com/hotels/list?destination=place:Sejong',
    '청주': 'https://hotel.naver.com/hotels/list?destination=place:Cheongju'
}


def get_hotel_data(url):

    options = webdriver.ChromeOptions()
    options.add_argument('headless')
    options.add_argument('disable-gpu')
    # driverOpen
    driver = webdriver.Chrome('./chromedriver_win32/chromedriver.exe',options=options)
    driver.get(url)
    req = driver.page_source
    soup = BeautifulSoup(req, 'html.parser')

    result = []

    # 다음버튼 누를수있는 횟수 총 10번
    for _ in range(10, 0, -1):
        driver.implicitly_wait(5)  # 5초 대기
        detail_keys = soup.select('ul.lst_hotel > li.ng-scope')
        result.extend([key['id'] for key in detail_keys])

        # 다음버튼을 누른다.
        driver.find_element_by_xpath(
            '/html/body/div/div/div[1]/div[2]/div[6]/div[2]/a[2]').click()

    # 창을 닫는다.
    driver.close()
    return result


def main():
    hotel_keys = []
    for local in local_url.keys():
        hotel_keys.extend(get_hotel_data(local_url[local]))
    return hotel_keys


if __name__ == '__main__':
    main()
