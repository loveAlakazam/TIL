# 검색키워드에 알맞는 네이버 블로그 데이터 수집.
import re
import requests
from urllib.parse import urlparse, quote
from bs4 import BeautifulSoup

# 몽고디비에 연결을 한다.
from pymongo import MongoClient
client = MongoClient('localhost', 27017) #로컬호스트 database
db= client.db_cek_final # db_cek_final 이라는 데이터베이스 생성 및 호출

# 블로그에 추출한 텍스트중 불필요한 텍스트를 없애버린다.
def remove_tag(content):
    cleanr= re.compile('<.*?>') # <b></b> 태그 제거
    cleantext1= re.sub(cleanr, '', content)

    cleanr2= re.compile('&.*?;') #&lt; &gt; &quot; 제거 
    cleantext2= re.sub(cleanr2, '', cleantext1)
    return cleantext2


# 네이버 블로그 데이터를 수집한다.
# keyword : 선택옵션 메뉴 - 음식메뉴 이름들
def collect_blogs(keyword):
    client_id = "네이버 블로그검색 API 아이디"
    client_secret = "네이버 블로그검색 API 시크릿"
    
    encText=quote(keyword)

    # 메뉴에 해당하는 블로그 데이터 100개를 가지고온다.
    url = "https://openapi.naver.com/v1/search/blog?query=" + encText +'&display=100'
    result = requests.get(urlparse(url).geturl(),
                        headers={"X-Naver-Client-Id":client_id,
                                "X-Naver-Client-Secret":client_secret})
    # 검색결과를 json으로 둔다.   
    json_obj = result.json()

    # naver blog 검색 api를 통해 얻은 블로그 데이터 (100개)
    blogs= json_obj['items'] 
    
    search_results=[] #검색결과 블로그
    for blog in blogs:
        # 블로그 이름
        title=remove_tag(blog['title'])

        # 블로거 이름
        author=remove_tag(blog['bloggername'])
        
        # 블로그 링크
        url=remove_tag(blog['link'])

        # 메뉴이름: keyword 
        data={
            'title': title,
            'author': author,
            'url': url,
            'menu': keyword
        }
        search_results.append(data)

        #search_results를 몽고디비에 저장한다.
        #정확히말해서는 naver_blogs 라는 콜렉션에 저장한다.
        #콜렉션 naver_blogs가 존재하지 않으면 -> 자동적으로 새로운 콜렉션을 생성하여 -> data를 추가하고
        #콜렉션 naver_blogs가 존재한다면, 콜렉션에 dictionary형태의 데이터(JSON)를 추가한다.
        db.naver_blogs.insert_one(data)
    print(f'naver_blogs 콜렉션에 {keyword} 메뉴에 대한 모든 블로그 데이터를 몽고디비에 삽입 완료!')

def update_db_data(menu_options):
    # 몽고디비의 데이터를 업데이트한다.
    # 기존에 naver_blogs 컬렉션 안에있는 모든 데이터를 지우고 
    db.naver_blogs.remove({}); #조건에 상관없이 모두 지운다.
    for menu_option in menu_options:
        print(menu_option)
        collect_blogs(menu_option)
    print('naver_blogs 콜렉션 데이터 업데이트 완료.')


if __name__=='__main__':
    update_db_data(['고기집', '수제버거'])
