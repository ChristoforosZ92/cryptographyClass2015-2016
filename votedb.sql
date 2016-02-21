-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: votedb
-- ------------------------------------------------------
-- Server version	5.5.47-log

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
-- Table structure for table `captcha`
--

DROP TABLE IF EXISTS `captcha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `randomNumber` varchar(5) DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `cap` (`randomNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=171 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha`
--

LOCK TABLES `captcha` WRITE;
/*!40000 ALTER TABLE `captcha` DISABLE KEYS */;
INSERT INTO `captcha` VALUES (137,'33281',1),(138,'56826',1),(139,'12470',1),(140,'99629',1),(141,'93303',1),(142,'77978',1),(143,'41881',1),(144,'48940',1),(145,'38378',1),(146,'23278',1),(147,'80145',1),(148,'75966',1),(149,'87473',1),(150,'37532',1),(151,'64280',1),(152,'32603',1),(153,'97350',0),(154,'04329',1),(155,'77910',1),(156,'01223',0),(157,'45958',0),(158,'77752',1),(159,'15475',0),(160,'54309',1),(161,'63539',1),(162,'71735',1),(163,'68982',0),(164,'87314',1),(165,'56077',0),(166,'14730',1),(167,'21663',0),(168,'31732',1),(169,'84058',1),(170,'09092',1);
/*!40000 ALTER TABLE `captcha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votedetails`
--

DROP TABLE IF EXISTS `votedetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votedetails` (
  `subjectID` int(11) NOT NULL,
  `detailsID` int(11) NOT NULL,
  `vOption` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`subjectID`,`detailsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votedetails`
--

LOCK TABLES `votedetails` WRITE;
/*!40000 ALTER TABLE `votedetails` DISABLE KEYS */;
INSERT INTO `votedetails` VALUES (16,1,'option1'),(16,2,'option2'),(17,1,'10'),(17,2,'9'),(17,3,'8'),(17,4,'7'),(17,5,'6'),(17,6,'5'),(17,7,'4'),(17,8,'3'),(17,9,'2'),(17,10,'1'),(17,11,'0'),(18,1,'Yes'),(18,2,'No'),(18,3,'Iam still looking'),(19,1,'Yes'),(19,2,'No');
/*!40000 ALTER TABLE `votedetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voters`
--

DROP TABLE IF EXISTS `voters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voters` (
  `vat` varchar(9) NOT NULL,
  `subjectID` int(11) NOT NULL,
  PRIMARY KEY (`vat`,`subjectID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voters`
--

LOCK TABLES `voters` WRITE;
/*!40000 ALTER TABLE `voters` DISABLE KEYS */;
/*!40000 ALTER TABLE `voters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votes`
--

DROP TABLE IF EXISTS `votes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subjectID` int(11) NOT NULL,
  `detailsID` int(11) NOT NULL,
  `vDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vote_det_id_idx` (`subjectID`,`detailsID`),
  CONSTRAINT `vote_det_id` FOREIGN KEY (`subjectID`, `detailsID`) REFERENCES `votedetails` (`subjectID`, `detailsID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votes`
--

LOCK TABLES `votes` WRITE;
/*!40000 ALTER TABLE `votes` DISABLE KEYS */;
INSERT INTO `votes` VALUES (43,19,1,'2016-02-21 19:04:08'),(44,19,1,'2016-02-21 19:19:34'),(45,17,1,'2016-02-21 19:23:02'),(46,17,10,'2016-02-21 19:23:11');
/*!40000 ALTER TABLE `votes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `votesubject`
--

DROP TABLE IF EXISTS `votesubject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `votesubject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `status` int(11) DEFAULT '1',
  `vType` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `votesubject`
--

LOCK TABLES `votesubject` WRITE;
/*!40000 ALTER TABLE `votesubject` DISABLE KEYS */;
INSERT INTO `votesubject` VALUES (16,'Example Old','This is an expired poll question!','2016-02-10 18:20:21','2016-02-20 23:59:59',1,2),(17,'Example1','From scale 1-10 how complete did you find this project?','2016-02-21 18:24:42','2016-03-02 23:59:59',1,1),(18,'Example2','Did you expirience any issues with this web application?','2016-02-21 18:30:41','2016-03-02 23:59:59',1,2),(19,'Example Poll','Is this a good example?','2016-02-21 18:33:23','2016-03-02 23:59:59',1,1);
/*!40000 ALTER TABLE `votesubject` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-02-21 19:44:31
