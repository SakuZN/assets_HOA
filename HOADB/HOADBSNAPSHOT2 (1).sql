-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: hoadb
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `asset_activity`
--

DROP TABLE IF EXISTS `asset_activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_activity` (
  `asset_id` int NOT NULL,
  `activity_date` date NOT NULL,
  `activity_description` varchar(45) DEFAULT NULL,
  `tent_start` date DEFAULT NULL,
  `tent_end` date DEFAULT NULL,
  `act_start` date DEFAULT NULL,
  `act_end` date DEFAULT NULL,
  `cost` decimal(9,2) DEFAULT NULL,
  `status` enum('S','O','C') NOT NULL COMMENT 'S - Scheduled\nO - Ongoing\nC - Completed\n',
  PRIMARY KEY (`asset_id`,`activity_date`),
  CONSTRAINT `FKLANZ11` FOREIGN KEY (`asset_id`, `activity_date`) REFERENCES `asset_transactions` (`asset_id`, `transaction_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_activity`
--

LOCK TABLES `asset_activity` WRITE;
/*!40000 ALTER TABLE `asset_activity` DISABLE KEYS */;
INSERT INTO `asset_activity` VALUES (5001,'2022-12-20','Repair and Wash','2022-12-21','2022-12-21','2022-12-21','2022-12-21',100.00,'C'),(5001,'2022-12-21','Repaint','2022-12-22','2022-12-23','2022-12-22','2022-12-22',400.00,'C'),(5002,'2022-12-21','Repair','2022-12-22','2022-12-22','2022-12-22','2022-12-22',0.00,'C');
/*!40000 ALTER TABLE `asset_activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_donations`
--

DROP TABLE IF EXISTS `asset_donations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_donations` (
  `donation_id` int NOT NULL,
  `donor_completename` varchar(45) NOT NULL,
  `donation_formfile` varchar(45) DEFAULT NULL,
  `date_donation` date NOT NULL,
  `accept_hoid` int NOT NULL,
  `accept_position` varchar(45) NOT NULL,
  `accept_electiondate` date NOT NULL,
  `isdeleted` tinyint(1) NOT NULL,
  `approval_hoid` int DEFAULT NULL,
  `approval_position` varchar(45) DEFAULT NULL,
  `approval_electiondate` date DEFAULT NULL,
  PRIMARY KEY (`donation_id`),
  KEY `FKTYE40_idx` (`accept_hoid`,`accept_position`,`accept_electiondate`),
  KEY `FKTYE68_idx` (`approval_hoid`,`approval_position`,`approval_electiondate`),
  KEY `FKNORM30_idx` (`donor_completename`),
  CONSTRAINT `FKNORM30` FOREIGN KEY (`donor_completename`) REFERENCES `donors` (`donorname`),
  CONSTRAINT `FKTYE40` FOREIGN KEY (`accept_hoid`, `accept_position`, `accept_electiondate`) REFERENCES `officer` (`ho_id`, `position`, `election_date`),
  CONSTRAINT `FKTYE68` FOREIGN KEY (`approval_hoid`, `approval_position`, `approval_electiondate`) REFERENCES `officer_presidents` (`ho_id`, `position`, `election_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_donations`
--

LOCK TABLES `asset_donations` WRITE;
/*!40000 ALTER TABLE `asset_donations` DISABLE KEYS */;
INSERT INTO `asset_donations` VALUES (6001,'Ramon Magsaysay','6001ramon.pdf','2022-12-10',9004,'President','2022-12-01',0,NULL,NULL,NULL),(6002,'Edgardo Tangchoco','6002edgardo.pdf','2022-12-10',9004,'President','2022-12-01',0,NULL,NULL,NULL),(6003,'Edgardo Tangchoco','6003edgardo.pdf','2022-12-10',9004,'President','2022-12-01',0,NULL,NULL,NULL),(6004,'Romeo Joselito','6004romeo.pdf','2022-12-11',9003,'Vice-President','2022-12-01',0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `asset_donations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_rentals`
--

DROP TABLE IF EXISTS `asset_rentals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_rentals` (
  `asset_id` int NOT NULL,
  `rental_date` date NOT NULL,
  `reservation_date` date NOT NULL,
  `resident_id` int NOT NULL,
  `rental_amount` decimal(9,2) DEFAULT NULL,
  `discount` decimal(9,2) DEFAULT NULL,
  `status` enum('R','C','O','N') NOT NULL COMMENT 'R - Reserved\nC - Cancelled\nO - On-Rent\nN - Returned\n',
  `inspection_details` longtext,
  `assessed_value` decimal(9,2) DEFAULT NULL,
  `accept_hoid` int DEFAULT NULL,
  `accept_position` varchar(45) DEFAULT NULL,
  `accept_electiondate` date DEFAULT NULL,
  `return_date` date DEFAULT NULL,
  PRIMARY KEY (`asset_id`,`rental_date`),
  KEY `FKTYE10_idx` (`accept_hoid`,`accept_position`,`accept_electiondate`),
  KEY `FKTYE63_idx` (`resident_id`),
  CONSTRAINT `FKLANZ10` FOREIGN KEY (`asset_id`, `rental_date`) REFERENCES `asset_transactions` (`asset_id`, `transaction_date`),
  CONSTRAINT `FKTYE10` FOREIGN KEY (`accept_hoid`, `accept_position`, `accept_electiondate`) REFERENCES `officer` (`ho_id`, `position`, `election_date`),
  CONSTRAINT `FKTYE63` FOREIGN KEY (`resident_id`) REFERENCES `residents` (`resident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_rentals`
--

LOCK TABLES `asset_rentals` WRITE;
/*!40000 ALTER TABLE `asset_rentals` DISABLE KEYS */;
INSERT INTO `asset_rentals` VALUES (5008,'2022-12-23','2022-12-20',9016,50.00,0.00,'N','All returned OK',0.00,9009,'Secretary','2022-12-01','2022-12-23'),(5008,'2022-12-24','2022-12-20',9018,50.00,0.00,'N','Some Damage',500.00,9010,'Treasurer','2022-12-01','2022-12-25'),(5010,'2022-12-23','2022-12-20',9017,50.00,0.00,'N','All returned OK',0.00,9010,'Treasurer','2022-12-01','2022-12-25'),(5010,'2023-04-05','2023-04-04',9002,NULL,NULL,'R',NULL,NULL,NULL,NULL,NULL,NULL),(5012,'2023-04-06','2023-04-05',9017,NULL,NULL,'R',NULL,NULL,NULL,NULL,NULL,NULL),(5013,'2023-04-06','2023-04-05',9017,NULL,NULL,'R',NULL,NULL,NULL,NULL,NULL,NULL),(5015,'2023-04-06','2023-04-05',9017,NULL,NULL,'R',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `asset_rentals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_transactions`
--

DROP TABLE IF EXISTS `asset_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_transactions` (
  `asset_id` int NOT NULL,
  `transaction_date` date NOT NULL,
  `trans_hoid` int NOT NULL,
  `trans_position` varchar(45) NOT NULL,
  `trans_electiondate` date NOT NULL,
  `isdeleted` tinyint(1) NOT NULL,
  `approval_hoid` int DEFAULT NULL,
  `approval_position` varchar(45) DEFAULT NULL,
  `approval_electiondate` date DEFAULT NULL,
  `ornum` int DEFAULT NULL,
  `transaction_type` enum('R','T','A') NOT NULL,
  PRIMARY KEY (`asset_id`,`transaction_date`),
  UNIQUE KEY `ornum_UNIQUE` (`ornum`),
  KEY `FKLANZ15_idx` (`trans_hoid`,`trans_position`,`trans_electiondate`),
  KEY `FKLANZ16_idx` (`approval_hoid`,`approval_position`,`approval_electiondate`),
  KEY `FKLANZ17_idx` (`ornum`),
  CONSTRAINT `FKLANZ01` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`),
  CONSTRAINT `FKLANZ15` FOREIGN KEY (`trans_hoid`, `trans_position`, `trans_electiondate`) REFERENCES `officer` (`ho_id`, `position`, `election_date`),
  CONSTRAINT `FKLANZ16` FOREIGN KEY (`approval_hoid`, `approval_position`, `approval_electiondate`) REFERENCES `officer_presidents` (`ho_id`, `position`, `election_date`),
  CONSTRAINT `FKLANZ17` FOREIGN KEY (`ornum`) REFERENCES `ref_ornumbers` (`ornum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_transactions`
--

LOCK TABLES `asset_transactions` WRITE;
/*!40000 ALTER TABLE `asset_transactions` DISABLE KEYS */;
INSERT INTO `asset_transactions` VALUES (5001,'2022-12-20',9003,'Vice-President','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5001,'2022-12-21',9003,'Vice-President','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5002,'2022-12-21',9003,'Vice-President','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5003,'2022-12-23',9011,'Auditor','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5005,'2022-12-21',9009,'Secretary','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5005,'2022-12-23',9011,'Auditor','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5007,'2022-12-23',9011,'Auditor','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5008,'2022-12-23',9011,'Auditor','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5008,'2022-12-24',9009,'Secretary','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5010,'2022-12-23',9011,'Auditor','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5010,'2023-04-05',9005,'Auditor','2022-06-01',0,NULL,NULL,NULL,NULL,'R'),(5012,'2023-04-06',9011,'Auditor','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5013,'2023-04-06',9011,'Auditor','2022-12-01',0,NULL,NULL,NULL,NULL,'R'),(5015,'2023-04-06',9011,'Auditor','2022-12-01',0,NULL,NULL,NULL,NULL,'R');
/*!40000 ALTER TABLE `asset_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `asset_transfer`
--

DROP TABLE IF EXISTS `asset_transfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asset_transfer` (
  `asset_id` int NOT NULL,
  `schedule_date` date NOT NULL,
  `act_date` date DEFAULT NULL,
  `source_lattitude` decimal(7,4) NOT NULL,
  `source_longitude` decimal(7,4) NOT NULL,
  `dest_latittude` decimal(7,4) NOT NULL,
  `dest_longitude` decimal(7,4) NOT NULL,
  `transfer_cost` decimal(9,2) DEFAULT NULL,
  `status` enum('S','O','C') NOT NULL COMMENT 'S - Scheduled\nO - Ongoing\nC - Completed\n',
  `completename` varchar(45) NOT NULL,
  PRIMARY KEY (`asset_id`,`schedule_date`),
  KEY `FKNORM35_idx` (`completename`),
  CONSTRAINT `FKAT07` FOREIGN KEY (`asset_id`, `schedule_date`) REFERENCES `asset_transactions` (`asset_id`, `transaction_date`),
  CONSTRAINT `FKNORM88` FOREIGN KEY (`completename`) REFERENCES `outsiders` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asset_transfer`
--

LOCK TABLES `asset_transfer` WRITE;
/*!40000 ALTER TABLE `asset_transfer` DISABLE KEYS */;
INSERT INTO `asset_transfer` VALUES (5005,'2022-12-21','2022-12-23',100.4300,100.5300,150.5500,150.5600,50.00,'C','Juan Estanislao'),(5005,'2022-12-23','2022-12-23',243.5500,254.2230,212.4450,212.4220,100.00,'C','Kyle Rosalita'),(5007,'2022-12-23','2022-12-23',423.2120,353.2340,255.2560,123.5320,100.00,'C','Kyle Rosalita');
/*!40000 ALTER TABLE `asset_transfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `assets`
--

DROP TABLE IF EXISTS `assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assets` (
  `asset_id` int NOT NULL,
  `asset_name` varchar(45) NOT NULL,
  `asset_description` varchar(45) NOT NULL,
  `acquisition_date` date NOT NULL,
  `forrent` tinyint(1) NOT NULL,
  `asset_value` decimal(9,2) NOT NULL,
  `type_asset` enum('P','E','F','O') NOT NULL COMMENT 'P - Property\nE - Equipment\nF - F&F\nO - Others\n',
  `status` enum('W','D','P','S','X') NOT NULL COMMENT 'W - Working\nD - Deterioted\nP - For Repair\nS - For Disposal\nX - Disposed',
  `loc_lattitude` decimal(7,4) NOT NULL,
  `loc_longiture` decimal(7,4) NOT NULL,
  `hoa_name` varchar(45) NOT NULL,
  `enclosing_asset` int DEFAULT NULL,
  PRIMARY KEY (`asset_id`),
  KEY `FKTYE05_idx` (`hoa_name`),
  KEY `FKTYE07_idx` (`enclosing_asset`),
  CONSTRAINT `FKTYE05` FOREIGN KEY (`hoa_name`) REFERENCES `hoa` (`hoa_name`),
  CONSTRAINT `FKTYE07` FOREIGN KEY (`enclosing_asset`) REFERENCES `assets` (`asset_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assets`
--

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;
INSERT INTO `assets` VALUES (5001,'Chair','Upuang Duwende','2022-01-01',0,100.00,'F','W',100.4350,100.4360,'SJH',NULL),(5002,'Chair','Upuang Maliit','2022-01-02',0,100.00,'F','W',100.4350,100.4360,'SJH',NULL),(5003,'Chair','Upuang Malaki','2022-01-01',0,100.00,'F','W',100.4350,100.4360,'SJH',NULL),(5004,'Table','Lamesa','2022-02-01',0,100.00,'F','W',101.4350,101.4350,'SJH',NULL),(5005,'Meeting Room','Maritesan','2022-02-01',0,100000.00,'P','W',101.4350,101.4350,'SJH',NULL),(5006,'Conference Room','Malaking Maritesan','2002-02-02',0,100000.00,'P','W',101.4350,101.4350,'SJH',NULL),(5007,'TV','Television','2022-01-04',0,50000.00,'E','W',101.4350,101.4350,'SJH',5006),(5008,'TV','Television','2022-03-01',1,50000.00,'E','W',101.4350,101.4370,'SJH',NULL),(5009,'Vase','Vase','2022-05-01',0,350.00,'O','W',101.3330,101.3330,'SJH',5006),(5010,'Vase','Vase','2022-03-02',0,350.00,'','W',101.3330,101.3330,'SJH',NULL),(5012,'Floaty1','For Fun!','2023-04-05',0,249.00,'E','W',312.4210,314.2130,'SJH',5015),(5013,'Floaty2','For Fun','2023-04-05',0,2497.00,'E','W',231.3210,321.4210,'SJH',5015),(5014,'Swimming Pool','For Fun','2023-04-05',0,2500.00,'P','X',232.2310,321.2129,'SJH',NULL),(5015,'New Swimming Pool','Better And Bigger','2023-04-05',0,4998.00,'P','W',232.3210,313.2130,'SJH',NULL);
/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donated_assets`
--

DROP TABLE IF EXISTS `donated_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donated_assets` (
  `donation_id` int NOT NULL,
  `asset_id` int NOT NULL,
  `amount_donated` decimal(9,2) NOT NULL,
  PRIMARY KEY (`donation_id`,`asset_id`),
  KEY `FKTYE30_idx` (`asset_id`),
  CONSTRAINT `FKTYE30` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`),
  CONSTRAINT `FKTYE31` FOREIGN KEY (`donation_id`) REFERENCES `asset_donations` (`donation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donated_assets`
--

LOCK TABLES `donated_assets` WRITE;
/*!40000 ALTER TABLE `donated_assets` DISABLE KEYS */;
INSERT INTO `donated_assets` VALUES (6001,5004,1000.00),(6002,5005,2000.00),(6003,5006,2000.00),(6004,5006,2500.00);
/*!40000 ALTER TABLE `donated_assets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donation_pictures`
--

DROP TABLE IF EXISTS `donation_pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donation_pictures` (
  `donation_id` int NOT NULL,
  `picturefile` varchar(45) NOT NULL,
  PRIMARY KEY (`donation_id`,`picturefile`),
  CONSTRAINT `FKTYE70` FOREIGN KEY (`donation_id`) REFERENCES `asset_donations` (`donation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donation_pictures`
--

LOCK TABLES `donation_pictures` WRITE;
/*!40000 ALTER TABLE `donation_pictures` DISABLE KEYS */;
INSERT INTO `donation_pictures` VALUES (6001,'6001-a.jpg'),(6001,'6001-b.jpg'),(6002,'6002.jpg'),(6004,'6004-a.jpg'),(6004,'6004-b.jpg'),(6004,'6004-s.jpg');
/*!40000 ALTER TABLE `donation_pictures` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `donors`
--

DROP TABLE IF EXISTS `donors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `donors` (
  `donorname` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  PRIMARY KEY (`donorname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `donors`
--

LOCK TABLES `donors` WRITE;
/*!40000 ALTER TABLE `donors` DISABLE KEYS */;
INSERT INTO `donors` VALUES ('Edgardo Tangchoco','Manila'),('Ramon Magsaysay','Quezon City'),('Romeo Joselito','Pasay');
/*!40000 ALTER TABLE `donors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `elections`
--

DROP TABLE IF EXISTS `elections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `elections` (
  `election_date` date NOT NULL,
  `election_venue` varchar(45) NOT NULL,
  `quorum` tinyint(1) NOT NULL,
  `outsider_wname` varchar(45) NOT NULL,
  PRIMARY KEY (`election_date`),
  KEY `FKNORM20_idx` (`outsider_wname`),
  CONSTRAINT `FKNORM20` FOREIGN KEY (`outsider_wname`) REFERENCES `outsiders` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `elections`
--

LOCK TABLES `elections` WRITE;
/*!40000 ALTER TABLE `elections` DISABLE KEYS */;
INSERT INTO `elections` VALUES ('2022-06-01','Clubhouse',1,'Jose Ignacio'),('2022-12-01','Gymnasium',1,'Maria Estrella');
/*!40000 ALTER TABLE `elections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoa`
--

DROP TABLE IF EXISTS `hoa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hoa` (
  `hoa_name` varchar(45) NOT NULL,
  `ofcaddr_streetno` varchar(10) NOT NULL,
  `ofcaddr_street` varchar(45) NOT NULL,
  `ofcaddr_barangay` varchar(45) NOT NULL,
  `ofcaddr_city` varchar(45) NOT NULL,
  `ofcaddr_province` varchar(45) NOT NULL,
  `ofcaddr_lattitude` decimal(7,4) NOT NULL,
  `ofcaddr_longitude` decimal(7,2) NOT NULL,
  `year_establishment` date NOT NULL,
  `website` varchar(45) DEFAULT NULL,
  `subdivision_name` varchar(45) NOT NULL,
  `req_scannedarticles` varchar(45) DEFAULT NULL,
  `req_notarizedbylaws` varchar(45) DEFAULT NULL,
  `req_minutes` varchar(45) DEFAULT NULL,
  `req_attendance` varchar(45) DEFAULT NULL,
  `req_certification` varchar(45) DEFAULT NULL,
  `req_codeofethics` varchar(45) DEFAULT NULL,
  `req_regularmonthly` decimal(9,2) DEFAULT NULL,
  `req_collectionday` int NOT NULL COMMENT 'Checking the \nintegrity of the \ndomain values is \nagreed to be \nhandled by the \nDB Application\n',
  PRIMARY KEY (`hoa_name`),
  KEY `FK003_idx` (`req_collectionday`),
  KEY `FKNORM08_idx` (`ofcaddr_barangay`,`ofcaddr_city`,`ofcaddr_province`),
  CONSTRAINT `FK003` FOREIGN KEY (`req_collectionday`) REFERENCES `ref_collectiondays` (`days`),
  CONSTRAINT `FKNORM08` FOREIGN KEY (`ofcaddr_barangay`, `ofcaddr_city`, `ofcaddr_province`) REFERENCES `zipcodes` (`barangay`, `city`, `province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoa`
--

LOCK TABLES `hoa` WRITE;
/*!40000 ALTER TABLE `hoa` DISABLE KEYS */;
INSERT INTO `hoa` VALUES ('SJH','15','Chico St','Bayanan','Muntinlupa','National Capital Region',14.2340,29.29,'2003-12-13','www.sjh.com','Sait Joseph Homes','sjh_articles.pdf','sjh_bylaws.pdf','sjh_minutes.pdf','sjh_attendance.pdf','sjh_certification.pdf','sjh_codeofethics.pdf',250.00,10),('SMH','10','Jade St','Bayanan','Muntinlupa','National Capital Region',10.4560,20.32,'2005-05-04','www.smh.com','Saint Mary\'s Homes','smh_articles.pdf','smh_bylaws.pdf','smh_minutes.pdf','smh_attendance.pdf','smh_certification.pdf','smh_codeofethics.pdf',350.00,18);
/*!40000 ALTER TABLE `hoa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hoa_geninfosheets`
--

DROP TABLE IF EXISTS `hoa_geninfosheets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hoa_geninfosheets` (
  `hoa_name` varchar(45) NOT NULL,
  `gen_infosheet` varchar(45) NOT NULL,
  PRIMARY KEY (`hoa_name`,`gen_infosheet`),
  CONSTRAINT `FK001` FOREIGN KEY (`hoa_name`) REFERENCES `hoa` (`hoa_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hoa_geninfosheets`
--

LOCK TABLES `hoa_geninfosheets` WRITE;
/*!40000 ALTER TABLE `hoa_geninfosheets` DISABLE KEYS */;
INSERT INTO `hoa_geninfosheets` VALUES ('SJH','sjh_property01.pdf'),('SJH','sjh_property02.pdf'),('SJH','sjh_property03.pdf'),('SJH','sjh_property04.pdf'),('SJH','sjh_property05.pdf'),('SJH','sjh_property06.pdf'),('SJH','sjh_property07.pdf'),('SJH','sjh_property08.pdf'),('SJH','sjh_property09.pdf'),('SJH','sjh_property10.pdf'),('SJH','sjh_property11.pdf'),('SJH','sjh_property12.pdf'),('SJH','sjh_property13.pdf'),('SJH','sjh_property14.pdf'),('SJH','sjh_property15.pdf'),('SMH','smh_property01.pdf'),('SMH','smh_property03.pdf'),('SMH','smh_property04.pdf'),('SMH','smh_property05.pdf'),('SMH','smh_property06.pdf'),('SMH','smh_property07.pdf'),('SMH','smh_property08.pdf'),('SMH','smh_property09.pdf'),('SMH','smh_property10.pdf'),('SMH','smh_property11.pdf'),('SMH','smh_property12.pdf'),('SMH','smh_property13.pdf'),('SMH','smh_property14.pdf'),('SMH','smh_property15.pdf'),('SMH','smh__property02.pdf');
/*!40000 ALTER TABLE `hoa_geninfosheets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `homeowner`
--

DROP TABLE IF EXISTS `homeowner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `homeowner` (
  `ho_id` int NOT NULL,
  `hostart_date` date NOT NULL,
  `undertaking` tinyint(1) NOT NULL,
  `want_member` tinyint(1) NOT NULL,
  `other_streetno` varchar(45) DEFAULT NULL,
  `other_street` varchar(45) DEFAULT NULL,
  `other_barangay` varchar(45) DEFAULT NULL,
  `other_city` varchar(45) DEFAULT NULL,
  `other_province` varchar(45) DEFAULT NULL,
  `other_longitude` decimal(7,4) DEFAULT NULL,
  `other_lattitude` decimal(7,4) DEFAULT NULL,
  `other_email` varchar(45) DEFAULT NULL,
  `other_mobile` bigint DEFAULT NULL,
  PRIMARY KEY (`ho_id`),
  UNIQUE KEY `other_email_UNIQUE` (`other_email`),
  UNIQUE KEY `other_mobile_UNIQUE` (`other_mobile`),
  KEY `FKNORM03_idx` (`other_barangay`,`other_city`,`other_province`),
  CONSTRAINT `FKNORM03` FOREIGN KEY (`other_barangay`, `other_city`, `other_province`) REFERENCES `zipcodes` (`barangay`, `city`, `province`),
  CONSTRAINT `FKSENATOR05` FOREIGN KEY (`ho_id`) REFERENCES `people` (`peopleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `homeowner`
--

LOCK TABLES `homeowner` WRITE;
/*!40000 ALTER TABLE `homeowner` DISABLE KEYS */;
INSERT INTO `homeowner` VALUES (9001,'2002-05-04',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9002,'2002-05-02',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9003,'2002-02-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9004,'2002-04-04',1,1,'24','Macopa St','Alabang','Muntinlupa','National Capital Region',13.2330,15.2350,'tanya@gmail.com',9999203321),(9005,'2002-05-14',1,1,'30','National Highway','Tunasan','Muntinlupa','National Capital Region',24.5000,23.2330,'francine@gmail.com',9923090992),(9006,'2002-02-05',1,1,'31','Apple St.','Tunasan','Muntinlupa','National Capital Region',NULL,NULL,NULL,NULL),(9007,'2002-05-06',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9008,'2002-04-12',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9009,'2002-04-05',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9010,'2022-03-15',1,1,'19','National Road','Poblacion','Calapan','Oriental Mindoro',NULL,NULL,NULL,NULL),(9011,'2022-03-12',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9012,'2022-04-01',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9013,'2022-04-10',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9014,'2022-02-19',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),(9015,'2022-03-27',1,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `homeowner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `household`
--

DROP TABLE IF EXISTS `household`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `household` (
  `household_id` int NOT NULL,
  PRIMARY KEY (`household_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `household`
--

LOCK TABLES `household` WRITE;
/*!40000 ALTER TABLE `household` DISABLE KEYS */;
INSERT INTO `household` VALUES (6001),(6002),(6003),(6004),(6005),(6006);
/*!40000 ALTER TABLE `household` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `officer`
--

DROP TABLE IF EXISTS `officer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `officer` (
  `ho_id` int NOT NULL,
  `position` varchar(45) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `election_date` date NOT NULL,
  `availability_time` enum('M','A') NOT NULL COMMENT 'M -Morning\nA - Afternoon\n',
  `M` tinyint(1) NOT NULL,
  `T` tinyint(1) NOT NULL,
  `W` tinyint(1) NOT NULL,
  `H` tinyint(1) NOT NULL,
  `F` tinyint(1) NOT NULL,
  `S` tinyint(1) NOT NULL,
  `N` tinyint(1) NOT NULL,
  PRIMARY KEY (`ho_id`,`position`,`election_date`),
  KEY `FKBENSON01_idx` (`position`),
  KEY `FKNORM01_idx` (`election_date`),
  CONSTRAINT `FKBENSON01` FOREIGN KEY (`position`) REFERENCES `ref_positions` (`position`),
  CONSTRAINT `FKGABRIEL06` FOREIGN KEY (`ho_id`) REFERENCES `homeowner` (`ho_id`),
  CONSTRAINT `FKNORM01` FOREIGN KEY (`election_date`) REFERENCES `elections` (`election_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officer`
--

LOCK TABLES `officer` WRITE;
/*!40000 ALTER TABLE `officer` DISABLE KEYS */;
INSERT INTO `officer` VALUES (9001,'President','2022-06-10','2022-12-10','2022-06-01','A',1,1,0,0,0,1,0),(9002,'Vice-President','2022-06-10','2022-12-10','2022-06-01','A',0,1,0,1,0,1,1),(9003,'Secretary','2022-06-10','2022-12-10','2022-06-01','M',0,1,1,0,0,1,0),(9003,'Vice-President','2022-12-10','2023-12-10','2022-12-01','M',1,0,0,1,1,1,0),(9004,'President','2022-12-10','2023-12-10','2022-12-01','M',1,0,0,1,0,0,1),(9004,'Treasurer','2022-06-10','2022-12-10','2022-06-01','M',1,1,1,1,1,0,0),(9005,'Auditor','2022-06-10','2022-12-10','2022-06-01','M',1,1,1,1,0,0,1),(9009,'Secretary','2023-01-10','2023-12-10','2022-12-01','A',0,1,0,1,0,0,1),(9010,'Treasurer','2023-01-10','2023-12-10','2022-12-01','A',0,0,0,0,0,0,0),(9011,'Auditor','2022-12-10','2023-12-10','2022-12-01','M',1,1,1,1,0,1,1);
/*!40000 ALTER TABLE `officer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `officer_presidents`
--

DROP TABLE IF EXISTS `officer_presidents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `officer_presidents` (
  `ho_id` int NOT NULL,
  `position` varchar(45) NOT NULL,
  `election_date` date NOT NULL,
  PRIMARY KEY (`ho_id`,`position`,`election_date`),
  CONSTRAINT `FKTYE50` FOREIGN KEY (`ho_id`, `position`, `election_date`) REFERENCES `officer` (`ho_id`, `position`, `election_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `officer_presidents`
--

LOCK TABLES `officer_presidents` WRITE;
/*!40000 ALTER TABLE `officer_presidents` DISABLE KEYS */;
INSERT INTO `officer_presidents` VALUES (9001,'President','2022-06-01'),(9004,'President','2022-12-01');
/*!40000 ALTER TABLE `officer_presidents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outsiders`
--

DROP TABLE IF EXISTS `outsiders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `outsiders` (
  `name` varchar(45) NOT NULL,
  `mobileno` bigint NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `mobileno_UNIQUE` (`mobileno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outsiders`
--

LOCK TABLES `outsiders` WRITE;
/*!40000 ALTER TABLE `outsiders` DISABLE KEYS */;
INSERT INTO `outsiders` VALUES ('Kyle Rosalita',9285443322),('Maria Estrella',9816667777),('Jose Ignacio',9817776666),('Juan Estanislao',9823335454);
/*!40000 ALTER TABLE `outsiders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people`
--

DROP TABLE IF EXISTS `people`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `people` (
  `peopleid` int NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `facebook` varchar(45) DEFAULT NULL,
  `picturefile` varchar(45) NOT NULL,
  `birthday` date NOT NULL,
  PRIMARY KEY (`peopleid`),
  UNIQUE KEY `picturefile_UNIQUE` (`picturefile`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people`
--

LOCK TABLES `people` WRITE;
/*!40000 ALTER TABLE `people` DISABLE KEYS */;
INSERT INTO `people` VALUES (9001,'Mendoza','Rose','F','rose.m@gmail.com','www.facebook.com/rose.m','rosem.png','1990-01-01'),(9002,'Leandro','George','M','george.l@gmail.com','www.facebook.com/george.l','georgel.png','1990-01-02'),(9003,'Hamil','Dan','M','dan.h@gmail.com','www.facebook.com/dan.h','danh.png','1990-01-03'),(9004,'Robles','Esteban','M','esteban.r@gmail.com','www.facebook.com/esteban.r','estebanr.png','1991-01-01'),(9005,'Go','Sara','F','sara.g@gmail.com','www.facebook.com/sara.g','sarag.png','1992-01-01'),(9006,'Yulo','Leo','M','leo.y@gmail.com','www.facebook.com/leo.y','leoy.png','1993-01-01'),(9007,'Policarpio','Paul','M','paul,p@gmail.com','www.facebook.com/paul.p','paulp.png','1994-01-01'),(9008,'Reyes','Edward','M','edward.r@gmail.com','www.facebook.com/edward.r','edwardr.png','1990-01-04'),(9009,'Wong','Sandro','M','sandro.w@gmail.com','www.facebook.com/sandro.w','sandrow.png','1990-01-05'),(9010,'Que','Hadrian','M','hadrian.q@gmail.com','www.facebook.com/hadrian.q','hadrianq.png','1990-01-06'),(9011,'Tang','Kathrine','F','katrine.t@gmail.com','www.facebook.com/katrine.t','katrinet.png','1993-01-01'),(9012,'Flores','Carlos','M','carlos.f@gmail.com','www.facebook.com/carlos.f','carlosf.png','1994-01-01'),(9013,'Danilo','Vivian','F','vivian.d@gmail.com','www.facebook.com/vivan.d','viviand.png','1995-01-01'),(9014,'Valenzuela','Boying','M','b.valenzuela@gmail.com','www.facebook.com/b.valenzuela','bvalenzuela.png','1997-01-01'),(9015,'Baco','Manolo','M','manolo.b@gmail.com','www.facebook.com/manolo.b','manolob.png','1998-01-01'),(9016,'Silang','Renato','M','renato.s@gmail.com','www.facebook.com/renato.s','renatos.png','1990-03-01'),(9017,'Magtibay','Inigo','M','inigo.m@gmail.com','www.facebook.com/inigo.m','inigom.png','1999-01-01'),(9018,'Jose','Hendrick','M','hendrick.j@gmail.com','www.facebook.com/hendrick.j','hendrickj.png','1996-01-01'),(9019,'Ko','George','M',NULL,'www.facebook.com/george.k','georgek.png','1995-01-01'),(9020,'Lamsin','Ryan','M',NULL,'www.facebook.com/ryan.l','ryanl.png','1992-01-01');
/*!40000 ALTER TABLE `people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `people_mobile`
--

DROP TABLE IF EXISTS `people_mobile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `people_mobile` (
  `peopleid` int NOT NULL,
  `mobileno` bigint NOT NULL,
  PRIMARY KEY (`peopleid`,`mobileno`),
  CONSTRAINT `FKSENATOR10` FOREIGN KEY (`peopleid`) REFERENCES `people` (`peopleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `people_mobile`
--

LOCK TABLES `people_mobile` WRITE;
/*!40000 ALTER TABLE `people_mobile` DISABLE KEYS */;
INSERT INTO `people_mobile` VALUES (9001,9200000001),(9002,9200000002),(9003,9200000003),(9003,9200000698),(9004,9200000004),(9005,9200000005),(9005,9200000697),(9005,9200000763),(9006,9200000006),(9007,9200000010),(9008,9200000011),(9008,9200000700),(9009,9200000012),(9009,9200000699),(9010,9200000013),(9011,9200000014),(9012,9200000021),(9013,9200000032),(9013,9200000695),(9014,9200000043),(9014,9200000594),(9015,9200000024),(9016,9200000090),(9017,9200000091),(9018,9200000191),(9018,9200000696),(9019,9200000392),(9020,9200000493);
/*!40000 ALTER TABLE `people_mobile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `property_code` varchar(10) NOT NULL,
  `hoa_name` varchar(45) NOT NULL,
  `size` decimal(6,2) NOT NULL,
  `turnover_date` date DEFAULT NULL,
  `ho_id` int DEFAULT NULL,
  `household_id` int DEFAULT NULL,
  PRIMARY KEY (`property_code`,`hoa_name`),
  UNIQUE KEY `household_id_UNIQUE` (`household_id`),
  KEY `FKBENSON03_idx` (`hoa_name`),
  KEY `FKBENSON04_idx` (`ho_id`),
  KEY `FKJASON05_idx` (`household_id`),
  CONSTRAINT `FKBENSON03` FOREIGN KEY (`hoa_name`) REFERENCES `hoa` (`hoa_name`),
  CONSTRAINT `FKBENSON04` FOREIGN KEY (`ho_id`) REFERENCES `homeowner` (`ho_id`),
  CONSTRAINT `FKJASON05` FOREIGN KEY (`household_id`) REFERENCES `household` (`household_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES ('B01L01','SJH',25.00,'2003-01-01',9001,NULL),('B01L01','SMH',40.00,'2003-01-02',9012,NULL),('B01L02','SJH',25.00,'2003-01-02',9001,NULL),('B01L03','SJH',25.00,'2003-01-03',9002,6001),('B01L04','SJH',25.00,'2003-01-04',9002,NULL),('B01L05','SJH',25.00,'2003-01-05',9001,NULL),('B02L01','SJH',25.00,'2003-01-05',9004,NULL),('B02L02','SJH',25.00,'2003-01-04',9005,6002),('B02L03','SJH',25.00,'2003-01-03',9006,NULL),('B02L04','SJH',25.00,'2003-01-02',9001,NULL),('B02L05','SJH',25.00,'2003-01-01',9004,NULL),('B03L01','SJH',25.00,'2003-01-01',9006,NULL),('B03L02','SJH',25.00,'2003-01-01',9007,NULL),('B03L03','SJH',25.00,'2003-01-05',9008,6003),('B03L04','SJH',25.00,'2003-01-04',9009,6004),('B03L05','SJH',25.00,'2003-01-03',9011,NULL),('B04L01','SJH',30.00,'2003-01-02',9013,NULL),('B04L02','SJH',30.00,'2003-01-05',9014,NULL),('B04L03','SJH',30.00,'2003-01-03',9003,NULL),('B04L05','SJH',40.00,'2003-01-03',9010,NULL),('B04L06','SJH',25.00,'2003-01-01',9015,NULL),('B04L07','SJH',30.00,'2003-01-01',9010,NULL),('B04L08','SJH',25.00,'2003-01-01',9011,NULL),('B04L09','SJH',25.00,'2003-01-05',9012,NULL),('B04L10','SJH',25.00,'2003-01-03',9013,NULL),('B04L11','SJH',25.00,'2003-01-01',9014,NULL),('B04L12','SJH',100.00,'2003-01-05',9015,NULL),('B04L13','SJH',40.00,'2003-01-03',9006,NULL),('B04L14','SJH',40.00,'2003-01-04',9007,NULL),('B04L15','SJH',40.00,'2003-01-01',9003,NULL);
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provinces`
--

DROP TABLE IF EXISTS `provinces`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `provinces` (
  `province` varchar(45) NOT NULL,
  `region` varchar(45) NOT NULL,
  PRIMARY KEY (`province`),
  KEY `FKAMELIA01_idx` (`region`),
  CONSTRAINT `FKAMELIA01` FOREIGN KEY (`region`) REFERENCES `ref_regions` (`regions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provinces`
--

LOCK TABLES `provinces` WRITE;
/*!40000 ALTER TABLE `provinces` DISABLE KEYS */;
INSERT INTO `provinces` VALUES ('Oriental Mindoro','IV-A'),('National Capital Region','NCR');
/*!40000 ALTER TABLE `provinces` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_collectiondays`
--

DROP TABLE IF EXISTS `ref_collectiondays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_collectiondays` (
  `days` int NOT NULL,
  PRIMARY KEY (`days`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_collectiondays`
--

LOCK TABLES `ref_collectiondays` WRITE;
/*!40000 ALTER TABLE `ref_collectiondays` DISABLE KEYS */;
INSERT INTO `ref_collectiondays` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
/*!40000 ALTER TABLE `ref_collectiondays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_ornumbers`
--

DROP TABLE IF EXISTS `ref_ornumbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_ornumbers` (
  `ornum` int NOT NULL,
  PRIMARY KEY (`ornum`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_ornumbers`
--

LOCK TABLES `ref_ornumbers` WRITE;
/*!40000 ALTER TABLE `ref_ornumbers` DISABLE KEYS */;
INSERT INTO `ref_ornumbers` VALUES (3000001),(3000002),(3000003),(3000004),(3000005),(3000006),(3000007),(3000008),(3000009),(3000010),(3000011),(3000012),(3000013),(3000014),(3000015),(3000016),(3000017),(3000018),(3000019),(3000020),(3000021),(3000022),(3000023),(3000024),(3000025),(3000026),(3000027),(3000028),(3000029),(3000030);
/*!40000 ALTER TABLE `ref_ornumbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_positions`
--

DROP TABLE IF EXISTS `ref_positions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_positions` (
  `position` varchar(45) NOT NULL,
  PRIMARY KEY (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_positions`
--

LOCK TABLES `ref_positions` WRITE;
/*!40000 ALTER TABLE `ref_positions` DISABLE KEYS */;
INSERT INTO `ref_positions` VALUES ('Auditor'),('President'),('Secretary'),('Treasurer'),('Vice-President');
/*!40000 ALTER TABLE `ref_positions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ref_regions`
--

DROP TABLE IF EXISTS `ref_regions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ref_regions` (
  `regions` varchar(45) NOT NULL,
  PRIMARY KEY (`regions`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ref_regions`
--

LOCK TABLES `ref_regions` WRITE;
/*!40000 ALTER TABLE `ref_regions` DISABLE KEYS */;
INSERT INTO `ref_regions` VALUES ('IV-A'),('NCR');
/*!40000 ALTER TABLE `ref_regions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resident_idcards`
--

DROP TABLE IF EXISTS `resident_idcards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resident_idcards` (
  `card_number` int NOT NULL,
  `requested_date` date NOT NULL,
  `request_reason` varchar(45) NOT NULL,
  `provided_date` date DEFAULT NULL,
  `ornum` int DEFAULT NULL,
  `fee` decimal(9,2) NOT NULL,
  `resident_id` int NOT NULL,
  `cancelled` tinyint(1) NOT NULL,
  `ofcr_hoid` int NOT NULL,
  `position` varchar(45) NOT NULL,
  `election_date` date NOT NULL,
  PRIMARY KEY (`card_number`),
  UNIQUE KEY `ORnum_UNIQUE` (`ornum`),
  KEY `FKGABRIEL02_idx` (`resident_id`),
  KEY `FKSENATOR01_idx` (`ofcr_hoid`,`position`,`election_date`),
  CONSTRAINT `FKGABRIEL02` FOREIGN KEY (`resident_id`) REFERENCES `residents` (`resident_id`),
  CONSTRAINT `FKJERICHO01` FOREIGN KEY (`ornum`) REFERENCES `ref_ornumbers` (`ornum`),
  CONSTRAINT `FKSENATOR01` FOREIGN KEY (`ofcr_hoid`, `position`, `election_date`) REFERENCES `officer` (`ho_id`, `position`, `election_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resident_idcards`
--

LOCK TABLES `resident_idcards` WRITE;
/*!40000 ALTER TABLE `resident_idcards` DISABLE KEYS */;
INSERT INTO `resident_idcards` VALUES (5201,'2022-11-03','Security','2022-11-04',NULL,0.00,9002,1,9004,'President','2022-12-01'),(5202,'2022-11-05','Security','2022-11-05',3000002,100.00,9002,0,9004,'President','2022-12-01'),(5203,'2022-11-05','Barangay Identification','2022-11-05',NULL,0.00,9016,1,9003,'Vice-President','2022-12-01'),(5204,'2022-11-10','Barangay Identification','2022-11-15',3000003,100.00,9016,0,9010,'Treasurer','2022-12-01');
/*!40000 ALTER TABLE `resident_idcards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `residents`
--

DROP TABLE IF EXISTS `residents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `residents` (
  `resident_id` int NOT NULL,
  `renter` tinyint(1) NOT NULL,
  `relationship` varchar(45) NOT NULL,
  `undertaking` tinyint(1) NOT NULL,
  `authorized` enum('Yes','No') NOT NULL,
  `household_id` int DEFAULT NULL,
  `last_update` date NOT NULL,
  PRIMARY KEY (`resident_id`),
  KEY `FKGABRIEL01_idx` (`household_id`),
  CONSTRAINT `FKGABRIEL01` FOREIGN KEY (`household_id`) REFERENCES `household` (`household_id`),
  CONSTRAINT `FKSENATOR06` FOREIGN KEY (`resident_id`) REFERENCES `people` (`peopleid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residents`
--

LOCK TABLES `residents` WRITE;
/*!40000 ALTER TABLE `residents` DISABLE KEYS */;
INSERT INTO `residents` VALUES (9002,0,'None',1,'Yes',6001,'2022-06-10'),(9005,1,'None',1,'Yes',6002,'2022-06-10'),(9008,1,'None',1,'Yes',6003,'2022-06-10'),(9009,1,'None',1,'No',6004,'2022-06-10'),(9016,1,'Friend',1,'No',6005,'2022-06-10'),(9017,0,'Friend',1,'No',6006,'2022-06-10'),(9018,0,'Relative',1,'No',6006,'2022-06-10'),(9019,0,'Relative',1,'No',6002,'2022-06-10'),(9020,1,'Landlord',1,'Yes',6003,'2022-06-10');
/*!40000 ALTER TABLE `residents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zipcodes`
--

DROP TABLE IF EXISTS `zipcodes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `zipcodes` (
  `barangay` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `province` varchar(45) NOT NULL,
  `zipcode` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`barangay`,`city`,`province`),
  KEY `FKNORM06_idx` (`province`),
  CONSTRAINT `FKNORM06` FOREIGN KEY (`province`) REFERENCES `provinces` (`province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zipcodes`
--

LOCK TABLES `zipcodes` WRITE;
/*!40000 ALTER TABLE `zipcodes` DISABLE KEYS */;
INSERT INTO `zipcodes` VALUES ('Alabang','Muntinlupa','National Capital Region','1775'),('Bayanan','Lamesa','Oriental Mindoro','1801'),('Bayanan','Muntinlupa','National Capital Region','1771'),('Poblacion','Calapan','Oriental Mindoro','1800'),('Tunasan','Muntinlupa','National Capital Region','1770');
/*!40000 ALTER TABLE `zipcodes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-04-05 15:47:09
