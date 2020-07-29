from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from oauth2client.tools import argparser

DEVELOPER_KEY='발급받은 유튜트 API '
YOUTUBE_API_SERVICE_NAME='youtube'
YOUTUBE_API_VERSION='v3'

# 몽고디비
from pymongo import MongoClient
client = MongoClient('localhost', 27017)
db= client.db_cek_final # db_cek_final 이라는 데이터베이스를 생성 및 호출.


# query: 검색대상
def collect_youtubes(query):

    #크롤링 객체
    youtube= build(YOUTUBE_API_SERVICE_NAME,
                YOUTUBE_API_VERSION,
                developerKey= DEVELOPER_KEY)

    # 검색결과 크롤링
    # q: query(지역이름) + 맛집 : 검색질의어
    # pageToken: 페이지 토큰
    # order: 유튜브 게시글 정렬순서 (최신 영상을 우선순위로함)
    # 영상 코드나 정보를 모두 읽을 수 있음
    # maxResults: 수집하려는 데이터 개수 150
    search_response=youtube.search().list(
        q=query + ' 맛집',
        pageToken='CDIQAA',
        order='date',
        part='snippet',
        maxResults=150
    ).execute()

    #검색대상에 해당하는 데이터를 몽고디비에 넣는다.
    for search_result in search_response.get('items', []):
        if search_result['id']['kind']=='youtube#video':
            #영상 타이틀
            title= search_result['snippet']['title']
            
            # 영상 url
            url_id= search_result['id']['videoId']
            url= 'https://wwww.youtube.com/watch?v='+url_id

            # 영상 썸네일
            photo= search_result['snippet']['thumbnails']['default']['url']

            #영상 description
            description= search_result['snippet']['description']

            #데이터를 넣는다.
            data={
                'location': query,
                'title': title,
                'url': url,
                'photo': photo,
                'description':description
            }

            # youtubes라는 몽고디비 콜렉션에 data를 저장한다.
            db.youtubes.insert_one(data)


def update_youtubes(menu_options):
    # 한도 할당량 제한에 관한 에러
    # Msg googleapiclient.errors.HttpError: 
    # <HttpError 403 when requesting https://www.googleapis.com/youtube/v3/search?q=%EA%B0%95%EB%82%A8%EC%97%AD+%EB%A7%9B%EC%A7%91&pageToken=CDIQAA&order=date&part=snippet&maxResults=50&key=AIzaSyAIVCdh_CLXjeyrB-r46z9EcAuxROUl2xU&alt=json
    #  returned "The request cannot be completed 
    #  because you have exceeded your <a href="/youtube/v3/getting-started#quota">quota</a>.">
    
    # [참고자료]
    # https://stackoverflow.com/questions/47408723/youtube-quotas-exceeded
    # https://cloud.google.com/iam/docs/granting-changing-revoking-access?hl=ko
    
    # youtubes 몽고디비 콜렉션을 비운다.
    db.youtubes.remove({})
    for menu in menu_options:
        collect_youtubes(menu)
        print(menu+'와 관련된 유튜브 데이터 수집 완료')
    print('유튜브데이터 수집 완료!')



def main():
    # 수집이 잘됐는지 미리 테스트
    # (2020.7.29 이전) 맛집 유튜브 영상볼래 버튼을 누를 때마다 유튜브 API를 호출하여 몽고디비에 저장된 영상을 계속 업데이트
    # api 할당량이 exceeded(api 사용 할당량 한도초과)되어 더 이상 api호출을 할 수 없는 문제에 부딪힘.
    
    # (2020.7.29 업데이트 ) API를 이용하여
    # 각 지역의 유튜브 영상 데이터 150개씩를 수집한 뒤
    # mongodb의 youtubes 콜렉션에 영상데이터를 저장한다.
    collect_youtubes('강남역 맛집')
    locations=['강남역', '잠실', '홍대', '건대', '신사동', '압구정', '왕십리', '사당', '방배동', '한남동', '수원역']
    for location in locations:
        collect_youtubes(location)
    print('몽고디비 데이터 수집을 완료 했습니다!')

if __name__=='__main__':
    main()

