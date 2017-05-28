-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.1.19-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win32
-- HeidiSQL Versión:             9.4.0.5159
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Volcando estructura de base de datos para andromeda
CREATE DATABASE IF NOT EXISTS `andromeda` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `andromeda`;

-- Volcando estructura para tabla andromeda.andromeda_andromedadevices
CREATE TABLE IF NOT EXISTS `andromeda_andromedadevices` (
  `idAndromeda` int(11) NOT NULL AUTO_INCREMENT,
  `ubicacion` varchar(50) NOT NULL,
  `creado` datetime(6) NOT NULL,
  PRIMARY KEY (`idAndromeda`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.andromeda_andromedadevices: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `andromeda_andromedadevices` DISABLE KEYS */;
REPLACE INTO `andromeda_andromedadevices` (`idAndromeda`, `ubicacion`, `creado`) VALUES
	(1, 'Querétaro', '2017-05-21 00:00:00.000000');
/*!40000 ALTER TABLE `andromeda_andromedadevices` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.andromeda_andromedausers
CREATE TABLE IF NOT EXISTS `andromeda_andromedausers` (
  `idAndromedaUser_id` int(11) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `estatus` int(11) NOT NULL,
  `imagen` varchar(50) NOT NULL,
  `idAndromeda_id` int(11) NOT NULL,
  PRIMARY KEY (`idAndromedaUser_id`),
  KEY `andromeda_andromedau_idAndromeda_id_be0a8f12_fk_andromeda` (`idAndromeda_id`),
  CONSTRAINT `andromeda_andromedau_idAndromedaUser_id_ce46d0c7_fk_auth_user` FOREIGN KEY (`idAndromedaUser_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `andromeda_andromedau_idAndromeda_id_be0a8f12_fk_andromeda` FOREIGN KEY (`idAndromeda_id`) REFERENCES `andromeda_andromedadevices` (`idAndromeda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.andromeda_andromedausers: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `andromeda_andromedausers` DISABLE KEYS */;
REPLACE INTO `andromeda_andromedausers` (`idAndromedaUser_id`, `date_joined`, `estatus`, `imagen`, `idAndromeda_id`) VALUES
	(1, '2017-05-21 15:44:22.526435', 1, 'users.svg', 1),
	(2, '2017-05-21 23:04:14.382843', 1, 'users.svg', 1),
	(3, '2017-05-22 12:44:07.811158', 1, 'users.svg', 1),
	(4, '2017-05-22 14:40:37.573948', 1, 'users.svg', 1);
/*!40000 ALTER TABLE `andromeda_andromedausers` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.andromeda_estadosrecordatorios
CREATE TABLE IF NOT EXISTS `andromeda_estadosrecordatorios` (
  `idEstadoRecordatorio` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(20) NOT NULL,
  PRIMARY KEY (`idEstadoRecordatorio`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.andromeda_estadosrecordatorios: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `andromeda_estadosrecordatorios` DISABLE KEYS */;
REPLACE INTO `andromeda_estadosrecordatorios` (`idEstadoRecordatorio`, `estado`) VALUES
	(1, 'Pendiente'),
	(2, 'Eliminado'),
	(3, 'Completado');
/*!40000 ALTER TABLE `andromeda_estadosrecordatorios` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.andromeda_recordatorios
CREATE TABLE IF NOT EXISTS `andromeda_recordatorios` (
  `idRecordatorio` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) NOT NULL,
  `diaRecordatorio` datetime(6) NOT NULL,
  `fechaCreado` datetime(6) NOT NULL,
  `idAndromedaUser` int(11) NOT NULL,
  `idEstadoRecordatorio` int(11) NOT NULL,
  `idTipoRecordatorio` int(11) NOT NULL,
  `horaRecordar` time(6) DEFAULT NULL,
  PRIMARY KEY (`idRecordatorio`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.andromeda_recordatorios: ~14 rows (aproximadamente)
/*!40000 ALTER TABLE `andromeda_recordatorios` DISABLE KEYS */;
REPLACE INTO `andromeda_recordatorios` (`idRecordatorio`, `descripcion`, `diaRecordatorio`, `fechaCreado`, `idAndromedaUser`, `idEstadoRecordatorio`, `idTipoRecordatorio`, `horaRecordar`) VALUES
	(14, 'hola mundo', '2017-05-22 01:22:41.430464', '2017-05-22 01:22:41.429464', 1, 2, 1, '00:00:00.000000'),
	(15, 'l', '2017-05-22 01:33:18.993236', '2017-05-22 01:33:18.992735', 1, 3, 2, '12:12:00.000000'),
	(16, 'Terminar', '2017-05-22 03:19:16.917195', '2017-05-22 03:19:16.916194', 1, 2, 2, '00:03:00.000000'),
	(17, 'Ejemplo', '2017-05-22 03:55:55.348440', '2017-05-22 03:55:55.346939', 1, 2, 2, '22:58:00.000000'),
	(19, '1234', '2017-05-22 14:41:17.128229', '2017-05-22 14:41:17.127227', 4, 3, 2, '00:03:00.000000'),
	(20, '12', '2017-05-22 14:46:09.540246', '2017-05-22 14:46:09.539246', 4, 1, 2, '00:00:00.000000'),
	(21, '1212', '2017-05-22 15:28:17.302617', '2017-05-22 15:28:17.300618', 4, 1, 2, '10:26:00.000000'),
	(22, 'Hola', '2017-05-22 15:33:15.369468', '2017-05-22 15:33:15.368467', 4, 1, 2, '10:33:00.000000'),
	(23, 'Hola', '2017-05-22 15:33:21.663251', '2017-05-22 15:33:21.662251', 4, 2, 2, '10:33:00.000000'),
	(24, 'Hola', '2017-05-22 15:33:37.816097', '2017-05-22 15:33:37.815096', 4, 2, 1, '10:33:00.000000'),
	(25, 'Hola', '2017-05-22 15:33:50.311145', '2017-05-22 15:33:50.310144', 4, 2, 3, '10:33:00.000000'),
	(26, '', '2017-05-22 15:36:31.024532', '2017-05-22 15:36:31.023531', 1, 2, 2, '10:36:00.000000'),
	(27, 'Hola mike', '2017-05-22 19:52:32.958355', '2017-05-22 19:52:32.957356', 1, 2, 2, '14:52:00.000000'),
	(28, 'Hola mike', '2017-05-22 19:53:25.505922', '2017-05-22 19:53:25.504922', 1, 3, 2, '14:52:00.000000');
/*!40000 ALTER TABLE `andromeda_recordatorios` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.andromeda_tiporecordatorio
CREATE TABLE IF NOT EXISTS `andromeda_tiporecordatorio` (
  `idTipoRecordatorio` int(11) NOT NULL AUTO_INCREMENT,
  `prioridad` varchar(20) NOT NULL,
  PRIMARY KEY (`idTipoRecordatorio`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.andromeda_tiporecordatorio: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `andromeda_tiporecordatorio` DISABLE KEYS */;
REPLACE INTO `andromeda_tiporecordatorio` (`idTipoRecordatorio`, `prioridad`) VALUES
	(1, 'Alta'),
	(2, 'Moderada'),
	(3, 'Baja');
/*!40000 ALTER TABLE `andromeda_tiporecordatorio` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.auth_group
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.auth_group: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.auth_group_permissions
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.auth_group_permissions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.auth_permission
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.auth_permission: ~36 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
REPLACE INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
	(1, 'Can add log entry', 1, 'add_logentry'),
	(2, 'Can change log entry', 1, 'change_logentry'),
	(3, 'Can delete log entry', 1, 'delete_logentry'),
	(4, 'Can add permission', 2, 'add_permission'),
	(5, 'Can change permission', 2, 'change_permission'),
	(6, 'Can delete permission', 2, 'delete_permission'),
	(7, 'Can add group', 3, 'add_group'),
	(8, 'Can change group', 3, 'change_group'),
	(9, 'Can delete group', 3, 'delete_group'),
	(10, 'Can add user', 4, 'add_user'),
	(11, 'Can change user', 4, 'change_user'),
	(12, 'Can delete user', 4, 'delete_user'),
	(13, 'Can add content type', 5, 'add_contenttype'),
	(14, 'Can change content type', 5, 'change_contenttype'),
	(15, 'Can delete content type', 5, 'delete_contenttype'),
	(16, 'Can add session', 6, 'add_session'),
	(17, 'Can change session', 6, 'change_session'),
	(18, 'Can delete session', 6, 'delete_session'),
	(19, 'Can add site', 7, 'add_site'),
	(20, 'Can change site', 7, 'change_site'),
	(21, 'Can delete site', 7, 'delete_site'),
	(22, 'Can add tiporecordatorio', 8, 'add_tiporecordatorio'),
	(23, 'Can change tiporecordatorio', 8, 'change_tiporecordatorio'),
	(24, 'Can delete tiporecordatorio', 8, 'delete_tiporecordatorio'),
	(25, 'Can add andromedadevices', 9, 'add_andromedadevices'),
	(26, 'Can change andromedadevices', 9, 'change_andromedadevices'),
	(27, 'Can delete andromedadevices', 9, 'delete_andromedadevices'),
	(28, 'Can add estados recordatorios', 10, 'add_estadosrecordatorios'),
	(29, 'Can change estados recordatorios', 10, 'change_estadosrecordatorios'),
	(30, 'Can delete estados recordatorios', 10, 'delete_estadosrecordatorios'),
	(31, 'Can add andromeda users', 11, 'add_andromedausers'),
	(32, 'Can change andromeda users', 11, 'change_andromedausers'),
	(33, 'Can delete andromeda users', 11, 'delete_andromedausers'),
	(34, 'Can add recordatorios', 12, 'add_recordatorios'),
	(35, 'Can change recordatorios', 12, 'change_recordatorios'),
	(36, 'Can delete recordatorios', 12, 'delete_recordatorios');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.auth_user
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.auth_user: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
REPLACE INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
	(1, 'pbkdf2_sha256$36000$izxT6GX2A7B7$X8biuMhQI7IL1R7CBzOOCpDuwDkNU3ubmQ3QsKwhUfU=', '2017-05-24 14:50:25.935552', 0, 'enriqueao', 'Enrique Aguilar', '', 'enriqueao96@gmail.com', 0, 1, '2017-05-21 15:44:22.337393'),
	(2, 'pbkdf2_sha256$36000$NcSPxV18x37X$EX6OBckUskEV+9m2bH4/Mw/dwfE/YB8tTFDz60cp0Ok=', '2017-05-21 23:11:34.884835', 0, 'carlos', 'CarlosOrozco', '', 'skyronnersd47@gmail.com', 0, 1, '2017-05-21 23:04:14.060641'),
	(3, 'pbkdf2_sha256$36000$9EkDpMCCrQkh$V+PLe6QDet5Rk/VM1I7Rrx6P1Mg2xTooqijKVEV2ihY=', '2017-05-22 12:46:07.815233', 0, 'nanesdom', 'Daniel Dominguez', '', 'juandanieldomsan.nan@gmail.com', 0, 1, '2017-05-22 12:44:07.542614'),
	(4, 'pbkdf2_sha256$36000$QtFcRWb72o04$J2fjQeWyo7LLofahFOmi+yvQfDfEVuzz25nk+7b7JOY=', '2017-05-22 14:40:49.373996', 0, '1234', '1234', '', '1234', 0, 1, '2017-05-22 14:40:37.392907');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.auth_user_groups
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.auth_user_groups: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.auth_user_user_permissions
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.auth_user_user_permissions: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.django_admin_log
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.django_admin_log: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.django_content_type
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.django_content_type: ~12 rows (aproximadamente)
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
REPLACE INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
	(1, 'admin', 'logentry'),
	(9, 'andromeda', 'andromedadevices'),
	(11, 'andromeda', 'andromedausers'),
	(10, 'andromeda', 'estadosrecordatorios'),
	(12, 'andromeda', 'recordatorios'),
	(8, 'andromeda', 'tiporecordatorio'),
	(3, 'auth', 'group'),
	(2, 'auth', 'permission'),
	(4, 'auth', 'user'),
	(5, 'contenttypes', 'contenttype'),
	(6, 'sessions', 'session'),
	(7, 'sites', 'site');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.django_migrations
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.django_migrations: ~23 rows (aproximadamente)
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
REPLACE INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
	(1, 'contenttypes', '0001_initial', '2017-05-21 15:38:09.344616'),
	(2, 'auth', '0001_initial', '2017-05-21 15:38:21.825364'),
	(3, 'admin', '0001_initial', '2017-05-21 15:38:25.396352'),
	(4, 'admin', '0002_logentry_remove_auto_add', '2017-05-21 15:38:25.578696'),
	(5, 'contenttypes', '0002_remove_content_type_name', '2017-05-21 15:38:26.822099'),
	(6, 'auth', '0002_alter_permission_name_max_length', '2017-05-21 15:38:27.873347'),
	(7, 'auth', '0003_alter_user_email_max_length', '2017-05-21 15:38:28.832631'),
	(8, 'auth', '0004_alter_user_username_opts', '2017-05-21 15:38:28.908656'),
	(9, 'auth', '0005_alter_user_last_login_null', '2017-05-21 15:38:29.600905'),
	(10, 'auth', '0006_require_contenttypes_0002', '2017-05-21 15:38:29.619454'),
	(11, 'auth', '0007_alter_validators_add_error_messages', '2017-05-21 15:38:29.659539'),
	(12, 'auth', '0008_alter_user_username_max_length', '2017-05-21 15:38:30.429302'),
	(13, 'andromeda', '0001_initial', '2017-05-21 15:38:30.732137'),
	(14, 'andromeda', '0002_auto_20170424_2206', '2017-05-21 15:38:31.701441'),
	(15, 'andromeda', '0003_auto_20170515_2231', '2017-05-21 15:38:43.208683'),
	(16, 'andromeda', '0004_auto_20170515_2318', '2017-05-21 15:38:43.404723'),
	(17, 'andromeda', '0005_auto_20170515_2321', '2017-05-21 15:38:44.923082'),
	(18, 'andromeda', '0006_auto_20170521_0930', '2017-05-21 15:38:46.921864'),
	(19, 'andromeda', '0007_auto_20170521_0931', '2017-05-21 15:38:47.167423'),
	(20, 'andromeda', '0008_auto_20170521_0933', '2017-05-21 15:38:47.463963'),
	(21, 'sessions', '0001_initial', '2017-05-21 15:38:48.533096'),
	(22, 'sites', '0001_initial', '2017-05-21 15:38:49.154213'),
	(23, 'sites', '0002_alter_domain_unique', '2017-05-21 15:38:49.579816'),
	(24, 'andromeda', '0009_auto_20170521_1550', '2017-05-21 20:50:57.332917'),
	(25, 'andromeda', '0010_auto_20170521_1723', '2017-05-21 22:23:15.402501'),
	(26, 'andromeda', '0011_auto_20170521_1726', '2017-05-21 22:26:16.666826');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.django_session
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.django_session: ~8 rows (aproximadamente)
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
REPLACE INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
	('37h4983ye3q07b83utrqpuagc7yivlzm', 'M2JiMjE4YWZmMDZmM2M0OTFiOTczMDVjMjNjM2ZiNDRjNGY5NDZjMTp7InVzZXJBbmRyb21lZGEiOnsiaW1hZ2VuIjoidXNlcnMuc3ZnIiwiaWRBbmRyb21lZGEiOjF9LCJpZEFuZHJvbWVkYSI6MSwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSIsInVzZXIiOnsiaWQiOjEsInVzZXJuYW1lIjoiZW5yaXF1ZWFvIiwiZW1haWwiOiJlbnJpcXVlYW85NkBnbWFpbC5jb20ifSwiX2F1dGhfdXNlcl9oYXNoIjoiOGViNTAyZDY1ZTIwNGQ1ZjQ3ZGNhNTY2YjQ4YTUyMGRkNmEzMjg4MCJ9', '2017-06-05 14:23:40.612941'),
	('7tw1gg8u6l055dsjpi0qa6mta0ys2pd6', 'MDZkMDhmOTllNGNiZjNkNDg4MzdmM2E3MWUyZTI1NzNjNmJhYmM4MDp7InVzZXJBbmRyb21lZGEiOnsiaW1hZ2VuIjoidXNlcnMuc3ZnIiwiaWRBbmRyb21lZGEiOjF9LCJ1c2VyIjp7ImlkIjoxLCJ1c2VybmFtZSI6ImVucmlxdWVhbyIsImVtYWlsIjoiZW5yaXF1ZWFvOTZAZ21haWwuY29tIn0sImlkQW5kcm9tZWRhIjoxLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfaGFzaCI6IjhlYjUwMmQ2NWUyMDRkNWY0N2RjYTU2NmI0OGE1MjBkZDZhMzI4ODAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9', '2017-06-04 22:59:01.485679'),
	('9az6946zza840fof00a8ct4iz4bqmggd', 'NTRjMDAwNzgzODE1ZjliNGE4NWQ4ZjRiMDBhMWU5Yzc5MTA4NDc1ZDp7InVzZXIiOnsidXNlcm5hbWUiOiJlbnJpcXVlYW8iLCJpZCI6MSwiZW1haWwiOiJlbnJpcXVlYW85NkBnbWFpbC5jb20ifSwidXNlckFuZHJvbWVkYSI6eyJpZEFuZHJvbWVkYSI6MSwiaW1hZ2VuIjoidXNlcnMuc3ZnIn0sIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4ZWI1MDJkNjVlMjA0ZDVmNDdkY2E1NjZiNDhhNTIwZGQ2YTMyODgwIiwiaWRBbmRyb21lZGEiOjF9', '2017-06-07 14:50:25.990594'),
	('dji42xkckqvt3uukbj7r29ra68nk80tn', 'YWY2ZWJiMWRlNGY3MjUwMWJkZjI1ZmY4NDAxNWQ3NGI0YzRkOTg3Mjp7Il9hdXRoX3VzZXJfaGFzaCI6IjhlYjUwMmQ2NWUyMDRkNWY0N2RjYTU2NmI0OGE1MjBkZDZhMzI4ODAiLCJpZEFuZHJvbWVkYSI6MSwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJ1c2VyIjp7ImlkIjoxLCJ1c2VybmFtZSI6ImVucmlxdWVhbyIsImVtYWlsIjoiZW5yaXF1ZWFvOTZAZ21haWwuY29tIn0sInVzZXJBbmRyb21lZGEiOnsiaW1hZ2VuIjoidXNlcnMuc3ZnIiwiaWRBbmRyb21lZGEiOjF9LCJfYXV0aF91c2VyX2lkIjoiMSJ9', '2017-06-04 21:12:25.361032'),
	('k5vj84ge6dlay0j8dx4xaxonywvm9r7c', 'MjViZWY4YjVmZjhhNGI0ZjkxMDdjYjZlZDEwY2UyYzk0MWE0NjMwNTp7InVzZXIiOnsidXNlcm5hbWUiOiJuYW5lc2RvbSIsImVtYWlsIjoianVhbmRhbmllbGRvbXNhbi5uYW5AZ21haWwuY29tIiwiaWQiOjN9LCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsInVzZXJBbmRyb21lZGEiOnsiaW1hZ2VuIjoidXNlcnMuc3ZnIiwiaWRBbmRyb21lZGEiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJmZmZmYzUyY2ExMGFiMWYzODQ0NGI3MDExMmJlZDVmMjk3YzNhODRjIiwiaWRBbmRyb21lZGEiOjEsIl9hdXRoX3VzZXJfaWQiOiIzIn0=', '2017-06-05 12:44:29.663057'),
	('qbqh7s2x2t751182j6epmhjk6tzf99er', 'NDNjZTJjMjdhNGYyOWU5OTQ2N2Q4OTdhMjJjM2QzYTIyYTFiZmU4Nzp7Il9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiaWRBbmRyb21lZGEiOjEsIl9hdXRoX3VzZXJfaWQiOiIxIiwidXNlckFuZHJvbWVkYSI6eyJpZEFuZHJvbWVkYSI6MSwiaW1hZ2VuIjoidXNlcnMuc3ZnIn0sInVzZXIiOnsidXNlcm5hbWUiOiJlbnJpcXVlYW8iLCJpZCI6MSwiZW1haWwiOiJlbnJpcXVlYW85NkBnbWFpbC5jb20ifSwiX2F1dGhfdXNlcl9oYXNoIjoiOGViNTAyZDY1ZTIwNGQ1ZjQ3ZGNhNTY2YjQ4YTUyMGRkNmEzMjg4MCJ9', '2017-06-05 19:52:05.156984'),
	('ulap8p2ea9wlgifmey61wvoky5y4r7n2', 'MjViZWY4YjVmZjhhNGI0ZjkxMDdjYjZlZDEwY2UyYzk0MWE0NjMwNTp7InVzZXIiOnsidXNlcm5hbWUiOiJuYW5lc2RvbSIsImVtYWlsIjoianVhbmRhbmllbGRvbXNhbi5uYW5AZ21haWwuY29tIiwiaWQiOjN9LCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsInVzZXJBbmRyb21lZGEiOnsiaW1hZ2VuIjoidXNlcnMuc3ZnIiwiaWRBbmRyb21lZGEiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJmZmZmYzUyY2ExMGFiMWYzODQ0NGI3MDExMmJlZDVmMjk3YzNhODRjIiwiaWRBbmRyb21lZGEiOjEsIl9hdXRoX3VzZXJfaWQiOiIzIn0=', '2017-06-05 12:46:07.848232'),
	('x37qu4ts49488a02aiwpihbbijlnz1xn', 'NTRjMDAwNzgzODE1ZjliNGE4NWQ4ZjRiMDBhMWU5Yzc5MTA4NDc1ZDp7InVzZXIiOnsidXNlcm5hbWUiOiJlbnJpcXVlYW8iLCJpZCI6MSwiZW1haWwiOiJlbnJpcXVlYW85NkBnbWFpbC5jb20ifSwidXNlckFuZHJvbWVkYSI6eyJpZEFuZHJvbWVkYSI6MSwiaW1hZ2VuIjoidXNlcnMuc3ZnIn0sIl9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4ZWI1MDJkNjVlMjA0ZDVmNDdkY2E1NjZiNDhhNTIwZGQ2YTMyODgwIiwiaWRBbmRyb21lZGEiOjF9', '2017-06-07 14:50:25.393370');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;

-- Volcando estructura para tabla andromeda.django_site
CREATE TABLE IF NOT EXISTS `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla andromeda.django_site: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
REPLACE INTO `django_site` (`id`, `domain`, `name`) VALUES
	(1, 'example.com', 'example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
