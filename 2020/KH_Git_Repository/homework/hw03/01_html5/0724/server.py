from flask import Flask, render_template, request, jsonify, url_for, redirect

app=Flask(__name__)

@app.route('/')
def index():
    return render_template('productform.html')

@app.route('/access', methods=['POST'])
def access():
    name=request.form['name']
    email=request.form['email']
    url=request.form['url']
    product_name=request.form['product_name']
    product_cnt=request.form['product_cnt']
    product_rank=request.form['product_rank']
    product_etc=request.form['product_etc']
    
    results={
        'name': name,
        'email': email,
        'url': url,
        'product_name': product_name,
        'product_cnt': product_cnt,
        'product_rank': product_rank,
        'product_etc': product_etc
    }
    print(results)
    return render_template('after_submit.html', results=results)
    # return jsonify({'results':results})


if __name__=='__main__':
    app.run('0.0.0.0', port=5001, debug=True)