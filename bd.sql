CREATE DATABASE Andromeda;

CREATE TABLE devices(
	dev_id		int(8)	AUTOINCREMENT PRIMARY KEY,
);

CREATE TABLE users(
	user_id		varchar2(16)	PRIMARY KEY,
	user_name	varchar2(40)	NOT NULL,
	user_dev	int(8)			NOT NULL,
	user_isAdm	boolean			NOT NULL,
	FOREIGN KEY (user_dev) REFERENCES devices(dev_id) ON DELETE CASCADE ON UPDATE CASCADE
);

/*Opcional, puede ser un archivo almacenado de manera local*/
CREATE TABLE preferences(
	pref_location	varchar2(30)	DEFAULT NULL,
	pref_localTime	varchar2(6)		DEFAULT NULL,
	pref_user		varchar2(16)	NOT NULL,
	pref_dev		int(8)			NOT NULL,
	CONSTRAINT FOREIGN KEY (pref_user) REFERENCES users(user_id),
	CONSTRAINT FOREIGN KEY (pref_dev) REFERENCES users(user_dev),
	PRIMARY KEY (pref_user, pref_dev)

);

CREATE TABLE userDevices(
	usrDev_id	varchar2(30)		PRIMARY KEY, /*Si se puede obtener MAC del dispositivo*/
	usrDev_user	varchar2(16)		NOT NULL,
	usrDev_dev	int(8)				NOT NULL,
	CONSTRAINT FOREIGN KEY (usrDev_user) REFERENCES users(user_id),
	CONSTRAINT FOREIGN KEY (usrDev_dev) REFERENCES users(user_dev)
);