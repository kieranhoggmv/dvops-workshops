import os

def main():
    api_url = os.environ.get("API_URL", "http://default-api.internal")
    print(f"FinTech API initialized successfully.")
    print(f"Connected to backend service at: {api_url}")

if __name__ == "__main__":
    main()
