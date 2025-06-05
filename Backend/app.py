from flask import Flask, jsonify, request
from flask_cors import CORS # 1. استيراد Flask-Cors

app = Flask(__name__)
CORS(app) # 2. تفعيل CORS على التطبيق كله

# قائمة بيانات تجريبية (زي ما هي)
data = [
    {"id": 1, "name": "Alice", "city": "New York"},
    {"id": 2, "name": "Bob", "city": "London"},
    {"id": 3, "name": "Charlie", "city": "Paris"}
]

@app.route('/')
def home():
    return "Backend is running! Try /api/data"

@app.route('/api/data', methods=['GET'])
def get_data():
    return jsonify(data)

@app.route('/api/greet', methods=['GET'])
def greet_backend():
    return jsonify({"message": "Hello from the Backend!"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
