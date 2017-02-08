-- MySQL dump 10.13  Distrib 5.7.17, for Linux (x86_64)
--
-- Host: localhost    Database: tutor
-- ------------------------------------------------------
-- Server version	5.7.17

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$20000$IQVQJXrCOSqc$QFdIobbTd9klJqYkLcPLbl4aT3LC/BoIv0MFbIENEro=','2017-02-08 19:30:05.182487',0,'odE4WwK3g05pesjOYGbwcbmOWTnc','','','',0,1,'2016-12-07 12:43:58.781551'),(2,'pbkdf2_sha256$20000$CuHssME6eCaW$86NpUO2L5o4CgyqJK4h4Ej20m+17bO4t7D0pdpLV5uk=','2017-01-26 07:14:42.525904',0,'odE4WwK3g05pesjOYGbwcbmOWTnc2','','','',0,1,'2016-12-07 12:54:24.872888'),(3,'pbkdf2_sha256$20000$Ri2RILF2eOpA$YHWE8/jfUGA5dy8PPVWoIUP8avyYwR7Q0NRSlWrhaVE=','2017-01-22 14:35:50.112381',0,'odE4WwK3g05pesjOYGbwcbmOWTnc23','','','',0,1,'2016-12-07 12:54:49.653798'),(4,'pbkdf2_sha256$20000$y4Thh8JT6TFA$ttNZ9nE7MtIs/ndKyVm9E9P6XwCwEs+ZoI54S8epfh8=','2017-01-25 16:58:54.495262',0,'odE4WwK3g05pesjOYGbwcbmOWTnc4','','','',0,1,'2017-01-24 20:49:52.488854'),(5,'pbkdf2_sha256$20000$SmysEYecWYNL$Wvifpex9AyHOD4bmY2jJh5253/XhFpH0+5/JwwdXQs4=','2017-01-26 01:04:30.273563',0,'odE4WwK3g05pesjOYGbwcbmOWTnc5','','','',0,1,'2017-01-24 22:06:25.932930'),(6,'pbkdf2_sha256$20000$vFukI2nIQuRD$FZzhZNLHEAcIo2zV1DB1q7mA5uRK2OfCIZDO2tIQkpk=','2017-01-25 17:24:28.094747',0,'odE4WwK3g05pesjOYGbwcbmOWTnc3','','','',0,1,'2017-01-25 14:43:07.105032'),(7,'pbkdf2_sha256$20000$5xQmcms0W4qN$b6K9dqZsFElycnqyCxaa5Zndyu4nH9v7xNJT79Tus5I=','2017-02-08 19:30:30.179934',1,'yinzishao','','','370953598@qq.com',1,1,'2017-02-05 00:43:26.418460');
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
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(45) DEFAULT NULL,
  `value` text COMMENT '配置相关信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config`
--

LOCK TABLES `config` WRITE;
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` VALUES (1,'salary','更新了薪酬标准');
/*!40000 ALTER TABLE `config` ENABLE KEYS */;
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
INSERT INTO `django_session` VALUES ('0q5rshp5n4f1at6l69sxygbo1aikmvsa','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-02-03 08:29:03.413383'),('0vwv8g6npfibq418ksb6yj7hxecdunem','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-02-09 07:14:38.129413'),('16kqbvu0om8otk55iwm3spe3fcrs3e58','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-06 17:38:24.905033'),('195o2ceg3tgnn96wkmraxs3ajphzbc5q','MWUxZjlhZjM2OTAzODUxYjNjNDRhZDJiZjIwMDUwMWFlNTkzMjkxMjp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiIyNWFiNDc3ZmU1YWFlYmU5ODE4Y2M2MTY0YjAwNzYyNWRhZTM2ZTA2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiNCJ9','2017-02-07 22:10:48.313244'),('1bfzf3ld7erod1357hivqtwizmmwezbo','NDE2NGJhZGYxN2IzZWJlYTI4YzVhYjE1M2EyMTBiYjhiNGRhNGRmYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImQ2YmE5ZTA0NjI4YWExYzYzMjRhZDIyOTMyMmZkNTU5ZjI1MDA4ODEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI3In0=','2017-02-22 19:28:34.582852'),('1j703x5oohdz2v9q5gkm94ogq5yx3vu3','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-12-30 16:39:20.517326'),('2kq29lskpmr7er3c1byxqni8axdlmjag','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 21:49:00.014840'),('3zlskwybne81yz9kjl5mviqef77gaaa9','MjA2NGI3Y2NlMmQwZTUxMmMzYzlhN2Q0ZTMwZWE4NzhjYTRkNDQwODp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiIyYmU1NDczOGU1NDhkYzQ3OWRjZWQxOTNjMTZhZDA1ZWRhMTFiMjY3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiNSJ9','2017-02-09 01:04:21.298325'),('4ie3u0ffqf54ycumbwl866sf6ymzxigu','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-20 13:56:53.377165'),('4skvjp008fnh9segtq1mglmhfaccwkrm','NTJiODMzMjhlMzRkNzUxNjFmNzJmNzFmMDU0Y2M5OTNkYTZmZDMzNDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-01-27 20:07:50.638908'),('59owxed07jmuwo0z9f0syatzeeewyk76','NDE2NGJhZGYxN2IzZWJlYTI4YzVhYjE1M2EyMTBiYjhiNGRhNGRmYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImQ2YmE5ZTA0NjI4YWExYzYzMjRhZDIyOTMyMmZkNTU5ZjI1MDA4ODEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI3In0=','2017-02-22 12:21:56.514428'),('5ny9alzwdtmsktvachjggb9rj39cdrlp','MjA2NGI3Y2NlMmQwZTUxMmMzYzlhN2Q0ZTMwZWE4NzhjYTRkNDQwODp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiIyYmU1NDczOGU1NDhkYzQ3OWRjZWQxOTNjMTZhZDA1ZWRhMTFiMjY3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiNSJ9','2017-02-09 01:04:30.276241'),('5z1uygm5q89gj4jhael87ttuy306lzko','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-09 04:02:51.595280'),('655ugxevll8v09s4x5znmtl6ni4f5rir','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-10 10:37:55.768670'),('6afnztymb3d9tcvs0193shfu166flyxz','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 20:37:05.222053'),('74walrvjaydal70mhjc5oudq3l2pp4xa','MjA2NGI3Y2NlMmQwZTUxMmMzYzlhN2Q0ZTMwZWE4NzhjYTRkNDQwODp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiIyYmU1NDczOGU1NDhkYzQ3OWRjZWQxOTNjMTZhZDA1ZWRhMTFiMjY3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiNSJ9','2017-02-08 02:19:07.563552'),('7ex45sp6yg298k2kf9ouqhkvzursqlbp','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-22 16:43:48.581652'),('7h0rahlb6rfsi63d5kp88apaxiv4b1qa','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-05 19:46:15.198438'),('86edb9l3gfo7n6ujitmz78ysl7gdoojb','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-06 20:36:37.621121'),('8it54gd0ix1045kw9l2vz58lp1ddwlmc','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-05 14:37:08.352598'),('8iw9kpotwun8j7vyyqbso13fvpjz7p4t','MWUxZjlhZjM2OTAzODUxYjNjNDRhZDJiZjIwMDUwMWFlNTkzMjkxMjp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiIyNWFiNDc3ZmU1YWFlYmU5ODE4Y2M2MTY0YjAwNzYyNWRhZTM2ZTA2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiNCJ9','2017-02-08 01:18:22.232644'),('8mttavvi59pjvegpvgfr0jx4vqxortg9','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-07 22:24:04.348168'),('8wm0a45ddxpvagdill9i0zajy1gsx1fl','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 21:33:46.087726'),('9282wtgdkumljig4xqjqxth46kqtojat','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-02 04:28:20.609338'),('9onzjnjk09k501txm68c07u732r2vqa5','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-15 00:01:35.044625'),('9qoom9bzznea583y3kc2qlcnpuawkfv2','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 20:35:56.291900'),('ajbibg7yn5afj1yl5d8gfyd7yrymp12a','NDE2NGJhZGYxN2IzZWJlYTI4YzVhYjE1M2EyMTBiYjhiNGRhNGRmYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImQ2YmE5ZTA0NjI4YWExYzYzMjRhZDIyOTMyMmZkNTU5ZjI1MDA4ODEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI3In0=','2017-02-19 04:37:44.252767'),('awqqpcwr2midty7ysxb1nw5gvu5dwwz0','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-15 03:22:07.296941'),('b0ebnzitm0w1cblp26bg2ohr93v5o6kb','NDE2NGJhZGYxN2IzZWJlYTI4YzVhYjE1M2EyMTBiYjhiNGRhNGRmYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImQ2YmE5ZTA0NjI4YWExYzYzMjRhZDIyOTMyMmZkNTU5ZjI1MDA4ODEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI3In0=','2017-02-21 06:48:17.597760'),('b4bnc0c4ttn8ndsf01838rc8pdjfrm8o','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-01 23:54:55.345722'),('d8ultg2siyoczot45z5ogquzi16fabvr','MjA2NGI3Y2NlMmQwZTUxMmMzYzlhN2Q0ZTMwZWE4NzhjYTRkNDQwODp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiIyYmU1NDczOGU1NDhkYzQ3OWRjZWQxOTNjMTZhZDA1ZWRhMTFiMjY3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiNSJ9','2017-02-08 02:19:16.213694'),('dnoofiibwo8ajkkbtp9ey91v7zxnbv8y','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-02-03 13:35:20.274578'),('dtcljrt59ao1xwbijicbhmcffh31hroe','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-07 02:37:14.272468'),('eypjxra84lo6nyx9x36xjkcavq1ul1tg','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-27 20:07:48.245779'),('f05slm2ms3duxe689n0riceup0c2dyf4','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-02-09 07:14:37.314136'),('fgci3uxf1ohnfb5w1q25azar076fxbm3','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-10 13:46:53.391908'),('g0bysign460zk3tqtwo4ylmvgwoe29xr','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-12-31 21:20:56.242813'),('h52jie0t9xmthpdwy4j7ki6qmlavmjxb','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-01-31 12:34:37.648879'),('h67dl3r3tvg1qm3vcx2kkxr6sypxmmtg','NDE2NGJhZGYxN2IzZWJlYTI4YzVhYjE1M2EyMTBiYjhiNGRhNGRmYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImQ2YmE5ZTA0NjI4YWExYzYzMjRhZDIyOTMyMmZkNTU5ZjI1MDA4ODEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI3In0=','2017-02-19 00:43:30.322905'),('hd3qugahjkzhe4ogt8ii6b567jk07c7c','NTcwYjIzNTRlYjU2ZWM2MWRkMDE5MWEzNDU0NGQyNzIzY2YwNGE3YTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNThhYzAyY2U4MjNhN2JjNWFmNmU2YzIwMzU1YzliN2YxMWNjOTg5IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiNiJ9','2017-02-08 17:24:28.107031'),('imts5iqkfcetfxg8gv38qk8y9qz8qqem','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-10 04:17:58.272268'),('isnk3isyxn3pzzlhzd7fzj9omb1xr9zm','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-07 23:54:35.894251'),('iyejoyog2xgujhk7xqok6o0gvlf5164g','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-29 08:56:04.410318'),('jd63za2ca1hy4g1609uyhcq6feig1tnk','NTJiODMzMjhlMzRkNzUxNjFmNzJmNzFmMDU0Y2M5OTNkYTZmZDMzNDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-01-26 21:24:45.245934'),('jvbk9ab7lrutt4r4iqx9ai9w58zik0ge','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-01-29 13:38:09.955632'),('jyqapezypv7in5qbj2gs8jb4cxsdxr1x','ODA2M2MxMGFlZGE0NGM5ZWNhODY1NTM2NjQwMjAwZDFlY2M1OTliMTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9pZCI6IjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2017-02-02 17:21:54.767154'),('kv7h48fqp7gbjzcywesrbaxifx1qvwzx','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-13 09:04:47.402589'),('kyy2f84o55v8z4w3xnnwwmihvfuavxyn','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-28 14:51:37.172327'),('m758583d2zzy9uukoikxtzne6h6n7ll5','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-15 06:38:22.976267'),('mgmno82iwp92gpofksjuvwbot96nsa7d','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-20 09:10:07.847920'),('mun9hr9gifojxh6ax54hgwszzbt6uw9l','NDE2NGJhZGYxN2IzZWJlYTI4YzVhYjE1M2EyMTBiYjhiNGRhNGRmYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImQ2YmE5ZTA0NjI4YWExYzYzMjRhZDIyOTMyMmZkNTU5ZjI1MDA4ODEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI3In0=','2017-02-22 19:30:30.183851'),('nltpn1ru2oryxgcfecclrju152vqlnhl','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2016-12-30 17:16:03.750609'),('oqfykc77mu5raheajnjm082760a8oy1o','ZjhiM2NjZTAwZjY2Zjc3Y2FmN2FlNGNlM2RkMzgwZDFjYzQ4OTZlODp7Il9hdXRoX3VzZXJfaGFzaCI6ImE1OTAzYzVmNzE2MmZlZDEyNThjZjdkMmU0OGNlZjgyN2IwZWFiOTYiLCJfYXV0aF91c2VyX2lkIjoiMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2016-12-31 20:05:27.139372'),('oqjdyf344ggm09vqxhuc7yujzqniobjr','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-28 14:03:00.013662'),('qe869k2cbkebh8vd29gpr046ij1te4rh','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-06 22:43:43.335403'),('qzxk0ova9pesteoz8zwhkscpgc5tn2mq','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-02-08 00:32:34.757880'),('r1prxi5n0kg1kfe1clcugziygs2uqajt','NTJiODMzMjhlMzRkNzUxNjFmNzJmNzFmMDU0Y2M5OTNkYTZmZDMzNDp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2lkIjoiMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIn0=','2017-01-27 20:08:03.489982'),('rhdqrxqr1z4eo7hqxne1zochugsviy5q','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-09 08:48:57.069213'),('rqom366h4g3on36b8szwz91siblvzy2n','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-01-29 13:37:57.196154'),('rtp7mxs7q1a91j6ilgumdn98z04bhlhj','ODA2M2MxMGFlZGE0NGM5ZWNhODY1NTM2NjQwMjAwZDFlY2M1OTliMTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9pZCI6IjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCJ9','2017-02-08 21:36:21.251612'),('rvklts82fkdxea9ejli3gov7bgkn21uz','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-27 20:08:00.671383'),('s9fj41qb5z6rgatc5i64589t3r0cgx4c','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-28 03:22:13.280295'),('sjl4y7zzlfylhqosdcavqea0gxa6zxsh','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-01-31 16:15:19.529874'),('snpvzpso0wzn87f1cxtlktdz5tak8yri','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-09 12:05:38.283459'),('t2188fbq7pnpwci3a1nx0usmbmiv5guy','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-02-08 00:32:24.926135'),('u5b34759iiy8d29wcvkrqut0xx2sdwsw','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-22 12:41:38.361447'),('ue08665epp2gw297hjd5uk1ewrzuz2lg','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 20:30:11.893679'),('v8284gveyk08k7bzsldl2jz2b6o711f5','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-12 23:20:57.256246'),('vkgd4846lnpvwnrdb460z0cxvq9mvags','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-02-09 07:14:42.528255'),('w53rhhetcv6vbahfivplwelht28tezlc','NDE2NGJhZGYxN2IzZWJlYTI4YzVhYjE1M2EyMTBiYjhiNGRhNGRmYjp7Il9hdXRoX3VzZXJfaGFzaCI6ImQ2YmE5ZTA0NjI4YWExYzYzMjRhZDIyOTMyMmZkNTU5ZjI1MDA4ODEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiI3In0=','2017-02-22 12:42:34.558858'),('wg82dn6pfueu6djp2a6d49g352w73o9q','Mzc0NzExZDE3MTgxZDBmNmRkZmQ1NDVhOTNlZjA0YzQ3NTRiOTYxNjp7Il9hdXRoX3VzZXJfaGFzaCI6Ijc0NWMzNmQ2ZDE1MGQ2OTg3ZmI5ZWJlNGFlMWJjYWJkY2E4YWMwNzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIyIn0=','2017-01-26 21:33:10.834978'),('wgrqvxno27ekkj6zr7aye3iwy8f1cb71','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-08 21:37:01.189678'),('wt5lanw9yx6exvmusz4qk14i2yy4ccva','ODBiOTBiY2U2MWQ3ZGViZmY5YzYxZWEwYjQ4OTFjN2YwMGU2YTllMDp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiI3NDVjMzZkNmQxNTBkNjk4N2ZiOWViZTRhZTFiY2FiZGNhOGFjMDc3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMiJ9','2017-02-09 07:14:38.130239'),('xn6yaf4fkehqnpma8nuqme9rd9imihif','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-08 21:50:00.352436'),('xnudtxxdc9kctzjz50776xa4tsyngevs','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-05 19:56:12.391964'),('z0zcn43xo6q5uuh8b2mmscgpk96i3xr0','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-07 22:23:54.269830'),('zdesun5idakcxa7xhucn9zxi098nnw26','ZWZhNzQ4MTRkOWY5Y2RjMDYzYzUxYmFiOGRjYmRmZTM2ZjNhMDczYTp7ImluZm8iOnsicHJvdmluY2UiOiJHdWFuZ2RvbmciLCJvcGVuaWQiOiJvZEU0V3dLM2cwNXBlc2pPWUdid2NibU9XVG5jIiwiaGVhZGltZ3VybCI6Imh0dHA6Ly93eC5xbG9nby5jbi9tbW9wZW4vZlI0MVZiaWNybnRpYnhoTlkzV2ZhS2dIQlRiZTFkNkd6MHRQamhIcGljd0plckppYUFpY3RmSGlhTGlhcUNjVklzNUVLT3pzRDR5YWlhZHlVSVVISzJMdTA3SzlFcUFydGlhbFZKZDRiLzAiLCJsYW5ndWFnZSI6InpoX0NOIiwiY2l0eSI6Ill1bmZ1IiwicHJpdmlsZWdlIjpbXSwiY291bnRyeSI6IkNOIiwibmlja25hbWUiOiJcdTVjMzlcdTViNTBcdTUyZmEiLCJzZXgiOjF9LCJfYXV0aF91c2VyX2hhc2giOiJhNTkwM2M1ZjcxNjJmZWQxMjU4Y2Y3ZDJlNDhjZWY4MjdiMGVhYjk2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2lkIjoiMSJ9','2017-02-07 09:41:07.427811');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wechat` int(11) DEFAULT NULL,
  `tutorService` text,
  `appService` text,
  `rate` float DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_feedback_1_idx` (`wechat`),
  CONSTRAINT `fk_feedback_1` FOREIGN KEY (`wechat`) REFERENCES `auth_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (1,1,'teacher2向你报名!',NULL,1,2),(2,2,'None向您发起了邀请!',NULL,1,1),(3,2,'李素向您发起了邀请!请到“我的老师”处查看详细信息!','李素向您发起了邀请!',0,1),(4,1,'teacher2向您报名!请到“我的老师”处查看详细信息!','teacher2向您报名!',0,2),(5,2,'李素向您报名!请到“我的老师”处查看详细信息!','李素向您报名!',0,1),(6,2,'李素取消了报名!','李素取消了报名!',0,2),(7,2,'李素向您报名!请到“我的老师”处查看详细信息!','李素向您报名!',0,1),(8,2,'diang接受了你的报名！请到“我的家长”处查看详细信息!','diang接受了你的报名！',0,1),(9,2,'李素向您报名!请到“我的老师”处查看详细信息!','李素向您报名!',0,1),(10,2,'李素向您报名!请到“我的老师”处查看详细信息!','李素向您报名!',0,1),(11,1,'teacher2向您报名!请到“我的老师”处查看详细信息!','teacher2向您报名!',0,1),(12,1,'teacher2取消了报名!','teacher2取消了报名!',0,1),(13,1,'teacher2向您报名!请到“我的老师”处查看详细信息!','teacher2向您报名!',0,1),(14,1,'teacher2取消了报名!','teacher2取消了报名!',0,1),(15,1,'teacher2向您报名!请到“我的老师”处查看详细信息!','teacher2向您报名!',0,1),(16,1,'teacher2取消了报名!','teacher2取消了报名!',0,1),(17,1,'teacher2向您报名!请到“我的老师”处查看详细信息!','teacher2向您报名!',0,1),(18,1,'teacher2取消了报名!','teacher2取消了报名!',0,1),(19,1,'teacher2向您报名!请到“我的老师”处查看详细信息!','teacher2向您报名!',0,1),(20,1,'teacher2取消了报名!','teacher2取消了报名!',0,1),(21,1,'teacher2向您报名!请到“我的老师”处查看详细信息!','teacher2向您报名!',0,1),(22,1,'李素珍向您报名!请到“我的老师”处查看详细信息!','李素珍向您报名!',0,2),(23,1,'李素珍取消了报名!','李素珍取消了报名!',0,1),(24,5,'parentOrder5向您发起了邀请!请到“我的家长”处查看详细信息!','parentOrder5向您发起了邀请!',0,4),(25,1,'李素向您发起了邀请!请到“我的家长”处查看详细信息!','李素向您发起了邀请!',0,2),(26,1,'李素取消了邀请!','李素取消了邀请!',0,2),(27,1,'李素向您发起了邀请!请到“我的家长”处查看详细信息!','李素向您发起了邀请!',0,2),(28,1,'丁丁向您报名!请到“我的老师”处查看详细信息!','丁丁向您报名!',0,1),(29,1,'丁丁取消了报名!','丁丁取消了报名!',0,1),(30,1,'丁丁向您报名!请到“我的老师”处查看详细信息!','丁丁向您报名!',0,1),(31,1,'李素取消了邀请!','李素取消了邀请!',0,2),(32,1,'李素向您发起了邀请!请到“我的家长”处查看详细信息!','李素向您发起了邀请!',0,2),(33,1,'李素取消了邀请!','李素取消了邀请!',0,2),(34,1,'李素向您发起了邀请!请到“我的家长”处查看详细信息!','李素向您发起了邀请!',0,4),(35,1,'李素取消了邀请!','李素取消了邀请!',0,4),(36,1,'李素向您发起了邀请!请到“我的家长”处查看详细信息!','李素向您发起了邀请!',0,2),(37,1,'李素取消了邀请!','李素取消了邀请!',0,2),(38,1,'李素向您发起了邀请!请到“我的家长”处查看详细信息!','李素向您发起了邀请!',0,2),(39,1,'李素取消了邀请!','李素取消了邀请!',0,2),(40,1,'李素向您发起了邀请!请到“我的家长”处查看详细信息!','李素向您发起了邀请!',0,2),(41,1,'李素取消了邀请!','李素取消了邀请!',0,2),(42,1,'李素向您发起了邀请!请到“我的家长”处查看详细信息!','李素向您发起了邀请!',0,4),(43,1,'hh取消了报名!','hh取消了报名!',0,1),(44,1,'hh向您报名!请到“我的老师”处查看详细信息!','hh向您报名!',0,1);
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
  `finished` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`oa_id`),
  KEY `fk_order_apply_parent_order_idx` (`pd_id`),
  KEY `fk_order_apply_teacher1_idx` (`tea_id`),
  CONSTRAINT `fk_order_apply_parent_order` FOREIGN KEY (`pd_id`) REFERENCES `parent_order` (`pd_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_apply_teacher1` FOREIGN KEY (`tea_id`) REFERENCES `teacher` (`tea_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8 COMMENT='教师对家教需求申请';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_apply`
--

LOCK TABLES `order_apply` WRITE;
/*!40000 ALTER TABLE `order_apply` DISABLE KEYS */;
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
  `subject_other` text,
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
  `bonus` text,
  `learning_phase` tinyint(4) DEFAULT NULL COMMENT '学习阶段(0-其他 1-幼升小 2-小学 3-初中 4-高中)',
  `class` tinyint(4) DEFAULT NULL COMMENT '班级排名(1-较为靠后 2-中等偏下 3-中等水平 4-中上水平 5-名列前茅)',
  `grade` text COMMENT '年级(0-无 1-一年级 以此类推)',
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
  PRIMARY KEY (`pd_id`),
  KEY `fk_parent_order_1_idx` (`wechat_id`),
  CONSTRAINT `fk_parent_order_1` FOREIGN KEY (`wechat_id`) REFERENCES `auth_user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8 COMMENT='家长发布的订单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parent_order`
--

LOCK TABLES `parent_order` WRITE;
/*!40000 ALTER TABLE `parent_order` DISABLE KEYS */;
INSERT INTO `parent_order` VALUES (56,4,'奥数','','陪读',NULL,NULL,NULL,NULL,NULL,NULL,3,9,NULL,NULL,1,1,1,1,1,1,3,0,'亲和力强','','',2,3,'一年级','我真的不知道',20.00,0,'2017-02-08 00:00:00','李素','13532555118','广州',1,'2017-01-25 19:43:04','2017-01-25 19:44:30',1),(57,1,'奥数','','陪读',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,2,7,0,1,1,0,0,0,0,0,'亲和力强','','阿士大夫的',2,2,'一年级','打算打发',40.00,1,'2017-01-31 00:00:00','李素','13532555118','广州',1,'2017-01-26 09:53:24','2017-01-26 09:53:24',1),(58,7,'数学','','打基础',NULL,NULL,5,10,NULL,NULL,5,9,NULL,NULL,0,1,0,0,0,0,2,0,'亲和力强','','',2,2,'一年级','好老师',40.00,0,'2017-02-22 00:00:00','Susan','13532555118','广州',1,'2017-02-06 08:51:36','2017-02-06 08:51:36',1);
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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES (8,2,'李素',1,1,'广州','计算机','18826103726','数学,英语,语文','','广州','严厉要求,亲和力强','','看得见风了','看得见风',30.00,60.00,'','',1,'2017-01-18 12:04:39',1,3,8,2,7,4,10,NULL,NULL,NULL,NULL,1,1,1,1,1,1,0,'小学1年级,小学3年级','201410002426'),(18,1,'1',1,1,'广州','计算机','18826103726','','','广州','','','哈哈哈','哈哈',30.00,60.00,NULL,NULL,1,'2017-01-26 09:48:09',1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,4,10,0,1,0,1,1,0,0,'','20141002426'),(19,7,'当当',1,1,'广州','计算机','18826103726','英语,数学','','广州','严厉要求','','哈哈哈','哈哈',30.00,60.00,'data:image/jpeg;base64,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',NULL,1,'2017-02-06 00:00:00',1,NULL,NULL,5,9,NULL,NULL,NULL,NULL,NULL,NULL,1,0,0,0,0,0,0,'小学3年级,小学5年级','20141002426');
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

-- Dump completed on 2017-02-08 19:44:49
