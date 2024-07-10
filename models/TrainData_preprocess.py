import os
import pickle

import mediapipe as mp
import cv2
import matplotlib.pyplot as plt

#defining dataset directories
DATA_DIR_1 = './ASL_Alphabet_Dataset/asl_alphabet_train'
#DATA_DIR_1 = './temp'
#DATA_DIR_1 = './temp'

#mp_holistic = mp.solutions.holistic
mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils

def image_resize(image, width = None, height = None, inter = cv2.INTER_AREA):
    dim = None
    (h, w) = image.shape[:2]
    if width is None and height is None:
        return image

    if width is None:
        r = height / float(h)
        dim = (int(w * r), height)

    else:
        r = width / float(w)
        dim = (width, int(h * r))
    
    resized = cv2.resize(image, dim, interpolation = inter)
    return resized

def mediapipe_detection(image, model):
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) # COLOR CONVERSION BGR 2 RGB
    image.flags.writeable = False                  # Image is no longer writeable
    results = model.process(image)                 # Make prediction
    image.flags.writeable = True                   # Image is now writeable 
    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR) # COLOR COVERSION RGB 2 BGR
    return image, results

def draw_styled_landmarks(image, results):
    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(image, 
                                      hand_landmarks, 
                                      mp_hands.HAND_CONNECTIONS,
                                      mp_drawing.DrawingSpec(color=(121,22,76), thickness=2, circle_radius=4), 
                                      mp_drawing.DrawingSpec(color=(121,44,250), thickness=2, circle_radius=2))


data = []
labels = []
with mp_hands.Hands(static_image_mode=True, max_num_hands=2, min_detection_confidence=0.5) as hands:
    for dir in os.listdir(DATA_DIR_1):
        num = 0
        for img_path in os.listdir(os.path.join(DATA_DIR_1, dir)):
            data_aux = []
            img = cv2.imread(os.path.join(DATA_DIR_1, dir, img_path))
            if img is None:
                print(os.path.join(DATA_DIR_1, dir, img_path))
                break
            img = image_resize(img, width = 600)
            image, results = mediapipe_detection(img, hands)
            if results.multi_hand_landmarks:
                if results.multi_hand_landmarks:
                    for hand_landmarks in results.multi_hand_landmarks:
                        for i in range(len(hand_landmarks.landmark)):
                            x = hand_landmarks.landmark[i].x
                            y = hand_landmarks.landmark[i].y
                            data_aux.append(x)
                            data_aux.append(y)
                        break
                            
                    data.append(data_aux)
                    labels.append(dir)
            num+=1
            if num%100 == 0:
                print(f"{dir} - {num}")
            #For Plotting
                
                    #draw_styled_landmarks(image, results)
                    #cv2.imshow('OpenCV Feed', image)
                    #cv2.waitKey()
        print("=====================================")
        print("=====================================")
        print(f"{dir} complete")
        print("=====================================")
        print("=====================================")

f = open('data.pickle', 'wb')
pickle.dump({'data': data, 'labels': labels},f)
f.close()