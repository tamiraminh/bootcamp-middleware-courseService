-- MySQL dump 10.13  Distrib 8.0.23, for Win64 (x86_64)
--
-- Host: localhost    Database: bootcampcrud
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `ID` varchar(36) NOT NULL,
  `ClientName` varchar(255) DEFAULT NULL,
  `PhotographerName` varchar(255) DEFAULT NULL,
  `Package` varchar(100) DEFAULT NULL,
  `DateTime` varchar(50) DEFAULT NULL,
  `Location` varchar(255) DEFAULT NULL,
  `Status` enum('confirmed','pending','canceled') DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES ('2a342f95-1669-4182-9443-fd0e67db4f18','Tim Tam','Tamir','Potrait Session','2023-08-15 10:00','City Park','confirmed','2023-08-02 15:38:33',NULL,NULL),('771f5893-4af8-4a17-a6b2-d42a5bbbb4be','Tim Tam Update','Tamir Update','Wedding Photo Session','2023-08-15 10:00','City Park','confirmed','2023-08-02 02:28:23','2023-08-02 02:58:48','2023-08-02 03:07:52'),('bb3c1f0a-76fc-4f45-b1b8-3ebfb9861760','Alice Johnson','Emily Davis','Portrait Session','2023-08-15 10:00','City Park','confirmed',NULL,NULL,NULL),('be3d6e72-4659-492c-9d54-47e9ed9f6e45','Bob Smith','Michael Brown','Wedding Photography','2023-09-02 14:30','Beach Resort','confirmed',NULL,NULL,NULL),('c1c1e32f-03da-4e22-a77b-e6e31e11ff6a','Ella Rodriguez','James Miller','Engagement Shoot','2023-08-28 16:30','Botanical Gardens','confirmed',NULL,NULL,NULL),('e9a81996-1a6e-4c35-9270-96f470fb7d7e','Claire Turner','John Anderson','Family Portraits','2023-08-25 11:45','Studio','pending',NULL,NULL,NULL),('eead8462-80e1-4e25-9e5b-66d7191c11e7','David Lee','Sophia White','Event Photography','2023-09-10 18:00','Grand Ballroom','confirmed',NULL,NULL,NULL);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `id` varchar(36) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `userId` varchar(36) DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `createdBy` varchar(36) DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  `updatedBy` varchar(36) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `userId` (`userId`),
  CONSTRAINT `course_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('0ad650f4-89f6-4d13-91ef-35047e7c16ce','bootcamp course 1','content bootcamp course 1','652be4ab-a8c5-4876-9d8b-616c4e992598','2023-08-03 20:48:02','652be4ab-a8c5-4876-9d8b-616c4e992598',NULL,NULL,NULL,NULL),('56edc460-14ba-4fb5-aed1-e163244686af','bootcamp course 2','content bootcamp course 2','652be4ab-a8c5-4876-9d8b-616c4e992598','2023-08-03 20:57:26','652be4ab-a8c5-4876-9d8b-616c4e992598',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'Introduction to Backend Engineering','Getting Started','Fundamentals','An overview of backend engineering and its importance.'),(2,'Backend Development Tools','Tools of the Trade','Fundamentals','Introduction to various tools and technologies used in backend development.'),(3,'Server-side Programming with Node.js','Node.js Basics','Programming','Learn about server-side programming using Node.js.'),(4,'Database Design and Management','Database Fundamentals','Database','Understanding database design and management principles.'),(5,'API Development','Building RESTful APIs','APIs','How to design and build RESTful APIs for backend services.'),(6,'Authentication and Authorization','Securing Backend Services','Security','Implementing authentication and authorization mechanisms.'),(7,'Error Handling and Logging','Best Practices for Error Handling','Error Handling','Managing errors and implementing effective logging strategies.'),(8,'Performance Optimization','Optimizing Backend Services','Performance','Techniques to optimize the performance of backend services.'),(9,'Testing and Test Automation','Ensuring Code Quality','Testing','Introduction to testing and automated testing in backend engineering.'),(10,'Deployment and DevOps','Deploying Backend Applications','DevOps','Understanding deployment and DevOps practices for backend projects.'),(11,'Scaling and Load Balancing','Handling High Traffic','Performance','Strategies for scaling backend systems and implementing load balancing.'),(12,'Caching and Performance','Improving Response Time','Performance','Using caching to enhance the performance of backend services.'),(13,'Security Best Practices','Protecting Against Threats','Security','Best practices for securing backend applications and data.'),(14,'Version Control with Git','Collaborative Development','Tools','Introduction to version control using Git for team collaboration.'),(15,'Continuous Integration and Deployment','Automating the Deployment Pipeline','DevOps','Implementing CI/CD for efficient and automated deployment.'),(16,'update v2 sample title 16','update sample subtitle 16','update sample cat\' 16','update sample description 16'),(17,'sample title 17','sample subtitle 17','sample category 17','sample description 17'),(18,'sample title 18','sample subtitle 18','sample category 18','sample description 18'),(20,'sample title 20','sample subtitle 20','sample category 20','sample description 20'),(21,'sample title 21','sample subtitle 21','sample category 21','sample description 21'),(22,'sample title 22','sample subtitle 22','sample category 22','sample description 22'),(23,'sample title 23','sample subtitle 23','sample category 23','sample description 23'),(24,'sample title 20','sample subtitle 20','sample category 20','sample description 20'),(25,'sample title 20','sample subtitle 20','sample category 20','sample description 20');
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` varchar(36) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` enum('teacher','student') DEFAULT NULL,
  `createdAt` timestamp NULL DEFAULT NULL,
  `createdBy` varchar(36) DEFAULT NULL,
  `updatedAt` timestamp NULL DEFAULT NULL,
  `updatedBy` varchar(36) DEFAULT NULL,
  `deletedAt` timestamp NULL DEFAULT NULL,
  `deletedBy` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('5a33433c-a9f8-4a06-8442-30d3fe754526','tamir student','tamir student','$2a$14$wlBzUvGVtIrVBwk24sF9oemavDGW2GfWl4lCjrk8WNvXmawiUJlCC','student','2023-08-03 21:01:52','5a33433c-a9f8-4a06-8442-30d3fe754526',NULL,NULL,NULL,NULL),('652be4ab-a8c5-4876-9d8b-616c4e992598','tamiramin','tamiramin','$2a$14$ypiRoWNH3r/3FpAJM5q4uu4SxifJitLzbyIS47gCcF8i2HBGstKHq','teacher','2023-08-03 00:24:27','652be4ab-a8c5-4876-9d8b-616c4e992598','2023-08-03 06:56:23','652be4ab-a8c5-4876-9d8b-616c4e992598',NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-04 11:16:27
