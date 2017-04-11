import cv2
import sys
import numpy
import os
size = 4
# XML con parametros que determinan el reconocimiento facial
fn_haar = 'haarcascade_frontalface_alt.xml' 
# Carpeta donde se guardaran las imagenes de usuarios reconocidos
fn_dir = 'Faces' 
# Obtiene como parametro el nombre de la persona a quien se reconoce y se guarda en una carpeta aparte
fn_name = sys.argv[1]
path = os.path.join(fn_dir, fn_name)
if not os.path.isdir(path):
    os.mkdir(path)

#Tamanos de imagen
(im_width, im_height) = (256, 256)
haar_cascade = cv2.CascadeClassifier(fn_haar)
#Activamos la camara para captura de video
webcam = cv2.VideoCapture(0)
count = 0
while count < 20:
    (rval, im) = webcam.read()
    im = cv2.flip(im, 1, 0)
    gray = cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)
    mini = cv2.resize(gray, (gray.shape[1] / size, gray.shape[0] / size))
    faces = haar_cascade.detectMultiScale(mini)
    faces = sorted(faces, key=lambda x: x[3])
    if faces:
        face_i = faces[0]
        (x, y, w, h) = [v * size for v in face_i]
        face = gray[y:y + h, x:x + w]
        face_resize = cv2.resize(face, (im_width, im_height))
        pin=sorted([int(n[:n.find('.')]) for n in os.listdir(path)
               if n[0]!='.' ]+[0])[-1] + 1
        cv2.imwrite('%s/%s.png' % (path, pin), face_resize)
        cv2.rectangle(im, (x, y), (x + w, y + h), (0, 255, 0), 3)
        cv2.putText(im, fn_name, (x - 10, y - 10), cv2.FONT_HERSHEY_PLAIN,
            1,(0, 255, 0))
        count += 1
    cv2.imshow('OpenCV', im)
    key = cv2.waitKey(10)
    if key == 27:
        break