import cv2
import numpy as np
from flask import Flask, request, jsonify
from io import BytesIO
import base64
from sklearn.cluster import KMeans

app = Flask(__name__)

# Fungsi untuk mendeteksi warna kulit dari gambar
def get_skin_color(frame):
    hsv_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
    lower_skin = np.array([0, 20, 70], dtype=np.uint8)
    upper_skin = np.array([20, 255, 255], dtype=np.uint8)
    skin_mask = cv2.inRange(hsv_frame, lower_skin, upper_skin)
    skin_area = cv2.bitwise_and(frame, frame, mask=skin_mask)
    skin_pixels = frame[skin_mask > 0]
    
    if len(skin_pixels) > 0:
        kmeans = KMeans(n_clusters=1)
        kmeans.fit(skin_pixels)
        skin_color = kmeans.cluster_centers_[0].astype(int)
        return skin_color
    else:
        return None

# Fungsi untuk menentukan warna kulit
def get_skin_color_description(skin_color):
    r, g, b = skin_color
    if r > 150 and g > 120:
        return "Cerah"
    elif r > 100 and g > 80:
        return "Sawo Kuning"
    elif r < 100 and b > 100:
        return "Sawo Matang"
    else:
        return "Gelap"

# Fungsi untuk rekomendasi outfit
def recommend_outfit(skin_description):
    if skin_description == "Cerah":
        return "Outfit Berwarna Putih atau Cerah"
    elif skin_description == "Sawo Kuning":
        return "Outfit Berwarna Sawo Kuning atau Hangat"
    elif skin_description == "Sawo Matang":
        return "Outfit Berwarna Cerah atau Warna Sawo Matang"
    else:
        return "Outfit Berwarna Hitam atau Gelap"

# API untuk menerima gambar dari Flutter dan memprosesnya
@app.route('/process_image', methods=['POST'])
def process_image():
    # Mendapatkan gambar dari request
    img_data = request.files['image'].read()
    np_img = np.frombuffer(img_data, dtype=np.uint8)
    frame = cv2.imdecode(np_img, cv2.IMREAD_COLOR)
    
    # Deteksi warna kulit
    skin_color = get_skin_color(frame)
    if skin_color:
        skin_description = get_skin_color_description(skin_color)
        recommendation = recommend_outfit(skin_description)
    else:
        recommendation = "Warna kulit tidak terdeteksi"
    
    # Mengembalikan rekomendasi ke aplikasi Flutter
    return jsonify({"recommendation": recommendation})

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
