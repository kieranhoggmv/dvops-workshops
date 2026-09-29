import os
import requests

app_port = os.environ["APP_PORT"]

def test_health_endpoint():
    target_url = os.environ.get("TARGET_URL", f"http://localhost:{app_port}")
    response = requests.get(f"{target_url}/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy"}

def test_payment_endpoint():
    target_url = os.environ.get("TARGET_URL", f"http://localhost:{app_port}")
    response = requests.post(f"{target_url}/api/payment", json={"amount": 100})
    assert response.status_code == 200
    assert response.json()["message"] == "Payment processed successfully"
