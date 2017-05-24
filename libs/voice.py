from gtts import gTTS
from playsound import playsound
import speech_recognition as sr
from pocketsphinx.pocketsphinx import *
from sphinxbase.sphinxbase import *
import sys, os, datetime, pyaudio, time
import pymysql as psql

def escuchar():
	playsound("beep.mp3")
	r = sr.Recognizer()
	m = sr.Microphone()
	with m as src:
		print("Di un comando")
		audio = r.listen(src)

	try:
		speech = rec.recognize_google(audio)
		command = speech.split(' ')
		action(command)
	except sr.UnknownValueError:
		talk('No te he entendido, intenta nuevamente.')
		escuchar()
	except sr.RequestError as e:
		print("Could not request results from Google Speech Recognition service; {0}".format(e))

#def action(command):
#	return {
#		'dime' : say()
#		'di' : say()
#		'crear' : newRemember()
#	}[command]

modeldir = "C:\Python27\Lib\site-packages\pocketsphinx\model"
datadir = "C:\Python27\Lib\site-packages\pocketsphinx\data"
def continuousSpeech():
	print("Di \"Andromeda\" para empezar")
	# Create a decoder with certain model
	config = Decoder.default_config()
	config.set_string('-hmm', os.path.join(modeldir, 'es_ES\\es_ES\\model_parameters\\voxforge_es_sphinx.cd_ptm_4000'))
	config.set_string('-dict', os.path.join(modeldir, 'es_ES\\es_ES\\es.dict'))
	config.set_string('-keyphrase', 'a')
	config.set_float('-kws_threshold', 1e-1)

	# Read from microphone
	 
	p = pyaudio.PyAudio()
	stream = p.open(format=pyaudio.paInt16, channels=1, rate=16000, input=True, frames_per_buffer=1024)
	stream.start_stream()

	# Process audio chunk by chunk. On keyphrase detected perform action and restart search
	decoder = Decoder(config)
	decoder.start_utt()
	while True:
	    buf = stream.read(1024)
	    if buf:
	         decoder.process_raw(buf, False, False)
	    else:
	         break
	    if decoder.hyp() != None:
	        print ("Detected keyphrase, running listen()")
	        decoder.end_utt()
	        stream.stop_stream()
	        stream.close()
	        p.terminate()
	        escuchar()


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

def talk(text):
	tts = gTTS(text=text, lang='es-us')
	file = 'sample.mp3'
	tts.save(file)
	playsound('sample.mp3')

conectar()
continuousSpeech()
terminar()

