from flask import Flask, render_template, jsonify, request

#몽고디비와 연결 - 포트 27017
from pymongo import MongoClient
client= MongoClient('localhost', 27017)
db= client.ek_samples # 연결된 데이터베이스중 ek_samples와 연결.

app=Flask(__name__)

@app.route('/')
def home():
    return render_template('./join_member.html')


@app.route('/check_mongodb/id', methods=['POST'])
def is_available_id(input_id):
    # 길이가 3이하이라면
    if len(input_id)<=3:
        return False

    print('확인하려는 아이디: ',input_id)
    search_id=db.users.find_one({'id': input_id}, {'_id':False})
    
    # 이미 존재하는 아이디라면
    if search_id is not None:
        return False
    return True



@app.route('/check_id', methods=['POST'])
def check_id():
    input_id= request.form['input_id']

    if len(input_id)<=3:
        # 아이디 길이가 3이하일때
        return jsonify({'result': 'fail', 'error_msg': '길이가 너무 짧습니다! 3글자 이상으로 해주세요!'})
    else:
        # 아이디 길이가 4이상일때
        result=is_available_id(input_id)

        # 이미 존재하는 아이디라면
        if not result:
            return jsonify({'result': 'fail', 'error_msg': '이미 존재하는 아이디 입니다.'})

        return  jsonify({'result': 'success', 'success_msg': '사용 가능한 아이디입니다!'})


@app.route('/join_member', methods=['POST'])
def join_member():
    input_id=request.form['input_id']
    input_pwd=request.form['input_pwd']
    input_name= request.form['input_name']

    member_info={
        'id': input_id,
        'pwd': input_pwd,
        'input_name': input_name
    }

    #몽고디비 users 콜렉션에 등록한다
    db.users.insert_one(member_info)

    print(member_info)
    return jsonify({'result': 'success', 'user_name':input_name})

if __name__=='__main__':
    app.run('0.0.0.0', 5001, debug=True)
