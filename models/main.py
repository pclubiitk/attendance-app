import pickle
import numpy as np
import cv2
import mediapipe as mp
from zipfile import ZipFile 

with ZipFile("./model.zip", 'r') as zObject:  
    zObject.extract( 
        "model.p", path="./") 
zObject.close() 

model= pickle.load(open('./model.p', 'rb'))['model']
capture = cv2.VideoCapture(0)

mp_hands = mp.solutions.hands
mp_drawing = mp.solutions.drawing_utils
mp_drawing_styles = mp.solutions.drawing_styles

hands = mp_hands.Hands(static_image_mode=True, min_detection_confidence=0.5)

while True:
    data_aux = []
    x_ = []
    y_ = []

    ret, frame = capture.read()
    H, W, _ = frame.shape

    frame_rgb = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)

    results = hands.process(frame_rgb)
    if results.multi_hand_landmarks:
        for hand_landmarks in results.multi_hand_landmarks:
            mp_drawing.draw_landmarks(frame, 
                                      hand_landmarks, 
                                      mp_hands.HAND_CONNECTIONS,
                                      mp_drawing.DrawingSpec(color=(121,22,76), thickness=2, circle_radius=4), 
                                      mp_drawing.DrawingSpec(color=(121,44,250), thickness=2, circle_radius=2))

        for hand_landmarks in results.multi_hand_landmarks:
            for i in range(len(hand_landmarks.landmark)):
                x = hand_landmarks.landmark[i].x
                y = hand_landmarks.landmark[i].y

                x_.append(x)
                y_.append(y)

            for i in range(len(hand_landmarks.landmark)):
                x = hand_landmarks.landmark[i].x
                y = hand_landmarks.landmark[i].y
                data_aux.append(x - min(x_))
                data_aux.append(y - min(y_))

        x1 = int(min(x_) * W) - 10
        y1 = int(min(y_) * H) - 10
        x2 = int(max(x_) * W) - 10
        y2 = int(max(y_) * H) - 10

        data_aux = data_aux[:42]
        prediction = model.predict([np.asarray(data_aux)])

        if len(prediction):
            predicted_character = prediction[0]

            cv2.rectangle(frame, (x1, y1), (x2, y2), (0, 0, 0), 4)
            cv2.putText(frame, predicted_character, (x1, y1 - 10), cv2.FONT_HERSHEY_SIMPLEX, 1.3, (0, 0, 0), 3,
                        cv2.LINE_AA)

    cv2.imshow('frame', frame)
    cv2.waitKey(1)
    if cv2.waitKey(10) & 0xFF == ord('q'):
            break

capture.release()
cv2.destroyAllWindows()