-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: qr_payments
-- ------------------------------------------------------
-- Server version	8.0.33

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
  `UID` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `NombreCompleto` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `PasswordHash` longblob NOT NULL,
  `PasswordSalt` longblob NOT NULL,
  `Email` varchar(160) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Rol` tinyint(1) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (4,'b7235781-18a5-4041-aa56-f626c316eda3','CARLOS ADRIAN ARAYA RAMIREZ','adrian19921',_binary '∞\ŒU\⁄[<\≈>¯•òR÷ù\ÀH\Í2-\ÎÅ>º.í\Õ]1!dÇ%ˆzBip9üc^1U†ñı\ƒ\–5\·H\–Wç^Ç\»',_binary '\\\ŸF\¬ˆ	ıIÄ.˜Äﬁ∞,º-D\œS\ÌV∏G\‰fı∏¢]TÅ	©C\ƒbåêä™W\ÔV.Ã∂˘˜Zm\≈i¸Ñ`∂öàö\Ïj\‘	\“\Z\”1\≈€º€ùX\⁄Ú∞^GΩ=hm\ÔÅ\Â\⁄.èLT\Ê\¬>$˝Æf\◊\‰\”0:3ú´\’°bÆtx\ﬂ','adrian@gmail.com',1),(5,'9fbf5823-2cd6-4ef9-a1a7-ebd0a268e750','PEDRO GUZMAN VIZCAINO','pedro123',_binary 'I<qµ+çJr\0kjü\Í1P¯ }tGúØ0ì≠[\ÿ`≥\Ó¢ÊÄõÙ¯18≤v\ÎK‘∫i˝$\œjgu,?',_binary '0-H9F¬ØmmOó$êπÃç&\Êõ‘Å©Z˚Ü˝o\⁄\›]∂19<ã\‘\‡\Á∞ÈÆ©)0M^ú\›`\«\¬BzîPÿåﬂ©`=Y]%)üxc®4%\‘OÚÓáü?U¨i\ÈpÛm®Hºí;\0ù{?|M˛+û˛\Õ>EaÑ\Ã˘¿\›~G','pedro@gmail.com',1),(6,'53e8b8a8-6efb-4d15-a14c-cadb2bd5f141','SARA PATRICIA CHAVEZ MAYORGA','sara123',_binary '\«/04õ\Î˝‘∑Úú&‘´\À‹ìØ\È¿XõE\◊\€#˛ó)-…óÜô\Ì≠O\€Ò`\ﬁ|\n¸\‹\”À≠lX\\\"QJßVµ2',_binary '®\Ó/™=†M\‡\—~t@Ç\‘ak[Xc\’\„7A\ \Â[5?n›Æìú¡∫\—>îvxˆñ§\‡™}Ù\Ëi.\ÿ4\ F@}íln\·Öa≥è˘\Œ\Í\ﬁ\‚96ã#πØùoãW\nm\⁄\rq[dë\€-Gaa\–‘åk¯˝y\⁄[M\—ˆ=.Pl,G\n#','sara@gmail.com',1);
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

-- Dump completed on 2023-06-29 17:42:40
