from gtts import gTTS
from playsound import playsound
import speech_recognition as sr
from pocketsphinx.pocketsphinx import *
from sphinxbase.sphinxbase import *
import sys, os, datetime, pyaudio, time
import MySQLdb as mysql

# id_user de prueba, obtener mediante conexion con Andromeda mobile
id_user = '1'

modeldir = "C:\Python27\Lib\site-packages\pocketsphinx\model"
datadir = "C:\Python27\Lib\site-packages\pocketsphinx\data"

def continuousSpeech():
	print("Di \"Andromeda\" para empezar")
	# Create a decoder with certain model
	config = Decoder.default_config()
	config.set_string('-hmm', os.path.join(modeldir, 'es_ES\\es_ES\\model_parameters\\voxforge_es_sphinx.cd_ptm_4000'))
	config.set_string('-dict', os.path.join(modeldir, 'es_ES\\es_ES\\es.dict'))
	config.set_string('-keyphrase', 'andromeda')
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
	        activo=1
	        break
	if activo==1:
		escuchar()
	

def escuchar():
	playsound("beep.mp3")
	r = sr.Recognizer()
	m = sr.Microphone()
	with m as src:
		print("Di un comando")
		audio = r.listen(src)

	try:
		speech = r.recognize_google(audio, language='es-US')
		print(speech)
		action(speech)
	except sr.UnknownValueError:
		talk('No te he entendido, intenta nuevamente.', "error")
		escuchar()
	except sr.RequestError as e:
		print("Could not request results from Google Speech Recognition service; {0}".format(e))

def action(command):
	if command.find('Di') != -1:
		say(command)
	elif command.find('Dime') != -1:
		say(command)
	elif command.find('dime') != -1:
		say(command)
	elif command.find('di') != -1:
		say(command)

def say(command):
	if command.find('recordatorios de hoy') != -1:
		print("say")
		dia = time.strftime("%Y-%m-%d")
		select_recordatorios_dia(id_user, dia)
	elif command.find('todos') != -1:
		select_todos_recordatorios(id_user)

def conectar():
	global conn
	conn = mysql.connect(host='localhost', port=3306, user='root', passwd='', db='andromeda')
	global cur 
	cur = conn.cursor()
	print(conn)
	return conn, cur

def terminar(conn, cur):
	conn.close()

def select_recordatorios_dia(id_user, dia):
	cur.execute("SELECT descripcion FROM andromeda_recordatorios WHERE idAndromedaUser_id = "+id_user+" AND diaRecordatorio BETWEEN '"+dia+" 00:00:00.000000' AND '"+dia+" 23:59:59.999999' AND idEstadoRecordatorio_id = 1")
	data = cur.fetchall()
	i=0
	talk("Hoy tienes que", "hoy")
	for row in data:
		print(row[0])
		talk(row[0], "select"+str(i))
		i = i+1

def select_todos_recordatorios(id_user):
	cur.execute("SELECT descripcion FROM andromeda_recordatorios WHERE idAndromedaUser_id = '"+id_user+"' AND idEstadoRecordatorio_id = 1")
	data = cur.fetchall()
	i=0
	talk("Tus recordatorios son", "all")
	for row in data:
		print(row[0])
		talk(row[0], "all"+str(i))
		i = i+1

def talk(text, filename):
	tts = gTTS(text=text, lang='es-us')
	file = filename+'.mp3'
	tts.save(file)
	playsound(file)
	os.remove(file)

conectar()
continuousSpeech()
terminar(conn, cur)

