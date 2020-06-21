from flask import Flask, request, jsonify, render_template
app=Flask(__name__)

#pymongo module을 넣는다.

# 핵심페이지
@app.route('/')
def mainPage():
    return render_template('main.html')

# 시간대별로 아침/점심/저녁/야식 로 나타낸다.
@app.route('/now', methods=['POST'])
def get_now():
    receive_time=int(request.form['give_time'])
    meal_time=None

    # 5시 ~ 11시 : 아침
    if(receive_time>=5 and receive_time<=11):
        meal_time='아침'
    elif(receive_time>=12 and receive_time<=16):
        meal_time='점심'
    elif(receive_time>=17 and receive_time<=21):
        meal_time='저녁'
    elif((receive_time>=22 and receive_time<24) or (receive_time>=0 and receive_time<5)):
        meal_time='야식'

    return jsonify({'result':'success', 'meal_time': meal_time})



if __name__=='__main__':
    app.run('0.0.0.0', 6500, debug=True)