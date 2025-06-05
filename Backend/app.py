from flask import Flask, jsonify, request

app = Flask(__name__)

# قائمة بيانات تجريبية
data = [
    {"id": 1, "name": "Alice", "city": "New York"},
    {"id": 2, "name": "Bob", "city": "London"},
    {"id": 3, "name": "Charlie", "city": "Paris"}
]

@app.route('/')
def home():
    """نقطة دخول بسيطة لتأكيد أن السيرفر يعمل."""
    return "Backend is running! Try /api/data"

@app.route('/api/data', methods=['GET'])
def get_data():
    """يرجع بيانات تجريبية بصيغة JSON."""
    return jsonify(data)

@app.route('/api/greet', methods=['GET'])
def greet_backend():
    """يرجع رسالة ترحيب من الـBackend."""
    return jsonify({"message": "Hello from the Backend!"})

if __name__ == '__main__':
    # تشغيل التطبيق على جميع الواجهات (0.0.0.0) وعلى البورت 5000
    # debug=True مفيد للتطوير لأنه بيعيد تحميل السيرفر عند أي تغيير في الكود
    app.run(host='0.0.0.0', port=5000, debug=True)
