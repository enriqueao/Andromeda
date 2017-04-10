#!/usr/bin/python
# -*- coding: utf-8 -*-
import pyttsx
import speech_recognition as sr
from SimpleCV import *

def hablar(texto):
    engine = pyttsx.init()
    voices = engine.getProperty('voices')
    rate = engine.getProperty('rate')
    engine.setProperty('rate', rate-40)
    engine.setProperty('voice', voices[2].id)
    engine.say(texto)
    # engine.say('Hola Bienvenido, Comencemos yo soy Andromeda tu asistente en la seguridad, dime tu nombre para poder comenzar.')
    engine.runAndWait()

# Record Audio
def escuchar():
    r = sr.Recognizer()
    with sr.Microphone() as source:
        hablar('Bienvenido, Cual es tu nombre?')
        print('Bienvenido, Cual es tu nombre?')
        audio = r.listen(source)

    # Speech recognition using Google Speech Recognition
    try:
        # for testing purposes, we're just using the default API key
        # to use another API key, use `r.recognize_google(audio, key="GOOGLE_SPEECH_RECOGNITION_API_KEY")`
        # instead of `r.recognize_google(audio)`
        print("You said: " + r.recognize_google(audio))
        hablar('Bienvenido '+r.recognize_google(audio)+' soy Androme da, y sere tu asistente')
    except sr.UnknownValueError:
        hablar('no he podido entenderte, intenta de nuevo')
        escuchar()
    except sr.RequestError as e:
        print("Could not request results from Google Speech Recognition service; {0}".format(e))

escuchar()




# def bienvenido():
#     cam = Camera()
#     threshold = 5.0 # setting an adjustable threshold for motion detection
#     while True:
#         previous = cam.getImage() #get the current image
#         # time.sleep(0.5) #pause for half a second. The 0.5 can be adjusted
#         current = cam.getImage() #get another image
#         diff = current-previous # compute the image difference
#         matrix = diff.getNumpy()
#         mean = matrix.mean()
#         diff.show()
#         if mean >= threshold:
#             escuchar()
#
# bienvenido()
