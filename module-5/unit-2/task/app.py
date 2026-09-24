import os
import sys
from flask import Flask, jsonify

app = Flask(__name__)

# Simulating a basic configuration value
VERSION = os.environ.get("APP_VERSION", "1.0.0")

@app.route("/")
def home():
    return jsonify({
        "status": "Online",
        "service": "RetailStream Inventory API",
        "version": VERSION,
        "message": "Welcome to the stable release pool."
    }), 200

@app.route("/health")
def health():
    # Simulating the health check
    return jsonify({
        "status": "Healthy",
        "checks": {
            "database": "Connected",
            "disk_space": "OK"
        }
    }), 200

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 8080))
    app.run(host="0.0.0.0", port=port)
