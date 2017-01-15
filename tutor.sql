-- MySQL dump 10.13  Distrib 5.7.13, for linux-glibc2.5 (x86_64)
--
-- Host: localhost    Database: tutor
-- ------------------------------------------------------
-- Server version	5.7.16-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permission_group_id_689710a9a73b7457_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth__content_type_id_508cf46651277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can add permission',2,'add_permission'),(5,'Can change permission',2,'change_permission'),(6,'Can delete permission',2,'delete_permission'),(7,'Can add group',3,'add_group'),(8,'Can change group',3,'change_group'),(9,'Can delete group',3,'delete_group'),(10,'Can add user',4,'add_user'),(11,'Can change user',4,'change_user'),(12,'Can delete user',4,'delete_user'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add banner',7,'add_banner'),(20,'Can change banner',7,'change_banner'),(21,'Can delete banner',7,'delete_banner'),(22,'Can add order apply',8,'add_orderapply'),(23,'Can change order apply',8,'change_orderapply'),(24,'Can delete order apply',8,'delete_orderapply'),(25,'Can add parent order',9,'add_parentorder'),(26,'Can change parent order',9,'change_parentorder'),(27,'Can delete parent order',9,'delete_parentorder'),(28,'Can add sys text',10,'add_systext'),(29,'Can change sys text',10,'change_systext'),(30,'Can delete sys text',10,'delete_systext'),(31,'Can add teacher',11,'add_teacher'),(32,'Can change teacher',11,'change_teacher'),(33,'Can delete teacher',11,'delete_teacher'),(34,'Can add auth group',12,'add_authgroup'),(35,'Can change auth group',12,'change_authgroup'),(36,'Can delete auth group',12,'delete_authgroup'),(37,'Can add auth group permissions',13,'add_authgrouppermissions'),(38,'Can change auth group permissions',13,'change_authgrouppermissions'),(39,'Can delete auth group permissions',13,'delete_authgrouppermissions'),(40,'Can add auth permission',14,'add_authpermission'),(41,'Can change auth permission',14,'change_authpermission'),(42,'Can delete auth permission',14,'delete_authpermission'),(43,'Can add auth user',15,'add_authuser'),(44,'Can change auth user',15,'change_authuser'),(45,'Can delete auth user',15,'delete_authuser'),(46,'Can add auth user groups',16,'add_authusergroups'),(47,'Can change auth user groups',16,'change_authusergroups'),(48,'Can delete auth user groups',16,'delete_authusergroups'),(49,'Can add auth user user permissions',17,'add_authuseruserpermissions'),(50,'Can change auth user user permissions',17,'change_authuseruserpermissions'),(51,'Can delete auth user user permissions',17,'delete_authuseruserpermissions'),(52,'Can add django admin log',18,'add_djangoadminlog'),(53,'Can change django admin log',18,'change_djangoadminlog'),(54,'Can delete django admin log',18,'delete_djangoadminlog'),(55,'Can add django content type',19,'add_djangocontenttype'),(56,'Can change django content type',19,'change_djangocontenttype'),(57,'Can delete django content type',19,'delete_djangocontenttype'),(58,'Can add django migrations',20,'add_djangomigrations'),(59,'Can change django migrations',20,'change_djangomigrations'),(60,'Can delete django migrations',20,'delete_djangomigrations'),(61,'Can add django session',21,'add_djangosession'),(62,'Can change django session',21,'change_djangosession'),(63,'Can delete django session',21,'delete_djangosession'),(64,'Can add message',22,'add_message'),(65,'Can change message',22,'change_message'),(66,'Can delete message',22,'delete_message'),(67,'Can add cors model',23,'add_corsmodel'),(68,'Can change cors model',23,'change_corsmodel'),(69,'Can delete cors model',23,'delete_corsmodel');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$IQVQJXrCOSqc$QFdIobbTd9klJqYkLcPLbl4aT3LC/BoIv0MFbIENEro=','2017-01-15 21:55:01.413108',0,'odE4WwK3g05pesjOYGbwcbmOWTnc','','','',0,1,'2016-12-07 12:43:58.781551'),(2,'pbkdf2_sha256$20000$CuHssME6eCaW$86NpUO2L5o4CgyqJK4h4Ej20m+17bO4t7D0pdpLV5uk=','2017-01-15 11:13:56.077153',0,'odE4WwK3g05pesjOYGbwcbmOWTnc2','','','',0,1,'2016-12-07 12:54:24.872888'),(3,'pbkdf2_sha256$20000$Ri2RILF2eOpA$YHWE8/jfUGA5dy8PPVWoIUP8avyYwR7Q0NRSlWrhaVE=','2016-12-07 12:54:49.803428',0,'odE4WwK3g05pesjOYGbwcbmOWTnc23','','','',0,1,'2016-12-07 12:54:49.653798');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_33ac548dcf5f8e37_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_4b5ed4ffdb8fd9b0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_u_permission_id_384b62483d7071f0_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_user_u_permission_id_384b62483d7071f0_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissi_user_id_7f0938558328534a_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `banner` (
  `url` text NOT NULL COMMENT '链接',
  `image_path` text NOT NULL COMMENT '广告图片'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='广告banner';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

LOCK TABLES `banner` WRITE;
/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `corsheaders_corsmodel`
--

DROP TABLE IF EXISTS `corsheaders_corsmodel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `corsheaders_corsmodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cors` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `corsheaders_corsmodel`
--

LOCK TABLES `corsheaders_corsmodel` WRITE;
/*!40000 ALTER TABLE `corsheaders_corsmodel` DISABLE KEYS */;
/*!40000 ALTER TABLE `corsheaders_corsmodel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `djang_content_type_id_697914295151027a_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id` (`user_id`),
  CONSTRAINT `djang_content_type_id_697914295151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_52fdd58701c5f563_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_45f3b1d93ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(12,'api','authgroup'),(13,'api','authgrouppermissions'),(14,'api','authpermission'),(15,'api','authuser'),(16,'api','authusergroups'),(17,'api','authuseruserpermissions'),(7,'api','banner'),(18,'api','djangoadminlog'),(19,'api','djangocontenttype'),(20,'api','djangomigrations'),(21,'api','djangosession'),(22,'api','message'),(8,'api','orderapply'),(9,'api','parentorder'),(10,'api','systext'),(11,'api','teacher'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(23,'corsheaders','corsmodel'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2016-12-04 09:01:36.828923'),(2,'auth','0001_initial','2016-12-04 09:01:36.940450'),(3,'admin','0001_initial','2016-12-04 09:01:36.972136'),(4,'contenttypes','0002_remove_content_type_name','2016-12-04 09:01:37.025409'),(5,'auth','0002_alter_permission_name_max_length','2016-12-04 09:01:37.050093'),(6,'auth','0003_alter_user_email_max_length','2016-12-04 09:01:37.070042'),(7,'auth','0004_alter_user_username_opts','2016-12-04 09:01:37.085260'),(8,'auth','0005_alter_user_last_login_null','2016-12-04 09:01:37.104850'),(9,'auth','0006_require_contenttypes_0002','2016-12-04 09:01:37.106440'),(10,'sessions','0001_initial','2016-12-04 09:01:37.117964'),(11,'api','0001_initial','2016-12-10 05:49:26.616180');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1j703x5oohdz2v9q5gkm94ogq5yx3vu3','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-12-30 16:39:20.517326'),('2kq29lskpmr7er3c1byxqni8axdlmjag','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 21:49:00.014840'),('4609nykjslqvtjzra834qkk1cdqbeha9','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-01-29 11:13:55.934591'),('6afnztymb3d9tcvs0193shfu166flyxz','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 20:37:05.222053'),('8wm0a45ddxpvagdill9i0zajy1gsx1fl','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 21:33:46.087726'),('9qoom9bzznea583y3kc2qlcnpuawkfv2','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 20:35:56.291900'),('g0bysign460zk3tqtwo4ylmvgwoe29xr','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-12-31 21:20:56.242813'),('ij309in1oxiuvlcjqvxktaau0ok7e9b3','ZTUyZGU5NDM1ZWU1ODIyOWFkOWVlZWYzNDIzYzBmMWI4YzBiZWZiMjp7ImluZm8iOnsibmFtZSI6Inl6cyJ9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-01-29 11:10:04.743067'),('jd63za2ca1hy4g1609uyhcq6feig1tnk','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-28 14:32:28.371856'),('lt6e04gorkq0vmr345wcfs1yrt3za9er','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-01-29 21:55:01.476787'),('nltpn1ru2oryxgcfecclrju152vqlnhl','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-12-30 17:16:03.750609'),('oqfykc77mu5raheajnjm082760a8oy1o','ZjhiM2NjZTAwZjY2Zjc3Y2FmN2FlNGNlM2RkMzgwZDFjYzQ4OTZlODp7Il9hdXRoX3VzZXJfaGFzaCI6ImE1OTAzYzVmNzE2MmZlZDEyNThjZjdkMmU0OGNlZjgyN2IwZWFiOTYiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2016-12-31 20:05:27.139372'),('p7fjmuf52cl21p4dzga7akw4hupta8c9','NTJiODMzMjhlMzRkNzUxNjFmNzJmNzFmMDU0Y2M5OTNkYTZmZDMzNDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-01-29 09:52:40.641837'),('pu2kqo40wd4wzualaqtem2a4c7wlewng','ZTUyZGU5NDM1ZWU1ODIyOWFkOWVlZWYzNDIzYzBmMWI4YzBiZWZiMjp7ImluZm8iOnsibmFtZSI6Inl6cyJ9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-01-29 11:09:31.135826'),('ue08665epp2gw297hjd5uk1ewrzuz2lg','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 20:30:11.893679'),('wg82dn6pfueu6djp2a6d49g352w73o9q','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 21:33:10.834978'),('z2k8w0ct2ft1ajyzgqiid44ixjukeciq','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-01-29 11:13:56.122250');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `msg_id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` int(11) DEFAULT NULL,
  `message_content` text,
  `message_title` text,
  `status` tinyint(4) DEFAULT NULL,
  `receiver` int(11) DEFAULT NULL,
  PRIMARY KEY (`msg_id`),
  KEY `fk_message_1_idx` (`sender`),
  KEY `fk_message_2_idx` (`receiver`),
  CONSTRAINT `fk_message_1` FOREIGN KEY (`sender`) REFERENCES `auth_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_2` FOREIGN KEY (`receiver`) REFERENCES `auth_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,1,'teacher2向你报名!',NULL,1,2),(2,2,'None向您发起了邀请!',NULL,1,1),(3,2,'林向您发起了邀请!请到“我的老师”处查看详细信息!','林向您发起了邀请!',0,1),(4,2,'None向您报名!',NULL,0,1);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_apply`
--

DROP TABLE IF EXISTS `order_apply`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_apply` (
  `oa_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增编号',
  `apply_type` tinyint(4) NOT NULL COMMENT '申请的方式(1-老师主动申请 2-家长或管理员主动邀请)',
  `pd_id` int(11) NOT NULL COMMENT '家教需求的id',
  `tea_id` int(11) NOT NULL COMMENT '申请或被邀请的老师id',
  `teacher_willing` tinyint(4) NOT NULL COMMENT '老师的意愿:2-愿意 1-待处理 0-拒绝 (老师主动申请的默认为愿意，被邀请的默认为待处理)',
  `parent_willing` tinyint(4) NOT NULL COMMENT '家长的意愿:2-愿意 1-待处理 0-拒绝 (老师主动申请的默认为待处理，邀请老师的默认为愿意)',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `screenshot_path` text COMMENT '付费截图存储路径',
  `pass_not` tinyint(4) NOT NULL DEFAULT '1' COMMENT '管理员通过与否: 2-是 1-待处理 0-否 (如果管理员选择为否,订单重新置为确认双方willing,本申请不再有效)',
  `expectation` text,
  PRIMARY KEY (`oa_id`),
  KEY `fk_order_apply_parent_order_idx` (`pd_id`),
  KEY `fk_order_apply_teacher1_idx` (`tea_id`),
  CONSTRAINT `fk_order_apply_parent_order` FOREIGN KEY (`pd_id`) REFERENCES `parent_order` (`pd_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_apply_teacher1` FOREIGN KEY (`tea_id`) REFERENCES `teacher` (`tea_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='教师对家教需求申请';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_apply`
--

LOCK TABLES `order_apply` WRITE;
/*!40000 ALTER TABLE `order_apply` DISABLE KEYS */;
INSERT INTO `order_apply` VALUES (4,1,1,16,2,1,'2017-01-15 18:26:19',NULL,1,'很多很多钱');
/*!40000 ALTER TABLE `order_apply` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parent_order`
--

DROP TABLE IF EXISTS `parent_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parent_order` (
  `pd_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `wechat_id` int(11) DEFAULT NULL COMMENT '家长从微信发过来的标识(如果是管理员发布的需求就填''admin''值)',
  `subject` text COMMENT '孩子要提高的科目(英文,隔开)',
  `subject_other` text COMMENT '孩子要提高的科目，其他',
  `aim` text COMMENT '找老师的目的(英文,隔开)',
  `mon_begin` tinyint(4) DEFAULT NULL COMMENT '周一可安排学习的开始时间',
  `mon_end` tinyint(4) DEFAULT NULL COMMENT '周一可安排的学习结束时间',
  `tues_begin` tinyint(4) DEFAULT NULL,
  `tues_end` tinyint(4) DEFAULT NULL,
  `wed_begin` tinyint(4) DEFAULT NULL,
  `wed_end` tinyint(4) DEFAULT NULL,
  `thur_begin` tinyint(4) DEFAULT NULL,
  `thur_end` tinyint(4) DEFAULT NULL,
  `fri_begin` tinyint(4) DEFAULT NULL,
  `fri_end` tinyint(4) DEFAULT NULL,
  `sat_morning` tinyint(4) DEFAULT '0',
  `sat_afternoon` tinyint(4) DEFAULT '0',
  `sat_evening` tinyint(4) DEFAULT '0',
  `sun_morning` tinyint(4) DEFAULT '0',
  `sun_afternoon` tinyint(4) DEFAULT '0',
  `sun_evening` tinyint(4) DEFAULT '0',
  `weekend_tutor_length` tinyint(4) DEFAULT '0' COMMENT '周末每次辅导的时长(默认为0)',
  `teacher_sex` tinyint(4) DEFAULT NULL COMMENT '老师性别:0-不限 1-男 2-女',
  `teacher_method` text COMMENT '老师特色(用$隔开)',
  `teacher_method_other` text,
  `learning_phase` tinyint(4) DEFAULT NULL COMMENT '学习阶段(0-其他 1-幼升小 2-小学 3-初中 4-高中)',
  `class` tinyint(4) DEFAULT NULL COMMENT '年级(0-无 1-一年级 以此类推)',
  `grade` tinyint(4) DEFAULT NULL COMMENT '班级排名(1-较为靠后 2-中等偏下 3-中等水平 4-中上水平 5-名列前茅)',
  `require` text COMMENT '对老师的要求',
  `salary` decimal(20,2) DEFAULT NULL COMMENT '时薪',
  `allowance_not` tinyint(4) DEFAULT '0' COMMENT '是否补贴(1-是 0-否)',
  `deadline` datetime DEFAULT NULL COMMENT '需求最后期限时间',
  `name` text COMMENT '联系人姓名',
  `tel` text COMMENT '联系电话',
  `address` text COMMENT '住址',
  `pass_not` tinyint(4) DEFAULT '1' COMMENT '审核是否通过(1-待审核 0-不通过 2-通过)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `status` tinyint(4) DEFAULT '1' COMMENT '需求状态(1-正常显示欢迎预约 2-已经有心仪的老师等待确认 3-完成结束显示)默认为1',
  `bonus` text COMMENT '福利',
  PRIMARY KEY (`pd_id`),
  KEY `fk_parent_order_1_idx` (`wechat_id`),
  CONSTRAINT `fk_parent_order_1` FOREIGN KEY (`wechat_id`) REFERENCES `auth_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='家长发布的订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent_order`
--

LOCK TABLES `parent_order` WRITE;
/*!40000 ALTER TABLE `parent_order` DISABLE KEYS */;
INSERT INTO `parent_order` VALUES (1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'p1',NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `parent_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_text`
--

DROP TABLE IF EXISTS `sys_text`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_text` (
  `salary_standard` text NOT NULL COMMENT '时薪标准',
  `require_explain` text NOT NULL COMMENT '需求说明'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统文本';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_text`
--

LOCK TABLES `sys_text` WRITE;
/*!40000 ALTER TABLE `sys_text` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_text` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teacher` (
  `tea_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `wechat_id` int(11) DEFAULT NULL COMMENT '微信传送过来的id号',
  `name` text COMMENT '姓名',
  `qualification` tinyint(4) DEFAULT NULL COMMENT '学历状态: 1-本科生 2-研究生 3-毕业生',
  `sex` tinyint(4) DEFAULT NULL COMMENT '性别: 1-男 2-女',
  `native_place` text COMMENT '籍贯',
  `campus_major` text COMMENT '学院专业',
  `tel` text COMMENT '联系电话',
  `subject` text COMMENT '可辅导的科目(用英文,隔开)',
  `subject_other` text,
  `place` text COMMENT '可辅导的地区(用英文,隔开)',
  `teacher_method` text COMMENT '教学方法(用$隔开)',
  `teacher_method_other` text,
  `score` text COMMENT '相关成绩:大学中学获得的成绩、奖项',
  `self_comment` text COMMENT '自我评价',
  `salary_bottom` decimal(20,2) DEFAULT NULL COMMENT '时薪下限',
  `salary_top` decimal(20,2) DEFAULT NULL COMMENT '时薪上限',
  `certificate_photo` text COMMENT '证件照路径(大图就帮它转小到100k以下)',
  `teach_show_photo` text COMMENT '家教show图片路径(用;号隔开)大图要求压缩为100k以下',
  `massage_warn` tinyint(4) DEFAULT '1' COMMENT '是否有消息提醒 1-提醒 0-不提醒(默认是1)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `pass_not` tinyint(4) DEFAULT '1' COMMENT '简历是否审核通过(默认为1) 1-待审核 0-不通过 2-通过 ',
  `mon_begin` tinyint(4) DEFAULT NULL COMMENT '周一可辅导的开始时间(为空即周一没空)',
  `mon_end` tinyint(4) DEFAULT NULL COMMENT '周一可辅导的结束时间',
  `tues_begin` tinyint(4) DEFAULT NULL COMMENT '同周一',
  `tues_end` tinyint(4) DEFAULT NULL COMMENT '同周一',
  `wed_begin` tinyint(4) DEFAULT NULL,
  `wed_end` tinyint(4) DEFAULT NULL,
  `thur_begin` tinyint(4) DEFAULT NULL,
  `thur_end` tinyint(4) DEFAULT NULL,
  `fri_begin` tinyint(4) DEFAULT NULL,
  `fri_end` tinyint(4) DEFAULT NULL,
  `sat_morning` tinyint(4) DEFAULT '1' COMMENT '周六上午 1-有空 0-没空 默认为1',
  `sat_afternoon` tinyint(4) DEFAULT '1' COMMENT '同周六上午',
  `sat_evening` tinyint(4) DEFAULT '1' COMMENT '同周六上午',
  `sun_morning` tinyint(4) DEFAULT '1' COMMENT '同周六上午',
  `sun_afternoon` tinyint(4) DEFAULT '1' COMMENT '同周六上午',
  `sun_evening` tinyint(4) DEFAULT '1' COMMENT '同周六上午',
  `hot_not` tinyint(4) DEFAULT '0' COMMENT '是否设置为热门教师:1-是 0-否(默认为0)',
  `grade` text,
  `number` varchar(45) DEFAULT NULL COMMENT '学号',
  PRIMARY KEY (`tea_id`),
  KEY `fk_teacher_1_idx` (`wechat_id`),
  CONSTRAINT `fk_teacher_1` FOREIGN KEY (`wechat_id`) REFERENCES `auth_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (16,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2017-01-15 17:37:21',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,1,1,1,0,0,NULL,NULL);
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-15 22:09:08
