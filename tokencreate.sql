-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.31 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table mlps.m_user_type
DROP TABLE IF EXISTS `m_user_type`;
CREATE TABLE IF NOT EXISTS `m_user_type` (
  `m_user_type_id` smallint NOT NULL AUTO_INCREMENT,
  `user_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `redirect_url` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_by` int unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT (now()),
  `updated_by` int DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`m_user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table mlps.m_user_type: ~4 rows (approximately)
INSERT INTO `m_user_type` (`m_user_type_id`, `user_type`, `redirect_url`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_deleted`) VALUES
	(10, 'Admin', 'home.php', 0, '2024-09-21 15:51:28', NULL, NULL, 0);

-- Dumping structure for table mlps.user_login
DROP TABLE IF EXISTS `user_login`;
CREATE TABLE IF NOT EXISTS `user_login` (
  `user_login_id` smallint NOT NULL AUTO_INCREMENT,
  `m_user_type_id` smallint DEFAULT NULL,
  `user_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pass_word` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'MD5',
  `created_by` int unsigned NOT NULL DEFAULT '0',
  `created_on` datetime NOT NULL DEFAULT (now()),
  `updated_by` int DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_login_id`) USING BTREE,
  KEY `m_user_type_id` (`m_user_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table mlps.user_login: ~30 rows (approximately)
INSERT INTO `user_login` (`user_login_id`, `m_user_type_id`, `user_name`, `email_id`, `pass_word`, `created_by`, `created_on`, `updated_by`, `updated_on`, `is_deleted`) VALUES
	(1, 10, 'Boobalan', 'boobalan@gmail.com', '2c28f461c80b4a83a1943b4c6ea2c35f', 0, '2024-09-25 09:54:32', NULL, NULL, 0);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
