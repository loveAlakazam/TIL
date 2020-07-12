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

    #검색결과 크롤링
    search_response=youtube.search().list(
        q=query,
        pageToken='CDIQAA',
        order='date',
        part='snippet',
        maxResults=50
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
    collect_youtubes('강남역 맛집')
    

if __name__=='__main__':
    main()

