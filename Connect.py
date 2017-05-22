import pymysql as psql

def conectar():
	global conn
	conn = psql.connect(host='localhost', port=3306, user='root', passwd='', db='andromeda')
	global cur 
	cur = conn.cursor()

def terminar(conn, cur):
	conn.close()

def select_recordatorios_dia(id_user, dia):
	cur.execute("SELECT descripcion FROM andromeda_recordatorios WHERE idAndromedaUser_id = '"+id_user+"' AND diaRecordatorio BETWEEN '"+dia+" 00:00:00' AND '"+dia+" 23:59:59' AND idEstadoRecordatorio_id = 1")
	return cur

	    

