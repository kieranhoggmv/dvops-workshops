import os
import sys
from flask import Flask, jsonify

def greet(name):
    return f"Hello, {name}!"

def add(a, b):
    return a + b

app = Flask(__name__)

@app.route("/")
def home():
    return jsonify({
        "status": "Online",
        "service": "DOEM5",
        "message": greet(f'DOE #{add(2, 5)}')
    }), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
