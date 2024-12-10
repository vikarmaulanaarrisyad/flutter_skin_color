import cv2
import numpy as np
from sklearn.cluster import KMeans

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

def recommend_outfit(skin_description):
    if skin_description == "Cerah":
        return "Outfit Berwarna Putih atau Cerah"
    elif skin_description == "Sawo Kuning":
        return "Outfit Berwarna Sawo Kuning atau Hangat"
    elif skin_description == "Sawo Matang":
        return "Outfit Berwarna Cerah atau Warna Sawo Matang"
    else:
        return "Outfit Berwarna Hitam atau Gelap"
