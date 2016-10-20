from flask import Flask
from flask import request
from flask import jsonify

import requests
import json
import os

app = Flask(__name__)

@app.route("/")
def get_tasks():
    response = requests.get(os.environ['APP_URL'] + '/json')
    if response.status_code == 200 :
        return jsonify(response.json())

    return jsonify ( { 'ResponseStatusCode': response.status_code } ) 

    
if __name__ == "__main__":
    app.run(debug = True, host = '0.0.0.0')
