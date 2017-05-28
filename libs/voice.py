from gtts import gTTS
from playsound import playsound
import speech_recognition as sr
from pocketsphinx.pocketsphinx import *
from sphinxbase.sphinxbase import *
import sys, os, datetime, pyaudio, time
import MySQLdb as mysql
from datetime import datetime, timedelta
import threading

# id_user de prueba, obtener mediante conexion con Andromeda mobile
id_user = 1
andromeda_id = 1

modeldir = "C:\Python27\Lib\site-packages\pocketsphinx\model"
datadir = "C:\Python27\Lib\site-packages\pocketsphinx\data"

aud=0
sels = 0
al = 0

def continuousSpeech(id_user):
	global aud
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
	        hour = time.strftime("%H:%M:%S")
	        day = time.strftime("%Y-%m-%d")
	        hr = datetime.strptime(hour, "%H:%M:%S")
	        interval = hr+timedelta(minutes=1)
	        interval = interval.strftime("%H:%M:%S")
	        cur.execute("SELECT idRecordatorio, horaRecordar, descripcion FROM andromeda_recordatorios WHERE idAndromedaUser = "+str(id_user)+" AND idEstadoRecordatorio = 1 AND diaRecordatorio BETWEEN '"+day+" 00:00:00.000000' AND '"+day+" 23:59:59.999999' AND horaRecordar BETWEEN '"+hour+".000000' AND '"+interval+".999999' ORDER BY diaRecordatorio, horaRecordar")
	        data = cur.fetchall()
	        if not data:
	        	a = 0
	        else:
        		playsound("notify.mp3")
        		talk("Recordatorio programado.", "nowa"+str(aud))
        		for row in data:
        			talk(row[2], "now0"+str(aud))
        			talk("Que deseas hacer?", "action"+str(aud))
        			r = sr.Recognizer()
        			m = sr.Microphone()
        			with m as src:
        				playsound("beep.mp3")
        				print("Di un comando")
        				audio = r.listen(src)
					try:
						speech = r.recognize_google(audio, language='es-US')
						print(speech)
					except sr.UnknownValueError:
						talk('No te he entendido, intenta nuevamente.', "error"+str(aud))
					except sr.RequestError as e:
						print("Could not request results from Google Speech Recognition service; {0}".format(e))
					if speech.find("Descartar") != -1:
						cur.execute("UPDATE andromeda_recordatorios SET idEstadoRecordatorio = 3 WHERE idRecordatorio = '"+str(row[0])+"'")
						talk("Recordatorio descartado", "descartado"+str(aud))
						conn.commit()
					elif speech.find("descartar") != -1:
						cur.execute("UPDATE andromeda_recordatorios SET idEstadoRecordatorio = 3 WHERE idRecordatorio = '"+str(row[0])+"'")
						talk("Recordatorio descartado", "descartado"+str(aud))
						conn.commit()
					elif speech.find("Descargar") != -1:
						cur.execute("UPDATE andromeda_recordatorios SET idEstadoRecordatorio = 3 WHERE idRecordatorio = '"+str(row[0])+"'")
						talk("Recordatorio descartado", "descartado"+str(aud))
						conn.commit()
					elif speech.find("descartgr") != -1:
						cur.execute("UPDATE andromeda_recordatorios SET idEstadoRecordatorio = 3 WHERE idRecordatorio = '"+str(row[0])+"'")
						talk("Recordatorio descartado", "descartado"+str(aud))
						conn.commit()
					elif speech.find("Posponer") != -1:
						hr = datetime.strptime(hour, "%H:%M:%S")
						interval = hr+timedelta(minutes=10)
						interval = interval.strftime("%H:%M:%S")
						cur.execute("UPDATE andromeda_recordatorios SET horaRecordar = '"+interval+".000000' WHERE idRecordatorio = '"+str(row[0])+"'")
						talk("Recordatorio pospuesto, te recordare en diez minutos", "pospon"+str(aud))
						conn.commit()
					elif speech.find("posponer") != -1:
						hr = datetime.strptime(hour, "%H:%M:%S")
						interval = hr+timedelta(minutes=10)
						interval = interval.strftime("%H:%M:%S")
						cur.execute("UPDATE andromeda_recordatorios SET horaRecordar = '"+interval+".000000' WHERE idRecordatorio = '"+str(row[0])+"'")
						talk("Recordatorio pospuesto, te recordare en diez minutos", "pospon"+str(aud))
						conn.commit()
					aud+=1
				break
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
	r = sr.Recognizer()
	m = sr.Microphone()
	with m as src:
		playsound("beep.mp3")
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
	elif command.find('Salir') != -1:
		terminar(conn, cur)
		exit()
	elif command.find('salir') != -1:
		terminar(conn, cur)
		exit()

def say(command):
	if command.find('recordatorios de hoy') != -1:
		dia = time.strftime("%Y-%m-%d")
		select_recordatorios_dia(id_user, dia)
	elif command.find('todos') != -1:
		select_todos_recordatorios(id_user)
	elif command.find('tu id') != -1:
		talk("El ID de tu dispositivo andromeda es: "+str(andromeda_id))
	elif command.find('tu ID') != -1:
		talk("El ID de tu dispositivo andromeda es: "+str(andromeda_id), "id")
	

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
	global sels
	cur.execute("SELECT descripcion, horaRecordar FROM andromeda_recordatorios WHERE idAndromedaUser = "+str(id_user)+" AND diaRecordatorio BETWEEN '"+dia+" 00:00:00.000000' AND '"+dia+" 23:59:59.999999' AND idEstadoRecordatorio = 1")
	data = cur.fetchall()
	if not data:
		talk("No tienes recordatorios para hoy.", "hoy"+str(sels))
	else:
		talk("Hoy tienes que", "hoy"+str(sels))
		for row in data:
			hr, mins, segs = convert_timedelta(row[1])
			strtime = "A las"+str(hr)+" horas, con "+str(mins)+" minutos"
			talk(row[0]+strtime, "select"+str(sels))
	sels = sels+1

def select_todos_recordatorios(id_user):
	global al
	cur.execute("SELECT descripcion, horaRecordar, diaRecordatorio FROM andromeda_recordatorios WHERE idAndromedaUser = "+str(id_user)+" AND idEstadoRecordatorio = 1")
	data = cur.fetchall()
	if not data:
		talk("No tienes recordatorios pendientes.", "all"+str(al))
	else:
		i=0
		talk("Tus recordatorios son", "all"+str(al))
		for row in data:
			dy = get_weekday(row[2].weekday())
			day = row[2].day
			month = get_month(row[2].month)
			year = get_year(row[2].year)
			date = (". El "+dy+", "+str(day)+" de "+month+" de dos mil"+str(year))
			hr, mins, segs = convert_timedelta(row[1])
			strtime = ". A las"+str(hr)+" horas, con "+str(mins)+" minutos"
			talk(row[0]+date+strtime, "all"+str(al))
	al = al+1

def get_year(year):
	return{
		2017 : "Diecisiete",
		2018 : "Dieciocho",
		2019 : "Diecinueve",
		2020 : "Veinte",
		2021 : "Veintiuno",
		2022 : "Veintidos",
		2023 : "Veintitres",
		2024 : "Veinticuatro",
		2025 : "Veinticinco",
		2026 : "Veintiseis",
		2027 : "Veintisiete",
		2028 : "Veintiocho",
		2029 : "Veintinueve",
		2030 : "Treinta",
		2031 : "Teinta y uno"
	}[year]

def get_month(month):
	return{
		1 : "Enero",
		2 : "Febrero",
		3 : "Marzo",
		4 : "Abril",
		5 : "Mayo",
		6 : "Junio",
		7 : "Julio",
		8 : "Agosto",
		9 : "Septiembre",
		10 : "Octubre",
		11: "Noviembre",
		12 : "Diciembre",
	}[month]

def get_weekday(day):
	return{
		7 : "Lunes",
		1 : "Martes",
		2 : "Miercoles",
		3 : "Jueves",
		4 : "Viernes",
		5 : "Sa bado",
		6 : "Domingo"
	}[day]

def talk(text, filename):
	tts = gTTS(text=text, lang='es-us')
	file = filename+'.mp3'
	tts.save(file)
	playsound(file)
	os.remove(file)

def convert_timedelta(duration):
    days, seconds = duration.days, duration.seconds
    hours = days * 24 + seconds // 3600
    minutes = (seconds % 3600) // 60
    seconds = (seconds % 60)
    return hours, minutes, seconds

	
	
def main():
	conectar()
	while True: 
		continuousSpeech(id_user)
	terminar(conn, cur)

main()