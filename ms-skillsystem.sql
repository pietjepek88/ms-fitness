-- --------------------------------------------------------
-- Host:                         141.95.6.121
-- Server version:               10.3.31-MariaDB-0ubuntu0.20.04.1 - Ubuntu 20.04
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for s8790_Middenstad3
CREATE DATABASE IF NOT EXISTS `s8790_Middenstad3` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `s8790_Middenstad3`;

-- Dumping structure for table s8790_Middenstad3.pepe-skills
CREATE TABLE IF NOT EXISTS `pepe-skills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `stamina` varchar(255) NOT NULL,
  `strength` varchar(255) NOT NULL,
  `driving` varchar(255) DEFAULT NULL,
  `shooting` varchar(255) DEFAULT NULL,
  `fishing` varchar(255) DEFAULT NULL,
  `drugs` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

-- Dumping data for table s8790_Middenstad3.pepe-skills: ~1 rows (approximately)
/*!40000 ALTER TABLE `pepe-skills` DISABLE KEYS */;
INSERT INTO `pepe-skills` (`id`, `identifier`, `stamina`, `strength`, `driving`, `shooting`, `fishing`, `drugs`) VALUES
	(47, 'NFU65346', '20', '0', '0', '0', '0', '0');
/*!40000 ALTER TABLE `pepe-skills` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
