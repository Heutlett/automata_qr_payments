-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: qr_payments
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `Id` int NOT NULL AUTO_INCREMENT,
  `UID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `PasswordHash` longblob NOT NULL,
  `PasswordSalt` longblob NOT NULL,
  `Email` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `Rol` int NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'d1c075ef-0b56-4441-8f92-28056959a0e5','adrian19921',_binary '˜\'\≈˝¥K.tr\Ô\–\÷oA˙+¨\’3T\Ê=ıÅ\‘∞\›\Ï\Œ@´:C}éx≤\ÃB\n≥ßù\Œ≠˚eﬂÖæ˜2ÒÄ\›',_binary '¶é<.[}1ø¡´ÖE–Ω\≈$¯\ŒÛ[¥?Û\∆\‘*Ö¥j\Zˇq<ÒájT5\\ØY5ßo6Gû\Î\¬\ÿ@4\≈ˆ€áßºØ˝\Ó¿l≠ÖW\ŒW7r$§CBuÄB˚`\Î§,õ\»)å\Ëm\∆7[.ﬁ≠µ∑q\‡_(ÑéÚ1ΩØäFyú\n\ÊQ','carlosadrian19921@gmail.com',1),(2,'2b80c5fb-ae4e-4a3f-88c2-288230358455','pedro123',_binary '6Nª\√É\¬\0•\Ó£\Óu+øM<]_ˇ_\ZûNä%K;≠–µ\ﬁñ·óù©0¬ù1\ÿg‹ïô$0üIøßÛßÿÄ',_binary 'Åìb˝4»æSu\Ô\Óï\0\\\Ÿx]\–:S\⁄ˇ˙àOú>\Í\rq¨—äg>%~¥*h\"hÚY\…›≥V\„%?Ø”émT!|\Õ”Ö4…∂H\Áµ\œk©gÑxâò^ \‚Ru!múä¯™î¸^\Z\"øxÜ@∞~\¬I¢ı\‡∏IŒ°(  cÚ','pedro123@gmail.com',1),(3,'65d0b892-f275-401a-ba2a-57f3efe1f6e2','sara123',_binary '\Õ?∂†	*\Ë\∆wsTôûQwJ\‰¢fHÜﬂ®zaBh\ﬂg´hFpu\Ê¿qP\≈ı/vè”ìgá\Óˇ\÷\⁄,\Œ\◊$',_binary 'Vn\∆#¿\Óç{öµúÄ_f¥3\—7Uü˜~$Nµ\√ko˛◊≥kÉ†Q\∆\ﬁS¸J“ÉDv\"îΩ\Ì(f\Íà\\ÚcWRZ/†\÷7NIù\n”åΩ\Õ\¬@ó\»z6ı!(¡˝’∏œÇ\‹@6J\ÎàO˝2SRiØ_G™©`êPêBY/\Ã\ÊFözºì\«','sara@gmail.com',1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-03 13:17:05
