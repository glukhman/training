from flask import Flask, request, jsonify
from multiprocessing import Value

counter = Value('i', 0)
app = Flask(__name__)

@app.route('/posts', methods=['GET'])
def posts():
    if request.method == 'GET':
        with counter.get_lock():
            counter.value += 1
        return jsonify(count=counter.value)
    else:
        return 'Hello, World!'

@app.route('/')
def hello():
    return 'Hello, World!'

