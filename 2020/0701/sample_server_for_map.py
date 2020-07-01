from flask import Flask, render_template, request, jsonify

app=Flask(__name__)

@app.route('/', methods=['GET'])
def main_page():
    return render_template('using_kakao_map_api.html')

@app.route('/show/map', methods=['GET'])
def show_map():
    return jsonify({'result': 'success'})


if __name__=='__main__':
    app.run('0.0.0.0', 포트번호 ,debug=True)
