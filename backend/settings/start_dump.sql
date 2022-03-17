-- MySQL dump 10.19  Distrib 10.3.34-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: marketplace
-- ------------------------------------------------------
-- Server version	10.3.34-MariaDB-0ubuntu0.20.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `manager`
--

DROP TABLE IF EXISTS `manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `manager` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(50) NOT NULL DEFAULT '',
  `password` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL DEFAULT '',
  `make_save_graph` tinyint(3) unsigned NOT NULL DEFAULT 0 COMMENT 'может пополнять библиотеку фигур',
  PRIMARY KEY (`id`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager`
--

LOCK TABLES `manager` WRITE;
/*!40000 ALTER TABLE `manager` DISABLE KEYS */;
INSERT INTO `manager` VALUES (1,'admin','98224fb713a53cb53eb8b666b8de679bd1ae8eb622df3451afdbcc2dc9f8c9b2','Администратор',1);
/*!40000 ALTER TABLE `manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obj_library`
--

DROP TABLE IF EXISTS `obj_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obj_library` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `header` varchar(100) NOT NULL DEFAULT '',
  `manager_id` int(10) unsigned DEFAULT NULL,
  `registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `object` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obj_library`
--

LOCK TABLES `obj_library` WRITE;
/*!40000 ALTER TABLE `obj_library` DISABLE KEYS */;
INSERT INTO `obj_library` VALUES (8,'Зелёный прямоугольник',1,'2022-03-16 11:35:54','{\"x\": 113.69565217391312, \"y\": 243.0978260869564, \"rotate\": 0, \"width\": 377, \"height\": 323, \"isDragging\": false, \"selected\": true, \"isResize\": false, \"type\": \"rectangle\", \"lineWidth\": 2, \"border_color\": \"#0000FF\", \"need_border\": true, \"text\": \"\\u0422\\u0435\\u043a\\u0441\\u0442\", \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#109312\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 20, \"font_family\": \"Serif\", \"font_x\": 20, \"font_stroke\": false, \"font_y\": 80}'),(10,'Чёрный квадрат',1,'2022-03-16 11:37:15','{\"x\": 438.75, \"y\": 282.5, \"rotate\": 0, \"width\": 200, \"height\": 200, \"isDragging\": false, \"selected\": true, \"isResize\": false, \"type\": \"square\", \"lineWidth\": 2, \"border_color\": \"#0000FF\", \"need_border\": true, \"text\": \"\\u0422\\u0435\\u043a\\u0441\\u0442\", \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#000000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 20, \"font_family\": \"Serif\", \"font_x\": 20, \"font_stroke\": false, \"font_y\": 80}'),(11,'стрелка1',1,'2022-03-16 14:43:54','{\"x\": 148.5326086956522, \"y\": 349.4565217391305, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": true, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}'),(12,'стрелка2',1,'2022-03-16 14:44:02','{\"x\": 100.97826086956522, \"y\": 88.20652173913045, \"rotate\": 180, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": true, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}'),(13,'Круг синий',1,'2022-03-16 14:44:49','{\"x\": 717.5, \"y\": 73.75, \"rotate\": 0, \"width\": 200, \"height\": 200, \"isDragging\": false, \"selected\": true, \"isResize\": false, \"type\": \"circle\", \"lineWidth\": 2, \"border_color\": \"#0000FF\", \"need_border\": true, \"text\": \"\\u0422\\u0435\\u043a\\u0441\\u0442\", \"rounded\": true, \"round_left_top\": 100, \"round_left_bottom\": 100, \"round_right_top\": 100, \"round_right_bottom\": 100, \"need_fill\": true, \"background_color\": \"#101093\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 20, \"font_family\": \"Serif\", \"font_x\": 20, \"font_stroke\": false, \"font_y\": 100}'),(14,'круг красный',1,'2022-03-16 14:45:05','{\"x\": 717.5, \"y\": 73.75, \"rotate\": 0, \"width\": 200, \"height\": 200, \"isDragging\": false, \"selected\": true, \"isResize\": false, \"type\": \"circle\", \"lineWidth\": 2, \"border_color\": \"#0000FF\", \"need_border\": true, \"text\": \"\\u0422\\u0435\\u043a\\u0441\\u0442\", \"rounded\": true, \"round_left_top\": 100, \"round_left_bottom\": 100, \"round_right_top\": 100, \"round_right_bottom\": 100, \"need_fill\": true, \"background_color\": \"#ff0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 20, \"font_family\": \"Serif\", \"font_x\": 20, \"font_stroke\": false, \"font_y\": 100}');
/*!40000 ALTER TABLE `obj_library` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `obj_template`
--

DROP TABLE IF EXISTS `obj_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obj_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `header` varchar(100) NOT NULL DEFAULT '',
  `manager_id` int(10) unsigned DEFAULT NULL,
  `registered` timestamp NOT NULL DEFAULT current_timestamp(),
  `template` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `obj_template`
--

LOCK TABLES `obj_template` WRITE;
/*!40000 ALTER TABLE `obj_template` DISABLE KEYS */;
INSERT INTO `obj_template` VALUES (1,'32323232',1,'2022-03-16 13:41:53','[{\"x\": 100.97826086956522, \"y\": 88.20652173913045, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 151.25, \"y\": 418.75, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 62.5, \"spike_tail\": 12.5, \"tail_height\": 22.222222222222225, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 151.25, \"y\": 418.75, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 62.5, \"spike_tail\": 12.5, \"tail_height\": 22.222222222222225, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 151.25, \"y\": 418.75, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 62.5, \"spike_tail\": 12.5, \"tail_height\": 22.222222222222225, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 159.40217391304347, \"y\": 565.4891304347825, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 177.5543478260871, \"y\": 219.99999999999986, \"rotate\": 61, \"width\": 377, \"height\": 323, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"rectangle\", \"lineWidth\": 2, \"border_color\": \"#0000FF\", \"need_border\": true, \"text\": \"\\u0422\\u0435\\u043a\\u0441\\u0442\", \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#109312\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 84, \"font_family\": \"Serif\", \"font_x\": 84, \"font_stroke\": false, \"font_y\": 80}, {\"x\": 151.25, \"y\": 418.75, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 182.5, \"y\": 303.2608695652173, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 148.5326086956522, \"y\": 349.4565217391305, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 439.1304347826087, \"y\": 457.33695652173924, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}]'),(2,'шаблон2',1,'2022-03-16 14:45:58','[{\"x\": 151.25, \"y\": 418.75, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 62.5, \"spike_tail\": 12.5, \"tail_height\": 22.222222222222225, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 151.25, \"y\": 418.75, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 62.5, \"spike_tail\": 12.5, \"tail_height\": 22.222222222222225, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 159.40217391304347, \"y\": 565.4891304347825, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 62.5, \"spike_tail\": 12.5, \"tail_height\": 22.222222222222225, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 151.25, \"y\": 418.75, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 62.5, \"spike_tail\": 12.5, \"tail_height\": 22.222222222222225, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 439.1304347826087, \"y\": 457.33695652173924, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 62.5, \"spike_tail\": 12.5, \"tail_height\": 22.222222222222225, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 151.25, \"y\": 418.75, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 148.5326086956522, \"y\": 349.4565217391305, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 100.97826086956522, \"y\": 88.20652173913045, \"rotate\": 180, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 406.25, \"y\": 228.26086956521732, \"rotate\": 0, \"width\": 250, \"height\": 66.66666666666667, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"arrow\", \"lineWidth\": 4, \"border_color\": \"#0000FF\", \"need_border\": true, \"spike_head\": 63, \"spike_tail\": 13, \"tail_height\": 22, \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#fa0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 25, \"font_family\": \"Serif\", \"font_x\": 25, \"font_stroke\": false, \"font_y\": 8}, {\"x\": 665, \"y\": 78.75, \"rotate\": 0, \"width\": 200, \"height\": 200, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"circle\", \"lineWidth\": 2, \"border_color\": \"#0000FF\", \"need_border\": true, \"text\": \"\\u0422\\u0435\\u043a\\u0441\\u0442\", \"rounded\": true, \"round_left_top\": 100, \"round_left_bottom\": 100, \"round_right_top\": 100, \"round_right_bottom\": 100, \"need_fill\": true, \"background_color\": \"#ff0000\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 20, \"font_family\": \"Serif\", \"font_x\": 20, \"font_stroke\": false, \"font_y\": 100}, {\"x\": 631.25, \"y\": 355, \"rotate\": 0, \"width\": 200, \"height\": 200, \"isDragging\": false, \"selected\": false, \"isResize\": false, \"type\": \"circle\", \"lineWidth\": 2, \"border_color\": \"#0000FF\", \"need_border\": true, \"text\": \"\\u0422\\u0435\\u043a\\u0441\\u0442\", \"rounded\": true, \"round_left_top\": 100, \"round_left_bottom\": 100, \"round_right_top\": 100, \"round_right_bottom\": 100, \"need_fill\": true, \"background_color\": \"#101093\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 20, \"font_family\": \"Serif\", \"font_x\": 20, \"font_stroke\": false, \"font_y\": 100}, {\"x\": 184.61956521739148, \"y\": 107.44565217391289, \"rotate\": 61, \"width\": 377, \"height\": 323, \"isDragging\": false, \"selected\": true, \"isResize\": false, \"type\": \"rectangle\", \"lineWidth\": 2, \"border_color\": \"#0000FF\", \"need_border\": true, \"text\": \"\\u0422\\u0435\\u043a\\u0441\\u0442\", \"rounded\": false, \"round_left_top\": 50, \"round_left_bottom\": 50, \"round_right_top\": 50, \"round_right_bottom\": 50, \"need_fill\": true, \"background_color\": \"#109312\", \"background_opacity\": 0.8, \"font_bold\": false, \"font_italic\": false, \"font_color\": \"#ffffff\", \"font_size\": 84, \"font_family\": \"Serif\", \"font_x\": 84, \"font_stroke\": false, \"font_y\": 80}]');
/*!40000 ALTER TABLE `obj_template` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session`
--

DROP TABLE IF EXISTS `session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `auth_id` int(10) unsigned NOT NULL DEFAULT 0,
  `registered` timestamp NULL DEFAULT current_timestamp(),
  `session_key` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_id` (`auth_id`,`session_key`),
  CONSTRAINT `session_ibfk_1` FOREIGN KEY (`auth_id`) REFERENCES `manager` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session`
--

LOCK TABLES `session` WRITE;
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` VALUES (1,1,'2022-03-15 11:14:29','EBNu2iniUD0JipmPirMq1ba8K1dUr4dplE1abXTUqR7l3Y5TeyB8nBKwvFmzOUOP4DxgdSxjwopZcFrY8gTUdIlFCfl7Aibx4a8HsbeT0tzlCVu6Zss8OIhLHr1O3FSKvLSM73Li3CUBgDCFlGjrvCeK4ombAWMWgjHxyKGFbemHXZ4RHjuEGWMdMtFffq8UlzjPKWFj'),(2,1,'2022-03-15 11:14:29','LCBwP7ers7hIIXkD4cfs3CiKdZLiC0SNPgK2YqmoWu0GLbwJ5GJiuNWW5C2NtYiexfHP8BDv4ZX10akyuhKnYnLjeLCUsOqBGfS3t3HFbosHrbGD7pbwzxxEwtQAtQocNsfKu6WePcMqsMNI4YLodbzZfKwZoxjeajq2FjV282f6qGe78UbFDzkFrkEP3vYp1VccMRqj'),(3,1,'2022-03-15 11:19:52','Harvp4L0Yl8iYdkm6hRJTj8UZTt5TtDjSacaH4g0LY0rBVcnBCxV0YSMVTEhDUFxKc8jcFTu6Tkdnpgm5FOyVKFtUdSyAcJkNtILE27KvSrCsM3DSIpKxoknzYvMDPVxZ140y5rQ8kSF4fHimIVbX4ssreoEKD6MJEReeHMGKX8eHvh5JAP4pzBWATqZ8C6fjfnYhScH'),(4,1,'2022-03-15 11:21:19','KItKmxgW8c77BRJkCtJF8oQ6TH1gHsZ0hUhNJewSugdqrqbo34Q2VWAJTTns60pccSyRKX2vBTe3Qw6sydrh8swidCqtTudiUfycuvbCqRWs6HxQpCnHYNSGIn8IHT0uU5siGpyjGEzyRKTn1xoLakdkYpj7PkLgcJR3SrO7FXX4YgOw2Rms7rfiKVsXEwIlxYhIJ46Z'),(5,1,'2022-03-15 11:24:00','gRtR06KkbJ4OrzIfiXIigesQfPIduBkywkVmUNeDkYtpruKttHk8NzEYF5nIJrbiIqrvE324qpm7pXend7Esi3ESbgF1i2MaUyKD82ITnqDtuoAPhVZcf5LHdBxR6auWusjaWdp6otIbtgtXgA3qzHdIZlZ6pp7LP7hcbOxA8yl7tHDOUyBluYrbjRcyQ8el35aa0w1n'),(6,1,'2022-03-15 12:23:35','tek7v6HbCD1xayZ5ruS2tfCg3zRqFaEGZtGRkhYv0vwikxySYpFoO88jG12s4jvt7dwoMJhEZcnaVQ7rKkU1JXPFoZOL14Y6NZtOdaZnyU61ByFmZwErkqPmsVfryOaCQjqhgmCD0kZPqlayZlMSOIXyP6q2zYORKfTHBPrqYCK1RKZ1UOOCTYkZvyEGAWfKLxOjauO6'),(7,1,'2022-03-15 12:25:16','r7diidd77ohcEJeYKJdxUisEp8QMdPwaRUWkBplyYsg85fteQgwBE43ZFsWPu0Rvx6VnpzLy01LFzWvgMYaBTLUJOd227cH0Ia6hLGTrQXlj5K1PbjBNORE7ltb38oT7xbA1eVsVaNiT0TXIX4ALGNTYWtLNQ7lJdPgjOLwxhIBtE5NFsTCHBFtD6lrGtYOLroNgwILc'),(8,1,'2022-03-15 12:57:27','CF4dW4d7TMCFcb67J4ziTMVv2uL6K1csOw6MYKG3jxAPmIrln01nQ1EC6axISf2peN2QGX5ikqbwsqIqT0w7IB0sbUuqv0vFjervx18PjtfSSR8UDSKzIXhARjQQFj0XJjOeI5PlHJcix4b1vCzJMrFg8PrlVvaZzHuOshWXrljFKryTH0SLdIa6KbbWSWbX0xP0SQ3v'),(9,1,'2022-03-15 12:57:47','evy8DzgfjpgoetNfW8xvnOMdwfCEBW64qbH1k2EANqYYaknpKUx5apXEjJ6kjpOS63CzYpKbWVyuoQ4FWM8XPAU10meFaWqg4bt3N4nc5IhJnYu4oRZ6lhZhhBaPIH8mtt1U5J0rE6UUOuYQmDWIWHSjUGMBA6SUNIhVJwPlqqLq82cl2PjeEb7Xnk5SoRQNNu0m4u5y');
/*!40000 ALTER TABLE `session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `session_fails`
--

DROP TABLE IF EXISTS `session_fails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `session_fails` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `login` varchar(200) NOT NULL DEFAULT '',
  `ip` varchar(20) NOT NULL DEFAULT '',
  `registered` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ip` (`ip`,`registered`),
  KEY `login` (`login`,`registered`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `session_fails`
--

LOCK TABLES `session_fails` WRITE;
/*!40000 ALTER TABLE `session_fails` DISABLE KEYS */;
/*!40000 ALTER TABLE `session_fails` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-03-16 18:25:47
