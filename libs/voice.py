from gtts import gTTS
from playsound import playsound
import speech_recognition as sr
from pocketsphinx import *
import sys, os, datetime
import pymysql as psql
import pyaudio

# def listen():
#	rec = sr.Recognizer()
#	with sr.Microphone() as src:

modeldir = "..\\..\\..\\..\\..\\..\\python27\\Lib\\site-packages\\pocketsphinx\\model"
print(modeldir)

# Create a decoder with certain model
config = Decoder.default_config()
config.set_string('-hmm', os.path.join(modeldir, 'en-us/en-us'))
config.set_string('-dict', os.path.join(modeldir, 'en-us/cmudict-en-us.dict'))
config.set_string('-kws', 'keyphrase.list')

p = pyaudio.PyAudio()
stream = p.open(format=pyaudio.paInt16, channels=1, rate=16000, input=True, frames_per_buffer=1024)
stream.start_stream()

# Process audio chunk by chunk. On keyword detected perform action and restart search
decoder = Decoder(config)
decoder.start_utt()
while True:
    buf = stream.read(1024)
    decoder.process_raw(buf, False, False)
    if decoder.hyp() != None:
        print "Detected keyword", decoder.hyp(), "restarting search"
        decoder.end_utt()
        decoder.start_utt()


def conectar():
	global conn
	conn = psql.connect(host='localhost', port=3306, user='root', passwd='', db='andromeda')
	global cur 
	cur = conn.cursor()
	print(conn)
	return conn, cur

def terminar(conn, cur):
	conn.close()

def select_recordatorios_dia(id_user, dia):
	cur.execute("SELECT descripcion FROM andromeda_recordatorios WHERE idAndromedaUser_id = '"+id_user+"' AND diaRecordatorio BETWEEN '"+dia+" 00:00:00' AND '"+dia+" 23:59:59' AND idEstadoRecordatorio_id = 1")

def nuevo_recordatorio(descripcion, dia, tipo, id_user):
	cur.execute("INSERT INTO andromeda_recordatorios VALUES(0, '"+descripcion+"', '"+dia+"', '"+str(datetime.now())+"', '"+id_user+"', 1, '"+tipo+"'")

def cambiar_estado_recordatorio(estado, id_user, id_recordatorio):
	cur.execute("UPDATE andromeda_recordatorios SET idEstadoRecordatorio_id = '"+estado+"' WHERE idRecordatorio = '"+id_recordatorio+"'")




tts = gTTS(text="Hola! Soy Andromeda y sere tu asistente virtual.", lang='es-us')
file = 'sample.mp3'
tts.save(file)

playsound('sample.mp3')


Connect.conectar()
print(conn)
Connect.select_recordatorios_dia('1', '2017-05-25')
Connect.terminar()

