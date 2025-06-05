import os
from flask import Flask, jsonify, request
from flask_cors import CORS
import psycopg2

app = Flask(__name__)
CORS(app)

DB_HOST = os.environ.get("DB_HOST", "localhost")
DB_NAME = os.environ.get("DB_NAME", "mydatabase")
DB_USER = os.environ.get("DB_USER", "user")
DB_PASSWORD = os.environ.get("DB_PASSWORD", "password")
DB_PORT = os.environ.get("DB_PORT", "5432")

def get_db_connection():
    try:
        conn = psycopg2.connect(
            host=DB_HOST,
            database=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            port=DB_PORT
        )
        return conn
    except Exception as e:
        print(f"Error connecting to database: {e}")
        return None

@app.route('/')
def home():
    return "Backend is running! Try /api/data"

@app.route('/api/data', methods=['GET'])
def get_data():
    conn = None
    try:
        conn = get_db_connection()
        if conn is None:
            return jsonify({"error": "Failed to connect to database"}), 500

        cur = conn.cursor()
        
        # إنشاء جدول وإدخال بيانات إذا كان الجدول غير موجود
        cur.execute("""
            CREATE TABLE IF NOT EXISTS users (
                id SERIAL PRIMARY KEY,
                name VARCHAR(100) NOT NULL,
                city VARCHAR(100) NOT NULL
            );
        """)
        conn.commit()

        # التحقق مما إذا كان الجدول فارغًا، وإدخال بيانات أولية إذا كان كذلك
        cur.execute("SELECT COUNT(*) FROM users;")
        if cur.fetchone()[0] == 0:
            cur.execute("INSERT INTO users (name, city) VALUES ('Alice', 'New York');")
            cur.execute("INSERT INTO users (name, city) VALUES ('Bob', 'London');")
            cur.execute("INSERT INTO users (name, city) VALUES ('Charlie', 'Paris');")
            conn.commit()

        # سحب البيانات من الجدول
        cur.execute("SELECT id, name, city FROM users;")
        users = cur.fetchall()
        
        # تحويل البيانات لصيغة JSON
        data = [{"id": row[0], "name": row[1], "city": row[2]} for row in users]
        return jsonify(data)

    except Exception as e:
        print(f"Error fetching data from database: {e}")
        return jsonify({"error": f"An error occurred: {e}"}), 500
    finally:
        if conn:
            conn.close()

@app.route('/api/greet', methods=['GET'])
def greet_backend():
    return jsonify({"message": "Hello from the Backend!"})

if __name__ == '__main__':
    conn = None
    try:
        conn = get_db_connection()
        if conn:
            cur = conn.cursor()
            cur.execute("""
                CREATE TABLE IF NOT EXISTS users (
                    id SERIAL PRIMARY KEY,
                    name VARCHAR(100) NOT NULL,
                    city VARCHAR(100) NOT NULL
                );
            """)
            conn.commit()
            print("Database table 'users' ensured exists or created.")
        else:
            print("Could not connect to database on startup for table check.")
    except Exception as e:
        print(f"Error during startup database check: {e}")
    finally:
        if conn:
            conn.close()

    app.run(host='0.0.0.0', port=5000, debug=True)
