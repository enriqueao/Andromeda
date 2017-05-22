import meinheld
import MySQLdb

def waiter(fd):
	meinheld.server.trampoline(fd, read=True, timeout=10)

def app(env, start):
	cont = b"Hello, World\n"
	conn = MySQLdb(user="root", waiter=waiter)
	cur = conn.cursor()
	cur.execute("SELECT SLEEP(2)")
	start(b"200 OK", [('Content-Type', 'text/plain'), ('Content-Length', str(len(cont)))])
	return [cont]

meinheld.server.listen(("127.0.0.1", 8080))
meinheld.server.run(app)