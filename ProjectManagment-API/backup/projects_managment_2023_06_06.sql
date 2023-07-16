/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: agreement
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `agreement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imagePath` varchar(250) DEFAULT 'images/default/default-placeholder-150x150.png',
  `projectId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projectId_idx` (`projectId`),
  CONSTRAINT `projectId` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 24 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: checks_imgs
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `checks_imgs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `checksImgPath` varchar(250) DEFAULT NULL,
  `payId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `payFk_idx` (`payId`),
  CONSTRAINT `payFk` FOREIGN KEY (`payId`) REFERENCES `project_pays` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 6 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: employee
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `bankAccount` varchar(45) DEFAULT NULL,
  `bankBranch` varchar(45) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` varchar(45) DEFAULT 'null',
  `isActive` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 45 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: employeeDailyWage
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `employeeDailyWage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employeeId` int(11) DEFAULT NULL,
  `dailyWage` int(11) DEFAULT NULL,
  `startFromDate` varchar(45) DEFAULT '2021-10-01T00:00:00.000Z',
  PRIMARY KEY (`id`),
  KEY `id_idx` (`employeeId`),
  CONSTRAINT `id` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 54 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: employeesTimeSheet
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `employeesTimeSheet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(50) DEFAULT NULL,
  `employeeId` int(11) DEFAULT NULL,
  `startAt` varchar(50) DEFAULT NULL,
  `endAt` varchar(50) DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `payPerDay` float DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `employeeId` (`employeeId`),
  CONSTRAINT `fk_employeeId` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 2231 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: mafreaot
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `mafreaot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employeeId` int(11) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `notes` varchar(45) DEFAULT NULL,
  `createdAt` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 41 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: project_notes
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `project_notes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectId` int(11) DEFAULT NULL,
  `notes` varchar(250) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `projectFK_idx` (`projectId`),
  CONSTRAINT `projectNotesFk` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 11 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: project_pays
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `project_pays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paidDate` datetime DEFAULT NULL,
  `projectId` int(11) NOT NULL,
  `paid` int(11) NOT NULL,
  `method` enum('cash', 'check', 'other') DEFAULT 'cash',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `notes` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `projectFK_idx` (`projectId`),
  CONSTRAINT `projectFK` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: project_quotation
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `project_quotation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectId` int(11) NOT NULL,
  `quotation` int(11) NOT NULL DEFAULT '0',
  `notes` varchar(250) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `projectfk_idx` (`projectId`),
  CONSTRAINT `projectQFK` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 42 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: projects
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `projects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `projectName` varchar(250) NOT NULL,
  `clientFullName` varchar(45) NOT NULL,
  `clientPhone` varchar(45) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `createdAt` varchar(45) DEFAULT NULL,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 217 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: salary
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `salary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employeeId` int(11) DEFAULT NULL,
  `salary` varchar(45) DEFAULT '0',
  `salaryDate` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `empFK_idx` (`employeeId`),
  CONSTRAINT `empFK` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 140 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: settings
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(200) DEFAULT NULL,
  `owner` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `license_code` varchar(250) DEFAULT NULL,
  `expaier_date` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `password` varchar(250) NOT NULL,
  `role` enum('User', 'Admin') NOT NULL DEFAULT 'User',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: workedProjects
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `workedProjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dayId` int(11) NOT NULL,
  `projectId` int(11) NOT NULL,
  `notes` varchar(250) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `pk_dayId_idx` (`dayId`),
  KEY `pk_projectId_idx` (`projectId`),
  CONSTRAINT `pk_dayId` FOREIGN KEY (`dayId`) REFERENCES `employeesTimeSheet` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `pk_projectId` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 2993 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: agreement
# ------------------------------------------------------------

INSERT INTO
  `agreement` (`id`, `imagePath`, `projectId`)
VALUES
  (13, 'images/agreements/210-1673367560717.png', 210);
INSERT INTO
  `agreement` (`id`, `imagePath`, `projectId`)
VALUES
  (22, 'images/agreements/209-1673175744092.jpg', 209);
INSERT INTO
  `agreement` (`id`, `imagePath`, `projectId`)
VALUES
  (23, 'images/agreements/154-1676632652956.png', 154);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: checks_imgs
# ------------------------------------------------------------

INSERT INTO
  `checks_imgs` (`id`, `checksImgPath`, `payId`, `createdAt`)
VALUES
  (
    2,
    'images/checks/209/209-1673435425916.png',
    6,
    '2023-01-11 11:10:26'
  );
INSERT INTO
  `checks_imgs` (`id`, `checksImgPath`, `payId`, `createdAt`)
VALUES
  (
    3,
    'images/checks/209/209-1673437634532.png',
    1,
    '2023-01-11 11:41:35'
  );
INSERT INTO
  `checks_imgs` (`id`, `checksImgPath`, `payId`, `createdAt`)
VALUES
  (
    5,
    'images/checks/210/210-1673783049307.png',
    7,
    '2023-01-15 11:44:09'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: employee
# ------------------------------------------------------------

INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    13,
    'בהאא',
    'אבו גנב',
    '0532810466',
    '0',
    '0000',
    '2021-09-30 12:05:27',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    14,
    'אמגד ',
    'אבו גנב',
    '0000000000000',
    '0',
    '00000',
    '2021-09-30 13:13:37',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    15,
    'ניראן',
    'אבו טריך',
    '00000000000',
    '0',
    '00000',
    '2021-09-30 13:14:07',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    16,
    'ארקאן',
    'אבו גנב',
    '00000000000',
    '0',
    '00000',
    '2021-09-30 13:14:35',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    17,
    'חמזה',
    'כסרא',
    '00000000000',
    '0',
    '00000',
    '2021-09-30 13:14:56',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    18,
    'ויסאם',
    'חאג',
    '00000000000',
    '0',
    '00000',
    '2021-10-08 11:30:57',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    19,
    'הלאל',
    'אבו גנב',
    '00000000000',
    '0',
    '00000',
    '2021-11-21 11:33:14',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    20,
    'דועאא',
    'מולא',
    '00000000000',
    '0',
    '0',
    '2021-11-22 07:27:51',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    21,
    'סלימאן',
    'אבו גנב',
    '00000000000',
    '0',
    '0000',
    '2022-01-18 12:41:23',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    22,
    'ביאן',
    'אבו גנב',
    '00000000000',
    '0',
    '0',
    '2022-06-17 21:57:07',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    23,
    'סנד',
    'סנד',
    '00000000000',
    '0',
    '000',
    '2022-06-18 08:34:31',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    24,
    'חמזה',
    'חמזה',
    '00000000000',
    '0',
    '00',
    '2022-06-18 20:23:26',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    25,
    'מחמד',
    'מחמד',
    '00000000000',
    '0',
    '00',
    '2022-06-18 20:29:52',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    26,
    'טהא',
    'טהא',
    '00',
    '0',
    '000',
    '2022-08-17 14:36:59',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    27,
    'סגיע',
    'אבו גנב',
    '00000000000',
    '0',
    '000',
    '2022-09-18 09:38:59',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    28,
    'ראזי',
    'אבו גנב',
    '00000000000',
    '0',
    '0000',
    '2022-09-18 09:39:15',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    29,
    'קוסי',
    'קוסי',
    '00000000000',
    '0',
    '00000',
    '2022-09-18 14:12:38',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    30,
    'בשאר',
    'בשאר',
    '0',
    '0',
    '0',
    '2022-10-12 07:11:53',
    'null',
    0
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    31,
    'וסים',
    'וסים',
    '0',
    '0',
    '0',
    '2022-10-12 07:26:08',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    38,
    'אבראהים',
    'אבראהים',
    '00000000000',
    '0',
    '00000',
    '2022-11-28 22:33:14',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    39,
    'טארק',
    'טארק',
    '00000000000',
    '0',
    '00000',
    '2022-11-28 22:51:13',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    41,
    'רונן',
    'רונן',
    '0000000000',
    '000',
    '000',
    '2023-01-22 12:06:19',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    42,
    'מאלק',
    'מאלק',
    '00000000000',
    '000',
    '00000',
    '2023-04-12 20:43:09',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    43,
    'חמודי',
    'חמודי',
    '00000000000',
    '000',
    '00000',
    '2023-04-12 20:44:16',
    'null',
    1
  );
INSERT INTO
  `employee` (
    `id`,
    `firstName`,
    `lastName`,
    `phone`,
    `bankAccount`,
    `bankBranch`,
    `createdAt`,
    `updatedAt`,
    `isActive`
  )
VALUES
  (
    44,
    'מחמד',
    'חדש',
    '00000000000',
    '000',
    '00000',
    '2023-05-06 21:59:59',
    'null',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: employeeDailyWage
# ------------------------------------------------------------

INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (15, 13, 400, '2021-09-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (17, 14, 380, '2021-09-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (18, 16, 310, '2021-09-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (19, 17, 320, '2021-09-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (20, 15, 280, '2021-09-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (21, 18, 370, '2021-09-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (22, 13, 400, '2021-10-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (23, 17, 330, '2021-10-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (24, 19, 280, '2021-10-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (25, 20, 2500, '2021-09-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (26, 21, 380, '2021-12-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (27, 13, 430, '2022-02-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (28, 21, 400, '2022-02-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (29, 25, 220, '2022-05-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (30, 23, 300, '2022-05-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (31, 24, 300, '2022-05-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (32, 22, 300, '2022-06-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (33, 22, 300, '2022-05-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (34, 25, 200, '2022-06-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (35, 13, 450, '2022-07-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (36, 26, 290, '2022-07-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (37, 27, 200, '2022-06-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (38, 27, 200, '2022-06-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (39, 29, 300, '2022-08-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (40, 28, 200, '2022-07-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (41, 28, 200, '2022-06-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (42, 24, 330, '2022-07-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (43, 26, 310, '2022-08-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (44, 25, 220, '2022-08-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (45, 31, 310, '2022-09-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (46, 30, 300, '2022-09-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (47, 39, 280, '2022-11-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (48, 24, 340, '2022-11-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (49, 31, 300, '2022-11-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (50, 38, 250, '2022-10-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (51, 41, 280, '2022-11-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (52, 43, 100, '2023-01-01 00:00:00');
INSERT INTO
  `employeeDailyWage` (`id`, `employeeId`, `dailyWage`, `startFromDate`)
VALUES
  (53, 42, 100, '2023-01-01 00:00:00');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: employeesTimeSheet
# ------------------------------------------------------------

INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    144,
    '2021-09-01',
    13,
    '2021-09-01T04:00:00.000Z',
    '2021-09-01T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    145,
    '2021-09-01',
    17,
    '2021-09-01T04:00:00.000Z',
    '2021-09-01T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    146,
    '2021-09-01',
    14,
    '2021-09-01T04:00:00.000Z',
    '2021-09-01T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    147,
    '2021-09-01',
    15,
    '2021-09-01T04:00:00.000Z',
    '2021-09-01T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    148,
    '2021-09-01',
    16,
    '2021-09-01T04:00:00.000Z',
    '2021-09-01T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    149,
    '2021-09-02',
    13,
    '2021-09-02T04:00:00.000Z',
    '2021-09-02T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    150,
    '2021-09-02',
    15,
    '2021-09-02T04:00:00.000Z',
    '2021-09-02T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    151,
    '2021-09-02',
    15,
    '2021-09-02T04:00:00.000Z',
    '2021-09-02T09:00:00.000Z',
    4.5,
    148,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    152,
    '2021-09-02',
    16,
    '2021-09-02T04:00:00.000Z',
    '2021-09-02T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    153,
    '2021-09-02',
    14,
    '2021-09-02T04:00:00.000Z',
    '2021-09-02T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    154,
    '2021-09-03',
    13,
    '2021-09-03T04:00:00.000Z',
    '2021-09-03T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    155,
    '2021-09-03',
    17,
    '2021-09-03T04:00:00.000Z',
    '2021-09-03T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    156,
    '2021-09-03',
    16,
    '2021-09-03T04:00:00.000Z',
    '2021-09-03T11:00:00.000Z',
    6.5,
    237,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    157,
    '2021-09-03',
    14,
    '2021-09-03T04:00:00.000Z',
    '2021-09-03T11:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    158,
    '2021-09-05',
    13,
    '2021-09-05T04:00:00.000Z',
    '2021-09-05T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    159,
    '2021-09-05',
    17,
    '2021-09-05T04:00:00.000Z',
    '2021-09-05T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    160,
    '2021-09-05',
    14,
    '2021-09-05T04:00:00.000Z',
    '2021-09-05T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    161,
    '2021-09-05',
    15,
    '2021-09-05T04:00:00.000Z',
    '2021-09-05T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    162,
    '2021-09-05',
    16,
    '2021-09-05T04:00:00.000Z',
    '2021-09-05T12:00:00.000Z',
    7.5,
    274,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    163,
    '2021-09-06',
    16,
    '2021-09-06T04:00:00.000Z',
    '2021-09-06T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    164,
    '2021-09-06',
    14,
    '2021-09-06T04:00:00.000Z',
    '2021-09-06T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    165,
    '2021-09-06',
    17,
    '2021-09-06T04:00:00.000Z',
    '2021-09-06T09:00:00.000Z',
    4.5,
    169,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    166,
    '2021-09-07',
    17,
    '2021-09-07T04:00:00.000Z',
    '2021-09-07T10:30:00.000Z',
    6,
    226,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    167,
    '2021-09-07',
    13,
    '2021-09-07T04:00:00.000Z',
    '2021-09-07T10:30:00.000Z',
    6,
    282,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    168,
    '2021-09-08',
    16,
    '2021-09-08T04:00:00.000Z',
    '2021-09-08T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    169,
    '2021-09-08',
    14,
    '2021-09-08T04:00:00.000Z',
    '2021-09-08T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    170,
    '2021-09-09',
    13,
    '2021-09-09T04:00:00.000Z',
    '2021-09-09T09:00:00.000Z',
    4.5,
    212,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    171,
    '2021-09-09',
    17,
    '2021-09-09T04:00:00.000Z',
    '2021-09-09T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    172,
    '2021-09-09',
    16,
    '2021-09-09T04:00:00.000Z',
    '2021-09-09T13:00:00.000Z',
    8.5,
    310,
    'המשך סידור מחסן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    173,
    '2021-09-09',
    14,
    '2021-09-09T04:00:00.000Z',
    '2021-09-09T13:00:00.000Z',
    8.5,
    380,
    'המשך סידור מחסן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    174,
    '2021-09-12',
    13,
    '2021-09-12T04:00:00.000Z',
    '2021-09-12T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    175,
    '2021-09-12',
    17,
    '2021-09-12T04:00:00.000Z',
    '2021-09-12T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    176,
    '2021-09-12',
    14,
    '2021-09-12T04:00:00.000Z',
    '2021-09-12T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    177,
    '2021-09-12',
    16,
    '2021-09-12T04:00:00.000Z',
    '2021-09-12T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    178,
    '2021-09-13',
    17,
    '2021-09-13T04:00:00.000Z',
    '2021-09-13T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    179,
    '2021-09-13',
    16,
    '2021-09-13T04:00:00.000Z',
    '2021-09-13T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    180,
    '2021-09-13',
    14,
    '2021-09-13T04:00:00.000Z',
    '2021-09-13T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    181,
    '2021-09-14',
    13,
    '2021-09-14T04:00:00.000Z',
    '2021-09-14T13:00:00.000Z',
    8.5,
    400,
    'הכנות מיים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    182,
    '2021-09-14',
    17,
    '2021-09-14T04:00:00.000Z',
    '2021-09-14T13:00:00.000Z',
    8.5,
    320,
    'הכנות מיים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    183,
    '2021-09-14',
    14,
    '2021-09-14T04:00:00.000Z',
    '2021-09-14T13:00:00.000Z',
    8.5,
    380,
    'הכנות מיים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    184,
    '2021-09-14',
    16,
    '2021-09-14T04:00:00.000Z',
    '2021-09-14T13:00:00.000Z',
    8.5,
    310,
    'הכנות מיים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    185,
    '2021-09-15',
    18,
    '2021-09-15T04:00:00.000Z',
    '2021-09-15T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    186,
    '2021-09-15',
    13,
    '2021-09-15T04:00:00.000Z',
    '2021-09-15T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    187,
    '2021-09-15',
    17,
    '2021-09-15T04:00:00.000Z',
    '2021-09-15T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    188,
    '2021-09-15',
    16,
    '2021-09-15T04:00:00.000Z',
    '2021-09-15T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    189,
    '2021-09-15',
    14,
    '2021-09-15T04:00:00.000Z',
    '2021-09-15T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    190,
    '2021-09-16',
    17,
    '2021-09-16T04:00:00.000Z',
    '2021-09-16T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    191,
    '2021-09-16',
    18,
    '2021-09-16T04:00:00.000Z',
    '2021-09-16T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    192,
    '2021-09-16',
    13,
    '2021-09-16T04:00:00.000Z',
    '2021-09-16T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    193,
    '2021-09-16',
    14,
    '2021-09-16T04:00:00.000Z',
    '2021-09-16T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    194,
    '2021-09-16',
    16,
    '2021-09-16T04:00:00.000Z',
    '2021-09-16T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    195,
    '2021-09-17',
    13,
    '2021-09-17T04:00:00.000Z',
    '2021-09-17T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    196,
    '2021-09-17',
    18,
    '2021-09-17T06:30:00.000Z',
    '2021-09-17T11:00:00.000Z',
    4,
    174,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    197,
    '2021-09-17',
    14,
    '2021-09-17T04:00:00.000Z',
    '2021-09-17T11:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    198,
    '2021-09-17',
    16,
    '2021-09-17T04:00:00.000Z',
    '2021-09-17T11:00:00.000Z',
    6.5,
    237,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    199,
    '2021-09-19',
    13,
    '2021-09-19T04:00:00.000Z',
    '2021-09-19T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    200,
    '2021-09-19',
    16,
    '2021-09-19T04:00:00.000Z',
    '2021-09-19T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    201,
    '2021-09-19',
    18,
    '2021-09-19T04:00:00.000Z',
    '2021-09-19T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    202,
    '2021-09-19',
    14,
    '2021-09-19T04:00:00.000Z',
    '2021-09-19T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    203,
    '2021-09-19',
    17,
    '2021-09-19T04:00:00.000Z',
    '2021-09-19T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    204,
    '2021-09-20',
    14,
    '2021-09-20T04:00:00.000Z',
    '2021-09-20T13:00:00.000Z',
    8.5,
    380,
    'קוי מים צריכה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    205,
    '2021-09-20',
    16,
    '2021-09-20T04:00:00.000Z',
    '2021-09-20T13:00:00.000Z',
    8.5,
    310,
    'קוי מים צריכה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    206,
    '2021-09-20',
    18,
    '2021-09-20T04:00:00.000Z',
    '2021-09-20T13:00:00.000Z',
    8.5,
    370,
    'קוי מים צריכה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    207,
    '2021-09-20',
    17,
    '2021-09-20T04:00:00.000Z',
    '2021-09-20T06:00:00.000Z',
    1.5,
    56,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    208,
    '2021-09-20',
    13,
    '2021-09-20T04:00:00.000Z',
    '2021-09-20T13:00:00.000Z',
    8.5,
    400,
    'עם אחמד חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    209,
    '2021-09-21',
    17,
    '2021-09-21T04:00:00.000Z',
    '2021-09-21T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    210,
    '2021-09-21',
    13,
    '2021-09-21T04:00:00.000Z',
    '2021-09-21T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    211,
    '2021-09-21',
    16,
    '2021-09-21T04:00:00.000Z',
    '2021-09-21T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    212,
    '2021-09-21',
    14,
    '2021-09-21T04:00:00.000Z',
    '2021-09-21T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    213,
    '2021-09-21',
    18,
    '2021-09-21T04:00:00.000Z',
    '2021-09-21T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    214,
    '2021-09-22',
    13,
    '2021-09-22T04:00:00.000Z',
    '2021-09-22T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    215,
    '2021-09-22',
    16,
    '2021-09-22T04:00:00.000Z',
    '2021-09-22T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    216,
    '2021-09-22',
    18,
    '2021-09-22T04:00:00.000Z',
    '2021-09-22T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    217,
    '2021-09-22',
    14,
    '2021-09-22T04:00:00.000Z',
    '2021-09-22T11:30:00.000Z',
    7,
    313,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    218,
    '2021-09-22',
    17,
    '2021-09-22T04:00:00.000Z',
    '2021-09-22T11:30:00.000Z',
    7,
    264,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    219,
    '2021-09-23',
    13,
    '2021-09-23T04:00:00.000Z',
    '2021-09-23T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    220,
    '2021-09-23',
    18,
    '2021-09-23T04:00:00.000Z',
    '2021-09-23T08:00:00.000Z',
    3.5,
    152,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    221,
    '2021-09-23',
    17,
    '2021-09-23T04:00:00.000Z',
    '2021-09-23T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    222,
    '2021-09-23',
    16,
    '2021-09-23T04:00:00.000Z',
    '2021-09-23T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    223,
    '2021-09-23',
    14,
    '2021-09-23T04:00:00.000Z',
    '2021-09-23T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    224,
    '2021-09-24',
    13,
    '2021-09-24T04:00:00.000Z',
    '2021-09-24T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    225,
    '2021-09-24',
    16,
    '2021-09-24T04:00:00.000Z',
    '2021-09-24T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    226,
    '2021-09-24',
    17,
    '2021-09-24T04:00:00.000Z',
    '2021-09-24T11:00:00.000Z',
    6.5,
    245,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    227,
    '2021-09-24',
    14,
    '2021-09-24T04:00:00.000Z',
    '2021-09-24T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    228,
    '2021-09-24',
    18,
    '2021-09-24T04:00:00.000Z',
    '2021-09-24T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    229,
    '2021-09-26',
    16,
    '2021-09-26T04:00:00.000Z',
    '2021-09-26T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    230,
    '2021-09-26',
    14,
    '2021-09-26T04:00:00.000Z',
    '2021-09-26T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    231,
    '2021-09-26',
    13,
    '2021-09-26T04:00:00.000Z',
    '2021-09-26T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    232,
    '2021-09-26',
    17,
    '2021-09-26T04:00:00.000Z',
    '2021-09-26T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    233,
    '2021-09-26',
    18,
    '2021-09-26T04:00:00.000Z',
    '2021-09-26T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    234,
    '2021-09-27',
    13,
    '2021-09-27T04:00:00.000Z',
    '2021-09-27T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    235,
    '2021-09-27',
    18,
    '2021-09-27T04:00:00.000Z',
    '2021-09-27T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    236,
    '2021-09-27',
    17,
    '2021-09-27T04:00:00.000Z',
    '2021-09-27T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    237,
    '2021-09-27',
    16,
    '2021-09-27T04:00:00.000Z',
    '2021-09-27T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    238,
    '2021-09-27',
    14,
    '2021-09-27T04:00:00.000Z',
    '2021-09-27T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    239,
    '2021-09-28',
    18,
    '2021-09-28T04:00:00.000Z',
    '2021-09-28T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    240,
    '2021-09-28',
    17,
    '2021-09-28T04:00:00.000Z',
    '2021-09-28T13:00:00.000Z',
    8.5,
    320,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    241,
    '2021-09-28',
    13,
    '2021-09-28T04:00:00.000Z',
    '2021-09-28T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    242,
    '2021-09-28',
    16,
    '2021-09-28T04:00:00.000Z',
    '2021-09-28T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    243,
    '2021-09-28',
    14,
    '2021-09-28T04:00:00.000Z',
    '2021-09-28T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    244,
    '2021-09-29',
    16,
    '2021-09-29T04:00:00.000Z',
    '2021-09-29T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    245,
    '2021-09-29',
    13,
    '2021-09-29T04:00:00.000Z',
    '2021-09-29T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    246,
    '2021-09-29',
    17,
    '2021-09-29T04:00:00.000Z',
    '2021-09-29T11:00:00.000Z',
    6.5,
    245,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    247,
    '2021-09-29',
    18,
    '2021-09-29T04:00:00.000Z',
    '2021-09-29T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    248,
    '2021-09-29',
    14,
    '2021-09-29T04:00:00.000Z',
    '2021-09-29T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    249,
    '2021-09-30',
    16,
    '2021-09-30T04:00:00.000Z',
    '2021-09-30T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    250,
    '2021-09-30',
    14,
    '2021-09-30T04:00:00.000Z',
    '2021-09-30T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    251,
    '2021-09-30',
    13,
    '2021-09-30T04:00:00.000Z',
    '2021-09-30T08:00:00.000Z',
    3.5,
    165,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    252,
    '2021-09-30',
    17,
    '2021-09-30T04:00:00.000Z',
    '2021-09-30T08:00:00.000Z',
    3.5,
    132,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    287,
    '2021-10-01',
    14,
    '2021-10-01T04:00:00.000Z',
    '2021-10-01T13:00:00.000Z',
    8.5,
    380,
    'מול הנוף תיקון נזילה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    288,
    '2021-10-01',
    16,
    '2021-10-01T04:00:00.000Z',
    '2021-10-01T13:00:00.000Z',
    8.5,
    310,
    'מול הנוף תיקון נזילה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    289,
    '2021-10-03',
    17,
    '2021-10-03T04:00:00.000Z',
    '2021-10-03T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    290,
    '2021-10-03',
    13,
    '2021-10-03T04:00:00.000Z',
    '2021-10-03T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    291,
    '2021-10-03',
    14,
    '2021-10-03T04:00:00.000Z',
    '2021-10-03T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    292,
    '2021-10-03',
    16,
    '2021-10-03T04:00:00.000Z',
    '2021-10-03T12:00:00.000Z',
    7.5,
    274,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    293,
    '2021-10-03',
    18,
    '2021-10-03T04:00:00.000Z',
    '2021-10-03T12:30:00.000Z',
    8,
    348,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    294,
    '2021-10-04',
    17,
    '2021-10-04T04:00:00.000Z',
    '2021-10-04T08:00:00.000Z',
    4,
    155,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    295,
    '2021-10-04',
    13,
    '2021-10-04T04:00:00.000Z',
    '2021-10-04T08:00:00.000Z',
    4,
    188,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    296,
    '2021-10-04',
    14,
    '2021-10-04T04:00:00.000Z',
    '2021-10-04T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    297,
    '2021-10-04',
    16,
    '2021-10-04T04:00:00.000Z',
    '2021-10-04T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    298,
    '2021-10-05',
    13,
    '2021-10-05T04:00:00.000Z',
    '2021-10-05T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    299,
    '2021-10-05',
    16,
    '2021-10-05T04:00:00.000Z',
    '2021-10-05T13:00:00.000Z',
    8.5,
    310,
    'תיקון בית מוריס עבאס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    300,
    '2021-10-05',
    14,
    '2021-10-05T04:00:00.000Z',
    '2021-10-05T13:00:00.000Z',
    8.5,
    380,
    'תיקון בית מוריס עבאס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    301,
    '2021-10-06',
    13,
    '2021-10-06T04:00:00.000Z',
    '2021-10-06T10:30:00.000Z',
    6,
    282,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    302,
    '2021-10-06',
    17,
    '2021-10-06T04:00:00.000Z',
    '2021-10-06T10:30:00.000Z',
    6,
    233,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    303,
    '2021-10-06',
    19,
    '2021-10-06T04:00:00.000Z',
    '2021-10-06T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    304,
    '2021-10-06',
    14,
    '2021-10-06T04:00:00.000Z',
    '2021-10-06T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    305,
    '2021-10-06',
    16,
    '2021-10-06T04:00:00.000Z',
    '2021-10-06T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    306,
    '2021-10-07',
    13,
    '2021-10-07T04:00:00.000Z',
    '2021-10-07T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    307,
    '2021-10-07',
    19,
    '2021-10-07T04:00:00.000Z',
    '2021-10-07T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    308,
    '2021-10-07',
    16,
    '2021-10-07T04:00:00.000Z',
    '2021-10-07T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    309,
    '2021-10-07',
    14,
    '2021-10-07T04:00:00.000Z',
    '2021-10-07T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    310,
    '2021-10-08',
    19,
    '2021-10-08T04:00:00.000Z',
    '2021-10-08T09:00:00.000Z',
    4.5,
    148,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    311,
    '2021-10-08',
    13,
    '2021-10-08T04:00:00.000Z',
    '2021-10-08T09:00:00.000Z',
    4.5,
    212,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    312,
    '2021-10-08',
    14,
    '2021-10-08T05:00:00.000Z',
    '2021-10-08T10:00:00.000Z',
    4.5,
    201,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    313,
    '2021-10-08',
    16,
    '2021-10-08T05:00:00.000Z',
    '2021-10-08T10:00:00.000Z',
    4.5,
    164,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    314,
    '2021-10-10',
    13,
    '2021-10-10T04:00:00.000Z',
    '2021-10-10T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    315,
    '2021-10-10',
    18,
    '2021-10-10T04:00:00.000Z',
    '2021-10-10T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    316,
    '2021-10-10',
    14,
    '2021-10-10T04:00:00.000Z',
    '2021-10-10T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    317,
    '2021-10-10',
    19,
    '2021-10-10T04:00:00.000Z',
    '2021-10-10T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    318,
    '2021-10-11',
    18,
    '2021-10-11T04:00:00.000Z',
    '2021-10-11T13:00:00.000Z',
    8.5,
    370,
    'המשיכו בירכא'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    319,
    '2021-10-11',
    13,
    '2021-10-11T04:00:00.000Z',
    '2021-10-11T13:00:00.000Z',
    8.5,
    400,
    'המשיכו בירכא'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    320,
    '2021-10-11',
    17,
    '2021-10-11T04:00:00.000Z',
    '2021-10-11T13:00:00.000Z',
    8.5,
    330,
    'המשיכו בירכא'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    321,
    '2021-10-11',
    14,
    '2021-10-11T04:30:00.000Z',
    '2021-10-11T13:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    322,
    '2021-10-11',
    16,
    '2021-10-11T04:30:00.000Z',
    '2021-10-11T13:00:00.000Z',
    8,
    292,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    323,
    '2021-10-11',
    19,
    '2021-10-11T04:30:00.000Z',
    '2021-10-11T13:00:00.000Z',
    8,
    264,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    324,
    '2021-10-13',
    13,
    '2021-10-13T04:00:00.000Z',
    '2021-10-13T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    325,
    '2021-10-13',
    18,
    '2021-10-13T04:00:00.000Z',
    '2021-10-13T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    326,
    '2021-10-13',
    14,
    '2021-10-13T04:00:00.000Z',
    '2021-10-13T13:00:00.000Z',
    8.5,
    380,
    'הכנות גג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    327,
    '2021-10-13',
    16,
    '2021-10-13T04:00:00.000Z',
    '2021-10-13T13:00:00.000Z',
    8.5,
    310,
    'הכנות גג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    328,
    '2021-10-12',
    13,
    '2021-10-12T04:00:00.000Z',
    '2021-10-12T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    329,
    '2021-10-12',
    19,
    '2021-10-12T04:00:00.000Z',
    '2021-10-12T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    330,
    '2021-10-12',
    14,
    '2021-10-12T04:00:00.000Z',
    '2021-10-12T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    331,
    '2021-10-12',
    18,
    '2021-10-12T04:00:00.000Z',
    '2021-10-12T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    332,
    '2021-10-12',
    16,
    '2021-10-12T04:00:00.000Z',
    '2021-10-12T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    333,
    '2021-10-14',
    19,
    '2021-10-14T04:00:00.000Z',
    '2021-10-14T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    334,
    '2021-10-14',
    18,
    '2021-10-14T04:00:00.000Z',
    '2021-10-14T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    335,
    '2021-10-14',
    16,
    '2021-10-14T04:00:00.000Z',
    '2021-10-14T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    336,
    '2021-10-14',
    14,
    '2021-10-14T04:00:00.000Z',
    '2021-10-14T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    337,
    '2021-10-17',
    13,
    '2021-10-17T04:00:00.000Z',
    '2021-10-17T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    338,
    '2021-10-17',
    19,
    '2021-10-17T04:00:00.000Z',
    '2021-10-17T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    339,
    '2021-10-17',
    18,
    '2021-10-17T04:00:00.000Z',
    '2021-10-17T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    340,
    '2021-10-17',
    14,
    '2021-10-17T04:00:00.000Z',
    '2021-10-17T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    341,
    '2021-10-17',
    16,
    '2021-10-17T04:00:00.000Z',
    '2021-10-17T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    342,
    '2021-10-18',
    13,
    '2021-10-18T04:00:00.000Z',
    '2021-10-18T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    343,
    '2021-10-18',
    19,
    '2021-10-18T04:00:00.000Z',
    '2021-10-18T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    344,
    '2021-10-18',
    18,
    '2021-10-18T04:00:00.000Z',
    '2021-10-18T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    345,
    '2021-10-18',
    16,
    '2021-10-18T04:00:00.000Z',
    '2021-10-18T15:00:00.000Z',
    10.5,
    383,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    346,
    '2021-10-18',
    14,
    '2021-10-18T04:00:00.000Z',
    '2021-10-18T15:00:00.000Z',
    10.5,
    469,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    347,
    '2021-10-19',
    13,
    '2021-10-19T04:00:00.000Z',
    '2021-10-19T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    348,
    '2021-10-19',
    19,
    '2021-10-19T04:00:00.000Z',
    '2021-10-19T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    349,
    '2021-10-19',
    18,
    '2021-10-19T04:00:00.000Z',
    '2021-10-19T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    350,
    '2021-10-19',
    14,
    '2021-10-19T04:00:00.000Z',
    '2021-10-19T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    351,
    '2021-10-20',
    13,
    '2021-10-20T04:00:00.000Z',
    '2021-10-20T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    352,
    '2021-10-20',
    18,
    '2021-10-20T04:00:00.000Z',
    '2021-10-20T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    353,
    '2021-10-20',
    14,
    '2021-10-20T04:00:00.000Z',
    '2021-10-20T13:00:00.000Z',
    8.5,
    380,
    'מול הנוף הכנות גג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    354,
    '2021-10-20',
    16,
    '2021-10-20T04:00:00.000Z',
    '2021-10-20T13:00:00.000Z',
    8.5,
    310,
    'מול הנוף הכנות גג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    355,
    '2021-10-20',
    19,
    '2021-10-20T04:00:00.000Z',
    '2021-10-20T13:00:00.000Z',
    8.5,
    280,
    'סארי הכנות גג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    356,
    '2021-10-21',
    18,
    '2021-10-21T04:00:00.000Z',
    '2021-10-21T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    357,
    '2021-10-21',
    13,
    '2021-10-21T04:00:00.000Z',
    '2021-10-21T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    358,
    '2021-10-21',
    19,
    '2021-10-21T04:00:00.000Z',
    '2021-10-21T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    359,
    '2021-10-21',
    14,
    '2021-10-21T04:00:00.000Z',
    '2021-10-21T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    360,
    '2021-10-22',
    18,
    '2021-10-22T04:00:00.000Z',
    '2021-10-22T10:00:00.000Z',
    5.5,
    239,
    'חיבור משאבות'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    361,
    '2021-10-22',
    13,
    '2021-10-22T04:00:00.000Z',
    '2021-10-22T10:00:00.000Z',
    5.5,
    259,
    'חיבור משאבות'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    362,
    '2021-10-22',
    19,
    '2021-10-22T04:00:00.000Z',
    '2021-10-22T10:00:00.000Z',
    5.5,
    181,
    'חיבור משאבות'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    363,
    '2021-10-22',
    14,
    '2021-10-22T04:00:00.000Z',
    '2021-10-22T10:00:00.000Z',
    5.5,
    246,
    'ויאם '
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    364,
    '2021-10-22',
    16,
    '2021-10-22T04:00:00.000Z',
    '2021-10-22T10:00:00.000Z',
    5.5,
    201,
    'ויאם '
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    365,
    '2021-10-24',
    18,
    '2021-10-24T04:00:00.000Z',
    '2021-10-24T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    366,
    '2021-10-24',
    14,
    '2021-10-24T04:00:00.000Z',
    '2021-10-24T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    367,
    '2021-10-24',
    16,
    '2021-10-24T04:00:00.000Z',
    '2021-10-24T10:00:00.000Z',
    5.5,
    201,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    368,
    '2021-10-24',
    19,
    '2021-10-24T04:00:00.000Z',
    '2021-10-24T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    369,
    '2021-10-25',
    14,
    '2021-10-25T04:00:00.000Z',
    '2021-10-25T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    370,
    '2021-10-25',
    16,
    '2021-10-25T04:00:00.000Z',
    '2021-10-25T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    371,
    '2021-10-25',
    18,
    '2021-10-25T04:00:00.000Z',
    '2021-10-25T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    372,
    '2021-10-25',
    19,
    '2021-10-25T04:30:00.000Z',
    '2021-10-25T13:00:00.000Z',
    8,
    264,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    373,
    '2021-10-26',
    16,
    '2021-10-26T04:00:00.000Z',
    '2021-10-26T13:00:00.000Z',
    8.5,
    310,
    'קווי ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    374,
    '2021-10-26',
    19,
    '2021-10-26T04:00:00.000Z',
    '2021-10-26T13:00:00.000Z',
    8.5,
    280,
    'קווי ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    375,
    '2021-10-26',
    18,
    '2021-10-26T04:00:00.000Z',
    '2021-10-26T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    376,
    '2021-10-26',
    14,
    '2021-10-26T04:00:00.000Z',
    '2021-10-26T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    377,
    '2021-10-27',
    18,
    '2021-10-27T04:00:00.000Z',
    '2021-10-27T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    378,
    '2021-10-27',
    14,
    '2021-10-27T04:00:00.000Z',
    '2021-10-27T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    379,
    '2021-10-27',
    16,
    '2021-10-27T05:30:00.000Z',
    '2021-10-27T13:00:00.000Z',
    7,
    255,
    'וסים קוי ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    380,
    '2021-10-28',
    14,
    '2021-10-28T04:00:00.000Z',
    '2021-10-28T13:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    381,
    '2021-10-28',
    19,
    '2021-10-28T04:00:00.000Z',
    '2021-10-28T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    382,
    '2021-10-28',
    16,
    '2021-10-28T04:00:00.000Z',
    '2021-10-28T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    383,
    '2021-10-28',
    18,
    '2021-10-28T04:00:00.000Z',
    '2021-10-28T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    384,
    '2021-10-29',
    14,
    '2021-10-29T07:00:00.000Z',
    '2021-10-29T12:00:00.000Z',
    4.5,
    201,
    'לואי אבו גב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    385,
    '2021-10-29',
    16,
    '2021-10-29T07:00:00.000Z',
    '2021-10-29T12:00:00.000Z',
    4.5,
    164,
    'לואי אבו גב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    386,
    '2021-10-31',
    19,
    '2021-10-31T05:00:00.000Z',
    '2021-10-31T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    387,
    '2021-10-31',
    18,
    '2021-10-31T05:00:00.000Z',
    '2021-10-31T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    388,
    '2021-10-31',
    13,
    '2021-10-31T05:00:00.000Z',
    '2021-10-31T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    389,
    '2021-10-31',
    16,
    '2021-10-31T05:00:00.000Z',
    '2021-10-31T12:00:00.000Z',
    6.5,
    237,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    390,
    '2021-10-31',
    14,
    '2021-10-31T05:00:00.000Z',
    '2021-10-31T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    391,
    '2021-10-15',
    16,
    '2021-10-15T04:00:00.000Z',
    '2021-10-15T08:45:00.000Z',
    4.25,
    155,
    'חצי יום'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    392,
    '2021-10-02',
    20,
    '2021-10-03T04:00:00.000Z',
    '2021-10-03T13:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    404,
    '2021-11-01',
    13,
    '2021-11-01T05:00:00.000Z',
    '2021-11-01T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    405,
    '2021-11-01',
    18,
    '2021-11-01T05:00:00.000Z',
    '2021-11-01T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    406,
    '2021-11-01',
    14,
    '2021-11-01T05:00:00.000Z',
    '2021-11-01T11:30:00.000Z',
    6,
    268,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    407,
    '2021-11-02',
    13,
    '2021-11-02T05:00:00.000Z',
    '2021-11-02T11:00:00.000Z',
    5.5,
    259,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    408,
    '2021-11-02',
    18,
    '2021-11-02T05:00:00.000Z',
    '2021-11-02T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    409,
    '2021-11-02',
    14,
    '2021-11-02T05:00:00.000Z',
    '2021-11-02T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    410,
    '2021-11-02',
    16,
    '2021-11-02T05:00:00.000Z',
    '2021-11-02T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    411,
    '2021-11-03',
    13,
    '2021-11-03T05:00:00.000Z',
    '2021-11-03T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    412,
    '2021-11-03',
    19,
    '2021-11-03T05:00:00.000Z',
    '2021-11-03T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    413,
    '2021-11-03',
    18,
    '2021-11-03T05:00:00.000Z',
    '2021-11-03T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    414,
    '2021-11-03',
    16,
    '2021-11-03T05:00:00.000Z',
    '2021-11-03T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    415,
    '2021-11-04',
    16,
    '2021-11-04T05:00:00.000Z',
    '2021-11-04T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    416,
    '2021-11-04',
    14,
    '2021-11-04T05:00:00.000Z',
    '2021-11-04T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    417,
    '2021-11-04',
    18,
    '2021-11-04T05:00:00.000Z',
    '2021-11-04T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    418,
    '2021-11-04',
    13,
    '2021-11-04T05:00:00.000Z',
    '2021-11-04T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    419,
    '2021-11-04',
    19,
    '2021-11-04T05:00:00.000Z',
    '2021-11-04T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    420,
    '2021-11-05',
    18,
    '2021-11-05T05:00:00.000Z',
    '2021-11-05T11:30:00.000Z',
    6,
    261,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    421,
    '2021-11-05',
    13,
    '2021-11-05T05:00:00.000Z',
    '2021-11-05T11:30:00.000Z',
    6,
    282,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    422,
    '2021-11-05',
    14,
    '2021-11-05T05:00:00.000Z',
    '2021-11-05T11:30:00.000Z',
    6,
    268,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    423,
    '2021-11-05',
    16,
    '2021-11-05T05:00:00.000Z',
    '2021-11-05T11:30:00.000Z',
    6,
    219,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    424,
    '2021-11-05',
    19,
    '2021-11-05T05:00:00.000Z',
    '2021-11-05T11:30:00.000Z',
    6,
    198,
    'לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    425,
    '2021-11-07',
    18,
    '2021-11-07T05:00:00.000Z',
    '2021-11-07T14:00:00.000Z',
    8.5,
    370,
    'המשך לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    426,
    '2021-11-07',
    13,
    '2021-11-07T05:00:00.000Z',
    '2021-11-07T14:00:00.000Z',
    8.5,
    400,
    'המשך לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    427,
    '2021-11-07',
    14,
    '2021-11-07T05:30:00.000Z',
    '2021-11-07T13:30:00.000Z',
    7.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    428,
    '2021-11-07',
    16,
    '2021-11-07T05:30:00.000Z',
    '2021-11-07T13:30:00.000Z',
    7.5,
    274,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    429,
    '2021-11-08',
    13,
    '2021-11-08T05:00:00.000Z',
    '2021-11-08T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    430,
    '2021-11-08',
    19,
    '2021-11-08T05:00:00.000Z',
    '2021-11-08T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    431,
    '2021-11-08',
    18,
    '2021-11-08T05:00:00.000Z',
    '2021-11-08T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    432,
    '2021-11-08',
    16,
    '2021-11-08T05:00:00.000Z',
    '2021-11-08T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    433,
    '2021-11-08',
    14,
    '2021-11-08T05:00:00.000Z',
    '2021-11-08T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    434,
    '2021-11-09',
    13,
    '2021-11-09T05:00:00.000Z',
    '2021-11-09T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    435,
    '2021-11-09',
    18,
    '2021-11-09T05:00:00.000Z',
    '2021-11-09T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    436,
    '2021-11-09',
    19,
    '2021-11-09T05:30:00.000Z',
    '2021-11-09T14:00:00.000Z',
    8,
    264,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    437,
    '2021-11-09',
    16,
    '2021-11-09T05:30:00.000Z',
    '2021-11-09T14:00:00.000Z',
    8,
    292,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    438,
    '2021-11-09',
    14,
    '2021-11-09T05:30:00.000Z',
    '2021-11-09T14:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    439,
    '2021-11-10',
    18,
    '2021-11-10T05:00:00.000Z',
    '2021-11-10T14:00:00.000Z',
    8.5,
    370,
    'קווי מיים ראשי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    440,
    '2021-11-10',
    13,
    '2021-11-10T05:00:00.000Z',
    '2021-11-10T14:00:00.000Z',
    8.5,
    400,
    'קווי מיים ראשי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    441,
    '2021-11-10',
    19,
    '2021-11-10T05:00:00.000Z',
    '2021-11-10T14:00:00.000Z',
    8.5,
    280,
    'קווי מיים ראשי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    442,
    '2021-11-10',
    16,
    '2021-11-10T05:00:00.000Z',
    '2021-11-10T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    443,
    '2021-11-10',
    14,
    '2021-11-10T05:00:00.000Z',
    '2021-11-10T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    444,
    '2021-11-11',
    13,
    '2021-11-11T05:00:00.000Z',
    '2021-11-11T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    445,
    '2021-11-11',
    19,
    '2021-11-11T05:00:00.000Z',
    '2021-11-11T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    446,
    '2021-11-11',
    18,
    '2021-11-11T05:00:00.000Z',
    '2021-11-11T14:00:00.000Z',
    8.5,
    370,
    'המשך עם לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    447,
    '2021-11-11',
    16,
    '2021-11-11T05:00:00.000Z',
    '2021-11-11T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    448,
    '2021-11-11',
    14,
    '2021-11-11T05:00:00.000Z',
    '2021-11-11T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    449,
    '2021-11-12',
    18,
    '2021-11-12T05:00:00.000Z',
    '2021-11-12T11:30:00.000Z',
    6,
    261,
    'אצל לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    450,
    '2021-11-12',
    13,
    '2021-11-12T05:00:00.000Z',
    '2021-11-12T11:30:00.000Z',
    6,
    282,
    'אצל לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    451,
    '2021-11-12',
    19,
    '2021-11-12T05:00:00.000Z',
    '2021-11-12T11:30:00.000Z',
    6,
    198,
    'אצל לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    452,
    '2021-11-12',
    14,
    '2021-11-12T05:00:00.000Z',
    '2021-11-12T11:30:00.000Z',
    6,
    268,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    453,
    '2021-11-12',
    16,
    '2021-11-12T05:00:00.000Z',
    '2021-11-12T11:30:00.000Z',
    6,
    219,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    454,
    '2021-11-14',
    19,
    '2021-11-14T05:00:00.000Z',
    '2021-11-14T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    455,
    '2021-11-14',
    13,
    '2021-11-14T05:00:00.000Z',
    '2021-11-14T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    456,
    '2021-11-14',
    14,
    '2021-11-14T05:00:00.000Z',
    '2021-11-14T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    457,
    '2021-11-14',
    18,
    '2021-11-14T05:00:00.000Z',
    '2021-11-14T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    458,
    '2021-11-14',
    16,
    '2021-11-14T05:00:00.000Z',
    '2021-11-14T12:30:00.000Z',
    7,
    255,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    459,
    '2021-11-15',
    19,
    '2021-11-15T05:00:00.000Z',
    '2021-11-15T14:00:00.000Z',
    8.5,
    280,
    'המשך לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    460,
    '2021-11-15',
    13,
    '2021-11-15T05:00:00.000Z',
    '2021-11-15T17:00:00.000Z',
    11.5,
    541,
    'המשך לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    461,
    '2021-11-15',
    18,
    '2021-11-15T05:00:00.000Z',
    '2021-11-15T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    462,
    '2021-11-15',
    16,
    '2021-11-15T05:00:00.000Z',
    '2021-11-15T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    463,
    '2021-11-15',
    14,
    '2021-11-15T05:00:00.000Z',
    '2021-11-15T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    464,
    '2021-11-16',
    14,
    '2021-11-16T05:30:00.000Z',
    '2021-11-16T14:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    465,
    '2021-11-16',
    19,
    '2021-11-16T05:30:00.000Z',
    '2021-11-16T14:00:00.000Z',
    8,
    264,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    466,
    '2021-11-16',
    18,
    '2021-11-16T05:00:00.000Z',
    '2021-11-16T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    467,
    '2021-11-16',
    16,
    '2021-11-16T05:00:00.000Z',
    '2021-11-16T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    468,
    '2021-11-16',
    13,
    '2021-11-16T05:00:00.000Z',
    '2021-11-16T17:00:00.000Z',
    11.5,
    541,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    469,
    '2021-11-17',
    16,
    '2021-11-17T05:00:00.000Z',
    '2021-11-17T14:00:00.000Z',
    8.5,
    310,
    'צימר לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    470,
    '2021-11-17',
    13,
    '2021-11-17T05:00:00.000Z',
    '2021-11-17T14:00:00.000Z',
    8.5,
    400,
    'צימר לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    471,
    '2021-11-17',
    14,
    '2021-11-17T05:00:00.000Z',
    '2021-11-17T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    472,
    '2021-11-17',
    19,
    '2021-11-17T05:00:00.000Z',
    '2021-11-17T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    473,
    '2021-11-17',
    18,
    '2021-11-17T05:00:00.000Z',
    '2021-11-17T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    474,
    '2021-11-18',
    13,
    '2021-11-18T05:00:00.000Z',
    '2021-11-18T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    475,
    '2021-11-18',
    19,
    '2021-11-18T05:00:00.000Z',
    '2021-11-18T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    476,
    '2021-11-18',
    14,
    '2021-11-18T05:00:00.000Z',
    '2021-11-18T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    477,
    '2021-11-18',
    18,
    '2021-11-18T05:00:00.000Z',
    '2021-11-18T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    478,
    '2021-11-18',
    16,
    '2021-11-18T05:00:00.000Z',
    '2021-11-18T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    479,
    '2021-11-19',
    13,
    '2021-11-19T05:00:00.000Z',
    '2021-11-19T12:00:00.000Z',
    6.5,
    306,
    'צימר לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    480,
    '2021-11-19',
    19,
    '2021-11-19T05:00:00.000Z',
    '2021-11-19T12:00:00.000Z',
    6.5,
    214,
    'צימר לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    481,
    '2021-11-19',
    14,
    '2021-11-19T05:00:00.000Z',
    '2021-11-19T12:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    482,
    '2021-11-19',
    16,
    '2021-11-19T05:00:00.000Z',
    '2021-11-19T12:00:00.000Z',
    6.5,
    237,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    483,
    '2021-11-21',
    13,
    '2021-11-21T05:00:00.000Z',
    '2021-11-21T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    484,
    '2021-11-21',
    18,
    '2021-11-21T05:00:00.000Z',
    '2021-11-21T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    485,
    '2021-11-21',
    16,
    '2021-11-21T05:00:00.000Z',
    '2021-11-21T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    486,
    '2021-11-21',
    14,
    '2021-11-21T05:00:00.000Z',
    '2021-11-21T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    487,
    '2021-11-22',
    19,
    '2021-11-22T05:00:00.000Z',
    '2021-11-22T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    488,
    '2021-11-22',
    13,
    '2021-11-22T05:00:00.000Z',
    '2021-11-22T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    489,
    '2021-11-22',
    14,
    '2021-11-22T05:00:00.000Z',
    '2021-11-22T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    490,
    '2021-11-22',
    16,
    '2021-11-22T05:00:00.000Z',
    '2021-11-22T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    491,
    '2021-11-22',
    18,
    '2021-11-22T05:00:00.000Z',
    '2021-11-22T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    492,
    '2021-11-23',
    19,
    '2021-11-23T05:00:00.000Z',
    '2021-11-23T12:00:00.000Z',
    6.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    493,
    '2021-11-23',
    13,
    '2021-11-23T05:00:00.000Z',
    '2021-11-23T12:00:00.000Z',
    6.5,
    306,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    494,
    '2021-11-23',
    14,
    '2021-11-23T05:00:00.000Z',
    '2021-11-23T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    495,
    '2021-11-23',
    18,
    '2021-11-23T05:00:00.000Z',
    '2021-11-23T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    496,
    '2021-11-24',
    16,
    '2021-11-24T05:00:00.000Z',
    '2021-11-24T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    497,
    '2021-11-24',
    13,
    '2021-11-24T05:00:00.000Z',
    '2021-11-24T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    498,
    '2021-11-24',
    18,
    '2021-11-24T05:00:00.000Z',
    '2021-11-24T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    499,
    '2021-11-24',
    19,
    '2021-11-24T05:00:00.000Z',
    '2021-11-24T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    500,
    '2021-11-25',
    18,
    '2021-11-25T05:00:00.000Z',
    '2021-11-25T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    501,
    '2021-11-25',
    14,
    '2021-11-25T05:00:00.000Z',
    '2021-11-25T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    502,
    '2021-11-25',
    19,
    '2021-11-25T05:00:00.000Z',
    '2021-11-25T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    503,
    '2021-11-25',
    16,
    '2021-11-25T05:00:00.000Z',
    '2021-11-25T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    504,
    '2021-11-26',
    18,
    '2021-11-26T05:00:00.000Z',
    '2021-11-26T12:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    505,
    '2021-11-26',
    13,
    '2021-11-26T05:00:00.000Z',
    '2021-11-26T12:00:00.000Z',
    6.5,
    306,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    506,
    '2021-11-26',
    19,
    '2021-11-26T05:00:00.000Z',
    '2021-11-26T12:00:00.000Z',
    6.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    507,
    '2021-11-26',
    16,
    '2021-11-26T06:30:00.000Z',
    '2021-11-26T12:00:00.000Z',
    5,
    182,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    508,
    '2021-11-28',
    13,
    '2021-11-28T05:00:00.000Z',
    '2021-11-28T09:00:00.000Z',
    4,
    188,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    509,
    '2021-11-28',
    18,
    '2021-11-28T05:00:00.000Z',
    '2021-11-28T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    510,
    '2021-11-28',
    14,
    '2021-11-28T05:00:00.000Z',
    '2021-11-28T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    511,
    '2021-11-29',
    13,
    '2021-11-29T05:00:00.000Z',
    '2021-11-29T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    512,
    '2021-11-29',
    18,
    '2021-11-29T05:00:00.000Z',
    '2021-11-29T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    513,
    '2021-11-29',
    19,
    '2021-11-29T05:00:00.000Z',
    '2021-11-29T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    514,
    '2021-11-29',
    16,
    '2021-11-29T05:00:00.000Z',
    '2021-11-29T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    515,
    '2021-11-29',
    14,
    '2021-11-29T05:00:00.000Z',
    '2021-11-29T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    516,
    '2021-11-30',
    18,
    '2021-11-30T05:00:00.000Z',
    '2021-11-30T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    517,
    '2021-11-30',
    13,
    '2021-11-30T05:00:00.000Z',
    '2021-11-30T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    518,
    '2021-11-30',
    19,
    '2021-11-30T05:00:00.000Z',
    '2021-11-30T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    519,
    '2021-11-30',
    14,
    '2021-11-30T05:30:00.000Z',
    '2021-11-30T14:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    520,
    '2021-11-30',
    16,
    '2021-11-30T05:30:00.000Z',
    '2021-11-30T14:00:00.000Z',
    8,
    292,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    521,
    '2021-11-01',
    20,
    '2021-11-01T05:00:00.000Z',
    '2021-11-01T14:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    522,
    '2021-11-19',
    18,
    '2021-11-19T05:00:00.000Z',
    '2021-11-19T12:00:00.000Z',
    6.5,
    283,
    'אצל לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    523,
    '2021-12-01',
    19,
    '2021-12-01T05:00:00.000Z',
    '2021-12-01T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    524,
    '2021-12-01',
    14,
    '2021-12-01T05:00:00.000Z',
    '2021-12-01T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    525,
    '2021-12-01',
    13,
    '2021-12-01T05:00:00.000Z',
    '2021-12-01T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    526,
    '2021-12-01',
    18,
    '2021-12-01T05:00:00.000Z',
    '2021-12-01T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    527,
    '2021-12-01',
    16,
    '2021-12-01T05:00:00.000Z',
    '2021-12-01T09:00:00.000Z',
    4,
    146,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    528,
    '2021-12-02',
    13,
    '2021-12-02T05:00:00.000Z',
    '2021-12-02T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    529,
    '2021-12-02',
    19,
    '2021-12-02T05:00:00.000Z',
    '2021-12-02T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    530,
    '2021-12-02',
    18,
    '2021-12-02T05:00:00.000Z',
    '2021-12-02T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    531,
    '2021-12-02',
    14,
    '2021-12-02T05:00:00.000Z',
    '2021-12-02T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    532,
    '2021-12-03',
    13,
    '2021-12-03T05:00:00.000Z',
    '2021-12-03T12:00:00.000Z',
    6.5,
    306,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    533,
    '2021-12-03',
    19,
    '2021-12-03T05:00:00.000Z',
    '2021-12-03T12:00:00.000Z',
    6.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    534,
    '2021-12-03',
    14,
    '2021-12-03T05:00:00.000Z',
    '2021-12-03T12:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    535,
    '2021-12-03',
    18,
    '2021-12-03T05:00:00.000Z',
    '2021-12-03T12:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    536,
    '2021-12-05',
    18,
    '2021-12-05T05:00:00.000Z',
    '2021-12-05T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    537,
    '2021-12-05',
    13,
    '2021-12-05T05:00:00.000Z',
    '2021-12-05T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    538,
    '2021-12-05',
    14,
    '2021-12-05T05:30:00.000Z',
    '2021-12-05T13:30:00.000Z',
    7.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    539,
    '2021-12-06',
    13,
    '2021-12-06T05:00:00.000Z',
    '2021-12-06T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    540,
    '2021-12-06',
    19,
    '2021-12-06T05:00:00.000Z',
    '2021-12-06T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    541,
    '2021-12-06',
    18,
    '2021-12-06T05:00:00.000Z',
    '2021-12-06T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    542,
    '2021-12-06',
    14,
    '2021-12-06T05:00:00.000Z',
    '2021-12-06T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    543,
    '2021-12-07',
    19,
    '2021-12-07T05:00:00.000Z',
    '2021-12-07T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    544,
    '2021-12-07',
    13,
    '2021-12-07T05:00:00.000Z',
    '2021-12-07T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    545,
    '2021-12-07',
    18,
    '2021-12-07T05:30:00.000Z',
    '2021-12-07T14:00:00.000Z',
    8,
    348,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    546,
    '2021-12-07',
    14,
    '2021-12-07T05:30:00.000Z',
    '2021-12-07T14:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    547,
    '2021-12-01',
    20,
    '2021-12-01T05:00:00.000Z',
    '2021-12-01T14:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    556,
    '2021-12-08',
    13,
    '2021-12-08T05:00:00.000Z',
    '2021-12-08T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    557,
    '2021-12-08',
    18,
    '2021-12-08T05:00:00.000Z',
    '2021-12-08T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    558,
    '2021-12-08',
    14,
    '2021-12-08T05:00:00.000Z',
    '2021-12-08T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    559,
    '2021-12-08',
    19,
    '2021-12-08T05:00:00.000Z',
    '2021-12-08T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    560,
    '2021-12-09',
    14,
    '2021-12-09T05:00:00.000Z',
    '2021-12-09T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    561,
    '2021-12-09',
    18,
    '2021-12-09T05:00:00.000Z',
    '2021-12-09T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    562,
    '2021-12-09',
    19,
    '2021-12-09T05:00:00.000Z',
    '2021-12-09T14:00:00.000Z',
    8.5,
    280,
    'המשך לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    563,
    '2021-12-09',
    13,
    '2021-12-09T05:00:00.000Z',
    '2021-12-09T14:00:00.000Z',
    8.5,
    400,
    'המשך לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    564,
    '2021-12-10',
    14,
    '2021-12-10T05:00:00.000Z',
    '2021-12-10T12:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    565,
    '2021-12-10',
    18,
    '2021-12-10T05:00:00.000Z',
    '2021-12-10T12:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    566,
    '2021-12-12',
    14,
    '2021-12-12T05:00:00.000Z',
    '2021-12-12T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    567,
    '2021-12-12',
    18,
    '2021-12-12T05:00:00.000Z',
    '2021-12-12T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    568,
    '2021-12-12',
    13,
    '2021-12-12T05:00:00.000Z',
    '2021-12-12T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    569,
    '2021-12-13',
    19,
    '2021-12-13T05:00:00.000Z',
    '2021-12-13T14:00:00.000Z',
    8.5,
    280,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    570,
    '2021-12-13',
    14,
    '2021-12-13T05:00:00.000Z',
    '2021-12-13T14:00:00.000Z',
    8.5,
    380,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    571,
    '2021-12-13',
    18,
    '2021-12-13T05:00:00.000Z',
    '2021-12-13T14:00:00.000Z',
    8.5,
    370,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    572,
    '2021-12-13',
    13,
    '2021-12-13T05:00:00.000Z',
    '2021-12-13T14:00:00.000Z',
    8.5,
    400,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    573,
    '2021-12-14',
    19,
    '2021-12-14T05:00:00.000Z',
    '2021-12-14T14:00:00.000Z',
    8.5,
    280,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    574,
    '2021-12-14',
    18,
    '2021-12-14T05:00:00.000Z',
    '2021-12-14T14:00:00.000Z',
    8.5,
    370,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    575,
    '2021-12-14',
    13,
    '2021-12-14T05:00:00.000Z',
    '2021-12-14T14:00:00.000Z',
    8.5,
    400,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    576,
    '2021-12-14',
    14,
    '2021-12-14T05:30:00.000Z',
    '2021-12-14T14:00:00.000Z',
    8,
    358,
    'רב דור ישן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    577,
    '2021-12-14',
    21,
    '2021-12-14T05:30:00.000Z',
    '2021-12-14T14:00:00.000Z',
    8,
    358,
    'רב דור ישן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    578,
    '2021-12-15',
    19,
    '2021-12-15T05:00:00.000Z',
    '2021-12-15T14:00:00.000Z',
    8.5,
    280,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    579,
    '2021-12-15',
    18,
    '2021-12-15T05:00:00.000Z',
    '2021-12-15T14:00:00.000Z',
    8.5,
    370,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    580,
    '2021-12-15',
    13,
    '2021-12-15T05:00:00.000Z',
    '2021-12-15T14:00:00.000Z',
    8.5,
    400,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    581,
    '2021-12-15',
    21,
    '2021-12-15T06:00:00.000Z',
    '2021-12-15T12:00:00.000Z',
    5.5,
    246,
    'רב דור ישן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    582,
    '2021-12-15',
    14,
    '2021-12-15T05:00:00.000Z',
    '2021-12-15T14:00:00.000Z',
    8.5,
    380,
    'רב דור ישן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    583,
    '2021-12-16',
    13,
    '2021-12-16T05:00:00.000Z',
    '2021-12-16T14:00:00.000Z',
    8.5,
    400,
    'הכנת ציוד במחסן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    584,
    '2021-12-16',
    19,
    '2021-12-16T05:00:00.000Z',
    '2021-12-16T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    585,
    '2021-12-16',
    14,
    '2021-12-16T05:00:00.000Z',
    '2021-12-16T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    586,
    '2021-12-16',
    18,
    '2021-12-16T05:00:00.000Z',
    '2021-12-16T10:00:00.000Z',
    4.5,
    196,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    587,
    '2021-12-17',
    18,
    '2021-12-17T05:30:00.000Z',
    '2021-12-17T12:00:00.000Z',
    6,
    261,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    588,
    '2021-12-17',
    14,
    '2021-12-17T05:30:00.000Z',
    '2021-12-17T12:00:00.000Z',
    6,
    268,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    589,
    '2021-12-17',
    13,
    '2021-12-17T05:00:00.000Z',
    '2021-12-17T13:00:00.000Z',
    7.5,
    353,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    590,
    '2021-12-17',
    19,
    '2021-12-17T05:00:00.000Z',
    '2021-12-17T13:00:00.000Z',
    7.5,
    247,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    591,
    '2021-12-19',
    18,
    '2021-12-19T05:30:00.000Z',
    '2021-12-19T14:00:00.000Z',
    8,
    348,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    592,
    '2021-12-19',
    14,
    '2021-12-19T05:30:00.000Z',
    '2021-12-19T14:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    593,
    '2021-12-19',
    13,
    '2021-12-19T05:00:00.000Z',
    '2021-12-19T14:00:00.000Z',
    8.5,
    400,
    'דיורון'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    594,
    '2021-12-20',
    19,
    '2021-12-20T05:00:00.000Z',
    '2021-12-20T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    595,
    '2021-12-20',
    13,
    '2021-12-20T05:00:00.000Z',
    '2021-12-20T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    596,
    '2021-12-20',
    14,
    '2021-12-20T06:00:00.000Z',
    '2021-12-20T14:00:00.000Z',
    7.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    597,
    '2021-12-20',
    18,
    '2021-12-20T06:00:00.000Z',
    '2021-12-20T14:00:00.000Z',
    7.5,
    326,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    598,
    '2021-12-21',
    14,
    '2021-12-21T07:00:00.000Z',
    '2021-12-21T14:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    599,
    '2021-12-21',
    18,
    '2021-12-21T07:00:00.000Z',
    '2021-12-21T14:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    600,
    '2021-12-22',
    19,
    '2021-12-22T05:00:00.000Z',
    '2021-12-22T14:00:00.000Z',
    8.5,
    280,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    601,
    '2021-12-22',
    13,
    '2021-12-22T05:00:00.000Z',
    '2021-12-22T14:00:00.000Z',
    8.5,
    400,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    602,
    '2021-12-22',
    18,
    '2021-12-22T05:30:00.000Z',
    '2021-12-22T14:00:00.000Z',
    8,
    348,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    603,
    '2021-12-22',
    14,
    '2021-12-22T05:30:00.000Z',
    '2021-12-22T14:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    604,
    '2021-12-23',
    13,
    '2021-12-23T05:00:00.000Z',
    '2021-12-23T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    605,
    '2021-12-23',
    19,
    '2021-12-23T05:00:00.000Z',
    '2021-12-23T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    606,
    '2021-12-23',
    14,
    '2021-12-23T05:30:00.000Z',
    '2021-12-23T14:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    607,
    '2021-12-23',
    18,
    '2021-12-23T05:30:00.000Z',
    '2021-12-23T14:00:00.000Z',
    8,
    348,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    608,
    '2021-12-24',
    19,
    '2021-12-24T05:00:00.000Z',
    '2021-12-24T13:00:00.000Z',
    7.5,
    247,
    'לואי צימר'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    609,
    '2021-12-24',
    13,
    '2021-12-24T05:00:00.000Z',
    '2021-12-24T14:00:00.000Z',
    8.5,
    400,
    'לואי צימר'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    610,
    '2021-12-24',
    14,
    '2021-12-24T05:00:00.000Z',
    '2021-12-24T12:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    611,
    '2021-12-24',
    18,
    '2021-12-24T05:00:00.000Z',
    '2021-12-24T12:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    612,
    '2021-12-26',
    18,
    '2021-12-26T05:30:00.000Z',
    '2021-12-26T14:00:00.000Z',
    8,
    348,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    613,
    '2021-12-26',
    14,
    '2021-12-26T05:30:00.000Z',
    '2021-12-26T14:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    614,
    '2021-12-26',
    13,
    '2021-12-26T05:00:00.000Z',
    '2021-12-26T14:00:00.000Z',
    8.5,
    400,
    'צימר לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    615,
    '2021-12-27',
    14,
    '2021-12-27T06:00:00.000Z',
    '2021-12-27T14:00:00.000Z',
    7.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    616,
    '2021-12-27',
    18,
    '2021-12-27T06:00:00.000Z',
    '2021-12-27T14:00:00.000Z',
    7.5,
    326,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    617,
    '2021-12-27',
    19,
    '2021-12-27T05:00:00.000Z',
    '2021-12-27T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    618,
    '2021-12-27',
    13,
    '2021-12-27T05:00:00.000Z',
    '2021-12-27T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    619,
    '2021-12-28',
    18,
    '2021-12-28T05:00:00.000Z',
    '2021-12-28T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    620,
    '2021-12-28',
    14,
    '2021-12-28T05:00:00.000Z',
    '2021-12-28T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    621,
    '2021-12-28',
    19,
    '2021-12-28T05:00:00.000Z',
    '2021-12-28T14:00:00.000Z',
    8.5,
    280,
    'המשך לואי צימירים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    622,
    '2021-12-28',
    13,
    '2021-12-28T05:00:00.000Z',
    '2021-12-28T17:00:00.000Z',
    11.5,
    541,
    'המשך לואי צימירים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    623,
    '2021-12-29',
    18,
    '2021-12-29T05:00:00.000Z',
    '2021-12-29T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    624,
    '2021-12-29',
    14,
    '2021-12-29T05:00:00.000Z',
    '2021-12-29T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    625,
    '2021-12-29',
    19,
    '2021-12-29T05:00:00.000Z',
    '2021-12-29T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    626,
    '2021-12-29',
    13,
    '2021-12-29T05:00:00.000Z',
    '2021-12-29T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    627,
    '2021-12-29',
    21,
    '2021-12-29T05:00:00.000Z',
    '2021-12-29T16:00:00.000Z',
    10.5,
    469,
    'צימר לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    628,
    '2021-12-30',
    14,
    '2021-12-30T05:00:00.000Z',
    '2021-12-30T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    629,
    '2021-12-30',
    18,
    '2021-12-30T05:00:00.000Z',
    '2021-12-30T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    630,
    '2021-12-30',
    19,
    '2021-12-30T05:00:00.000Z',
    '2021-12-30T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    631,
    '2021-12-30',
    13,
    '2021-12-30T05:00:00.000Z',
    '2021-12-30T16:30:00.000Z',
    11,
    518,
    'צימר לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    632,
    '2021-12-30',
    21,
    '2021-12-30T05:00:00.000Z',
    '2021-12-30T16:30:00.000Z',
    11,
    492,
    'צימר לואי'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    633,
    '2021-12-31',
    13,
    '2021-12-31T05:00:00.000Z',
    '2021-12-31T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    634,
    '2021-12-31',
    18,
    '2021-12-31T05:00:00.000Z',
    '2021-12-31T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    635,
    '2021-12-31',
    14,
    '2021-12-31T05:00:00.000Z',
    '2021-12-31T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    636,
    '2021-12-31',
    21,
    '2021-12-31T05:00:00.000Z',
    '2021-12-31T12:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    637,
    '2022-01-02',
    20,
    '2022-01-02T05:00:00.000Z',
    '2022-01-02T14:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    638,
    '2022-01-02',
    13,
    '2022-01-02T05:00:00.000Z',
    '2022-01-02T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    639,
    '2022-01-02',
    18,
    '2022-01-02T05:00:00.000Z',
    '2022-01-02T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    640,
    '2022-01-02',
    14,
    '2022-01-02T05:00:00.000Z',
    '2022-01-02T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    641,
    '2022-01-02',
    21,
    '2022-01-02T05:00:00.000Z',
    '2022-01-02T12:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    642,
    '2022-01-03',
    19,
    '2022-01-03T05:00:00.000Z',
    '2022-01-03T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    643,
    '2022-01-03',
    14,
    '2022-01-03T05:00:00.000Z',
    '2022-01-03T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    644,
    '2022-01-03',
    18,
    '2022-01-03T05:00:00.000Z',
    '2022-01-03T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    645,
    '2022-01-04',
    14,
    '2022-01-04T05:00:00.000Z',
    '2022-01-04T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    646,
    '2022-01-04',
    21,
    '2022-01-04T05:00:00.000Z',
    '2022-01-04T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    647,
    '2022-01-04',
    13,
    '2022-01-04T05:00:00.000Z',
    '2022-01-04T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    648,
    '2022-01-05',
    19,
    '2022-01-05T05:00:00.000Z',
    '2022-01-05T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    649,
    '2022-01-05',
    13,
    '2022-01-05T05:00:00.000Z',
    '2022-01-05T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    650,
    '2022-01-05',
    14,
    '2022-01-05T05:00:00.000Z',
    '2022-01-05T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    651,
    '2022-01-05',
    18,
    '2022-01-05T05:00:00.000Z',
    '2022-01-05T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    652,
    '2022-01-05',
    21,
    '2022-01-05T05:00:00.000Z',
    '2022-01-05T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    653,
    '2022-01-06',
    19,
    '2022-01-06T05:00:00.000Z',
    '2022-01-06T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    654,
    '2022-01-06',
    13,
    '2022-01-06T05:00:00.000Z',
    '2022-01-06T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    655,
    '2022-01-06',
    18,
    '2022-01-06T05:00:00.000Z',
    '2022-01-06T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    656,
    '2022-01-06',
    14,
    '2022-01-06T05:00:00.000Z',
    '2022-01-06T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    657,
    '2022-01-06',
    21,
    '2022-01-06T05:00:00.000Z',
    '2022-01-06T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    658,
    '2022-01-07',
    14,
    '2022-01-07T05:00:00.000Z',
    '2022-01-07T12:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    659,
    '2022-01-07',
    18,
    '2022-01-07T05:00:00.000Z',
    '2022-01-07T12:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    660,
    '2022-01-07',
    21,
    '2022-01-07T05:00:00.000Z',
    '2022-01-07T12:00:00.000Z',
    6.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    661,
    '2022-01-07',
    13,
    '2022-01-07T05:00:00.000Z',
    '2022-01-07T12:00:00.000Z',
    6.5,
    306,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    662,
    '2022-01-07',
    19,
    '2022-01-07T05:00:00.000Z',
    '2022-01-07T12:00:00.000Z',
    6.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    663,
    '2022-01-09',
    13,
    '2022-01-09T05:00:00.000Z',
    '2022-01-09T14:00:00.000Z',
    8.5,
    400,
    'המשך סידור מחסן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    664,
    '2022-01-09',
    21,
    '2022-01-09T05:00:00.000Z',
    '2022-01-09T14:00:00.000Z',
    8.5,
    380,
    'המשך סידור מחסן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    665,
    '2022-01-09',
    18,
    '2022-01-09T05:00:00.000Z',
    '2022-01-09T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    666,
    '2022-01-09',
    14,
    '2022-01-09T05:00:00.000Z',
    '2022-01-09T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    671,
    '2022-01-10',
    14,
    '2022-01-10T06:00:00.000Z',
    '2022-01-10T14:00:00.000Z',
    7.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    672,
    '2022-01-10',
    18,
    '2022-01-10T06:00:00.000Z',
    '2022-01-10T14:00:00.000Z',
    7.5,
    326,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    673,
    '2022-01-10',
    13,
    '2022-01-10T05:00:00.000Z',
    '2022-01-10T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    674,
    '2022-01-10',
    19,
    '2022-01-10T05:00:00.000Z',
    '2022-01-10T11:00:00.000Z',
    5.5,
    181,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    675,
    '2022-01-10',
    21,
    '2022-01-10T05:00:00.000Z',
    '2022-01-10T11:00:00.000Z',
    5.5,
    246,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    676,
    '2022-01-11',
    18,
    '2022-01-11T05:30:00.000Z',
    '2022-01-11T14:00:00.000Z',
    8,
    348,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    677,
    '2022-01-11',
    14,
    '2022-01-11T05:30:00.000Z',
    '2022-01-11T14:00:00.000Z',
    8,
    358,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    678,
    '2022-01-11',
    19,
    '2022-01-11T05:00:00.000Z',
    '2022-01-11T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    679,
    '2022-01-11',
    13,
    '2022-01-11T05:00:00.000Z',
    '2022-01-11T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    680,
    '2022-01-11',
    21,
    '2022-01-11T05:00:00.000Z',
    '2022-01-11T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    681,
    '2022-01-12',
    13,
    '2022-01-12T05:00:00.000Z',
    '2022-01-12T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    682,
    '2022-01-12',
    19,
    '2022-01-12T05:00:00.000Z',
    '2022-01-12T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    683,
    '2022-01-12',
    14,
    '2022-01-12T05:00:00.000Z',
    '2022-01-12T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    684,
    '2022-01-12',
    18,
    '2022-01-12T05:00:00.000Z',
    '2022-01-12T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    685,
    '2022-01-12',
    21,
    '2022-01-12T05:00:00.000Z',
    '2022-01-12T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    686,
    '2022-01-13',
    19,
    '2022-01-13T05:00:00.000Z',
    '2022-01-13T14:00:00.000Z',
    8.5,
    280,
    'העתקת קוי מים והמשך בניין ישן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    687,
    '2022-01-13',
    13,
    '2022-01-13T05:00:00.000Z',
    '2022-01-13T14:00:00.000Z',
    8.5,
    400,
    'העתקת קוי מים והמשך בניין ישן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    688,
    '2022-01-13',
    14,
    '2022-01-13T05:00:00.000Z',
    '2022-01-13T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    689,
    '2022-01-13',
    18,
    '2022-01-13T05:00:00.000Z',
    '2022-01-13T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    690,
    '2022-01-13',
    21,
    '2022-01-13T05:00:00.000Z',
    '2022-01-13T14:00:00.000Z',
    8.5,
    380,
    'עם אחמד'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    691,
    '2022-01-14',
    19,
    '2022-01-14T05:00:00.000Z',
    '2022-01-14T11:30:00.000Z',
    6,
    198,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    692,
    '2022-01-14',
    13,
    '2022-01-14T05:00:00.000Z',
    '2022-01-14T11:30:00.000Z',
    6,
    282,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    693,
    '2022-01-14',
    21,
    '2022-01-14T05:00:00.000Z',
    '2022-01-14T11:30:00.000Z',
    6,
    268,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    694,
    '2022-01-14',
    18,
    '2022-01-14T05:00:00.000Z',
    '2022-01-14T11:30:00.000Z',
    6,
    261,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    695,
    '2022-01-16',
    13,
    '2022-01-16T05:00:00.000Z',
    '2022-01-16T14:00:00.000Z',
    8.5,
    400,
    'התקנת מיכל הדחה אצל רקאן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    696,
    '2022-01-16',
    21,
    '2022-01-16T05:00:00.000Z',
    '2022-01-16T10:30:00.000Z',
    5,
    224,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    697,
    '2022-01-16',
    14,
    '2022-01-16T05:30:00.000Z',
    '2022-01-16T14:00:00.000Z',
    8,
    358,
    'המשך התקנת כלים בבניין סלימאן גדעאן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    698,
    '2022-01-16',
    18,
    '2022-01-16T05:30:00.000Z',
    '2022-01-16T14:00:00.000Z',
    8,
    348,
    'המשך התקנת כלים בבניין סלימאן גדעאן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    699,
    '2022-01-17',
    13,
    '2022-01-17T05:00:00.000Z',
    '2022-01-17T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    700,
    '2022-01-17',
    19,
    '2022-01-17T05:00:00.000Z',
    '2022-01-17T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    701,
    '2022-01-17',
    14,
    '2022-01-17T05:30:00.000Z',
    '2022-01-17T14:30:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    702,
    '2022-01-17',
    18,
    '2022-01-17T05:30:00.000Z',
    '2022-01-17T14:30:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    703,
    '2022-01-18',
    18,
    '2022-01-18T05:00:00.000Z',
    '2022-01-18T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    704,
    '2022-01-18',
    14,
    '2022-01-18T05:00:00.000Z',
    '2022-01-18T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    705,
    '2022-01-18',
    21,
    '2022-01-18T05:00:00.000Z',
    '2022-01-18T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    706,
    '2022-01-18',
    13,
    '2022-01-18T05:00:00.000Z',
    '2022-01-18T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    707,
    '2022-01-18',
    19,
    '2022-01-18T05:00:00.000Z',
    '2022-01-18T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    708,
    '2022-01-19',
    21,
    '2022-01-19T05:00:00.000Z',
    '2022-01-19T10:00:00.000Z',
    4.5,
    201,
    'מערכת מים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    709,
    '2022-01-19',
    13,
    '2022-01-19T05:00:00.000Z',
    '2022-01-19T14:00:00.000Z',
    8.5,
    400,
    'מערכת מים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    710,
    '2022-01-19',
    19,
    '2022-01-19T05:00:00.000Z',
    '2022-01-19T14:00:00.000Z',
    8.5,
    280,
    'מערכת מים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    711,
    '2022-01-20',
    21,
    '2022-01-20T05:00:00.000Z',
    '2022-01-20T14:00:00.000Z',
    8.5,
    380,
    'מערכת מים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    712,
    '2022-01-20',
    19,
    '2022-01-20T05:00:00.000Z',
    '2022-01-20T14:00:00.000Z',
    8.5,
    280,
    'מערכת מים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    713,
    '2022-01-20',
    13,
    '2022-01-20T05:00:00.000Z',
    '2022-01-20T14:00:00.000Z',
    8.5,
    400,
    'מערכת מים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    714,
    '2022-01-21',
    21,
    '2022-01-21T05:00:00.000Z',
    '2022-01-21T12:00:00.000Z',
    6.5,
    291,
    'מערכת מיםֿ'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    715,
    '2022-01-21',
    19,
    '2022-01-21T05:00:00.000Z',
    '2022-01-21T12:00:00.000Z',
    6.5,
    214,
    'מערכת מיםֿ'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    716,
    '2022-01-21',
    13,
    '2022-01-21T05:00:00.000Z',
    '2022-01-21T12:00:00.000Z',
    6.5,
    306,
    'מערכת מיםֿ'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    717,
    '2022-01-23',
    13,
    '2022-01-23T05:00:00.000Z',
    '2022-01-23T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    718,
    '2022-01-23',
    19,
    '2022-01-23T05:00:00.000Z',
    '2022-01-23T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    719,
    '2022-01-23',
    14,
    '2022-01-23T05:00:00.000Z',
    '2022-01-23T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    720,
    '2022-01-24',
    13,
    '2022-01-24T05:00:00.000Z',
    '2022-01-24T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    721,
    '2022-01-24',
    14,
    '2022-01-24T05:00:00.000Z',
    '2022-01-24T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    722,
    '2022-01-25',
    19,
    '2022-01-25T05:00:00.000Z',
    '2022-01-25T09:30:00.000Z',
    4,
    132,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    723,
    '2022-01-25',
    18,
    '2022-01-25T05:00:00.000Z',
    '2022-01-25T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    724,
    '2022-01-25',
    14,
    '2022-01-25T05:00:00.000Z',
    '2022-01-25T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    725,
    '2022-01-25',
    21,
    '2022-01-25T05:00:00.000Z',
    '2022-01-25T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    726,
    '2022-01-25',
    13,
    '2022-01-25T05:00:00.000Z',
    '2022-01-25T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    727,
    '2022-01-26',
    14,
    '2022-01-26T05:30:00.000Z',
    '2022-01-26T13:30:00.000Z',
    7.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    728,
    '2022-01-26',
    19,
    '2022-01-26T05:30:00.000Z',
    '2022-01-26T13:30:00.000Z',
    7.5,
    247,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    729,
    '2022-01-26',
    18,
    '2022-01-26T05:30:00.000Z',
    '2022-01-26T13:30:00.000Z',
    7.5,
    326,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    730,
    '2022-01-26',
    13,
    '2022-01-26T05:00:00.000Z',
    '2022-01-26T14:00:00.000Z',
    8.5,
    400,
    'מסעד : התקנת דוד והתקנת אסלה במגרש'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    731,
    '2022-01-26',
    21,
    '2022-01-26T05:00:00.000Z',
    '2022-01-26T14:00:00.000Z',
    8.5,
    380,
    'מסעד : התקנת דוד והתקנת אסלה במגרש'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    732,
    '2022-01-27',
    18,
    '2022-01-27T05:00:00.000Z',
    '2022-01-27T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    733,
    '2022-01-27',
    14,
    '2022-01-27T05:00:00.000Z',
    '2022-01-27T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    734,
    '2022-01-27',
    13,
    '2022-01-27T05:00:00.000Z',
    '2022-01-27T08:00:00.000Z',
    3,
    141,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    735,
    '2022-01-27',
    19,
    '2022-01-27T05:00:00.000Z',
    '2022-01-27T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    736,
    '2022-01-30',
    14,
    '2022-01-30T05:00:00.000Z',
    '2022-01-30T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    737,
    '2022-01-30',
    18,
    '2022-01-30T05:00:00.000Z',
    '2022-01-30T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    738,
    '2022-01-30',
    19,
    '2022-01-30T05:30:00.000Z',
    '2022-01-30T13:30:00.000Z',
    7.5,
    247,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    739,
    '2022-01-30',
    21,
    '2022-01-30T05:00:00.000Z',
    '2022-01-30T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    740,
    '2022-01-31',
    14,
    '2022-01-31T05:00:00.000Z',
    '2022-01-31T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    741,
    '2022-01-31',
    18,
    '2022-01-31T05:00:00.000Z',
    '2022-01-31T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    742,
    '2022-01-31',
    21,
    '2022-01-31T05:00:00.000Z',
    '2022-01-31T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    743,
    '2022-02-01',
    18,
    '2022-02-01T05:00:00.000Z',
    '2022-02-01T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    744,
    '2022-02-01',
    14,
    '2022-02-01T05:00:00.000Z',
    '2022-02-01T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    745,
    '2022-02-01',
    21,
    '2022-02-01T05:00:00.000Z',
    '2022-02-01T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    746,
    '2022-02-01',
    19,
    '2022-02-01T05:00:00.000Z',
    '2022-02-01T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    747,
    '2022-02-02',
    18,
    '2022-02-02T05:00:00.000Z',
    '2022-02-02T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    748,
    '2022-02-02',
    14,
    '2022-02-02T05:00:00.000Z',
    '2022-02-02T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    749,
    '2022-02-02',
    19,
    '2022-02-02T05:00:00.000Z',
    '2022-02-02T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    750,
    '2022-02-02',
    13,
    '2022-02-02T05:00:00.000Z',
    '2022-02-02T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    751,
    '2022-02-03',
    18,
    '2022-02-03T05:00:00.000Z',
    '2022-02-03T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    752,
    '2022-02-03',
    14,
    '2022-02-03T05:00:00.000Z',
    '2022-02-03T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    753,
    '2022-02-03',
    13,
    '2022-02-03T05:00:00.000Z',
    '2022-02-03T09:00:00.000Z',
    4,
    202,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    754,
    '2022-02-03',
    19,
    '2022-02-03T05:00:00.000Z',
    '2022-02-03T09:00:00.000Z',
    4,
    132,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    755,
    '2022-02-04',
    14,
    '2022-02-04T05:30:00.000Z',
    '2022-02-04T12:00:00.000Z',
    6,
    268,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    756,
    '2022-02-04',
    18,
    '2022-02-04T05:30:00.000Z',
    '2022-02-04T12:00:00.000Z',
    6,
    261,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    757,
    '2022-02-04',
    19,
    '2022-02-04T05:00:00.000Z',
    '2022-02-04T08:00:00.000Z',
    3,
    99,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    758,
    '2022-02-06',
    13,
    '2022-02-06T05:00:00.000Z',
    '2022-02-06T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    759,
    '2022-02-06',
    21,
    '2022-02-06T05:00:00.000Z',
    '2022-02-06T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    760,
    '2022-02-06',
    19,
    '2022-02-06T05:00:00.000Z',
    '2022-02-06T10:00:00.000Z',
    4.5,
    148,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    761,
    '2022-02-06',
    18,
    '2022-02-06T05:00:00.000Z',
    '2022-02-06T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    762,
    '2022-02-06',
    14,
    '2022-02-06T05:00:00.000Z',
    '2022-02-06T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    763,
    '2022-02-07',
    13,
    '2022-02-07T05:00:00.000Z',
    '2022-02-07T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    764,
    '2022-02-07',
    21,
    '2022-02-07T05:00:00.000Z',
    '2022-02-07T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    765,
    '2022-02-07',
    18,
    '2022-02-07T05:00:00.000Z',
    '2022-02-07T14:00:00.000Z',
    8.5,
    370,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    766,
    '2022-02-07',
    14,
    '2022-02-07T05:00:00.000Z',
    '2022-02-07T14:00:00.000Z',
    8.5,
    380,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    767,
    '2022-02-08',
    13,
    '2022-02-08T05:00:00.000Z',
    '2022-02-08T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    768,
    '2022-02-08',
    19,
    '2022-02-08T05:00:00.000Z',
    '2022-02-08T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    769,
    '2022-02-08',
    21,
    '2022-02-08T07:00:00.000Z',
    '2022-02-08T10:00:00.000Z',
    3,
    141,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    770,
    '2022-02-08',
    14,
    '2022-02-08T05:00:00.000Z',
    '2022-02-08T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    771,
    '2022-02-08',
    18,
    '2022-02-08T05:00:00.000Z',
    '2022-02-08T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    772,
    '2022-02-09',
    19,
    '2022-02-09T05:00:00.000Z',
    '2022-02-09T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    773,
    '2022-02-09',
    13,
    '2022-02-09T05:00:00.000Z',
    '2022-02-09T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    774,
    '2022-02-09',
    18,
    '2022-02-09T06:00:00.000Z',
    '2022-02-09T14:00:00.000Z',
    7.5,
    326,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    775,
    '2022-02-09',
    14,
    '2022-02-09T06:00:00.000Z',
    '2022-02-09T14:00:00.000Z',
    7.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    776,
    '2022-02-10',
    19,
    '2022-02-10T05:00:00.000Z',
    '2022-02-10T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    777,
    '2022-02-10',
    13,
    '2022-02-10T05:00:00.000Z',
    '2022-02-10T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    778,
    '2022-02-10',
    18,
    '2022-02-10T05:00:00.000Z',
    '2022-02-10T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    779,
    '2022-02-10',
    14,
    '2022-02-10T05:00:00.000Z',
    '2022-02-10T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    780,
    '2022-02-11',
    18,
    '2022-02-11T05:00:00.000Z',
    '2022-02-11T11:00:00.000Z',
    5.5,
    239,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    781,
    '2022-02-11',
    14,
    '2022-02-11T05:00:00.000Z',
    '2022-02-11T11:00:00.000Z',
    5.5,
    246,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    782,
    '2022-02-13',
    13,
    '2022-02-13T05:00:00.000Z',
    '2022-02-13T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    783,
    '2022-02-13',
    18,
    '2022-02-13T05:00:00.000Z',
    '2022-02-13T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    784,
    '2022-02-13',
    14,
    '2022-02-13T05:00:00.000Z',
    '2022-02-13T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    785,
    '2022-02-14',
    13,
    '2022-02-14T05:00:00.000Z',
    '2022-02-14T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    786,
    '2022-02-14',
    14,
    '2022-02-14T05:00:00.000Z',
    '2022-02-14T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    787,
    '2022-02-14',
    18,
    '2022-02-14T05:00:00.000Z',
    '2022-02-14T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    788,
    '2022-02-15',
    14,
    '2022-02-15T05:00:00.000Z',
    '2022-02-15T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    789,
    '2022-02-15',
    18,
    '2022-02-15T05:00:00.000Z',
    '2022-02-15T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    790,
    '2022-02-15',
    19,
    '2022-02-15T05:00:00.000Z',
    '2022-02-15T14:00:00.000Z',
    8.5,
    280,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    791,
    '2022-02-15',
    13,
    '2022-02-15T05:00:00.000Z',
    '2022-02-15T14:00:00.000Z',
    8.5,
    430,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    792,
    '2022-02-16',
    13,
    '2022-02-16T05:00:00.000Z',
    '2022-02-16T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    793,
    '2022-02-16',
    21,
    '2022-02-16T05:00:00.000Z',
    '2022-02-16T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    794,
    '2022-02-16',
    14,
    '2022-02-16T05:00:00.000Z',
    '2022-02-16T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    795,
    '2022-02-16',
    18,
    '2022-02-16T05:00:00.000Z',
    '2022-02-16T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    796,
    '2022-02-16',
    19,
    '2022-02-16T06:00:00.000Z',
    '2022-02-16T10:00:00.000Z',
    4,
    132,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    797,
    '2022-02-17',
    13,
    '2022-02-17T05:00:00.000Z',
    '2022-02-17T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    798,
    '2022-02-17',
    21,
    '2022-02-17T05:00:00.000Z',
    '2022-02-17T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    799,
    '2022-02-17',
    19,
    '2022-02-17T05:00:00.000Z',
    '2022-02-17T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    800,
    '2022-02-17',
    18,
    '2022-02-17T05:00:00.000Z',
    '2022-02-17T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    801,
    '2022-02-17',
    14,
    '2022-02-17T05:00:00.000Z',
    '2022-02-17T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    802,
    '2022-02-18',
    19,
    '2022-02-18T05:00:00.000Z',
    '2022-02-18T13:00:00.000Z',
    7.5,
    247,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    803,
    '2022-02-18',
    21,
    '2022-02-18T05:00:00.000Z',
    '2022-02-18T13:00:00.000Z',
    7.5,
    353,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    804,
    '2022-02-18',
    14,
    '2022-02-18T05:00:00.000Z',
    '2022-02-18T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    805,
    '2022-02-18',
    18,
    '2022-02-18T05:00:00.000Z',
    '2022-02-18T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    806,
    '2022-02-20',
    19,
    '2022-02-20T05:00:00.000Z',
    '2022-02-20T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    807,
    '2022-02-20',
    13,
    '2022-02-20T05:00:00.000Z',
    '2022-02-20T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    808,
    '2022-02-20',
    18,
    '2022-02-20T05:00:00.000Z',
    '2022-02-20T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    809,
    '2022-02-20',
    14,
    '2022-02-20T05:00:00.000Z',
    '2022-02-20T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    810,
    '2022-02-21',
    18,
    '2022-02-21T05:00:00.000Z',
    '2022-02-21T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    811,
    '2022-02-21',
    13,
    '2022-02-21T05:00:00.000Z',
    '2022-02-21T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    812,
    '2022-02-21',
    21,
    '2022-02-21T05:00:00.000Z',
    '2022-02-21T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    813,
    '2022-02-21',
    14,
    '2022-02-21T05:00:00.000Z',
    '2022-02-21T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    814,
    '2022-02-22',
    19,
    '2022-02-22T05:00:00.000Z',
    '2022-02-22T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    815,
    '2022-02-22',
    13,
    '2022-02-22T05:00:00.000Z',
    '2022-02-22T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    816,
    '2022-02-22',
    18,
    '2022-02-22T05:00:00.000Z',
    '2022-02-22T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    817,
    '2022-02-22',
    14,
    '2022-02-22T05:00:00.000Z',
    '2022-02-22T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    818,
    '2022-02-22',
    21,
    '2022-02-22T05:00:00.000Z',
    '2022-02-22T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    819,
    '2022-02-23',
    18,
    '2022-02-23T05:00:00.000Z',
    '2022-02-23T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    820,
    '2022-02-23',
    14,
    '2022-02-23T05:00:00.000Z',
    '2022-02-23T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    821,
    '2022-02-23',
    13,
    '2022-02-23T05:00:00.000Z',
    '2022-02-23T14:00:00.000Z',
    8.5,
    430,
    'התקנת 8 מיכלי הדחה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    822,
    '2022-02-23',
    21,
    '2022-02-23T07:00:00.000Z',
    '2022-02-23T12:00:00.000Z',
    4.5,
    212,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    823,
    '2022-02-23',
    19,
    '2022-02-23T05:00:00.000Z',
    '2022-02-23T10:00:00.000Z',
    4.5,
    148,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    824,
    '2022-02-24',
    14,
    '2022-02-24T05:00:00.000Z',
    '2022-02-24T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    825,
    '2022-02-24',
    18,
    '2022-02-24T05:00:00.000Z',
    '2022-02-24T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    826,
    '2022-02-24',
    13,
    '2022-02-24T05:00:00.000Z',
    '2022-02-24T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    827,
    '2022-02-24',
    19,
    '2022-02-24T05:00:00.000Z',
    '2022-02-24T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    828,
    '2022-02-24',
    21,
    '2022-02-24T05:00:00.000Z',
    '2022-02-24T09:30:00.000Z',
    4,
    188,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    829,
    '2022-02-27',
    13,
    '2022-02-27T05:00:00.000Z',
    '2022-02-27T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    830,
    '2022-02-27',
    19,
    '2022-02-27T05:00:00.000Z',
    '2022-02-27T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    831,
    '2022-02-27',
    14,
    '2022-02-27T05:00:00.000Z',
    '2022-02-27T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    832,
    '2022-02-27',
    18,
    '2022-02-27T05:00:00.000Z',
    '2022-02-27T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    833,
    '2022-02-28',
    18,
    '2022-02-28T05:00:00.000Z',
    '2022-02-28T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    834,
    '2022-02-28',
    14,
    '2022-02-28T05:00:00.000Z',
    '2022-02-28T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    835,
    '2022-02-28',
    13,
    '2022-02-28T05:00:00.000Z',
    '2022-02-28T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    836,
    '2022-02-28',
    21,
    '2022-02-28T05:00:00.000Z',
    '2022-02-28T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    837,
    '2022-02-01',
    20,
    '2022-02-01T05:00:00.000Z',
    '2022-02-01T14:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    838,
    '2022-03-01',
    20,
    '2022-03-01T05:00:00.000Z',
    '2022-03-01T14:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    839,
    '2022-03-01',
    14,
    '2022-03-01T05:00:00.000Z',
    '2022-03-01T14:00:00.000Z',
    8.5,
    380,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    840,
    '2022-03-01',
    18,
    '2022-03-01T05:00:00.000Z',
    '2022-03-01T14:00:00.000Z',
    8.5,
    370,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    841,
    '2022-03-01',
    21,
    '2022-03-01T05:00:00.000Z',
    '2022-03-01T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    842,
    '2022-03-01',
    19,
    '2022-03-01T05:00:00.000Z',
    '2022-03-01T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    843,
    '2022-03-02',
    13,
    '2022-03-02T05:00:00.000Z',
    '2022-03-02T12:30:00.000Z',
    7,
    354,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    844,
    '2022-03-02',
    14,
    '2022-03-02T05:00:00.000Z',
    '2022-03-02T12:30:00.000Z',
    7,
    313,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    845,
    '2022-03-02',
    18,
    '2022-03-02T05:00:00.000Z',
    '2022-03-02T12:30:00.000Z',
    7,
    305,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    846,
    '2022-03-02',
    21,
    '2022-03-02T05:00:00.000Z',
    '2022-03-02T12:00:00.000Z',
    6.5,
    306,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    847,
    '2022-03-02',
    19,
    '2022-03-02T05:00:00.000Z',
    '2022-03-02T10:00:00.000Z',
    4.5,
    148,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    848,
    '2022-03-03',
    19,
    '2022-03-03T05:00:00.000Z',
    '2022-03-03T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    849,
    '2022-03-03',
    13,
    '2022-03-03T05:00:00.000Z',
    '2022-03-03T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    850,
    '2022-03-03',
    18,
    '2022-03-03T05:00:00.000Z',
    '2022-03-03T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    851,
    '2022-03-03',
    21,
    '2022-03-03T05:00:00.000Z',
    '2022-03-03T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    852,
    '2022-03-03',
    14,
    '2022-03-03T05:00:00.000Z',
    '2022-03-03T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    853,
    '2022-03-04',
    21,
    '2022-03-04T05:00:00.000Z',
    '2022-03-04T12:00:00.000Z',
    6.5,
    306,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    854,
    '2022-03-04',
    18,
    '2022-03-04T05:00:00.000Z',
    '2022-03-04T12:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    855,
    '2022-03-04',
    19,
    '2022-03-04T05:00:00.000Z',
    '2022-03-04T12:00:00.000Z',
    6.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    856,
    '2022-03-06',
    13,
    '2022-03-06T05:00:00.000Z',
    '2022-03-06T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    857,
    '2022-03-06',
    21,
    '2022-03-06T05:00:00.000Z',
    '2022-03-06T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    858,
    '2022-03-06',
    19,
    '2022-03-06T05:00:00.000Z',
    '2022-03-06T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    859,
    '2022-03-06',
    14,
    '2022-03-06T05:00:00.000Z',
    '2022-03-06T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    860,
    '2022-03-06',
    18,
    '2022-03-06T05:00:00.000Z',
    '2022-03-06T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    861,
    '2022-03-07',
    13,
    '2022-03-07T05:00:00.000Z',
    '2022-03-07T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    862,
    '2022-03-07',
    19,
    '2022-03-07T05:00:00.000Z',
    '2022-03-07T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    863,
    '2022-03-07',
    14,
    '2022-03-07T05:00:00.000Z',
    '2022-03-07T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    864,
    '2022-03-07',
    21,
    '2022-03-07T05:00:00.000Z',
    '2022-03-07T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    865,
    '2022-03-07',
    18,
    '2022-03-07T05:00:00.000Z',
    '2022-03-07T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    866,
    '2022-03-08',
    21,
    '2022-03-08T06:00:00.000Z',
    '2022-03-08T14:00:00.000Z',
    7.5,
    353,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    867,
    '2022-03-08',
    13,
    '2022-03-08T05:00:00.000Z',
    '2022-03-08T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    868,
    '2022-03-08',
    18,
    '2022-03-08T05:00:00.000Z',
    '2022-03-08T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    869,
    '2022-03-08',
    14,
    '2022-03-08T05:00:00.000Z',
    '2022-03-08T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    870,
    '2022-03-08',
    19,
    '2022-03-08T05:00:00.000Z',
    '2022-03-08T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    871,
    '2022-03-09',
    14,
    '2022-03-09T05:00:00.000Z',
    '2022-03-09T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    872,
    '2022-03-09',
    13,
    '2022-03-09T05:00:00.000Z',
    '2022-03-09T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    873,
    '2022-03-09',
    18,
    '2022-03-09T05:00:00.000Z',
    '2022-03-09T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    874,
    '2022-03-09',
    21,
    '2022-03-09T08:00:00.000Z',
    '2022-03-09T14:00:00.000Z',
    5.5,
    259,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    875,
    '2022-03-10',
    13,
    '2022-03-10T05:00:00.000Z',
    '2022-03-10T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    876,
    '2022-03-10',
    19,
    '2022-03-10T05:00:00.000Z',
    '2022-03-10T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    877,
    '2022-03-10',
    21,
    '2022-03-10T06:00:00.000Z',
    '2022-03-10T14:00:00.000Z',
    7.5,
    353,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    878,
    '2022-03-10',
    18,
    '2022-03-10T05:00:00.000Z',
    '2022-03-10T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    879,
    '2022-03-10',
    14,
    '2022-03-10T05:00:00.000Z',
    '2022-03-10T14:00:00.000Z',
    8.5,
    380,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    880,
    '2022-03-11',
    21,
    '2022-03-11T05:30:00.000Z',
    '2022-03-11T20:00:00.000Z',
    14,
    659,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    881,
    '2022-03-11',
    18,
    '2022-03-11T05:30:00.000Z',
    '2022-03-11T20:00:00.000Z',
    14,
    609,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    882,
    '2022-03-11',
    19,
    '2022-03-11T05:00:00.000Z',
    '2022-03-11T21:30:00.000Z',
    16,
    527,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    883,
    '2022-03-13',
    18,
    '2022-03-13T05:30:00.000Z',
    '2022-03-13T14:00:00.000Z',
    8,
    348,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    884,
    '2022-03-13',
    13,
    '2022-03-13T05:30:00.000Z',
    '2022-03-13T14:00:00.000Z',
    8,
    405,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    885,
    '2022-03-13',
    19,
    '2022-03-13T05:30:00.000Z',
    '2022-03-13T14:00:00.000Z',
    8,
    264,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    886,
    '2022-03-14',
    13,
    '2022-03-14T05:00:00.000Z',
    '2022-03-14T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    887,
    '2022-03-14',
    18,
    '2022-03-14T05:00:00.000Z',
    '2022-03-14T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    888,
    '2022-03-14',
    21,
    '2022-03-14T05:00:00.000Z',
    '2022-03-14T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    889,
    '2022-03-15',
    19,
    '2022-03-15T05:00:00.000Z',
    '2022-03-15T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    890,
    '2022-03-15',
    13,
    '2022-03-15T05:00:00.000Z',
    '2022-03-15T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    891,
    '2022-03-15',
    21,
    '2022-03-15T05:00:00.000Z',
    '2022-03-15T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    892,
    '2022-03-15',
    18,
    '2022-03-15T05:00:00.000Z',
    '2022-03-15T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    893,
    '2022-03-16',
    13,
    '2022-03-16T05:00:00.000Z',
    '2022-03-16T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    894,
    '2022-03-16',
    19,
    '2022-03-16T05:00:00.000Z',
    '2022-03-16T11:00:00.000Z',
    5.5,
    181,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    895,
    '2022-03-16',
    18,
    '2022-03-16T05:00:00.000Z',
    '2022-03-16T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    896,
    '2022-03-16',
    21,
    '2022-03-16T05:00:00.000Z',
    '2022-03-16T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    897,
    '2022-03-17',
    19,
    '2022-03-17T05:00:00.000Z',
    '2022-03-17T12:30:00.000Z',
    7,
    231,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    898,
    '2022-03-17',
    13,
    '2022-03-17T05:00:00.000Z',
    '2022-03-17T12:30:00.000Z',
    7,
    354,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    899,
    '2022-03-17',
    18,
    '2022-03-17T05:00:00.000Z',
    '2022-03-17T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    900,
    '2022-03-17',
    21,
    '2022-03-17T05:00:00.000Z',
    '2022-03-17T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    901,
    '2022-03-20',
    18,
    '2022-03-20T05:00:00.000Z',
    '2022-03-20T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    902,
    '2022-03-20',
    21,
    '2022-03-20T05:00:00.000Z',
    '2022-03-20T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    903,
    '2022-03-20',
    19,
    '2022-03-20T05:00:00.000Z',
    '2022-03-20T14:00:00.000Z',
    8.5,
    280,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    904,
    '2022-03-20',
    13,
    '2022-03-20T05:00:00.000Z',
    '2022-03-20T14:00:00.000Z',
    8.5,
    430,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    905,
    '2022-03-21',
    21,
    '2022-03-21T05:00:00.000Z',
    '2022-03-21T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    906,
    '2022-03-21',
    13,
    '2022-03-21T05:00:00.000Z',
    '2022-03-21T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    907,
    '2022-03-21',
    18,
    '2022-03-21T05:00:00.000Z',
    '2022-03-21T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    908,
    '2022-03-22',
    19,
    '2022-03-22T05:00:00.000Z',
    '2022-03-22T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    909,
    '2022-03-22',
    13,
    '2022-03-22T05:00:00.000Z',
    '2022-03-22T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    910,
    '2022-03-22',
    18,
    '2022-03-22T05:00:00.000Z',
    '2022-03-22T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    911,
    '2022-03-22',
    21,
    '2022-03-22T05:30:00.000Z',
    '2022-03-22T13:30:00.000Z',
    7.5,
    353,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    912,
    '2022-03-23',
    18,
    '2022-03-23T05:00:00.000Z',
    '2022-03-23T14:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    913,
    '2022-03-23',
    13,
    '2022-03-23T05:00:00.000Z',
    '2022-03-23T14:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    914,
    '2022-03-23',
    21,
    '2022-03-23T05:00:00.000Z',
    '2022-03-23T14:00:00.000Z',
    8.5,
    400,
    'באסל בצימר'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    915,
    '2022-03-23',
    19,
    '2022-03-23T05:30:00.000Z',
    '2022-03-23T10:00:00.000Z',
    4,
    132,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    916,
    '2022-03-24',
    19,
    '2022-03-24T05:00:00.000Z',
    '2022-03-24T12:30:00.000Z',
    7,
    231,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    917,
    '2022-03-24',
    13,
    '2022-03-24T05:00:00.000Z',
    '2022-03-24T12:30:00.000Z',
    7,
    354,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    918,
    '2022-03-24',
    18,
    '2022-03-24T05:30:00.000Z',
    '2022-03-24T12:30:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    919,
    '2022-03-24',
    21,
    '2022-03-24T05:30:00.000Z',
    '2022-03-24T12:30:00.000Z',
    6.5,
    306,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    920,
    '2022-03-25',
    19,
    '2022-03-25T04:00:00.000Z',
    '2022-03-25T11:00:00.000Z',
    6.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    921,
    '2022-03-25',
    18,
    '2022-03-25T04:00:00.000Z',
    '2022-03-25T11:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    922,
    '2022-03-27',
    18,
    '2022-03-27T04:00:00.000Z',
    '2022-03-27T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    923,
    '2022-03-27',
    13,
    '2022-03-27T04:00:00.000Z',
    '2022-03-27T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    924,
    '2022-03-27',
    21,
    '2022-03-27T04:00:00.000Z',
    '2022-03-27T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    925,
    '2022-03-28',
    13,
    '2022-03-28T04:00:00.000Z',
    '2022-03-28T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    926,
    '2022-03-28',
    18,
    '2022-03-28T04:00:00.000Z',
    '2022-03-28T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    927,
    '2022-03-28',
    21,
    '2022-03-28T06:30:00.000Z',
    '2022-03-28T13:00:00.000Z',
    6,
    282,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    928,
    '2022-03-29',
    13,
    '2022-03-29T04:00:00.000Z',
    '2022-03-29T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    929,
    '2022-03-29',
    19,
    '2022-03-29T04:00:00.000Z',
    '2022-03-29T07:30:00.000Z',
    3.5,
    115,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    930,
    '2022-03-29',
    18,
    '2022-03-29T04:00:00.000Z',
    '2022-03-29T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    931,
    '2022-03-29',
    21,
    '2022-03-29T04:00:00.000Z',
    '2022-03-29T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    932,
    '2022-03-30',
    21,
    '2022-03-30T04:00:00.000Z',
    '2022-03-30T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    933,
    '2022-03-31',
    18,
    '2022-03-31T04:00:00.000Z',
    '2022-03-31T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    934,
    '2022-03-31',
    13,
    '2022-03-31T04:00:00.000Z',
    '2022-03-31T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    935,
    '2022-03-31',
    21,
    '2022-03-31T04:00:00.000Z',
    '2022-03-31T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    936,
    '2022-04-01',
    20,
    '2022-04-01T04:00:00.000Z',
    '2022-04-01T13:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    940,
    '2022-04-01',
    13,
    '2022-04-01T04:00:00.000Z',
    '2022-04-01T11:00:00.000Z',
    6.5,
    329,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    941,
    '2022-04-01',
    18,
    '2022-04-01T04:00:00.000Z',
    '2022-04-01T11:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    942,
    '2022-04-01',
    21,
    '2022-04-01T04:00:00.000Z',
    '2022-04-01T11:00:00.000Z',
    6.5,
    306,
    'צימרים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    943,
    '2022-04-03',
    19,
    '2022-04-03T04:00:00.000Z',
    '2022-04-03T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    944,
    '2022-04-03',
    13,
    '2022-04-03T04:00:00.000Z',
    '2022-04-03T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    945,
    '2022-04-03',
    18,
    '2022-04-03T04:00:00.000Z',
    '2022-04-03T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    946,
    '2022-04-04',
    13,
    '2022-04-04T04:00:00.000Z',
    '2022-04-04T13:00:00.000Z',
    8.5,
    430,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    947,
    '2022-04-04',
    18,
    '2022-04-04T04:00:00.000Z',
    '2022-04-04T13:00:00.000Z',
    8.5,
    370,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    948,
    '2022-04-04',
    19,
    '2022-04-04T04:00:00.000Z',
    '2022-04-04T13:00:00.000Z',
    8.5,
    280,
    'חיפה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    949,
    '2022-04-04',
    21,
    '2022-04-04T04:00:00.000Z',
    '2022-04-04T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    950,
    '2022-04-05',
    19,
    '2022-04-05T04:00:00.000Z',
    '2022-04-05T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    951,
    '2022-04-05',
    13,
    '2022-04-05T04:00:00.000Z',
    '2022-04-05T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    952,
    '2022-04-05',
    18,
    '2022-04-05T04:00:00.000Z',
    '2022-04-05T14:00:00.000Z',
    9.5,
    414,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    953,
    '2022-04-05',
    21,
    '2022-04-05T04:00:00.000Z',
    '2022-04-05T14:00:00.000Z',
    9.5,
    447,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    954,
    '2022-04-06',
    18,
    '2022-04-06T04:00:00.000Z',
    '2022-04-06T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    955,
    '2022-04-06',
    13,
    '2022-04-06T04:00:00.000Z',
    '2022-04-06T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    956,
    '2022-04-06',
    19,
    '2022-04-06T06:00:00.000Z',
    '2022-04-06T13:00:00.000Z',
    6.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    957,
    '2022-04-06',
    21,
    '2022-04-06T04:00:00.000Z',
    '2022-04-06T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    958,
    '2022-04-07',
    13,
    '2022-04-07T04:00:00.000Z',
    '2022-04-07T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    959,
    '2022-04-07',
    19,
    '2022-04-07T04:00:00.000Z',
    '2022-04-07T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    960,
    '2022-04-07',
    18,
    '2022-04-07T04:00:00.000Z',
    '2022-04-07T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    961,
    '2022-04-07',
    21,
    '2022-04-07T04:00:00.000Z',
    '2022-04-07T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    962,
    '2022-04-08',
    13,
    '2022-04-08T04:00:00.000Z',
    '2022-04-08T10:30:00.000Z',
    6,
    304,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    963,
    '2022-04-08',
    21,
    '2022-04-08T04:00:00.000Z',
    '2022-04-08T10:30:00.000Z',
    6,
    282,
    'המשך ראגח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    964,
    '2022-04-08',
    18,
    '2022-04-08T04:00:00.000Z',
    '2022-04-08T10:30:00.000Z',
    6,
    261,
    'המשך ראגח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    965,
    '2022-04-10',
    19,
    '2022-04-10T04:00:00.000Z',
    '2022-04-10T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    966,
    '2022-04-10',
    13,
    '2022-04-10T04:00:00.000Z',
    '2022-04-10T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    967,
    '2022-04-10',
    18,
    '2022-04-10T04:00:00.000Z',
    '2022-04-10T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    968,
    '2022-04-10',
    21,
    '2022-04-10T04:00:00.000Z',
    '2022-04-10T09:00:00.000Z',
    4.5,
    212,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    969,
    '2022-04-11',
    18,
    '2022-04-11T04:00:00.000Z',
    '2022-04-11T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    970,
    '2022-04-11',
    13,
    '2022-04-11T04:00:00.000Z',
    '2022-04-11T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    971,
    '2022-04-11',
    21,
    '2022-04-11T04:00:00.000Z',
    '2022-04-11T13:00:00.000Z',
    8.5,
    400,
    'צימרים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    972,
    '2022-04-12',
    13,
    '2022-04-12T04:00:00.000Z',
    '2022-04-12T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    973,
    '2022-04-12',
    19,
    '2022-04-12T04:00:00.000Z',
    '2022-04-12T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    974,
    '2022-04-12',
    21,
    '2022-04-12T04:00:00.000Z',
    '2022-04-12T14:00:00.000Z',
    9.5,
    447,
    'צימרים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    975,
    '2022-04-12',
    18,
    '2022-04-12T04:00:00.000Z',
    '2022-04-12T14:00:00.000Z',
    9.5,
    414,
    'צימרים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    976,
    '2022-04-13',
    18,
    '2022-04-13T04:00:00.000Z',
    '2022-04-13T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    977,
    '2022-04-13',
    19,
    '2022-04-13T04:00:00.000Z',
    '2022-04-13T11:00:00.000Z',
    6.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    978,
    '2022-04-14',
    19,
    '2022-04-14T04:00:00.000Z',
    '2022-04-14T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    979,
    '2022-04-14',
    13,
    '2022-04-14T04:00:00.000Z',
    '2022-04-14T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    980,
    '2022-04-14',
    18,
    '2022-04-14T04:00:00.000Z',
    '2022-04-14T13:00:00.000Z',
    8.5,
    370,
    'אלעזבה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    981,
    '2022-04-15',
    19,
    '2022-04-15T04:00:00.000Z',
    '2022-04-15T11:00:00.000Z',
    6.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    982,
    '2022-04-15',
    13,
    '2022-04-15T04:00:00.000Z',
    '2022-04-15T11:00:00.000Z',
    6.5,
    329,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    983,
    '2022-04-15',
    18,
    '2022-04-15T04:00:00.000Z',
    '2022-04-15T11:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    984,
    '2022-04-17',
    13,
    '2022-04-17T04:00:00.000Z',
    '2022-04-17T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    985,
    '2022-04-17',
    19,
    '2022-04-17T04:00:00.000Z',
    '2022-04-17T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    986,
    '2022-04-17',
    21,
    '2022-04-17T04:00:00.000Z',
    '2022-04-17T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    987,
    '2022-04-17',
    18,
    '2022-04-17T04:00:00.000Z',
    '2022-04-17T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    988,
    '2022-04-18',
    19,
    '2022-04-18T04:00:00.000Z',
    '2022-04-18T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    989,
    '2022-04-18',
    13,
    '2022-04-18T04:00:00.000Z',
    '2022-04-18T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    990,
    '2022-04-18',
    18,
    '2022-04-18T04:00:00.000Z',
    '2022-04-18T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    991,
    '2022-04-18',
    21,
    '2022-04-18T04:00:00.000Z',
    '2022-04-18T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    992,
    '2022-04-19',
    19,
    '2022-04-19T04:00:00.000Z',
    '2022-04-19T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    993,
    '2022-04-19',
    13,
    '2022-04-19T04:00:00.000Z',
    '2022-04-19T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    994,
    '2022-04-19',
    21,
    '2022-04-19T04:00:00.000Z',
    '2022-04-19T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    995,
    '2022-04-19',
    18,
    '2022-04-19T04:00:00.000Z',
    '2022-04-19T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    996,
    '2022-04-20',
    21,
    '2022-04-20T04:00:00.000Z',
    '2022-04-20T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    997,
    '2022-04-20',
    13,
    '2022-04-20T04:00:00.000Z',
    '2022-04-20T14:30:00.000Z',
    10,
    506,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    998,
    '2022-04-20',
    19,
    '2022-04-20T04:00:00.000Z',
    '2022-04-20T14:30:00.000Z',
    10,
    329,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    999,
    '2022-04-20',
    18,
    '2022-04-20T04:00:00.000Z',
    '2022-04-20T14:00:00.000Z',
    9.5,
    414,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1000,
    '2022-04-21',
    19,
    '2022-04-21T04:00:00.000Z',
    '2022-04-21T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1001,
    '2022-04-21',
    13,
    '2022-04-21T04:00:00.000Z',
    '2022-04-21T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1002,
    '2022-04-21',
    21,
    '2022-04-21T04:00:00.000Z',
    '2022-04-21T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1003,
    '2022-04-21',
    18,
    '2022-04-21T04:00:00.000Z',
    '2022-04-21T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1004,
    '2022-04-22',
    19,
    '2022-04-22T04:00:00.000Z',
    '2022-04-22T10:30:00.000Z',
    6,
    198,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1005,
    '2022-04-22',
    13,
    '2022-04-22T04:00:00.000Z',
    '2022-04-22T10:30:00.000Z',
    6,
    304,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1006,
    '2022-04-22',
    18,
    '2022-04-22T04:00:00.000Z',
    '2022-04-22T10:30:00.000Z',
    6,
    261,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1007,
    '2022-04-22',
    21,
    '2022-04-22T04:00:00.000Z',
    '2022-04-22T08:00:00.000Z',
    4,
    188,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1008,
    '2022-04-24',
    13,
    '2022-04-24T04:00:00.000Z',
    '2022-04-24T13:00:00.000Z',
    8.5,
    430,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1009,
    '2022-04-25',
    13,
    '2022-04-25T04:00:00.000Z',
    '2022-04-25T13:00:00.000Z',
    8.5,
    430,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1010,
    '2022-04-26',
    13,
    '2022-04-26T04:00:00.000Z',
    '2022-04-26T13:00:00.000Z',
    8.5,
    430,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1011,
    '2022-04-27',
    13,
    '2022-04-27T04:00:00.000Z',
    '2022-04-27T13:00:00.000Z',
    8.5,
    430,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1012,
    '2022-04-27',
    21,
    '2022-04-27T04:00:00.000Z',
    '2022-04-27T10:30:00.000Z',
    6,
    282,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1013,
    '2022-04-27',
    19,
    '2022-04-27T04:00:00.000Z',
    '2022-04-27T10:30:00.000Z',
    6,
    198,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1014,
    '2022-04-27',
    18,
    '2022-04-27T04:00:00.000Z',
    '2022-04-27T10:30:00.000Z',
    6,
    261,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1015,
    '2022-04-26',
    21,
    '2022-04-26T04:00:00.000Z',
    '2022-04-26T10:30:00.000Z',
    6,
    282,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1016,
    '2022-04-26',
    18,
    '2022-04-26T04:00:00.000Z',
    '2022-04-26T10:30:00.000Z',
    6,
    261,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1017,
    '2022-04-26',
    19,
    '2022-04-26T04:00:00.000Z',
    '2022-04-26T10:30:00.000Z',
    6,
    198,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1018,
    '2022-04-25',
    21,
    '2022-04-25T04:00:00.000Z',
    '2022-04-25T10:30:00.000Z',
    6,
    282,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1019,
    '2022-04-25',
    19,
    '2022-04-25T04:00:00.000Z',
    '2022-04-25T10:30:00.000Z',
    6,
    198,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1020,
    '2022-04-25',
    18,
    '2022-04-25T04:00:00.000Z',
    '2022-04-25T10:30:00.000Z',
    6,
    261,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1021,
    '2022-04-24',
    21,
    '2022-04-24T04:00:00.000Z',
    '2022-04-24T10:30:00.000Z',
    6,
    282,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1022,
    '2022-04-24',
    18,
    '2022-04-24T04:00:00.000Z',
    '2022-04-24T10:30:00.000Z',
    6,
    261,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1023,
    '2022-04-24',
    19,
    '2022-04-24T04:00:00.000Z',
    '2022-04-24T10:30:00.000Z',
    6,
    198,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1030,
    '2022-05-01',
    20,
    '2022-05-01T04:00:00.000Z',
    '2022-05-01T13:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1037,
    '2022-05-01',
    13,
    '2022-05-01T04:00:00.000Z',
    '2022-05-01T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1038,
    '2022-05-01',
    19,
    '2022-05-01T04:00:00.000Z',
    '2022-05-01T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1039,
    '2022-05-01',
    18,
    '2022-05-01T04:00:00.000Z',
    '2022-05-01T13:00:00.000Z',
    8.5,
    370,
    'הכנות גג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1040,
    '2022-05-02',
    18,
    '2022-05-02T04:00:00.000Z',
    '2022-05-02T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1041,
    '2022-05-02',
    13,
    '2022-05-02T04:00:00.000Z',
    '2022-05-02T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1042,
    '2022-05-02',
    21,
    '2022-05-02T04:00:00.000Z',
    '2022-05-02T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1043,
    '2022-05-03',
    21,
    '2022-05-03T04:00:00.000Z',
    '2022-05-03T16:00:00.000Z',
    11.5,
    541,
    'קוי ביוה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1044,
    '2022-05-03',
    13,
    '2022-05-03T04:00:00.000Z',
    '2022-05-03T16:00:00.000Z',
    11.5,
    582,
    'קוי ביוה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1045,
    '2022-05-03',
    22,
    '2022-05-03T04:00:00.000Z',
    '2022-05-03T13:00:00.000Z',
    8.5,
    300,
    'מערכת מים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1046,
    '2022-05-03',
    18,
    '2022-05-03T04:00:00.000Z',
    '2022-05-03T13:00:00.000Z',
    8.5,
    370,
    'מערכת מים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1047,
    '2022-05-03',
    19,
    '2022-05-03T04:00:00.000Z',
    '2022-05-03T13:00:00.000Z',
    8.5,
    280,
    'מערכת מים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1048,
    '2022-05-04',
    19,
    '2022-05-04T04:00:00.000Z',
    '2022-05-04T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1049,
    '2022-05-04',
    13,
    '2022-05-04T04:00:00.000Z',
    '2022-05-04T16:10:00.000Z',
    11.67,
    590,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1050,
    '2022-05-04',
    22,
    '2022-05-04T04:00:00.000Z',
    '2022-05-04T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1051,
    '2022-05-04',
    21,
    '2022-05-04T04:00:00.000Z',
    '2022-05-04T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1052,
    '2022-05-04',
    18,
    '2022-05-04T04:00:00.000Z',
    '2022-05-04T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1053,
    '2022-05-05',
    13,
    '2022-05-05T04:00:00.000Z',
    '2022-05-05T13:00:00.000Z',
    8.5,
    430,
    'יום העצמאות'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1054,
    '2022-05-05',
    21,
    '2022-05-05T04:00:00.000Z',
    '2022-05-05T10:30:00.000Z',
    6,
    282,
    'יום העצמאות'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1055,
    '2022-05-05',
    19,
    '2022-05-05T04:00:00.000Z',
    '2022-05-05T10:30:00.000Z',
    6,
    198,
    'יום העצמאות'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1057,
    '2022-05-08',
    13,
    '2022-05-08T04:00:00.000Z',
    '2022-05-08T14:00:00.000Z',
    9.5,
    481,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1058,
    '2022-05-08',
    19,
    '2022-05-08T04:00:00.000Z',
    '2022-05-08T14:00:00.000Z',
    9.5,
    313,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1059,
    '2022-05-08',
    18,
    '2022-05-08T04:00:00.000Z',
    '2022-05-08T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1060,
    '2022-05-08',
    21,
    '2022-05-08T04:00:00.000Z',
    '2022-05-08T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1061,
    '2022-05-09',
    13,
    '2022-05-09T04:00:00.000Z',
    '2022-05-09T16:00:00.000Z',
    11.5,
    582,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1062,
    '2022-05-09',
    21,
    '2022-05-09T04:00:00.000Z',
    '2022-05-09T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1063,
    '2022-05-09',
    18,
    '2022-05-09T04:00:00.000Z',
    '2022-05-09T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1064,
    '2022-05-10',
    23,
    '2022-05-10T04:00:00.000Z',
    '2022-05-10T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1065,
    '2022-05-10',
    13,
    '2022-05-10T04:00:00.000Z',
    '2022-05-10T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1066,
    '2022-05-10',
    18,
    '2022-05-10T04:00:00.000Z',
    '2022-05-10T13:00:00.000Z',
    8.5,
    370,
    'עזבה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1067,
    '2022-05-10',
    21,
    '2022-05-10T04:00:00.000Z',
    '2022-05-10T13:00:00.000Z',
    8.5,
    400,
    'עזבה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1068,
    '2022-05-11',
    23,
    '2022-05-11T04:00:00.000Z',
    '2022-05-11T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1069,
    '2022-05-11',
    13,
    '2022-05-11T04:00:00.000Z',
    '2022-05-11T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1070,
    '2022-05-11',
    18,
    '2022-05-11T04:00:00.000Z',
    '2022-05-11T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1071,
    '2022-05-12',
    13,
    '2022-05-12T04:00:00.000Z',
    '2022-05-12T15:30:00.000Z',
    11,
    556,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1072,
    '2022-05-12',
    21,
    '2022-05-12T04:00:00.000Z',
    '2022-05-12T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1073,
    '2022-05-12',
    18,
    '2022-05-12T04:00:00.000Z',
    '2022-05-12T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1074,
    '2022-05-12',
    23,
    '2022-05-12T04:00:00.000Z',
    '2022-05-12T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1076,
    '2022-05-13',
    13,
    '2022-05-13T04:00:00.000Z',
    '2022-05-13T11:00:00.000Z',
    6.5,
    329,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1077,
    '2022-05-13',
    21,
    '2022-05-13T04:00:00.000Z',
    '2022-05-13T08:30:00.000Z',
    4,
    188,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1078,
    '2022-05-13',
    18,
    '2022-05-13T04:00:00.000Z',
    '2022-05-13T11:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1080,
    '2022-05-15',
    21,
    '2022-05-15T04:00:00.000Z',
    '2022-05-15T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1081,
    '2022-05-15',
    13,
    '2022-05-15T04:00:00.000Z',
    '2022-05-15T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1082,
    '2022-05-12',
    24,
    '2022-05-12T04:00:00.000Z',
    '2022-05-12T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1083,
    '2022-05-13',
    24,
    '2022-05-13T04:00:00.000Z',
    '2022-05-13T11:00:00.000Z',
    6.5,
    229,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1084,
    '2022-05-15',
    24,
    '2022-05-15T04:00:00.000Z',
    '2022-05-15T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1085,
    '2022-05-15',
    18,
    '2022-05-15T04:00:00.000Z',
    '2022-05-15T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1086,
    '2022-05-15',
    23,
    '2022-05-15T04:00:00.000Z',
    '2022-05-15T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1087,
    '2022-05-16',
    13,
    '2022-05-16T04:00:00.000Z',
    '2022-05-16T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1088,
    '2022-05-16',
    21,
    '2022-05-16T04:00:00.000Z',
    '2022-05-16T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1089,
    '2022-05-16',
    18,
    '2022-05-16T04:00:00.000Z',
    '2022-05-16T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1090,
    '2022-05-16',
    24,
    '2022-05-16T04:00:00.000Z',
    '2022-05-16T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1091,
    '2022-05-16',
    25,
    '2022-05-16T04:00:00.000Z',
    '2022-05-16T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1092,
    '2022-05-16',
    23,
    '2022-05-16T04:00:00.000Z',
    '2022-05-16T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1093,
    '2022-05-17',
    13,
    '2022-05-17T04:00:00.000Z',
    '2022-05-17T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1094,
    '2022-05-17',
    21,
    '2022-05-17T04:00:00.000Z',
    '2022-05-17T12:00:00.000Z',
    7.5,
    353,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1095,
    '2022-05-17',
    25,
    '2022-05-17T04:00:00.000Z',
    '2022-05-17T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1096,
    '2022-05-17',
    18,
    '2022-05-17T04:00:00.000Z',
    '2022-05-17T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1097,
    '2022-05-17',
    24,
    '2022-05-17T04:00:00.000Z',
    '2022-05-17T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1098,
    '2022-05-17',
    23,
    '2022-05-17T04:00:00.000Z',
    '2022-05-17T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1099,
    '2022-05-18',
    21,
    '2022-05-18T04:00:00.000Z',
    '2022-05-18T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1100,
    '2022-05-18',
    23,
    '2022-05-18T04:00:00.000Z',
    '2022-05-18T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1101,
    '2022-05-18',
    13,
    '2022-05-18T04:00:00.000Z',
    '2022-05-18T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1102,
    '2022-05-18',
    24,
    '2022-05-18T04:00:00.000Z',
    '2022-05-18T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1103,
    '2022-05-18',
    18,
    '2022-05-18T04:00:00.000Z',
    '2022-05-18T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1104,
    '2022-05-18',
    25,
    '2022-05-18T04:00:00.000Z',
    '2022-05-18T12:00:00.000Z',
    7.5,
    194,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1105,
    '2022-05-19',
    13,
    '2022-05-19T04:00:00.000Z',
    '2022-05-19T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1106,
    '2022-05-19',
    23,
    '2022-05-19T04:00:00.000Z',
    '2022-05-19T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1107,
    '2022-05-19',
    24,
    '2022-05-19T04:00:00.000Z',
    '2022-05-19T13:00:00.000Z',
    8.5,
    300,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1108,
    '2022-05-19',
    18,
    '2022-05-19T04:00:00.000Z',
    '2022-05-19T13:00:00.000Z',
    8.5,
    370,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1109,
    '2022-05-19',
    25,
    '2022-05-19T04:00:00.000Z',
    '2022-05-19T13:00:00.000Z',
    8.5,
    220,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1110,
    '2022-05-19',
    21,
    '2022-05-19T04:00:00.000Z',
    '2022-05-19T13:00:00.000Z',
    8.5,
    400,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1111,
    '2022-05-20',
    23,
    '2022-05-20T04:00:00.000Z',
    '2022-05-20T09:30:00.000Z',
    5,
    176,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1112,
    '2022-05-20',
    13,
    '2022-05-20T04:00:00.000Z',
    '2022-05-20T09:30:00.000Z',
    5,
    253,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1113,
    '2022-05-20',
    18,
    '2022-05-20T04:00:00.000Z',
    '2022-05-20T10:30:00.000Z',
    6,
    261,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1114,
    '2022-05-20',
    25,
    '2022-05-20T04:00:00.000Z',
    '2022-05-20T10:30:00.000Z',
    6,
    155,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1115,
    '2022-05-20',
    24,
    '2022-05-20T04:00:00.000Z',
    '2022-05-20T10:30:00.000Z',
    6,
    212,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1116,
    '2022-05-22',
    23,
    '2022-05-22T04:00:00.000Z',
    '2022-05-22T12:00:00.000Z',
    7.5,
    265,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1117,
    '2022-05-22',
    19,
    '2022-05-22T04:00:00.000Z',
    '2022-05-22T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1118,
    '2022-05-22',
    13,
    '2022-05-22T04:00:00.000Z',
    '2022-05-22T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1119,
    '2022-05-22',
    18,
    '2022-05-22T04:00:00.000Z',
    '2022-05-22T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1120,
    '2022-05-22',
    24,
    '2022-05-22T04:00:00.000Z',
    '2022-05-22T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1121,
    '2022-05-22',
    25,
    '2022-05-22T04:00:00.000Z',
    '2022-05-22T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1122,
    '2022-05-23',
    21,
    '2022-05-23T04:00:00.000Z',
    '2022-05-23T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1123,
    '2022-05-23',
    13,
    '2022-05-23T04:00:00.000Z',
    '2022-05-23T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1124,
    '2022-05-23',
    18,
    '2022-05-23T04:00:00.000Z',
    '2022-05-23T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1125,
    '2022-05-23',
    24,
    '2022-05-23T04:00:00.000Z',
    '2022-05-23T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1126,
    '2022-05-23',
    25,
    '2022-05-23T04:00:00.000Z',
    '2022-05-23T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1127,
    '2022-05-23',
    23,
    '2022-05-23T04:00:00.000Z',
    '2022-05-23T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1128,
    '2022-05-24',
    19,
    '2022-05-24T04:00:00.000Z',
    '2022-05-24T13:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1129,
    '2022-05-24',
    13,
    '2022-05-24T04:00:00.000Z',
    '2022-05-24T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1130,
    '2022-05-24',
    24,
    '2022-05-24T04:00:00.000Z',
    '2022-05-24T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1131,
    '2022-05-24',
    18,
    '2022-05-24T04:00:00.000Z',
    '2022-05-24T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1132,
    '2022-05-24',
    21,
    '2022-05-24T04:00:00.000Z',
    '2022-05-24T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1133,
    '2022-05-24',
    23,
    '2022-05-24T04:00:00.000Z',
    '2022-05-24T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1134,
    '2022-05-24',
    25,
    '2022-05-24T04:00:00.000Z',
    '2022-05-24T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1135,
    '2022-05-25',
    24,
    '2022-05-25T04:00:00.000Z',
    '2022-05-25T16:30:00.000Z',
    12,
    424,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1136,
    '2022-05-25',
    13,
    '2022-05-25T04:00:00.000Z',
    '2022-05-25T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1137,
    '2022-05-25',
    25,
    '2022-05-25T04:00:00.000Z',
    '2022-05-25T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1138,
    '2022-05-25',
    18,
    '2022-05-25T04:00:00.000Z',
    '2022-05-25T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1139,
    '2022-05-25',
    21,
    '2022-05-25T04:00:00.000Z',
    '2022-05-25T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1140,
    '2022-05-25',
    23,
    '2022-05-25T04:00:00.000Z',
    '2022-05-25T16:30:00.000Z',
    12,
    424,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1141,
    '2022-05-26',
    13,
    '2022-05-26T04:00:00.000Z',
    '2022-05-26T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1142,
    '2022-05-26',
    24,
    '2022-05-26T04:00:00.000Z',
    '2022-05-26T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1143,
    '2022-05-26',
    18,
    '2022-05-26T04:00:00.000Z',
    '2022-05-26T13:00:00.000Z',
    8.5,
    370,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1144,
    '2022-05-26',
    25,
    '2022-05-26T04:00:00.000Z',
    '2022-05-26T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1145,
    '2022-05-26',
    21,
    '2022-05-26T04:00:00.000Z',
    '2022-05-26T10:30:00.000Z',
    6,
    282,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1146,
    '2022-05-26',
    23,
    '2022-05-26T04:00:00.000Z',
    '2022-05-26T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1147,
    '2022-05-27',
    24,
    '2022-05-27T04:00:00.000Z',
    '2022-05-27T11:00:00.000Z',
    6.5,
    229,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1148,
    '2022-05-27',
    13,
    '2022-05-27T04:00:00.000Z',
    '2022-05-27T11:00:00.000Z',
    6.5,
    329,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1149,
    '2022-05-27',
    25,
    '2022-05-27T04:00:00.000Z',
    '2022-05-27T11:00:00.000Z',
    6.5,
    168,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1150,
    '2022-05-27',
    18,
    '2022-05-27T04:00:00.000Z',
    '2022-05-27T11:00:00.000Z',
    6.5,
    283,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1151,
    '2022-05-27',
    23,
    '2022-05-27T04:00:00.000Z',
    '2022-05-27T13:30:00.000Z',
    9,
    318,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1152,
    '2022-05-27',
    21,
    '2022-05-27T04:00:00.000Z',
    '2022-05-27T13:30:00.000Z',
    9,
    424,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1153,
    '2022-05-29',
    21,
    '2022-05-29T04:00:00.000Z',
    '2022-05-29T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1154,
    '2022-05-29',
    23,
    '2022-05-29T04:00:00.000Z',
    '2022-05-29T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1155,
    '2022-05-29',
    24,
    '2022-05-29T04:00:00.000Z',
    '2022-05-29T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1156,
    '2022-05-29',
    25,
    '2022-05-29T04:00:00.000Z',
    '2022-05-29T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1157,
    '2022-05-29',
    13,
    '2022-05-29T04:00:00.000Z',
    '2022-05-29T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1158,
    '2022-05-30',
    21,
    '2022-05-30T04:00:00.000Z',
    '2022-05-30T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1159,
    '2022-05-30',
    23,
    '2022-05-30T04:00:00.000Z',
    '2022-05-30T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1160,
    '2022-05-30',
    13,
    '2022-05-30T04:00:00.000Z',
    '2022-05-30T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1161,
    '2022-05-30',
    24,
    '2022-05-30T04:00:00.000Z',
    '2022-05-30T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1162,
    '2022-05-30',
    25,
    '2022-05-30T04:00:00.000Z',
    '2022-05-30T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1163,
    '2022-05-31',
    23,
    '2022-05-31T04:00:00.000Z',
    '2022-05-31T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1164,
    '2022-05-31',
    21,
    '2022-05-31T04:00:00.000Z',
    '2022-05-31T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1165,
    '2022-05-31',
    24,
    '2022-05-31T04:00:00.000Z',
    '2022-05-31T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1166,
    '2022-05-31',
    25,
    '2022-05-31T04:00:00.000Z',
    '2022-05-31T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1167,
    '2022-05-31',
    13,
    '2022-05-31T04:00:00.000Z',
    '2022-05-31T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1168,
    '2022-06-01',
    20,
    '2022-06-01T04:00:00.000Z',
    '2022-06-01T13:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1169,
    '2022-06-01',
    23,
    '2022-06-01T04:00:00.000Z',
    '2022-06-01T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1170,
    '2022-06-01',
    21,
    '2022-06-01T04:00:00.000Z',
    '2022-06-01T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1171,
    '2022-06-01',
    25,
    '2022-06-01T04:00:00.000Z',
    '2022-06-01T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1172,
    '2022-06-01',
    13,
    '2022-06-01T04:00:00.000Z',
    '2022-06-01T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1173,
    '2022-06-01',
    24,
    '2022-06-01T04:00:00.000Z',
    '2022-06-01T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1174,
    '2022-06-02',
    25,
    '2022-06-02T04:00:00.000Z',
    '2022-06-02T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1175,
    '2022-06-02',
    24,
    '2022-06-02T04:00:00.000Z',
    '2022-06-02T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1176,
    '2022-06-02',
    13,
    '2022-06-02T04:00:00.000Z',
    '2022-06-02T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1177,
    '2022-06-03',
    13,
    '2022-06-03T04:00:00.000Z',
    '2022-06-03T07:00:00.000Z',
    3,
    152,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1178,
    '2022-06-03',
    24,
    '2022-06-03T04:00:00.000Z',
    '2022-06-03T15:00:00.000Z',
    10.5,
    371,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1179,
    '2022-06-03',
    25,
    '2022-06-03T04:00:00.000Z',
    '2022-06-03T15:00:00.000Z',
    10.5,
    247,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1180,
    '2022-06-03',
    21,
    '2022-06-03T04:00:00.000Z',
    '2022-06-03T11:00:00.000Z',
    6.5,
    306,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1181,
    '2022-06-03',
    23,
    '2022-06-03T04:00:00.000Z',
    '2022-06-03T15:00:00.000Z',
    10.5,
    371,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1182,
    '2022-06-04',
    23,
    '2022-06-04T04:00:00.000Z',
    '2022-06-04T14:00:00.000Z',
    9.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1183,
    '2022-06-04',
    24,
    '2022-06-04T04:00:00.000Z',
    '2022-06-04T14:00:00.000Z',
    9.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1184,
    '2022-06-04',
    25,
    '2022-06-04T04:00:00.000Z',
    '2022-06-04T14:00:00.000Z',
    9.5,
    224,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1185,
    '2022-06-05',
    24,
    '2022-06-05T04:00:00.000Z',
    '2022-06-05T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1186,
    '2022-06-05',
    13,
    '2022-06-05T04:00:00.000Z',
    '2022-06-05T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1187,
    '2022-06-05',
    25,
    '2022-06-05T04:00:00.000Z',
    '2022-06-05T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1188,
    '2022-06-05',
    21,
    '2022-06-05T04:00:00.000Z',
    '2022-06-05T13:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1189,
    '2022-06-05',
    23,
    '2022-06-05T04:00:00.000Z',
    '2022-06-05T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1190,
    '2022-06-06',
    25,
    '2022-06-06T04:00:00.000Z',
    '2022-06-06T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1191,
    '2022-06-06',
    24,
    '2022-06-06T04:00:00.000Z',
    '2022-06-06T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1192,
    '2022-06-06',
    13,
    '2022-06-06T04:00:00.000Z',
    '2022-06-06T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1193,
    '2022-06-06',
    23,
    '2022-06-06T04:00:00.000Z',
    '2022-06-06T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1194,
    '2022-06-06',
    21,
    '2022-06-06T04:00:00.000Z',
    '2022-06-06T11:30:00.000Z',
    7,
    329,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1195,
    '2022-06-07',
    24,
    '2022-06-07T04:00:00.000Z',
    '2022-06-07T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1196,
    '2022-06-07',
    13,
    '2022-06-07T04:00:00.000Z',
    '2022-06-07T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1197,
    '2022-06-07',
    25,
    '2022-06-07T04:00:00.000Z',
    '2022-06-07T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1198,
    '2022-06-07',
    23,
    '2022-06-07T04:00:00.000Z',
    '2022-06-07T07:00:00.000Z',
    3,
    106,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1199,
    '2022-06-07',
    21,
    '2022-06-07T04:00:00.000Z',
    '2022-06-07T07:00:00.000Z',
    3,
    141,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1200,
    '2022-06-08',
    24,
    '2022-06-08T04:00:00.000Z',
    '2022-06-08T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1201,
    '2022-06-08',
    13,
    '2022-06-08T04:00:00.000Z',
    '2022-06-08T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1202,
    '2022-06-08',
    23,
    '2022-06-08T04:00:00.000Z',
    '2022-06-08T13:00:00.000Z',
    8.5,
    300,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1205,
    '2022-06-09',
    13,
    '2022-06-09T04:00:00.000Z',
    '2022-06-09T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1206,
    '2022-06-09',
    24,
    '2022-06-09T04:00:00.000Z',
    '2022-06-09T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1207,
    '2022-06-09',
    23,
    '2022-06-09T04:00:00.000Z',
    '2022-06-09T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1208,
    '2022-06-10',
    24,
    '2022-06-10T04:00:00.000Z',
    '2022-06-10T11:00:00.000Z',
    6.5,
    229,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1209,
    '2022-06-10',
    13,
    '2022-06-10T04:00:00.000Z',
    '2022-06-10T11:00:00.000Z',
    6.5,
    329,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1210,
    '2022-06-10',
    25,
    '2022-06-10T04:00:00.000Z',
    '2022-06-10T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1211,
    '2022-06-10',
    23,
    '2022-06-10T04:00:00.000Z',
    '2022-06-10T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1212,
    '2022-06-12',
    23,
    '2022-06-12T04:00:00.000Z',
    '2022-06-12T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1213,
    '2022-06-12',
    13,
    '2022-06-12T04:00:00.000Z',
    '2022-06-12T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1214,
    '2022-06-12',
    24,
    '2022-06-12T04:00:00.000Z',
    '2022-06-12T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1215,
    '2022-06-12',
    25,
    '2022-06-12T04:00:00.000Z',
    '2022-06-12T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1216,
    '2022-06-13',
    13,
    '2022-06-13T04:00:00.000Z',
    '2022-06-13T13:00:00.000Z',
    8.5,
    430,
    'מערכת מים וביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1217,
    '2022-06-13',
    25,
    '2022-06-13T04:00:00.000Z',
    '2022-06-13T13:00:00.000Z',
    8.5,
    200,
    'מערכת מים וביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1218,
    '2022-06-13',
    24,
    '2022-06-13T04:00:00.000Z',
    '2022-06-13T13:00:00.000Z',
    8.5,
    300,
    'מערכת מים וביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1219,
    '2022-06-13',
    23,
    '2022-06-13T04:00:00.000Z',
    '2022-06-13T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1220,
    '2022-06-14',
    24,
    '2022-06-14T04:00:00.000Z',
    '2022-06-14T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1221,
    '2022-06-14',
    13,
    '2022-06-14T04:00:00.000Z',
    '2022-06-14T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1222,
    '2022-06-14',
    25,
    '2022-06-14T04:00:00.000Z',
    '2022-06-14T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1223,
    '2022-06-14',
    23,
    '2022-06-14T04:00:00.000Z',
    '2022-06-14T13:00:00.000Z',
    8.5,
    300,
    'רובין הכנות קורות כשר- ראגח הכנות גג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1224,
    '2022-06-15',
    24,
    '2022-06-15T04:00:00.000Z',
    '2022-06-15T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1225,
    '2022-06-15',
    13,
    '2022-06-15T04:00:00.000Z',
    '2022-06-15T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1226,
    '2022-06-15',
    23,
    '2022-06-15T04:00:00.000Z',
    '2022-06-15T13:00:00.000Z',
    8.5,
    300,
    'קוי ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1227,
    '2022-06-15',
    25,
    '2022-06-15T04:00:00.000Z',
    '2022-06-15T13:00:00.000Z',
    8.5,
    200,
    'קוי ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1228,
    '2022-06-16',
    13,
    '2022-06-16T04:00:00.000Z',
    '2022-06-16T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1229,
    '2022-06-16',
    24,
    '2022-06-16T04:00:00.000Z',
    '2022-06-16T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1230,
    '2022-06-16',
    25,
    '2022-06-16T04:00:00.000Z',
    '2022-06-16T13:00:00.000Z',
    8.5,
    200,
    'קוי ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1231,
    '2022-06-16',
    23,
    '2022-06-16T04:00:00.000Z',
    '2022-06-16T13:00:00.000Z',
    8.5,
    300,
    'קוי ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1232,
    '2022-06-17',
    24,
    '2022-06-17T04:00:00.000Z',
    '2022-06-17T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1233,
    '2022-06-17',
    13,
    '2022-06-17T04:00:00.000Z',
    '2022-06-17T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1234,
    '2022-06-17',
    25,
    '2022-06-17T04:00:00.000Z',
    '2022-06-17T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1235,
    '2022-06-17',
    23,
    '2022-06-17T04:00:00.000Z',
    '2022-06-17T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1236,
    '2022-06-18',
    25,
    '2022-06-18T04:00:00.000Z',
    '2022-06-18T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1237,
    '2022-06-18',
    23,
    '2022-06-18T04:00:00.000Z',
    '2022-06-18T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1238,
    '2022-06-19',
    13,
    '2022-06-19T04:00:00.000Z',
    '2022-06-19T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1239,
    '2022-06-19',
    24,
    '2022-06-19T04:00:00.000Z',
    '2022-06-19T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1240,
    '2022-06-19',
    25,
    '2022-06-19T04:00:00.000Z',
    '2022-06-19T13:00:00.000Z',
    8.5,
    200,
    'איטום'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1241,
    '2022-06-19',
    23,
    '2022-06-19T04:00:00.000Z',
    '2022-06-19T13:00:00.000Z',
    8.5,
    300,
    'איטום'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1242,
    '2022-06-20',
    13,
    '2022-06-20T04:00:00.000Z',
    '2022-06-20T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1243,
    '2022-06-20',
    24,
    '2022-06-20T04:00:00.000Z',
    '2022-06-20T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1244,
    '2022-06-20',
    25,
    '2022-06-20T04:00:00.000Z',
    '2022-06-20T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1245,
    '2022-06-20',
    23,
    '2022-06-20T04:00:00.000Z',
    '2022-06-20T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1246,
    '2022-06-21',
    13,
    '2022-06-21T04:00:00.000Z',
    '2022-06-21T12:00:00.000Z',
    7.5,
    379,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1247,
    '2022-06-21',
    24,
    '2022-06-21T04:00:00.000Z',
    '2022-06-21T12:00:00.000Z',
    7.5,
    265,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1248,
    '2022-06-21',
    25,
    '2022-06-21T04:00:00.000Z',
    '2022-06-21T12:00:00.000Z',
    7.5,
    176,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1249,
    '2022-06-21',
    23,
    '2022-06-21T04:00:00.000Z',
    '2022-06-21T12:00:00.000Z',
    7.5,
    265,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1250,
    '2022-06-22',
    24,
    '2022-06-22T04:00:00.000Z',
    '2022-06-22T14:00:00.000Z',
    9.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1251,
    '2022-06-22',
    13,
    '2022-06-22T04:00:00.000Z',
    '2022-06-22T14:00:00.000Z',
    9.5,
    481,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1252,
    '2022-06-22',
    23,
    '2022-06-22T04:00:00.000Z',
    '2022-06-22T14:00:00.000Z',
    9.5,
    335,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1253,
    '2022-06-22',
    25,
    '2022-06-22T04:00:00.000Z',
    '2022-06-22T14:00:00.000Z',
    9.5,
    224,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1254,
    '2022-06-23',
    24,
    '2022-06-23T04:00:00.000Z',
    '2022-06-23T13:00:00.000Z',
    8.5,
    300,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1255,
    '2022-06-23',
    13,
    '2022-06-23T04:00:00.000Z',
    '2022-06-23T13:00:00.000Z',
    8.5,
    430,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1256,
    '2022-06-23',
    25,
    '2022-06-23T04:00:00.000Z',
    '2022-06-23T13:00:00.000Z',
    8.5,
    200,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1257,
    '2022-06-24',
    13,
    '2022-06-24T04:00:00.000Z',
    '2022-06-24T11:00:00.000Z',
    6.5,
    329,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1258,
    '2022-06-24',
    25,
    '2022-06-24T04:00:00.000Z',
    '2022-06-24T11:00:00.000Z',
    6.5,
    153,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1259,
    '2022-06-24',
    24,
    '2022-06-24T04:00:00.000Z',
    '2022-06-24T11:00:00.000Z',
    6.5,
    229,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1260,
    '2022-06-26',
    13,
    '2022-06-26T04:00:00.000Z',
    '2022-06-26T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1261,
    '2022-06-26',
    25,
    '2022-06-26T04:00:00.000Z',
    '2022-06-26T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1262,
    '2022-06-26',
    24,
    '2022-06-26T04:00:00.000Z',
    '2022-06-26T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1263,
    '2022-06-26',
    23,
    '2022-06-26T04:00:00.000Z',
    '2022-06-26T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1264,
    '2022-06-27',
    24,
    '2022-06-27T04:00:00.000Z',
    '2022-06-27T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1265,
    '2022-06-27',
    13,
    '2022-06-27T04:00:00.000Z',
    '2022-06-27T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1266,
    '2022-06-27',
    25,
    '2022-06-27T04:00:00.000Z',
    '2022-06-27T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1267,
    '2022-06-27',
    23,
    '2022-06-27T04:00:00.000Z',
    '2022-06-27T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1268,
    '2022-06-28',
    13,
    '2022-06-28T04:00:00.000Z',
    '2022-06-28T14:00:00.000Z',
    9.5,
    481,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1269,
    '2022-06-28',
    24,
    '2022-06-28T04:00:00.000Z',
    '2022-06-28T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1270,
    '2022-06-28',
    25,
    '2022-06-28T04:00:00.000Z',
    '2022-06-28T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1271,
    '2022-06-28',
    23,
    '2022-06-28T04:00:00.000Z',
    '2022-06-28T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1272,
    '2022-06-29',
    13,
    '2022-06-29T04:00:00.000Z',
    '2022-06-29T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1273,
    '2022-06-29',
    23,
    '2022-06-29T04:00:00.000Z',
    '2022-06-29T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1274,
    '2022-06-29',
    25,
    '2022-06-29T04:00:00.000Z',
    '2022-06-29T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1275,
    '2022-06-29',
    24,
    '2022-06-29T04:00:00.000Z',
    '2022-06-29T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1276,
    '2022-06-30',
    23,
    '2022-06-30T04:00:00.000Z',
    '2022-06-30T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1277,
    '2022-06-30',
    24,
    '2022-06-30T04:00:00.000Z',
    '2022-06-30T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1278,
    '2022-06-30',
    13,
    '2022-06-30T04:00:00.000Z',
    '2022-06-30T13:00:00.000Z',
    8.5,
    430,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1279,
    '2022-06-30',
    25,
    '2022-06-30T04:00:00.000Z',
    '2022-06-30T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1280,
    '2022-06-08',
    25,
    '2022-06-08T04:00:00.000Z',
    '2022-06-08T13:00:00.000Z',
    8.5,
    200,
    'עם מורסל'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1281,
    '2022-06-09',
    25,
    '2022-06-09T04:00:00.000Z',
    '2022-06-09T13:00:00.000Z',
    8.5,
    200,
    'עם מורסל'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1282,
    '2022-07-01',
    20,
    '2022-07-01T04:00:00.000Z',
    '2022-07-01T13:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1283,
    '2022-07-01',
    13,
    '2022-07-01T04:00:00.000Z',
    '2022-07-01T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1284,
    '2022-07-01',
    23,
    '2022-07-01T04:00:00.000Z',
    '2022-07-01T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1285,
    '2022-07-01',
    24,
    '2022-07-01T04:00:00.000Z',
    '2022-07-01T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1286,
    '2022-07-01',
    25,
    '2022-07-01T04:00:00.000Z',
    '2022-07-01T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1287,
    '2022-07-03',
    23,
    '2022-07-03T04:00:00.000Z',
    '2022-07-03T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1288,
    '2022-07-03',
    13,
    '2022-07-03T04:00:00.000Z',
    '2022-07-03T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1289,
    '2022-07-03',
    25,
    '2022-07-03T04:00:00.000Z',
    '2022-07-03T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1290,
    '2022-07-03',
    24,
    '2022-07-03T04:00:00.000Z',
    '2022-07-03T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1291,
    '2022-07-04',
    23,
    '2022-07-04T04:00:00.000Z',
    '2022-07-04T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1292,
    '2022-07-04',
    13,
    '2022-07-04T04:00:00.000Z',
    '2022-07-04T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1293,
    '2022-07-04',
    24,
    '2022-07-04T04:00:00.000Z',
    '2022-07-04T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1294,
    '2022-07-04',
    25,
    '2022-07-04T04:00:00.000Z',
    '2022-07-04T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1295,
    '2022-07-05',
    23,
    '2022-07-05T04:00:00.000Z',
    '2022-07-05T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1296,
    '2022-07-05',
    25,
    '2022-07-05T04:00:00.000Z',
    '2022-07-05T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1297,
    '2022-07-05',
    24,
    '2022-07-05T04:00:00.000Z',
    '2022-07-05T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1298,
    '2022-07-05',
    13,
    '2022-07-05T04:00:00.000Z',
    '2022-07-05T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1299,
    '2022-07-06',
    23,
    '2022-07-06T04:00:00.000Z',
    '2022-07-06T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1300,
    '2022-07-06',
    13,
    '2022-07-06T04:00:00.000Z',
    '2022-07-06T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1301,
    '2022-07-06',
    25,
    '2022-07-06T04:00:00.000Z',
    '2022-07-06T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1302,
    '2022-07-06',
    24,
    '2022-07-06T04:00:00.000Z',
    '2022-07-06T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1303,
    '2022-07-07',
    13,
    '2022-07-07T04:00:00.000Z',
    '2022-07-07T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1304,
    '2022-07-08',
    13,
    '2022-07-08T04:00:00.000Z',
    '2022-07-08T13:00:00.000Z',
    8.5,
    450,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1305,
    '2022-07-10',
    13,
    '2022-07-10T04:00:00.000Z',
    '2022-07-10T13:00:00.000Z',
    8.5,
    450,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1306,
    '2022-07-11',
    13,
    '2022-07-11T04:00:00.000Z',
    '2022-07-11T13:00:00.000Z',
    8.5,
    450,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1307,
    '2022-07-12',
    13,
    '2022-07-12T04:00:00.000Z',
    '2022-07-12T13:00:00.000Z',
    8.5,
    450,
    'חג'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1308,
    '2022-07-17',
    23,
    '2022-07-17T04:00:00.000Z',
    '2022-07-17T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1309,
    '2022-07-17',
    13,
    '2022-07-17T04:00:00.000Z',
    '2022-07-17T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1310,
    '2022-07-18',
    13,
    '2022-07-18T04:00:00.000Z',
    '2022-07-18T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1311,
    '2022-07-18',
    26,
    '2022-07-18T04:00:00.000Z',
    '2022-07-18T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1312,
    '2022-07-18',
    25,
    '2022-07-18T04:00:00.000Z',
    '2022-07-18T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1313,
    '2022-07-18',
    23,
    '2022-07-18T04:00:00.000Z',
    '2022-07-18T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1314,
    '2022-07-18',
    24,
    '2022-07-18T04:00:00.000Z',
    '2022-07-18T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1315,
    '2022-07-19',
    13,
    '2022-07-19T04:00:00.000Z',
    '2022-07-19T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1316,
    '2022-07-19',
    23,
    '2022-07-19T04:00:00.000Z',
    '2022-07-19T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1318,
    '2022-07-19',
    25,
    '2022-07-19T04:00:00.000Z',
    '2022-07-19T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1319,
    '2022-07-19',
    26,
    '2022-07-19T04:00:00.000Z',
    '2022-07-19T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1320,
    '2022-07-19',
    24,
    '2022-07-19T04:00:00.000Z',
    '2022-07-19T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1321,
    '2022-07-20',
    25,
    '2022-07-20T04:00:00.000Z',
    '2022-07-20T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1322,
    '2022-07-21',
    23,
    '2022-07-21T04:00:00.000Z',
    '2022-07-21T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1323,
    '2022-07-21',
    25,
    '2022-07-21T04:00:00.000Z',
    '2022-07-21T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1324,
    '2022-07-21',
    26,
    '2022-07-21T04:00:00.000Z',
    '2022-07-21T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1325,
    '2022-07-21',
    24,
    '2022-07-21T04:00:00.000Z',
    '2022-07-21T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1326,
    '2022-07-21',
    13,
    '2022-07-21T04:00:00.000Z',
    '2022-07-21T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1327,
    '2022-07-22',
    24,
    '2022-07-22T04:00:00.000Z',
    '2022-07-22T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1328,
    '2022-07-22',
    13,
    '2022-07-22T04:00:00.000Z',
    '2022-07-22T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1329,
    '2022-07-22',
    23,
    '2022-07-22T04:00:00.000Z',
    '2022-07-22T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1330,
    '2022-07-22',
    25,
    '2022-07-22T04:00:00.000Z',
    '2022-07-22T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1331,
    '2022-07-22',
    26,
    '2022-07-22T04:00:00.000Z',
    '2022-07-22T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1332,
    '2022-07-24',
    13,
    '2022-07-24T04:00:00.000Z',
    '2022-07-24T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1333,
    '2022-07-24',
    25,
    '2022-07-24T04:00:00.000Z',
    '2022-07-24T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1334,
    '2022-07-24',
    23,
    '2022-07-24T04:00:00.000Z',
    '2022-07-24T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1335,
    '2022-07-24',
    24,
    '2022-07-24T04:00:00.000Z',
    '2022-07-24T13:00:00.000Z',
    8.5,
    330,
    'גולס'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1336,
    '2022-07-25',
    25,
    '2022-07-25T04:00:00.000Z',
    '2022-07-25T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1337,
    '2022-07-25',
    13,
    '2022-07-25T04:00:00.000Z',
    '2022-07-25T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1338,
    '2022-07-25',
    23,
    '2022-07-25T04:00:00.000Z',
    '2022-07-25T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1339,
    '2022-07-25',
    26,
    '2022-07-25T04:00:00.000Z',
    '2022-07-25T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1340,
    '2022-07-26',
    13,
    '2022-07-26T04:00:00.000Z',
    '2022-07-26T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1341,
    '2022-07-26',
    25,
    '2022-07-26T04:00:00.000Z',
    '2022-07-26T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1342,
    '2022-07-26',
    24,
    '2022-07-26T04:00:00.000Z',
    '2022-07-26T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1343,
    '2022-07-26',
    23,
    '2022-07-26T04:00:00.000Z',
    '2022-07-26T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1344,
    '2022-07-26',
    26,
    '2022-07-26T04:00:00.000Z',
    '2022-07-26T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1345,
    '2022-07-27',
    23,
    '2022-07-27T04:00:00.000Z',
    '2022-07-27T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1346,
    '2022-07-27',
    25,
    '2022-07-27T04:00:00.000Z',
    '2022-07-27T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1347,
    '2022-07-27',
    26,
    '2022-07-27T04:00:00.000Z',
    '2022-07-27T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1348,
    '2022-07-27',
    24,
    '2022-07-27T04:00:00.000Z',
    '2022-07-27T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1349,
    '2022-07-28',
    24,
    '2022-07-28T04:00:00.000Z',
    '2022-07-28T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1350,
    '2022-07-28',
    25,
    '2022-07-28T04:00:00.000Z',
    '2022-07-28T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1351,
    '2022-07-28',
    26,
    '2022-07-28T04:00:00.000Z',
    '2022-07-28T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1352,
    '2022-07-28',
    13,
    '2022-07-28T04:00:00.000Z',
    '2022-07-28T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1353,
    '2022-07-29',
    26,
    '2022-07-29T04:00:00.000Z',
    '2022-07-29T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1354,
    '2022-07-29',
    13,
    '2022-07-29T04:00:00.000Z',
    '2022-07-29T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1356,
    '2022-07-29',
    24,
    '2022-07-29T04:00:00.000Z',
    '2022-07-29T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1357,
    '2022-07-29',
    25,
    '2022-07-29T04:00:00.000Z',
    '2022-07-29T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1358,
    '2022-07-31',
    26,
    '2022-07-31T04:00:00.000Z',
    '2022-07-31T13:00:00.000Z',
    8.5,
    290,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1359,
    '2022-07-31',
    24,
    '2022-07-31T04:00:00.000Z',
    '2022-07-31T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1360,
    '2022-07-31',
    25,
    '2022-07-31T04:00:00.000Z',
    '2022-07-31T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1361,
    '2022-07-31',
    13,
    '2022-07-31T04:00:00.000Z',
    '2022-07-31T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1362,
    '2022-08-01',
    20,
    '2022-08-01T04:00:00.000Z',
    '2022-08-01T13:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1363,
    '2022-08-01',
    13,
    '2022-08-01T04:00:00.000Z',
    '2022-08-01T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1364,
    '2022-08-01',
    26,
    '2022-08-01T04:00:00.000Z',
    '2022-08-01T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1365,
    '2022-08-01',
    24,
    '2022-08-01T04:00:00.000Z',
    '2022-08-01T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1366,
    '2022-08-01',
    25,
    '2022-08-01T04:00:00.000Z',
    '2022-08-01T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1367,
    '2022-08-02',
    13,
    '2022-08-02T04:00:00.000Z',
    '2022-08-02T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1368,
    '2022-08-02',
    24,
    '2022-08-02T04:00:00.000Z',
    '2022-08-02T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1369,
    '2022-08-02',
    25,
    '2022-08-02T04:00:00.000Z',
    '2022-08-02T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1370,
    '2022-08-02',
    26,
    '2022-08-02T04:00:00.000Z',
    '2022-08-02T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1371,
    '2022-08-03',
    13,
    '2022-08-03T04:00:00.000Z',
    '2022-08-03T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1372,
    '2022-08-03',
    25,
    '2022-08-03T04:00:00.000Z',
    '2022-08-03T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1373,
    '2022-08-03',
    24,
    '2022-08-03T04:00:00.000Z',
    '2022-08-03T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1374,
    '2022-08-03',
    26,
    '2022-08-03T04:00:00.000Z',
    '2022-08-03T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1375,
    '2022-08-04',
    13,
    '2022-08-04T04:00:00.000Z',
    '2022-08-04T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1376,
    '2022-08-04',
    25,
    '2022-08-04T04:00:00.000Z',
    '2022-08-04T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1377,
    '2022-08-04',
    26,
    '2022-08-04T04:00:00.000Z',
    '2022-08-04T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1378,
    '2022-08-04',
    24,
    '2022-08-04T04:00:00.000Z',
    '2022-08-04T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1379,
    '2022-08-05',
    25,
    '2022-08-05T04:00:00.000Z',
    '2022-08-05T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1380,
    '2022-08-05',
    13,
    '2022-08-05T04:00:00.000Z',
    '2022-08-05T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1381,
    '2022-08-05',
    26,
    '2022-08-05T04:00:00.000Z',
    '2022-08-05T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1382,
    '2022-08-05',
    24,
    '2022-08-05T04:00:00.000Z',
    '2022-08-05T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1383,
    '2022-08-07',
    26,
    '2022-08-07T04:00:00.000Z',
    '2022-08-07T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1384,
    '2022-08-07',
    13,
    '2022-08-07T04:00:00.000Z',
    '2022-08-07T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1385,
    '2022-08-07',
    24,
    '2022-08-07T04:00:00.000Z',
    '2022-08-07T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1386,
    '2022-08-07',
    25,
    '2022-08-07T04:00:00.000Z',
    '2022-08-07T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1387,
    '2022-08-08',
    13,
    '2022-08-08T04:00:00.000Z',
    '2022-08-08T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1388,
    '2022-08-08',
    26,
    '2022-08-08T04:00:00.000Z',
    '2022-08-08T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1389,
    '2022-08-08',
    25,
    '2022-08-08T04:00:00.000Z',
    '2022-08-08T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1390,
    '2022-08-08',
    24,
    '2022-08-08T04:00:00.000Z',
    '2022-08-08T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1391,
    '2022-08-09',
    13,
    '2022-08-09T04:00:00.000Z',
    '2022-08-09T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1392,
    '2022-08-09',
    26,
    '2022-08-09T04:00:00.000Z',
    '2022-08-09T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1393,
    '2022-08-09',
    24,
    '2022-08-09T04:00:00.000Z',
    '2022-08-09T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1394,
    '2022-08-09',
    25,
    '2022-08-09T04:00:00.000Z',
    '2022-08-09T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1395,
    '2022-08-10',
    24,
    '2022-08-10T04:00:00.000Z',
    '2022-08-10T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1396,
    '2022-08-10',
    13,
    '2022-08-10T04:00:00.000Z',
    '2022-08-10T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1397,
    '2022-08-10',
    25,
    '2022-08-10T04:00:00.000Z',
    '2022-08-10T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1398,
    '2022-08-10',
    26,
    '2022-08-10T04:00:00.000Z',
    '2022-08-10T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1399,
    '2022-08-11',
    25,
    '2022-08-11T04:00:00.000Z',
    '2022-08-11T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1400,
    '2022-08-11',
    13,
    '2022-08-11T04:00:00.000Z',
    '2022-08-11T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1401,
    '2022-08-11',
    24,
    '2022-08-11T04:00:00.000Z',
    '2022-08-11T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1402,
    '2022-08-11',
    26,
    '2022-08-11T04:00:00.000Z',
    '2022-08-11T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1403,
    '2022-08-12',
    24,
    '2022-08-12T04:00:00.000Z',
    '2022-08-12T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1404,
    '2022-08-12',
    25,
    '2022-08-12T04:00:00.000Z',
    '2022-08-12T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1405,
    '2022-08-12',
    26,
    '2022-08-12T04:00:00.000Z',
    '2022-08-12T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1406,
    '2022-08-12',
    13,
    '2022-08-12T04:00:00.000Z',
    '2022-08-12T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1407,
    '2022-08-14',
    26,
    '2022-08-14T04:00:00.000Z',
    '2022-08-14T11:00:00.000Z',
    6.5,
    237,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1408,
    '2022-08-14',
    24,
    '2022-08-14T04:00:00.000Z',
    '2022-08-14T11:00:00.000Z',
    6.5,
    252,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1409,
    '2022-08-14',
    25,
    '2022-08-14T04:00:00.000Z',
    '2022-08-14T11:00:00.000Z',
    6.5,
    168,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1410,
    '2022-08-14',
    13,
    '2022-08-14T04:00:00.000Z',
    '2022-08-14T11:00:00.000Z',
    6.5,
    344,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1411,
    '2022-08-15',
    13,
    '2022-08-15T04:00:00.000Z',
    '2022-08-15T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1412,
    '2022-08-15',
    26,
    '2022-08-15T04:00:00.000Z',
    '2022-08-15T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1413,
    '2022-08-15',
    24,
    '2022-08-15T04:00:00.000Z',
    '2022-08-15T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1414,
    '2022-08-15',
    25,
    '2022-08-15T04:00:00.000Z',
    '2022-08-15T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1415,
    '2022-08-16',
    13,
    '2022-08-16T04:00:00.000Z',
    '2022-08-16T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1416,
    '2022-08-16',
    25,
    '2022-08-16T04:00:00.000Z',
    '2022-08-16T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1417,
    '2022-08-16',
    26,
    '2022-08-16T04:00:00.000Z',
    '2022-08-16T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1418,
    '2022-08-16',
    24,
    '2022-08-16T04:00:00.000Z',
    '2022-08-16T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1419,
    '2022-08-17',
    25,
    '2022-08-17T04:00:00.000Z',
    '2022-08-17T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1420,
    '2022-08-17',
    13,
    '2022-08-17T04:00:00.000Z',
    '2022-08-17T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1421,
    '2022-08-17',
    26,
    '2022-08-17T04:00:00.000Z',
    '2022-08-17T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1422,
    '2022-08-17',
    24,
    '2022-08-17T04:00:00.000Z',
    '2022-08-17T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1423,
    '2022-08-18',
    25,
    '2022-08-18T04:00:00.000Z',
    '2022-08-18T10:00:00.000Z',
    5.5,
    142,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1424,
    '2022-08-18',
    13,
    '2022-08-18T04:00:00.000Z',
    '2022-08-18T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1425,
    '2022-08-18',
    24,
    '2022-08-18T04:00:00.000Z',
    '2022-08-18T10:00:00.000Z',
    5.5,
    214,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1426,
    '2022-08-18',
    26,
    '2022-08-18T04:00:00.000Z',
    '2022-08-18T10:00:00.000Z',
    5.5,
    201,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1427,
    '2022-08-21',
    28,
    '2022-08-21T04:00:00.000Z',
    '2022-08-21T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1428,
    '2022-08-21',
    13,
    '2022-08-21T04:00:00.000Z',
    '2022-08-21T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1429,
    '2022-08-22',
    27,
    '2022-08-22T04:00:00.000Z',
    '2022-08-22T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1430,
    '2022-08-22',
    13,
    '2022-08-22T04:00:00.000Z',
    '2022-08-22T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1431,
    '2022-08-22',
    28,
    '2022-08-22T04:00:00.000Z',
    '2022-08-22T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1432,
    '2022-08-23',
    27,
    '2022-08-23T04:00:00.000Z',
    '2022-08-23T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1433,
    '2022-08-23',
    13,
    '2022-08-23T04:00:00.000Z',
    '2022-08-23T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1434,
    '2022-08-24',
    27,
    '2022-08-24T04:00:00.000Z',
    '2022-08-24T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1435,
    '2022-08-24',
    28,
    '2022-08-24T04:00:00.000Z',
    '2022-08-24T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1436,
    '2022-08-24',
    13,
    '2022-08-24T04:00:00.000Z',
    '2022-08-24T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1437,
    '2022-08-25',
    13,
    '2022-08-25T04:00:00.000Z',
    '2022-08-25T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1438,
    '2022-08-25',
    27,
    '2022-08-25T04:00:00.000Z',
    '2022-08-25T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1439,
    '2022-08-25',
    29,
    '2022-08-25T04:00:00.000Z',
    '2022-08-25T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1440,
    '2022-08-25',
    28,
    '2022-08-25T04:00:00.000Z',
    '2022-08-25T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1441,
    '2022-08-26',
    29,
    '2022-08-26T04:00:00.000Z',
    '2022-08-26T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1442,
    '2022-08-26',
    13,
    '2022-08-26T04:00:00.000Z',
    '2022-08-26T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1443,
    '2022-08-28',
    13,
    '2022-08-28T04:00:00.000Z',
    '2022-08-28T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1444,
    '2022-08-29',
    13,
    '2022-08-29T04:00:00.000Z',
    '2022-08-29T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1445,
    '2022-08-30',
    26,
    '2022-08-30T04:00:00.000Z',
    '2022-08-30T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1446,
    '2022-08-30',
    13,
    '2022-08-30T04:00:00.000Z',
    '2022-08-30T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1447,
    '2022-08-30',
    25,
    '2022-08-30T04:00:00.000Z',
    '2022-08-30T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1448,
    '2022-08-30',
    24,
    '2022-08-30T04:00:00.000Z',
    '2022-08-30T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1449,
    '2022-08-30',
    27,
    '2022-08-30T04:00:00.000Z',
    '2022-08-30T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1450,
    '2022-08-31',
    26,
    '2022-08-31T04:00:00.000Z',
    '2022-08-31T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1451,
    '2022-08-31',
    25,
    '2022-08-31T04:00:00.000Z',
    '2022-08-31T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1452,
    '2022-08-31',
    24,
    '2022-08-31T04:00:00.000Z',
    '2022-08-31T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1453,
    '2022-08-31',
    13,
    '2022-08-31T04:00:00.000Z',
    '2022-08-31T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1454,
    '2022-08-01',
    28,
    '2022-08-01T04:00:00.000Z',
    '2022-08-01T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1455,
    '2022-08-02',
    27,
    '2022-08-02T04:00:00.000Z',
    '2022-08-02T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1456,
    '2022-08-02',
    28,
    '2022-08-02T04:00:00.000Z',
    '2022-08-02T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1457,
    '2022-08-04',
    27,
    '2022-08-04T04:00:00.000Z',
    '2022-08-04T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1458,
    '2022-08-04',
    28,
    '2022-08-04T04:00:00.000Z',
    '2022-08-04T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1459,
    '2022-08-07',
    27,
    '2022-08-07T04:00:00.000Z',
    '2022-08-07T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1460,
    '2022-08-07',
    28,
    '2022-08-07T04:00:00.000Z',
    '2022-08-07T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1461,
    '2022-08-08',
    28,
    '2022-08-08T04:00:00.000Z',
    '2022-08-08T13:00:00.000Z',
    8.5,
    200,
    'קוי ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1462,
    '2022-08-08',
    27,
    '2022-08-08T04:00:00.000Z',
    '2022-08-08T13:00:00.000Z',
    8.5,
    200,
    'קוי ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1463,
    '2022-08-10',
    27,
    '2022-08-10T04:00:00.000Z',
    '2022-08-10T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1464,
    '2022-08-10',
    28,
    '2022-08-10T04:00:00.000Z',
    '2022-08-10T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1465,
    '2022-08-11',
    28,
    '2022-08-11T04:00:00.000Z',
    '2022-08-11T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1466,
    '2022-08-11',
    27,
    '2022-08-11T04:00:00.000Z',
    '2022-08-11T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1467,
    '2022-07-01',
    27,
    '2022-07-01T04:00:00.000Z',
    '2022-07-01T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1468,
    '2022-07-03',
    28,
    '2022-07-03T04:00:00.000Z',
    '2022-07-03T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1469,
    '2022-07-03',
    27,
    '2022-07-03T04:00:00.000Z',
    '2022-07-03T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1470,
    '2022-07-04',
    28,
    '2022-07-04T04:00:00.000Z',
    '2022-07-04T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1471,
    '2022-07-04',
    27,
    '2022-07-04T04:00:00.000Z',
    '2022-07-04T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1472,
    '2022-07-05',
    27,
    '2022-07-05T04:00:00.000Z',
    '2022-07-05T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1473,
    '2022-07-06',
    28,
    '2022-07-06T04:00:00.000Z',
    '2022-07-06T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1474,
    '2022-07-06',
    27,
    '2022-07-06T04:00:00.000Z',
    '2022-07-06T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1475,
    '2022-07-07',
    28,
    '2022-07-07T04:00:00.000Z',
    '2022-07-07T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1476,
    '2022-07-07',
    27,
    '2022-07-07T04:00:00.000Z',
    '2022-07-07T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1477,
    '2022-07-17',
    28,
    '2022-07-17T04:00:00.000Z',
    '2022-07-17T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1478,
    '2022-07-18',
    27,
    '2022-07-18T04:00:00.000Z',
    '2022-07-18T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1479,
    '2022-07-18',
    28,
    '2022-07-18T04:00:00.000Z',
    '2022-07-18T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1480,
    '2022-07-19',
    27,
    '2022-07-19T04:00:00.000Z',
    '2022-07-19T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1481,
    '2022-07-19',
    28,
    '2022-07-19T04:00:00.000Z',
    '2022-07-19T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1482,
    '2022-07-20',
    27,
    '2022-07-20T04:00:00.000Z',
    '2022-07-20T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1483,
    '2022-07-21',
    27,
    '2022-07-21T04:00:00.000Z',
    '2022-07-21T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1484,
    '2022-07-21',
    28,
    '2022-07-21T04:00:00.000Z',
    '2022-07-21T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1485,
    '2022-06-23',
    28,
    '2022-06-23T04:00:00.000Z',
    '2022-06-23T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1486,
    '2022-06-24',
    28,
    '2022-06-24T04:00:00.000Z',
    '2022-06-24T11:00:00.000Z',
    6.5,
    153,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1487,
    '2022-06-27',
    28,
    '2022-06-27T04:00:00.000Z',
    '2022-06-27T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1488,
    '2022-06-28',
    27,
    '2022-06-28T04:00:00.000Z',
    '2022-06-28T14:00:00.000Z',
    9.5,
    224,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1489,
    '2022-06-28',
    28,
    '2022-06-28T04:00:00.000Z',
    '2022-06-28T14:00:00.000Z',
    9.5,
    224,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1490,
    '2022-06-29',
    27,
    '2022-06-29T04:00:00.000Z',
    '2022-06-29T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1491,
    '2022-06-29',
    28,
    '2022-06-29T04:00:00.000Z',
    '2022-06-29T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1492,
    '2022-06-30',
    28,
    '2022-06-30T04:00:00.000Z',
    '2022-06-30T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1493,
    '2022-06-30',
    27,
    '2022-06-30T04:00:00.000Z',
    '2022-06-30T13:00:00.000Z',
    8.5,
    200,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1494,
    '2022-09-01',
    13,
    '2022-09-01T04:00:00.000Z',
    '2022-09-01T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1495,
    '2022-09-01',
    24,
    '2022-09-01T04:00:00.000Z',
    '2022-09-01T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1496,
    '2022-09-01',
    25,
    '2022-09-01T04:00:00.000Z',
    '2022-09-01T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1497,
    '2022-09-01',
    26,
    '2022-09-01T04:00:00.000Z',
    '2022-09-01T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1498,
    '2022-09-01',
    30,
    '2022-09-01T04:00:00.000Z',
    '2022-09-01T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1504,
    '2022-09-02',
    26,
    '2022-09-02T04:00:00.000Z',
    '2022-09-02T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1505,
    '2022-09-02',
    30,
    '2022-09-02T04:00:00.000Z',
    '2022-09-02T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1506,
    '2022-09-02',
    24,
    '2022-09-02T04:00:00.000Z',
    '2022-09-02T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1507,
    '2022-09-02',
    25,
    '2022-09-02T04:00:00.000Z',
    '2022-09-02T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1508,
    '2022-09-02',
    13,
    '2022-09-02T04:00:00.000Z',
    '2022-09-02T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1509,
    '2022-09-03',
    30,
    '2022-09-03T04:00:00.000Z',
    '2022-09-03T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1510,
    '2022-09-03',
    26,
    '2022-09-03T04:00:00.000Z',
    '2022-09-03T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1511,
    '2022-09-03',
    25,
    '2022-09-03T04:00:00.000Z',
    '2022-09-03T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1512,
    '2022-09-03',
    24,
    '2022-09-03T04:00:00.000Z',
    '2022-09-03T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1513,
    '2022-09-04',
    26,
    '2022-09-04T04:00:00.000Z',
    '2022-09-04T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1514,
    '2022-09-04',
    30,
    '2022-09-04T04:00:00.000Z',
    '2022-09-04T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1515,
    '2022-09-04',
    13,
    '2022-09-04T04:00:00.000Z',
    '2022-09-04T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1516,
    '2022-09-04',
    25,
    '2022-09-04T04:00:00.000Z',
    '2022-09-04T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1517,
    '2022-09-04',
    24,
    '2022-09-04T04:00:00.000Z',
    '2022-09-04T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1518,
    '2022-09-05',
    30,
    '2022-09-05T04:00:00.000Z',
    '2022-09-05T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1519,
    '2022-09-05',
    25,
    '2022-09-05T04:00:00.000Z',
    '2022-09-05T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1520,
    '2022-09-05',
    24,
    '2022-09-05T04:00:00.000Z',
    '2022-09-05T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1521,
    '2022-09-05',
    26,
    '2022-09-05T04:00:00.000Z',
    '2022-09-05T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1522,
    '2022-09-05',
    13,
    '2022-09-05T04:00:00.000Z',
    '2022-09-05T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1523,
    '2022-09-06',
    24,
    '2022-09-06T04:00:00.000Z',
    '2022-09-06T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1524,
    '2022-09-06',
    13,
    '2022-09-06T04:00:00.000Z',
    '2022-09-06T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1525,
    '2022-09-06',
    26,
    '2022-09-06T04:00:00.000Z',
    '2022-09-06T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1526,
    '2022-09-06',
    31,
    '2022-09-06T04:00:00.000Z',
    '2022-09-06T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1527,
    '2022-09-06',
    30,
    '2022-09-06T04:00:00.000Z',
    '2022-09-06T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1528,
    '2022-09-06',
    25,
    '2022-09-06T04:00:00.000Z',
    '2022-09-06T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1529,
    '2022-09-03',
    13,
    '2022-09-03T04:00:00.000Z',
    '2022-09-03T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1530,
    '2022-09-07',
    13,
    '2022-09-07T04:00:00.000Z',
    '2022-09-07T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1531,
    '2022-09-07',
    30,
    '2022-09-07T04:00:00.000Z',
    '2022-09-07T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1532,
    '2022-09-07',
    24,
    '2022-09-07T04:00:00.000Z',
    '2022-09-07T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1533,
    '2022-09-07',
    25,
    '2022-09-07T04:00:00.000Z',
    '2022-09-07T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1534,
    '2022-09-08',
    30,
    '2022-09-08T04:00:00.000Z',
    '2022-09-08T13:00:00.000Z',
    8.5,
    300,
    'עובד ראגח '
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1535,
    '2022-09-08',
    13,
    '2022-09-08T04:00:00.000Z',
    '2022-09-08T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1536,
    '2022-09-08',
    25,
    '2022-09-08T04:00:00.000Z',
    '2022-09-08T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1537,
    '2022-09-08',
    24,
    '2022-09-08T04:00:00.000Z',
    '2022-09-08T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1538,
    '2022-09-08',
    31,
    '2022-09-08T04:00:00.000Z',
    '2022-09-08T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1539,
    '2022-09-08',
    26,
    '2022-09-08T04:00:00.000Z',
    '2022-09-08T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1540,
    '2022-09-09',
    31,
    '2022-09-09T04:00:00.000Z',
    '2022-09-09T13:00:00.000Z',
    8.5,
    310,
    'סידור מחסן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1541,
    '2022-09-09',
    26,
    '2022-09-09T04:00:00.000Z',
    '2022-09-09T13:00:00.000Z',
    8.5,
    310,
    'סידור מחסן'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1542,
    '2022-09-09',
    25,
    '2022-09-09T04:00:00.000Z',
    '2022-09-09T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1543,
    '2022-09-09',
    24,
    '2022-09-09T04:00:00.000Z',
    '2022-09-09T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1544,
    '2022-09-09',
    30,
    '2022-09-09T04:00:00.000Z',
    '2022-09-09T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1545,
    '2022-09-09',
    13,
    '2022-09-09T04:00:00.000Z',
    '2022-09-09T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1546,
    '2022-09-11',
    13,
    '2022-09-11T04:00:00.000Z',
    '2022-09-11T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1547,
    '2022-09-11',
    30,
    '2022-09-11T04:00:00.000Z',
    '2022-09-11T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1548,
    '2022-09-11',
    25,
    '2022-09-11T04:00:00.000Z',
    '2022-09-11T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1549,
    '2022-09-11',
    24,
    '2022-09-11T04:00:00.000Z',
    '2022-09-11T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1550,
    '2022-09-11',
    31,
    '2022-09-11T04:00:00.000Z',
    '2022-09-11T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1551,
    '2022-09-11',
    26,
    '2022-09-11T04:00:00.000Z',
    '2022-09-11T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1552,
    '2022-09-12',
    30,
    '2022-09-12T04:00:00.000Z',
    '2022-09-12T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1553,
    '2022-09-12',
    13,
    '2022-09-12T04:00:00.000Z',
    '2022-09-12T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1554,
    '2022-09-12',
    25,
    '2022-09-12T04:00:00.000Z',
    '2022-09-12T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1555,
    '2022-09-12',
    24,
    '2022-09-12T04:00:00.000Z',
    '2022-09-12T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1556,
    '2022-09-12',
    26,
    '2022-09-12T04:00:00.000Z',
    '2022-09-12T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1557,
    '2022-09-12',
    31,
    '2022-09-12T04:00:00.000Z',
    '2022-09-12T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1558,
    '2022-09-13',
    25,
    '2022-09-13T04:00:00.000Z',
    '2022-09-13T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1559,
    '2022-09-13',
    13,
    '2022-09-13T04:00:00.000Z',
    '2022-09-13T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1560,
    '2022-09-13',
    24,
    '2022-09-13T04:00:00.000Z',
    '2022-09-13T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1561,
    '2022-09-13',
    30,
    '2022-09-13T04:00:00.000Z',
    '2022-09-13T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1562,
    '2022-09-13',
    26,
    '2022-09-13T04:00:00.000Z',
    '2022-09-13T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1563,
    '2022-09-13',
    31,
    '2022-09-13T04:00:00.000Z',
    '2022-09-13T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1564,
    '2022-09-14',
    30,
    '2022-09-14T04:00:00.000Z',
    '2022-09-14T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1565,
    '2022-09-14',
    13,
    '2022-09-14T04:00:00.000Z',
    '2022-09-14T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1566,
    '2022-09-14',
    26,
    '2022-09-14T04:00:00.000Z',
    '2022-09-14T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1567,
    '2022-09-14',
    31,
    '2022-09-14T04:00:00.000Z',
    '2022-09-14T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1568,
    '2022-09-14',
    25,
    '2022-09-14T04:00:00.000Z',
    '2022-09-14T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1569,
    '2022-09-14',
    24,
    '2022-09-14T04:00:00.000Z',
    '2022-09-14T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1570,
    '2022-09-15',
    31,
    '2022-09-15T04:00:00.000Z',
    '2022-09-15T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1571,
    '2022-09-15',
    24,
    '2022-09-15T04:00:00.000Z',
    '2022-09-15T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1572,
    '2022-09-15',
    13,
    '2022-09-15T04:00:00.000Z',
    '2022-09-15T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1573,
    '2022-09-15',
    30,
    '2022-09-15T04:00:00.000Z',
    '2022-09-15T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1574,
    '2022-09-15',
    26,
    '2022-09-15T04:00:00.000Z',
    '2022-09-15T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1575,
    '2022-09-15',
    25,
    '2022-09-15T04:00:00.000Z',
    '2022-09-15T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1576,
    '2022-09-16',
    24,
    '2022-09-16T04:00:00.000Z',
    '2022-09-16T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1577,
    '2022-09-16',
    13,
    '2022-09-16T04:00:00.000Z',
    '2022-09-16T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1578,
    '2022-09-16',
    25,
    '2022-09-16T04:00:00.000Z',
    '2022-09-16T13:00:00.000Z',
    8.5,
    220,
    'המשך טייח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1579,
    '2022-09-16',
    31,
    '2022-09-16T04:00:00.000Z',
    '2022-09-16T13:00:00.000Z',
    8.5,
    310,
    'המשך טייח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1580,
    '2022-09-16',
    30,
    '2022-09-16T04:00:00.000Z',
    '2022-09-16T13:00:00.000Z',
    8.5,
    300,
    'המשך טייח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1581,
    '2022-09-17',
    26,
    '2022-09-17T04:00:00.000Z',
    '2022-09-17T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1582,
    '2022-09-17',
    13,
    '2022-09-17T04:00:00.000Z',
    '2022-09-17T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1583,
    '2022-09-17',
    24,
    '2022-09-17T04:00:00.000Z',
    '2022-09-17T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1584,
    '2022-09-17',
    31,
    '2022-09-17T04:00:00.000Z',
    '2022-09-17T13:00:00.000Z',
    8.5,
    310,
    'המשך טייח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1585,
    '2022-09-17',
    30,
    '2022-09-17T04:00:00.000Z',
    '2022-09-17T13:00:00.000Z',
    8.5,
    300,
    'המשך טייח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1586,
    '2022-09-17',
    25,
    '2022-09-17T04:00:00.000Z',
    '2022-09-17T13:00:00.000Z',
    8.5,
    220,
    'המשך טייח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1587,
    '2022-09-18',
    25,
    '2022-09-18T04:00:00.000Z',
    '2022-09-18T13:00:00.000Z',
    8.5,
    220,
    'המשך טייח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1588,
    '2022-09-18',
    31,
    '2022-09-18T04:00:00.000Z',
    '2022-09-18T13:00:00.000Z',
    8.5,
    310,
    'המשך טייח'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1589,
    '2022-09-18',
    13,
    '2022-09-18T04:00:00.000Z',
    '2022-09-18T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1590,
    '2022-09-18',
    30,
    '2022-09-18T04:00:00.000Z',
    '2022-09-18T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1591,
    '2022-09-18',
    26,
    '2022-09-18T04:00:00.000Z',
    '2022-09-18T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1592,
    '2022-09-18',
    24,
    '2022-09-18T04:00:00.000Z',
    '2022-09-18T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1593,
    '2022-09-19',
    13,
    '2022-09-19T04:00:00.000Z',
    '2022-09-19T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1594,
    '2022-09-19',
    24,
    '2022-09-19T04:00:00.000Z',
    '2022-09-19T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1595,
    '2022-09-19',
    26,
    '2022-09-19T04:00:00.000Z',
    '2022-09-19T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1596,
    '2022-09-19',
    30,
    '2022-09-19T04:00:00.000Z',
    '2022-09-19T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1597,
    '2022-09-19',
    25,
    '2022-09-19T04:00:00.000Z',
    '2022-09-19T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1598,
    '2022-09-19',
    31,
    '2022-09-19T04:00:00.000Z',
    '2022-09-19T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1599,
    '2022-09-20',
    24,
    '2022-09-20T04:00:00.000Z',
    '2022-09-20T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1600,
    '2022-09-20',
    26,
    '2022-09-20T04:00:00.000Z',
    '2022-09-20T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1601,
    '2022-09-20',
    13,
    '2022-09-20T04:00:00.000Z',
    '2022-09-20T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1602,
    '2022-09-20',
    30,
    '2022-09-20T04:00:00.000Z',
    '2022-09-20T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1603,
    '2022-09-21',
    31,
    '2022-09-21T04:00:00.000Z',
    '2022-09-21T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1604,
    '2022-09-21',
    24,
    '2022-09-21T04:00:00.000Z',
    '2022-09-21T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1605,
    '2022-09-21',
    25,
    '2022-09-21T04:00:00.000Z',
    '2022-09-21T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1606,
    '2022-09-21',
    30,
    '2022-09-21T04:00:00.000Z',
    '2022-09-21T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1607,
    '2022-09-21',
    26,
    '2022-09-21T04:00:00.000Z',
    '2022-09-21T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1608,
    '2022-09-21',
    13,
    '2022-09-21T04:00:00.000Z',
    '2022-09-21T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1609,
    '2022-09-22',
    13,
    '2022-09-22T04:00:00.000Z',
    '2022-09-22T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1610,
    '2022-09-22',
    26,
    '2022-09-22T04:00:00.000Z',
    '2022-09-22T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1611,
    '2022-09-22',
    24,
    '2022-09-22T04:00:00.000Z',
    '2022-09-22T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1612,
    '2022-09-22',
    31,
    '2022-09-22T04:00:00.000Z',
    '2022-09-22T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1613,
    '2022-09-22',
    30,
    '2022-09-22T04:00:00.000Z',
    '2022-09-22T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1614,
    '2022-09-22',
    25,
    '2022-09-22T04:00:00.000Z',
    '2022-09-22T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1615,
    '2022-09-23',
    13,
    '2022-09-23T04:00:00.000Z',
    '2022-09-23T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1616,
    '2022-09-23',
    26,
    '2022-09-23T04:00:00.000Z',
    '2022-09-23T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1617,
    '2022-09-23',
    30,
    '2022-09-23T04:00:00.000Z',
    '2022-09-23T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1618,
    '2022-09-23',
    25,
    '2022-09-23T04:00:00.000Z',
    '2022-09-23T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1619,
    '2022-09-23',
    24,
    '2022-09-23T04:00:00.000Z',
    '2022-09-23T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1620,
    '2022-09-23',
    31,
    '2022-09-23T04:00:00.000Z',
    '2022-09-23T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1621,
    '2022-09-25',
    13,
    '2022-09-25T04:00:00.000Z',
    '2022-09-25T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1622,
    '2022-09-25',
    26,
    '2022-09-25T04:00:00.000Z',
    '2022-09-25T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1623,
    '2022-09-25',
    24,
    '2022-09-25T04:00:00.000Z',
    '2022-09-25T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1624,
    '2022-09-25',
    31,
    '2022-09-25T04:00:00.000Z',
    '2022-09-25T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1625,
    '2022-09-25',
    25,
    '2022-09-25T04:00:00.000Z',
    '2022-09-25T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1626,
    '2022-09-25',
    30,
    '2022-09-25T04:00:00.000Z',
    '2022-09-25T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1627,
    '2022-09-26',
    30,
    '2022-09-26T04:00:00.000Z',
    '2022-09-26T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1628,
    '2022-09-26',
    25,
    '2022-09-26T04:00:00.000Z',
    '2022-09-26T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1629,
    '2022-09-26',
    24,
    '2022-09-26T04:00:00.000Z',
    '2022-09-26T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1630,
    '2022-09-26',
    31,
    '2022-09-26T04:00:00.000Z',
    '2022-09-26T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1631,
    '2022-09-26',
    13,
    '2022-09-26T04:00:00.000Z',
    '2022-09-26T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1632,
    '2022-09-26',
    26,
    '2022-09-26T04:00:00.000Z',
    '2022-09-26T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1633,
    '2022-09-01',
    20,
    '2022-09-01T04:00:00.000Z',
    '2022-09-01T13:00:00.000Z',
    8.5,
    2500,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1636,
    '2022-09-27',
    24,
    '2022-09-27T04:00:00.000Z',
    '2022-09-27T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1637,
    '2022-09-27',
    31,
    '2022-09-27T04:00:00.000Z',
    '2022-09-27T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1638,
    '2022-09-27',
    13,
    '2022-09-27T04:00:00.000Z',
    '2022-09-27T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1639,
    '2022-09-27',
    26,
    '2022-09-27T04:00:00.000Z',
    '2022-09-27T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1640,
    '2022-09-27',
    25,
    '2022-09-27T04:00:00.000Z',
    '2022-09-27T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1641,
    '2022-09-27',
    30,
    '2022-09-27T04:00:00.000Z',
    '2022-09-27T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1642,
    '2022-09-28',
    24,
    '2022-09-28T04:00:00.000Z',
    '2022-09-28T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1643,
    '2022-09-28',
    31,
    '2022-09-28T04:00:00.000Z',
    '2022-09-28T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1644,
    '2022-09-28',
    25,
    '2022-09-28T04:00:00.000Z',
    '2022-09-28T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1645,
    '2022-09-28',
    30,
    '2022-09-28T04:00:00.000Z',
    '2022-09-28T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1646,
    '2022-09-28',
    13,
    '2022-09-28T04:00:00.000Z',
    '2022-09-28T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1647,
    '2022-09-28',
    26,
    '2022-09-28T04:00:00.000Z',
    '2022-09-28T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1648,
    '2022-09-29',
    31,
    '2022-09-29T04:00:00.000Z',
    '2022-09-29T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1649,
    '2022-09-29',
    30,
    '2022-09-29T04:00:00.000Z',
    '2022-09-29T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1650,
    '2022-09-29',
    25,
    '2022-09-29T04:00:00.000Z',
    '2022-09-29T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1651,
    '2022-09-29',
    24,
    '2022-09-29T04:00:00.000Z',
    '2022-09-29T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1652,
    '2022-09-29',
    26,
    '2022-09-29T04:00:00.000Z',
    '2022-09-29T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1653,
    '2022-09-29',
    13,
    '2022-09-29T04:00:00.000Z',
    '2022-09-29T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1654,
    '2022-09-30',
    31,
    '2022-09-30T04:00:00.000Z',
    '2022-09-30T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1655,
    '2022-09-30',
    24,
    '2022-09-30T04:00:00.000Z',
    '2022-09-30T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1656,
    '2022-09-30',
    26,
    '2022-09-30T04:00:00.000Z',
    '2022-09-30T13:00:00.000Z',
    8.5,
    310,
    'קוו ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1657,
    '2022-09-30',
    13,
    '2022-09-30T04:00:00.000Z',
    '2022-09-30T13:00:00.000Z',
    8.5,
    450,
    'קוו ביוב'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1658,
    '2022-09-30',
    25,
    '2022-09-30T04:00:00.000Z',
    '2022-09-30T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1659,
    '2022-09-30',
    30,
    '2022-09-30T04:00:00.000Z',
    '2022-09-30T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1660,
    '2022-10-02',
    31,
    '2022-10-02T04:00:00.000Z',
    '2022-10-02T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1661,
    '2022-10-02',
    24,
    '2022-10-02T04:00:00.000Z',
    '2022-10-02T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1662,
    '2022-10-02',
    25,
    '2022-10-02T04:00:00.000Z',
    '2022-10-02T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1663,
    '2022-10-02',
    30,
    '2022-10-02T04:00:00.000Z',
    '2022-10-02T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1664,
    '2022-10-02',
    26,
    '2022-10-02T04:00:00.000Z',
    '2022-10-02T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1665,
    '2022-10-02',
    13,
    '2022-10-02T04:00:00.000Z',
    '2022-10-02T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1666,
    '2022-10-03',
    24,
    '2022-10-03T04:00:00.000Z',
    '2022-10-03T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1667,
    '2022-10-03',
    31,
    '2022-10-03T04:00:00.000Z',
    '2022-10-03T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1668,
    '2022-10-03',
    25,
    '2022-10-03T04:00:00.000Z',
    '2022-10-03T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1669,
    '2022-10-03',
    26,
    '2022-10-03T04:00:00.000Z',
    '2022-10-03T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1670,
    '2022-10-03',
    30,
    '2022-10-03T04:00:00.000Z',
    '2022-10-03T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1671,
    '2022-10-03',
    13,
    '2022-10-03T04:00:00.000Z',
    '2022-10-03T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1672,
    '2022-10-04',
    30,
    '2022-10-04T04:00:00.000Z',
    '2022-10-04T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1673,
    '2022-10-04',
    24,
    '2022-10-04T04:00:00.000Z',
    '2022-10-04T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1674,
    '2022-10-04',
    31,
    '2022-10-04T04:00:00.000Z',
    '2022-10-04T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1675,
    '2022-10-04',
    13,
    '2022-10-04T04:00:00.000Z',
    '2022-10-04T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1676,
    '2022-10-04',
    26,
    '2022-10-04T04:00:00.000Z',
    '2022-10-04T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1677,
    '2022-10-04',
    25,
    '2022-10-04T04:00:00.000Z',
    '2022-10-04T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1678,
    '2022-10-05',
    24,
    '2022-10-05T04:00:00.000Z',
    '2022-10-05T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1679,
    '2022-10-05',
    31,
    '2022-10-05T04:00:00.000Z',
    '2022-10-05T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1680,
    '2022-10-05',
    25,
    '2022-10-05T04:00:00.000Z',
    '2022-10-05T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1681,
    '2022-10-05',
    30,
    '2022-10-05T04:00:00.000Z',
    '2022-10-05T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1682,
    '2022-10-05',
    26,
    '2022-10-05T04:00:00.000Z',
    '2022-10-05T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1683,
    '2022-10-05',
    13,
    '2022-10-05T04:00:00.000Z',
    '2022-10-05T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1684,
    '2022-10-06',
    26,
    '2022-10-06T04:00:00.000Z',
    '2022-10-06T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1685,
    '2022-10-06',
    13,
    '2022-10-06T04:00:00.000Z',
    '2022-10-06T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1686,
    '2022-10-06',
    30,
    '2022-10-06T04:00:00.000Z',
    '2022-10-06T12:00:00.000Z',
    7.5,
    265,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1687,
    '2022-10-06',
    25,
    '2022-10-06T04:00:00.000Z',
    '2022-10-06T12:00:00.000Z',
    7.5,
    194,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1688,
    '2022-10-06',
    31,
    '2022-10-06T04:00:00.000Z',
    '2022-10-06T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1689,
    '2022-10-06',
    24,
    '2022-10-06T04:00:00.000Z',
    '2022-10-06T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1690,
    '2022-10-07',
    24,
    '2022-10-07T07:00:00.000Z',
    '2022-10-07T12:00:00.000Z',
    4.5,
    175,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1691,
    '2022-10-07',
    31,
    '2022-10-07T07:00:00.000Z',
    '2022-10-07T12:00:00.000Z',
    4.5,
    164,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1692,
    '2022-10-09',
    30,
    '2022-10-09T04:00:00.000Z',
    '2022-10-09T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1693,
    '2022-10-09',
    25,
    '2022-10-09T04:00:00.000Z',
    '2022-10-09T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1694,
    '2022-10-09',
    31,
    '2022-10-09T04:00:00.000Z',
    '2022-10-09T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1695,
    '2022-10-09',
    24,
    '2022-10-09T04:00:00.000Z',
    '2022-10-09T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1696,
    '2022-10-09',
    13,
    '2022-10-09T04:00:00.000Z',
    '2022-10-09T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1697,
    '2022-10-09',
    26,
    '2022-10-09T04:00:00.000Z',
    '2022-10-09T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1698,
    '2022-10-10',
    31,
    '2022-10-10T04:00:00.000Z',
    '2022-10-10T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1699,
    '2022-10-10',
    24,
    '2022-10-10T04:00:00.000Z',
    '2022-10-10T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1700,
    '2022-10-10',
    25,
    '2022-10-10T04:00:00.000Z',
    '2022-10-10T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1701,
    '2022-10-10',
    30,
    '2022-10-10T04:00:00.000Z',
    '2022-10-10T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1702,
    '2022-10-10',
    13,
    '2022-10-10T04:00:00.000Z',
    '2022-10-10T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1703,
    '2022-10-10',
    26,
    '2022-10-10T04:00:00.000Z',
    '2022-10-10T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1704,
    '2022-10-11',
    24,
    '2022-10-11T04:00:00.000Z',
    '2022-10-11T13:00:00.000Z',
    8.5,
    330,
    'מתזים מוניר וסוקראט'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1705,
    '2022-10-11',
    30,
    '2022-10-11T04:00:00.000Z',
    '2022-10-11T13:00:00.000Z',
    8.5,
    300,
    'מתזים מוניר וסוקראט'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1706,
    '2022-10-11',
    31,
    '2022-10-11T04:00:00.000Z',
    '2022-10-11T13:00:00.000Z',
    8.5,
    310,
    'התאמת שוחאת'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1707,
    '2022-10-11',
    26,
    '2022-10-11T04:00:00.000Z',
    '2022-10-11T13:00:00.000Z',
    8.5,
    310,
    'התאמת שוחאת'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1708,
    '2022-10-11',
    25,
    '2022-10-11T04:00:00.000Z',
    '2022-10-11T13:00:00.000Z',
    8.5,
    220,
    'התאמת שוחאת'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1709,
    '2022-10-11',
    13,
    '2022-10-11T04:00:00.000Z',
    '2022-10-11T13:00:00.000Z',
    8.5,
    450,
    'התאמת שוחאת'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1710,
    '2022-10-12',
    31,
    '2022-10-12T04:00:00.000Z',
    '2022-10-12T13:00:00.000Z',
    8.5,
    310,
    'קיבוע מתזים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1711,
    '2022-10-12',
    24,
    '2022-10-12T04:00:00.000Z',
    '2022-10-12T13:00:00.000Z',
    8.5,
    330,
    'קיבוע מתזים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1712,
    '2022-10-12',
    26,
    '2022-10-12T04:00:00.000Z',
    '2022-10-12T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1713,
    '2022-10-12',
    25,
    '2022-10-12T04:00:00.000Z',
    '2022-10-12T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1714,
    '2022-10-12',
    30,
    '2022-10-12T04:00:00.000Z',
    '2022-10-12T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1715,
    '2022-10-12',
    13,
    '2022-10-12T04:00:00.000Z',
    '2022-10-12T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1716,
    '2022-10-13',
    31,
    '2022-10-13T04:00:00.000Z',
    '2022-10-13T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1717,
    '2022-10-13',
    24,
    '2022-10-13T04:00:00.000Z',
    '2022-10-13T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1718,
    '2022-10-13',
    13,
    '2022-10-13T04:00:00.000Z',
    '2022-10-13T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1719,
    '2022-10-13',
    26,
    '2022-10-13T04:00:00.000Z',
    '2022-10-13T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1720,
    '2022-10-13',
    30,
    '2022-10-13T04:00:00.000Z',
    '2022-10-13T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1721,
    '2022-10-13',
    25,
    '2022-10-13T04:00:00.000Z',
    '2022-10-13T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1722,
    '2022-10-14',
    13,
    '2022-10-14T04:00:00.000Z',
    '2022-10-14T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1723,
    '2022-10-14',
    26,
    '2022-10-14T04:00:00.000Z',
    '2022-10-14T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1724,
    '2022-10-14',
    25,
    '2022-10-14T04:00:00.000Z',
    '2022-10-14T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1725,
    '2022-10-14',
    30,
    '2022-10-14T04:00:00.000Z',
    '2022-10-14T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1726,
    '2022-10-14',
    24,
    '2022-10-14T04:00:00.000Z',
    '2022-10-14T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1727,
    '2022-10-14',
    31,
    '2022-10-14T04:00:00.000Z',
    '2022-10-14T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1728,
    '2022-10-16',
    30,
    '2022-10-16T04:00:00.000Z',
    '2022-10-16T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1729,
    '2022-10-16',
    13,
    '2022-10-16T04:00:00.000Z',
    '2022-10-16T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1730,
    '2022-10-16',
    31,
    '2022-10-16T04:00:00.000Z',
    '2022-10-16T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1731,
    '2022-10-16',
    24,
    '2022-10-16T04:00:00.000Z',
    '2022-10-16T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1732,
    '2022-10-16',
    26,
    '2022-10-16T04:00:00.000Z',
    '2022-10-16T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1733,
    '2022-10-16',
    25,
    '2022-10-16T04:00:00.000Z',
    '2022-10-16T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1734,
    '2022-10-17',
    13,
    '2022-10-17T04:00:00.000Z',
    '2022-10-17T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1735,
    '2022-10-17',
    26,
    '2022-10-17T04:00:00.000Z',
    '2022-10-17T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1736,
    '2022-10-17',
    24,
    '2022-10-17T04:00:00.000Z',
    '2022-10-17T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1737,
    '2022-10-17',
    31,
    '2022-10-17T04:00:00.000Z',
    '2022-10-17T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1738,
    '2022-10-17',
    25,
    '2022-10-17T04:00:00.000Z',
    '2022-10-17T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1739,
    '2022-10-17',
    30,
    '2022-10-17T04:00:00.000Z',
    '2022-10-17T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1740,
    '2022-10-18',
    30,
    '2022-10-18T04:00:00.000Z',
    '2022-10-18T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1741,
    '2022-10-18',
    13,
    '2022-10-18T04:00:00.000Z',
    '2022-10-18T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1742,
    '2022-10-18',
    26,
    '2022-10-18T04:00:00.000Z',
    '2022-10-18T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1743,
    '2022-10-18',
    31,
    '2022-10-18T04:00:00.000Z',
    '2022-10-18T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1744,
    '2022-10-18',
    24,
    '2022-10-18T04:00:00.000Z',
    '2022-10-18T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1745,
    '2022-10-18',
    25,
    '2022-10-18T04:00:00.000Z',
    '2022-10-18T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1746,
    '2022-10-19',
    25,
    '2022-10-19T04:00:00.000Z',
    '2022-10-19T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1747,
    '2022-10-19',
    30,
    '2022-10-19T04:00:00.000Z',
    '2022-10-19T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1748,
    '2022-10-19',
    31,
    '2022-10-19T04:00:00.000Z',
    '2022-10-19T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1749,
    '2022-10-19',
    13,
    '2022-10-19T04:00:00.000Z',
    '2022-10-19T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1750,
    '2022-10-19',
    24,
    '2022-10-19T04:00:00.000Z',
    '2022-10-19T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1751,
    '2022-10-19',
    26,
    '2022-10-19T04:00:00.000Z',
    '2022-10-19T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1752,
    '2022-10-20',
    24,
    '2022-10-20T04:00:00.000Z',
    '2022-10-20T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1753,
    '2022-10-20',
    31,
    '2022-10-20T04:00:00.000Z',
    '2022-10-20T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1754,
    '2022-10-20',
    13,
    '2022-10-20T04:00:00.000Z',
    '2022-10-20T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1755,
    '2022-10-20',
    25,
    '2022-10-20T04:00:00.000Z',
    '2022-10-20T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1756,
    '2022-10-20',
    30,
    '2022-10-20T04:00:00.000Z',
    '2022-10-20T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1757,
    '2022-10-20',
    26,
    '2022-10-20T04:00:00.000Z',
    '2022-10-20T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1758,
    '2022-10-21',
    31,
    '2022-10-21T04:00:00.000Z',
    '2022-10-21T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1759,
    '2022-10-21',
    24,
    '2022-10-21T04:00:00.000Z',
    '2022-10-21T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1760,
    '2022-10-21',
    25,
    '2022-10-21T04:00:00.000Z',
    '2022-10-21T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1761,
    '2022-10-21',
    26,
    '2022-10-21T04:00:00.000Z',
    '2022-10-21T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1762,
    '2022-10-21',
    30,
    '2022-10-21T04:00:00.000Z',
    '2022-10-21T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1763,
    '2022-10-21',
    13,
    '2022-10-21T04:00:00.000Z',
    '2022-10-21T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1764,
    '2022-10-23',
    25,
    '2022-10-23T04:00:00.000Z',
    '2022-10-23T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1765,
    '2022-10-23',
    26,
    '2022-10-23T04:00:00.000Z',
    '2022-10-23T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1766,
    '2022-10-23',
    13,
    '2022-10-23T04:00:00.000Z',
    '2022-10-23T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1767,
    '2022-10-23',
    31,
    '2022-10-23T04:00:00.000Z',
    '2022-10-23T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1768,
    '2022-10-23',
    30,
    '2022-10-23T04:00:00.000Z',
    '2022-10-23T13:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1769,
    '2022-10-23',
    24,
    '2022-10-23T04:00:00.000Z',
    '2022-10-23T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1770,
    '2022-10-24',
    25,
    '2022-10-24T04:00:00.000Z',
    '2022-10-24T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1771,
    '2022-10-24',
    26,
    '2022-10-24T04:00:00.000Z',
    '2022-10-24T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1772,
    '2022-10-24',
    13,
    '2022-10-24T04:00:00.000Z',
    '2022-10-24T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1773,
    '2022-10-24',
    31,
    '2022-10-24T04:00:00.000Z',
    '2022-10-24T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1774,
    '2022-10-24',
    24,
    '2022-10-24T04:00:00.000Z',
    '2022-10-24T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1775,
    '2022-10-24',
    38,
    '2022-10-24T04:00:00.000Z',
    '2022-10-24T13:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1776,
    '2022-10-25',
    26,
    '2022-10-25T04:00:00.000Z',
    '2022-10-25T13:00:00.000Z',
    8.5,
    310,
    'מערכת מיים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1777,
    '2022-10-25',
    13,
    '2022-10-25T04:00:00.000Z',
    '2022-10-25T13:00:00.000Z',
    8.5,
    450,
    'מערכת מיים'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1778,
    '2022-10-25',
    25,
    '2022-10-25T04:00:00.000Z',
    '2022-10-25T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1779,
    '2022-10-25',
    31,
    '2022-10-25T04:00:00.000Z',
    '2022-10-25T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1780,
    '2022-10-25',
    24,
    '2022-10-25T04:00:00.000Z',
    '2022-10-25T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1781,
    '2022-10-25',
    38,
    '2022-10-25T04:00:00.000Z',
    '2022-10-25T13:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1782,
    '2022-10-26',
    13,
    '2022-10-26T04:00:00.000Z',
    '2022-10-26T16:00:00.000Z',
    11.5,
    609,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1783,
    '2022-10-26',
    38,
    '2022-10-26T04:00:00.000Z',
    '2022-10-26T16:00:00.000Z',
    11.5,
    338,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1784,
    '2022-10-26',
    24,
    '2022-10-26T04:00:00.000Z',
    '2022-10-26T16:00:00.000Z',
    11.5,
    446,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1785,
    '2022-10-26',
    31,
    '2022-10-26T04:00:00.000Z',
    '2022-10-26T16:00:00.000Z',
    11.5,
    419,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1786,
    '2022-10-26',
    26,
    '2022-10-26T04:00:00.000Z',
    '2022-10-26T16:00:00.000Z',
    11.5,
    419,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1787,
    '2022-10-26',
    25,
    '2022-10-26T04:00:00.000Z',
    '2022-10-26T16:00:00.000Z',
    11.5,
    298,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1788,
    '2022-10-27',
    26,
    '2022-10-27T04:00:00.000Z',
    '2022-10-27T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1789,
    '2022-10-27',
    24,
    '2022-10-27T04:00:00.000Z',
    '2022-10-27T13:00:00.000Z',
    8.5,
    330,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1790,
    '2022-10-27',
    38,
    '2022-10-27T04:00:00.000Z',
    '2022-10-27T13:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1791,
    '2022-10-27',
    25,
    '2022-10-27T04:00:00.000Z',
    '2022-10-27T13:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1792,
    '2022-10-27',
    31,
    '2022-10-27T04:00:00.000Z',
    '2022-10-27T13:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1793,
    '2022-10-27',
    13,
    '2022-10-27T04:00:00.000Z',
    '2022-10-27T13:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1794,
    '2022-10-30',
    13,
    '2022-10-30T05:00:00.000Z',
    '2022-10-30T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1795,
    '2022-10-30',
    38,
    '2022-10-30T05:00:00.000Z',
    '2022-10-30T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1796,
    '2022-10-30',
    21,
    '2022-10-30T05:00:00.000Z',
    '2022-10-30T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1797,
    '2022-10-31',
    13,
    '2022-10-31T05:00:00.000Z',
    '2022-10-31T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1798,
    '2022-10-31',
    38,
    '2022-10-31T05:00:00.000Z',
    '2022-10-31T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1799,
    '2022-10-31',
    21,
    '2022-10-31T05:00:00.000Z',
    '2022-10-31T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1800,
    '2022-11-01',
    38,
    '2022-11-01T05:00:00.000Z',
    '2022-11-01T13:00:00.000Z',
    7.5,
    221,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1801,
    '2022-11-01',
    13,
    '2022-11-01T05:00:00.000Z',
    '2022-11-01T13:00:00.000Z',
    7.5,
    397,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1802,
    '2022-11-02',
    21,
    '2022-11-02T05:00:00.000Z',
    '2022-11-02T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1803,
    '2022-11-02',
    38,
    '2022-11-02T05:00:00.000Z',
    '2022-11-02T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1804,
    '2022-11-02',
    13,
    '2022-11-02T05:00:00.000Z',
    '2022-11-02T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1805,
    '2022-11-03',
    38,
    '2022-11-03T05:00:00.000Z',
    '2022-11-03T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1806,
    '2022-11-03',
    13,
    '2022-11-03T05:00:00.000Z',
    '2022-11-03T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1807,
    '2022-11-04',
    13,
    '2022-11-04T05:00:00.000Z',
    '2022-11-04T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1808,
    '2022-11-04',
    38,
    '2022-11-04T05:00:00.000Z',
    '2022-11-04T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1809,
    '2022-11-06',
    38,
    '2022-11-06T05:00:00.000Z',
    '2022-11-06T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1810,
    '2022-11-06',
    21,
    '2022-11-06T05:00:00.000Z',
    '2022-11-06T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1811,
    '2022-11-06',
    13,
    '2022-11-06T05:00:00.000Z',
    '2022-11-06T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1812,
    '2022-11-07',
    38,
    '2022-11-07T05:00:00.000Z',
    '2022-11-07T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1813,
    '2022-11-07',
    13,
    '2022-11-07T05:00:00.000Z',
    '2022-11-07T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1814,
    '2022-11-08',
    38,
    '2022-11-08T05:00:00.000Z',
    '2022-11-08T09:00:00.000Z',
    4,
    118,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1815,
    '2022-11-08',
    13,
    '2022-11-08T05:00:00.000Z',
    '2022-11-08T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1816,
    '2022-11-09',
    26,
    '2022-11-09T05:00:00.000Z',
    '2022-11-09T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1817,
    '2022-11-09',
    13,
    '2022-11-09T05:00:00.000Z',
    '2022-11-09T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1818,
    '2022-11-09',
    31,
    '2022-11-09T05:00:00.000Z',
    '2022-11-09T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1819,
    '2022-11-09',
    38,
    '2022-11-09T05:00:00.000Z',
    '2022-11-09T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1820,
    '2022-11-09',
    24,
    '2022-11-09T05:00:00.000Z',
    '2022-11-09T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1821,
    '2022-11-09',
    25,
    '2022-11-09T05:00:00.000Z',
    '2022-11-09T14:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1822,
    '2022-11-09',
    39,
    '2022-11-09T05:00:00.000Z',
    '2022-11-09T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1823,
    '2022-11-10',
    39,
    '2022-11-10T05:00:00.000Z',
    '2022-11-10T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1824,
    '2022-11-10',
    24,
    '2022-11-10T05:00:00.000Z',
    '2022-11-10T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1825,
    '2022-11-10',
    26,
    '2022-11-10T05:00:00.000Z',
    '2022-11-10T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1826,
    '2022-11-10',
    38,
    '2022-11-10T05:00:00.000Z',
    '2022-11-10T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1827,
    '2022-11-10',
    31,
    '2022-11-10T05:00:00.000Z',
    '2022-11-10T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1828,
    '2022-11-10',
    13,
    '2022-11-10T05:00:00.000Z',
    '2022-11-10T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1829,
    '2022-11-10',
    25,
    '2022-11-10T05:00:00.000Z',
    '2022-11-10T14:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1830,
    '2022-11-11',
    38,
    '2022-11-11T05:00:00.000Z',
    '2022-11-11T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1831,
    '2022-11-11',
    13,
    '2022-11-11T05:00:00.000Z',
    '2022-11-11T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1832,
    '2022-11-11',
    26,
    '2022-11-11T05:00:00.000Z',
    '2022-11-11T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1833,
    '2022-11-11',
    24,
    '2022-11-11T05:00:00.000Z',
    '2022-11-11T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1834,
    '2022-11-11',
    39,
    '2022-11-11T05:00:00.000Z',
    '2022-11-11T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1835,
    '2022-11-11',
    31,
    '2022-11-11T05:00:00.000Z',
    '2022-11-11T09:00:00.000Z',
    4,
    141,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1836,
    '2022-11-11',
    25,
    '2022-11-11T05:00:00.000Z',
    '2022-11-11T09:00:00.000Z',
    4,
    104,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1906,
    '2022-11-13',
    39,
    '2022-11-13T05:00:00.000Z',
    '2022-11-13T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1907,
    '2022-11-13',
    24,
    '2022-11-13T05:00:00.000Z',
    '2022-11-13T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1908,
    '2022-11-13',
    31,
    '2022-11-13T05:00:00.000Z',
    '2022-11-13T15:00:00+02:00',
    7.5,
    265,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1909,
    '2022-11-13',
    38,
    '2022-11-13T05:00:00.000Z',
    '2022-11-13T15:00:00+02:00',
    7.5,
    221,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1910,
    '2022-11-13',
    26,
    '2022-11-13T05:00:00.000Z',
    '2022-11-13T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1911,
    '2022-11-13',
    21,
    '2022-11-13T05:00:00.000Z',
    '2022-11-13T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1912,
    '2022-11-13',
    25,
    '2022-11-13T05:00:00.000Z',
    '2022-11-13T12:00:00+02:00',
    4.5,
    116,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1913,
    '2022-11-13',
    13,
    '2022-11-13T05:00:00.000Z',
    '2022-11-13T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1914,
    '2022-11-14',
    26,
    '2022-11-14T05:00:00.000Z',
    '2022-11-14T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1915,
    '2022-11-14',
    24,
    '2022-11-14T05:00:00.000Z',
    '2022-11-14T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1916,
    '2022-11-14',
    25,
    '2022-11-14T05:00:00.000Z',
    '2022-11-14T14:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1917,
    '2022-11-14',
    39,
    '2022-11-14T05:00:00.000Z',
    '2022-11-14T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1918,
    '2022-11-14',
    31,
    '2022-11-14T05:00:00.000Z',
    '2022-11-14T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1919,
    '2022-11-14',
    38,
    '2022-11-14T05:00:00.000Z',
    '2022-11-14T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1920,
    '2022-11-14',
    21,
    '2022-11-14T05:00:00.000Z',
    '2022-11-14T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1921,
    '2022-11-14',
    13,
    '2022-11-14T05:00:00.000Z',
    '2022-11-14T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1922,
    '2022-11-15',
    26,
    '2023-01-20T05:00:00.025Z',
    '2023-01-20T14:00:00.025Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1923,
    '2022-11-15',
    24,
    '2023-01-20T05:00:00.025Z',
    '2023-01-20T14:00:00.025Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1924,
    '2022-11-15',
    39,
    '2023-01-20T05:00:00.780Z',
    '2023-01-20T15:00:00+02:00',
    7.5,
    247,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1925,
    '2022-11-15',
    25,
    '2023-01-20T05:00:00.780Z',
    '2023-01-20T15:00:00+02:00',
    7.5,
    194,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1926,
    '2022-11-15',
    13,
    '2023-01-20T05:00:00.327Z',
    '2023-01-20T14:00:00.327Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1927,
    '2022-11-15',
    31,
    '2023-01-20T05:00:00.327Z',
    '2023-01-20T15:00:00+02:00',
    7.5,
    265,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1928,
    '2022-11-15',
    38,
    '2023-01-20T05:00:00.327Z',
    '2023-01-20T15:00:00+02:00',
    7.5,
    221,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1931,
    '2022-11-16',
    24,
    '2022-11-16T05:00:00.000Z',
    '2022-11-16T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1932,
    '2022-11-16',
    26,
    '2022-11-16T05:00:00.000Z',
    '2022-11-16T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1933,
    '2022-11-16',
    13,
    '2023-01-22T05:00:00.210Z',
    '2023-01-22T14:00:00.210Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1934,
    '2022-11-16',
    31,
    '2023-01-22T05:00:00.210Z',
    '2023-01-22T14:00:00.210Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1935,
    '2022-11-16',
    38,
    '2023-01-22T05:00:00.210Z',
    '2023-01-22T14:00:00.210Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1936,
    '2022-11-16',
    21,
    '2023-01-22T05:00:00.931Z',
    '2023-01-22T14:00:00.932Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1937,
    '2022-11-16',
    39,
    '2023-01-22T05:00:00.931Z',
    '2023-01-22T14:00:00.932Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1938,
    '2022-11-16',
    25,
    '2023-01-22T05:00:00.931Z',
    '2023-01-22T14:00:00.932Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1939,
    '2022-11-17',
    21,
    '2022-11-17T05:00:00.000Z',
    '2022-11-17T14:00:00.000Z',
    8.5,
    400,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1940,
    '2022-11-17',
    38,
    '2022-11-17T05:00:00.000Z',
    '2022-11-17T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1941,
    '2022-11-17',
    24,
    '2023-01-22T05:00:00.438Z',
    '2023-01-22T14:00:00.438Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1942,
    '2022-11-17',
    31,
    '2023-01-22T05:00:00.438Z',
    '2023-01-22T14:00:00.438Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1943,
    '2022-11-17',
    39,
    '2023-01-22T05:00:00.915Z',
    '2023-01-22T14:00:00.915Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1944,
    '2022-11-17',
    25,
    '2023-01-22T05:00:00.915Z',
    '2023-01-22T14:00:00.915Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1945,
    '2022-11-17',
    26,
    '2023-01-22T05:00:00.915Z',
    '2023-01-22T14:00:00.915Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1946,
    '2022-11-18',
    31,
    '2022-11-18T05:00:00.000Z',
    '2022-11-18T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1947,
    '2022-11-18',
    24,
    '2022-11-18T05:00:00.000Z',
    '2022-11-18T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1948,
    '2022-11-18',
    39,
    '2023-01-22T05:00:00.145Z',
    '2023-01-22T14:00:00.145Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1949,
    '2022-11-18',
    13,
    '2023-01-22T05:00:00.145Z',
    '2023-01-22T14:00:00.145Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1950,
    '2022-11-18',
    26,
    '2023-01-22T05:00:00.145Z',
    '2023-01-22T14:00:00.145Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1951,
    '2022-11-20',
    13,
    '2022-11-20T05:00:00.000Z',
    '2022-11-20T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1952,
    '2022-11-20',
    31,
    '2022-11-20T05:00:00.000Z',
    '2022-11-20T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1953,
    '2022-11-20',
    26,
    '2022-11-20T05:00:00.000Z',
    '2022-11-20T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1954,
    '2022-11-20',
    38,
    '2022-11-20T05:00:00.000Z',
    '2022-11-20T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1955,
    '2022-11-20',
    25,
    '2022-11-20T05:00:00.000Z',
    '2022-11-20T14:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1956,
    '2022-11-20',
    24,
    '2022-11-20T05:00:00.000Z',
    '2022-11-20T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1957,
    '2022-11-20',
    39,
    '2022-11-20T05:00:00.000Z',
    '2022-11-20T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1958,
    '2022-11-21',
    13,
    '2022-11-21T05:00:00.000Z',
    '2022-11-21T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1959,
    '2022-11-21',
    31,
    '2022-11-21T05:00:00.000Z',
    '2022-11-21T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1960,
    '2022-11-21',
    39,
    '2022-11-21T05:00:00.000Z',
    '2022-11-21T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1961,
    '2022-11-21',
    25,
    '2023-01-22T05:00:00.961Z',
    '2023-01-22T14:00:00.961Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1962,
    '2022-11-21',
    24,
    '2023-01-22T05:00:00.961Z',
    '2023-01-22T14:00:00.961Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1963,
    '2022-11-21',
    38,
    '2023-01-22T05:00:00.961Z',
    '2023-01-22T14:00:00.961Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1964,
    '2022-11-22',
    38,
    '2022-11-22T05:00:00.000Z',
    '2022-11-22T14:00:00.000Z',
    8.5,
    250,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1965,
    '2022-11-22',
    25,
    '2022-11-22T05:00:00.000Z',
    '2022-11-22T14:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1966,
    '2022-11-22',
    31,
    '2022-11-22T05:00:00.000Z',
    '2022-11-22T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1967,
    '2022-11-22',
    13,
    '2022-11-22T05:00:00.000Z',
    '2022-11-22T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1968,
    '2022-11-22',
    39,
    '2022-11-22T05:00:00.000Z',
    '2022-11-22T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1969,
    '2022-11-23',
    39,
    '2022-11-23T05:00:00.000Z',
    '2022-11-23T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1970,
    '2022-11-23',
    24,
    '2022-11-23T05:00:00.000Z',
    '2022-11-23T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1971,
    '2022-11-23',
    13,
    '2023-01-22T05:00:00.425Z',
    '2023-01-22T14:00:00.425Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1972,
    '2022-11-23',
    31,
    '2023-01-22T05:00:00.425Z',
    '2023-01-22T14:00:00.425Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1973,
    '2022-11-23',
    38,
    '2023-01-22T05:00:00.257Z',
    '2023-01-22T14:00:00.257Z',
    8.5,
    250,
    'אצל ויאם בוילה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1974,
    '2022-11-23',
    26,
    '2023-01-22T05:00:00.980Z',
    '2023-01-22T14:00:00.981Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1975,
    '2022-11-23',
    25,
    '2023-01-22T05:00:00.980Z',
    '2023-01-22T14:00:00.981Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1976,
    '2022-11-24',
    13,
    '2022-11-24T05:00:00.000Z',
    '2022-11-24T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1977,
    '2022-11-25',
    13,
    '2022-11-25T05:00:00.000Z',
    '2022-11-25T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1978,
    '2022-11-27',
    13,
    '2022-11-27T05:00:00.000Z',
    '2022-11-27T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1979,
    '2022-11-28',
    13,
    '2022-11-28T05:00:00.000Z',
    '2022-11-28T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1980,
    '2022-11-29',
    13,
    '2022-11-29T05:00:00.000Z',
    '2022-11-29T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1981,
    '2022-11-30',
    13,
    '2022-11-30T05:00:00.000Z',
    '2022-11-30T13:00:00+02:00',
    5.5,
    291,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1982,
    '2022-12-01',
    13,
    '2022-12-01T05:00:00.000Z',
    '2022-12-01T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1983,
    '2022-12-02',
    13,
    '2022-12-02T05:00:00.000Z',
    '2022-12-02T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1984,
    '2022-12-04',
    13,
    '2022-12-04T05:00:00.000Z',
    '2022-12-04T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1985,
    '2022-12-05',
    26,
    '2022-12-05T05:00:00.000Z',
    '2022-12-05T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1986,
    '2022-12-05',
    24,
    '2022-12-05T05:00:00.000Z',
    '2022-12-05T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1987,
    '2022-12-05',
    13,
    '2022-12-05T05:00:00.000Z',
    '2022-12-05T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1988,
    '2022-12-05',
    39,
    '2022-12-05T05:00:00.000Z',
    '2022-12-05T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1989,
    '2022-12-05',
    25,
    '2022-12-05T05:00:00.000Z',
    '2022-12-05T14:00:00.000Z',
    8.5,
    220,
    'אצל ויאם בוילה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1990,
    '2022-12-06',
    26,
    '2022-12-06T05:00:00.000Z',
    '2022-12-06T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1991,
    '2022-12-06',
    39,
    '2022-12-06T05:00:00.000Z',
    '2022-12-06T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1992,
    '2022-12-06',
    24,
    '2022-12-06T05:00:00.000Z',
    '2022-12-06T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1993,
    '2022-12-06',
    13,
    '2022-12-06T05:00:00.000Z',
    '2022-12-06T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1994,
    '2022-12-06',
    25,
    '2023-01-22T05:00:00.694Z',
    '2023-01-22T14:00:00.694Z',
    8.5,
    220,
    'אצל ויאם בוילה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1995,
    '2022-12-07',
    13,
    '2022-12-07T05:00:00.000Z',
    '2022-12-07T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1996,
    '2022-12-07',
    26,
    '2022-12-07T05:00:00.000Z',
    '2022-12-07T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1997,
    '2022-12-07',
    24,
    '2022-12-07T05:00:00.000Z',
    '2022-12-07T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1998,
    '2022-12-07',
    39,
    '2023-01-22T05:00:00.250Z',
    '2023-01-22T14:00:00.250Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    1999,
    '2022-12-07',
    25,
    '2023-01-22T05:00:00.459Z',
    '2023-01-22T14:00:00.459Z',
    8.5,
    220,
    'אצל ויאם בוילה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2000,
    '2022-12-08',
    26,
    '2022-12-08T05:00:00.000Z',
    '2022-12-08T15:00:00+02:00',
    7.5,
    274,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2001,
    '2022-12-08',
    24,
    '2022-12-08T05:00:00.000Z',
    '2022-12-08T15:00:00+02:00',
    7.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2002,
    '2022-12-08',
    25,
    '2023-01-22T05:00:00.117Z',
    '2023-01-22T14:00:00.117Z',
    8.5,
    220,
    'אצל ויאם בוילה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2003,
    '2022-12-08',
    39,
    '2023-01-22T05:00:00.901Z',
    '2023-01-22T14:00:00.901Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2004,
    '2022-12-08',
    13,
    '2023-01-22T05:00:00.901Z',
    '2023-01-22T14:00:00.901Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2005,
    '2022-12-09',
    26,
    '2022-12-09T05:00:00.000Z',
    '2022-12-09T11:00:00+02:00',
    4,
    146,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2006,
    '2022-12-09',
    24,
    '2022-12-09T05:00:00.000Z',
    '2022-12-09T11:00:00+02:00',
    4,
    160,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2007,
    '2022-12-09',
    41,
    '2023-01-22T05:00:00.803Z',
    '2023-01-22T14:00:00.803Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2008,
    '2022-12-09',
    13,
    '2023-01-22T05:00:00.803Z',
    '2023-01-22T14:00:00.803Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2009,
    '2022-12-09',
    39,
    '2023-01-22T05:00:00.975Z',
    '2023-01-22T14:00:00.975Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2010,
    '2022-12-12',
    41,
    '2022-12-12T05:00:00.000Z',
    '2022-12-12T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2011,
    '2022-12-12',
    39,
    '2022-12-12T05:00:00.000Z',
    '2022-12-12T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2012,
    '2022-12-12',
    24,
    '2023-01-22T05:00:00.167Z',
    '2023-01-22T14:00:00.167Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2013,
    '2022-12-12',
    13,
    '2023-01-22T05:00:00.167Z',
    '2023-01-22T14:00:00.167Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2014,
    '2022-12-12',
    26,
    '2023-01-22T05:00:00.167Z',
    '2023-01-22T14:00:00.167Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2015,
    '2022-12-13',
    31,
    '2022-12-13T05:00:00.000Z',
    '2022-12-13T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2016,
    '2022-12-13',
    24,
    '2022-12-13T05:00:00.000Z',
    '2022-12-13T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2017,
    '2022-12-13',
    25,
    '2023-01-22T05:00:00.982Z',
    '2023-01-22T14:00:00.982Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2018,
    '2022-12-13',
    41,
    '2023-01-22T05:00:00.105Z',
    '2023-01-22T14:00:00.105Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2019,
    '2022-12-13',
    39,
    '2023-01-22T05:00:00.105Z',
    '2023-01-22T14:00:00.105Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2020,
    '2022-12-13',
    26,
    '2023-01-22T05:00:00.105Z',
    '2023-01-22T14:00:00.105Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2021,
    '2022-12-14',
    39,
    '2022-12-14T05:00:00.000Z',
    '2022-12-14T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2022,
    '2022-12-14',
    25,
    '2022-12-14T05:00:00.000Z',
    '2022-12-14T14:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2023,
    '2022-12-14',
    13,
    '2022-12-14T05:00:00.000Z',
    '2022-12-14T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2024,
    '2022-12-14',
    41,
    '2022-12-14T05:00:00.000Z',
    '2022-12-14T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2025,
    '2022-12-14',
    31,
    '2023-01-22T05:00:00.727Z',
    '2023-01-22T14:00:00.727Z',
    8.5,
    300,
    'לואי מסעדה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2026,
    '2022-12-14',
    24,
    '2023-01-22T05:00:00.888Z',
    '2023-01-22T14:00:00.888Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2027,
    '2022-12-14',
    26,
    '2023-01-22T05:00:00.888Z',
    '2023-01-22T14:00:00.888Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2028,
    '2022-12-15',
    41,
    '2022-12-15T05:00:00.000Z',
    '2022-12-15T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2029,
    '2022-12-15',
    13,
    '2022-12-15T05:00:00.000Z',
    '2022-12-15T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2030,
    '2022-12-15',
    26,
    '2023-01-22T05:00:00.501Z',
    '2023-01-22T14:00:00.501Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2031,
    '2022-12-15',
    24,
    '2023-01-22T05:00:00.501Z',
    '2023-01-22T14:00:00.501Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2032,
    '2022-12-16',
    24,
    '2022-12-16T05:00:00.000Z',
    '2022-12-16T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2033,
    '2022-12-16',
    13,
    '2022-12-16T05:00:00.000Z',
    '2022-12-16T14:00:00.000Z',
    8.5,
    450,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2034,
    '2022-12-16',
    26,
    '2022-12-16T05:00:00.000Z',
    '2022-12-16T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2035,
    '2022-12-16',
    25,
    '2023-01-22T05:00:00.815Z',
    '2023-01-22T14:00:00.815Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2036,
    '2022-12-16',
    31,
    '2023-01-22T05:00:00.204Z',
    '2023-01-22T14:00:00.204Z',
    8.5,
    300,
    'לואי מסעדה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2037,
    '2022-12-16',
    39,
    '2023-01-22T05:00:00.204Z',
    '2023-01-22T14:00:00.204Z',
    8.5,
    280,
    'לואי מסעדה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2038,
    '2022-12-17',
    31,
    '2022-12-17T05:00:00.000Z',
    '2022-12-17T18:30:00+02:00',
    11,
    388,
    'לואי מסעדה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2039,
    '2022-12-17',
    39,
    '2022-12-17T05:00:00.000Z',
    '2022-12-17T18:30:00+02:00',
    11,
    362,
    'לואי מסעדה'
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2040,
    '2022-12-17',
    26,
    '2023-01-22T11:00:00+02:00',
    '2023-01-22T18:30:00+02:00',
    7,
    255,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2041,
    '2022-12-17',
    24,
    '2023-01-22T11:00:00+02:00',
    '2023-01-22T18:30:00+02:00',
    7,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2042,
    '2022-12-18',
    26,
    '2022-12-18T05:00:00.000Z',
    '2022-12-18T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2043,
    '2022-12-18',
    41,
    '2022-12-18T05:00:00.000Z',
    '2022-12-18T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2044,
    '2022-12-18',
    24,
    '2022-12-18T05:00:00.000Z',
    '2022-12-18T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2045,
    '2022-12-18',
    31,
    '2023-01-22T05:00:00.787Z',
    '2023-01-22T14:00:00.787Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2046,
    '2022-12-18',
    39,
    '2023-01-22T05:00:00.787Z',
    '2023-01-22T14:00:00.787Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2047,
    '2022-12-18',
    25,
    '2023-01-22T05:00:00.711Z',
    '2023-01-22T14:00:00.711Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2048,
    '2022-12-19',
    24,
    '2022-12-19T05:00:00.000Z',
    '2022-12-19T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2049,
    '2022-12-19',
    26,
    '2022-12-19T05:00:00.000Z',
    '2022-12-19T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2050,
    '2022-12-19',
    39,
    '2023-01-22T05:00:00.541Z',
    '2023-01-22T14:00:00.541Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2051,
    '2022-12-19',
    31,
    '2023-01-22T05:00:00.541Z',
    '2023-01-22T14:00:00.541Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2052,
    '2022-12-19',
    25,
    '2023-01-22T05:00:00.931Z',
    '2023-01-22T14:00:00.931Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2053,
    '2022-12-20',
    39,
    '2022-12-20T05:00:00.000Z',
    '2022-12-20T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2054,
    '2022-12-20',
    24,
    '2022-12-20T05:00:00.000Z',
    '2022-12-20T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2055,
    '2022-12-20',
    31,
    '2023-01-22T05:00:00.025Z',
    '2023-01-22T14:00:00.025Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2056,
    '2022-12-20',
    41,
    '2023-01-22T05:00:00.025Z',
    '2023-01-22T14:00:00.025Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2057,
    '2022-12-20',
    25,
    '2023-01-22T05:00:00.603Z',
    '2023-01-22T14:00:00.603Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2058,
    '2022-12-21',
    31,
    '2022-12-21T05:00:00.000Z',
    '2022-12-21T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2059,
    '2022-12-21',
    24,
    '2022-12-21T05:00:00.000Z',
    '2022-12-21T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2060,
    '2022-12-21',
    26,
    '2023-01-22T05:00:00.627Z',
    '2023-01-22T14:00:00.627Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2061,
    '2022-12-21',
    39,
    '2023-01-22T05:00:00.627Z',
    '2023-01-22T14:00:00.627Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2062,
    '2022-12-21',
    25,
    '2023-01-22T05:00:00.831Z',
    '2023-01-22T14:00:00.831Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2063,
    '2022-12-22',
    39,
    '2022-12-22T05:00:00.000Z',
    '2022-12-22T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2064,
    '2022-12-22',
    24,
    '2022-12-22T05:00:00.000Z',
    '2022-12-22T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2065,
    '2022-12-22',
    25,
    '2023-01-22T05:00:00.662Z',
    '2023-01-22T14:00:00.662Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2066,
    '2022-12-22',
    31,
    '2023-01-22T05:00:00.388Z',
    '2023-01-22T14:00:00.388Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2067,
    '2022-12-23',
    31,
    '2022-12-23T05:00:00.000Z',
    '2022-12-23T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2068,
    '2022-12-23',
    26,
    '2023-01-22T05:00:00.194Z',
    '2023-01-22T14:00:00.194Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2069,
    '2022-12-23',
    24,
    '2023-01-22T05:00:00.194Z',
    '2023-01-22T14:00:00.194Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2070,
    '2022-12-23',
    39,
    '2023-01-22T05:00:00.483Z',
    '2023-01-22T14:00:00.483Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2071,
    '2022-12-23',
    25,
    '2023-01-22T05:00:00.369Z',
    '2023-01-22T14:00:00.369Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2072,
    '2022-12-25',
    39,
    '2022-12-25T05:00:00.000Z',
    '2022-12-25T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2073,
    '2022-12-25',
    24,
    '2022-12-25T05:00:00.000Z',
    '2022-12-25T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2074,
    '2022-12-25',
    31,
    '2022-12-25T05:00:00.000Z',
    '2022-12-25T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2075,
    '2022-12-25',
    26,
    '2022-12-25T05:00:00.000Z',
    '2022-12-25T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2076,
    '2022-12-26',
    26,
    '2022-12-26T05:00:00.000Z',
    '2022-12-26T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2077,
    '2022-12-26',
    24,
    '2022-12-26T05:00:00.000Z',
    '2022-12-26T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2078,
    '2022-12-27',
    24,
    '2022-12-27T05:00:00.000Z',
    '2022-12-27T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2079,
    '2022-12-27',
    39,
    '2022-12-27T05:00:00.000Z',
    '2022-12-27T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2080,
    '2022-12-27',
    31,
    '2023-01-22T05:00:00.055Z',
    '2023-01-22T14:00:00.055Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2081,
    '2022-12-27',
    26,
    '2023-01-22T05:00:00.055Z',
    '2023-01-22T14:00:00.055Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2082,
    '2022-12-27',
    25,
    '2023-01-22T05:00:00.091Z',
    '2023-01-22T14:00:00.092Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2083,
    '2022-12-28',
    26,
    '2022-12-28T05:00:00.000Z',
    '2022-12-28T14:00:00.000Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2084,
    '2022-12-28',
    31,
    '2022-12-28T05:00:00.000Z',
    '2022-12-28T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2085,
    '2022-12-28',
    25,
    '2023-01-22T05:00:00.612Z',
    '2023-01-22T14:00:00.612Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2086,
    '2022-12-28',
    24,
    '2023-01-22T05:00:00.670Z',
    '2023-01-22T14:00:00.670Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2087,
    '2022-12-28',
    39,
    '2023-01-22T05:00:00.670Z',
    '2023-01-22T14:00:00.670Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2088,
    '2022-12-29',
    39,
    '2022-12-29T05:00:00.000Z',
    '2022-12-29T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2089,
    '2022-12-29',
    24,
    '2022-12-29T05:00:00.000Z',
    '2022-12-29T14:00:00.000Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2090,
    '2022-12-29',
    25,
    '2023-01-22T05:00:00.275Z',
    '2023-01-22T14:00:00.275Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2091,
    '2022-12-29',
    26,
    '2023-01-22T05:00:00.118Z',
    '2023-01-22T14:00:00.118Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2092,
    '2022-12-29',
    31,
    '2023-01-22T05:00:00.118Z',
    '2023-01-22T14:00:00.118Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2093,
    '2022-12-30',
    39,
    '2023-01-22T05:00:00.586Z',
    '2023-01-22T14:00:00.586Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2094,
    '2022-12-30',
    24,
    '2023-01-22T05:00:00.586Z',
    '2023-01-22T14:00:00.586Z',
    8.5,
    340,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2095,
    '2022-12-30',
    26,
    '2023-01-22T05:00:00.547Z',
    '2023-01-22T14:00:00.547Z',
    8.5,
    310,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2096,
    '2022-12-30',
    31,
    '2023-01-22T05:00:00.547Z',
    '2023-01-22T14:00:00.547Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2097,
    '2022-12-31',
    25,
    '2022-12-31T05:00:00.000Z',
    '2022-12-31T14:00:00.000Z',
    8.5,
    220,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2098,
    '2022-12-31',
    39,
    '2022-12-31T05:00:00.000Z',
    '2022-12-31T14:00:00.000Z',
    8.5,
    280,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2099,
    '2022-12-31',
    31,
    '2022-12-31T05:00:00.000Z',
    '2022-12-31T14:00:00.000Z',
    8.5,
    300,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2100,
    '2023-03-01',
    42,
    '2023-03-01T05:00:00.000Z',
    '2023-03-01T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2102,
    '2023-03-01',
    43,
    '2023-03-01T05:00:00.000Z',
    '2023-03-01T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2103,
    '2023-03-02',
    42,
    '2023-03-02T05:00:00.000Z',
    '2023-03-02T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2104,
    '2023-03-02',
    43,
    '2023-03-02T05:00:00.000Z',
    '2023-03-02T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2105,
    '2023-03-03',
    42,
    '2023-03-03T05:00:00.000Z',
    '2023-03-03T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2106,
    '2023-03-03',
    43,
    '2023-03-03T05:00:00.000Z',
    '2023-03-03T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2107,
    '2023-03-05',
    43,
    '2023-03-05T05:00:00.000Z',
    '2023-03-05T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2108,
    '2023-03-05',
    42,
    '2023-03-05T05:00:00.000Z',
    '2023-03-05T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2109,
    '2023-03-06',
    43,
    '2023-03-06T05:00:00.000Z',
    '2023-03-06T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2110,
    '2023-03-06',
    24,
    '2023-03-06T05:00:00.000Z',
    '2023-03-06T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2111,
    '2023-03-06',
    42,
    '2023-04-13T04:00:00.754Z',
    '2023-04-13T13:00:00.754Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2112,
    '2023-03-06',
    39,
    '2023-04-13T04:00:00.754Z',
    '2023-04-13T13:00:00.754Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2113,
    '2023-03-07',
    24,
    '2023-03-07T05:00:00.000Z',
    '2023-03-07T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2114,
    '2023-03-07',
    43,
    '2023-03-07T05:00:00.000Z',
    '2023-03-07T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2115,
    '2023-03-07',
    42,
    '2023-04-13T04:00:00.420Z',
    '2023-04-13T13:00:00.420Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2116,
    '2023-03-07',
    39,
    '2023-04-13T04:00:00.420Z',
    '2023-04-13T13:00:00.420Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2117,
    '2023-03-08',
    24,
    '2023-03-08T05:00:00.000Z',
    '2023-03-08T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2118,
    '2023-03-08',
    43,
    '2023-03-08T05:00:00.000Z',
    '2023-03-08T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2119,
    '2023-03-08',
    42,
    '2023-04-13T04:00:00.626Z',
    '2023-04-13T13:00:00.626Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2120,
    '2023-03-08',
    39,
    '2023-04-13T04:00:00.626Z',
    '2023-04-13T13:00:00.626Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2121,
    '2023-03-08',
    31,
    '2023-04-13T04:00:00.626Z',
    '2023-04-13T13:00:00.626Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2122,
    '2023-03-09',
    24,
    '2023-03-09T05:00:00.000Z',
    '2023-03-09T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2123,
    '2023-03-09',
    43,
    '2023-03-09T05:00:00.000Z',
    '2023-03-09T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2124,
    '2023-03-09',
    31,
    '2023-04-13T04:00:00.798Z',
    '2023-04-13T13:00:00.798Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2125,
    '2023-03-09',
    42,
    '2023-04-13T04:00:00.798Z',
    '2023-04-13T13:00:00.798Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2126,
    '2023-03-09',
    39,
    '2023-04-13T04:00:00.798Z',
    '2023-04-13T13:00:00.798Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2127,
    '2023-03-10',
    21,
    '2023-03-10T05:00:00.000Z',
    '2023-03-10T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2128,
    '2023-03-10',
    31,
    '2023-04-13T04:00:00.560Z',
    '2023-04-13T13:00:00.560Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2129,
    '2023-03-10',
    39,
    '2023-04-13T04:00:00.560Z',
    '2023-04-13T13:00:00.560Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2130,
    '2023-03-10',
    43,
    '2023-04-13T04:00:00.532Z',
    '2023-04-13T13:00:00.532Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2131,
    '2023-03-10',
    24,
    '2023-04-13T04:00:00.532Z',
    '2023-04-13T13:00:00.532Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2132,
    '2023-03-12',
    21,
    '2023-04-13T04:00:00.482Z',
    '2023-04-13T13:00:00.482Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2133,
    '2023-03-12',
    24,
    '2023-04-13T04:00:00.482Z',
    '2023-04-13T13:00:00.482Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2134,
    '2023-03-12',
    43,
    '2023-04-13T10:00:00+03:00',
    '2023-04-13T13:00:00.020Z',
    5.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2135,
    '2023-03-12',
    31,
    '2023-04-13T04:00:00.261Z',
    '2023-04-13T13:00:00.261Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2136,
    '2023-03-12',
    39,
    '2023-04-13T04:00:00.261Z',
    '2023-04-13T13:00:00.261Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2137,
    '2023-03-13',
    24,
    '2023-03-13T05:00:00.000Z',
    '2023-03-13T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2138,
    '2023-03-13',
    13,
    '2023-03-13T05:00:00.000Z',
    '2023-03-13T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2139,
    '2023-03-13',
    43,
    '2023-03-13T05:00:00.000Z',
    '2023-03-13T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2140,
    '2023-03-13',
    42,
    '2023-03-13T05:00:00.000Z',
    '2023-03-13T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2141,
    '2023-03-13',
    39,
    '2023-04-13T04:00:00.135Z',
    '2023-04-13T13:00:00.135Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2142,
    '2023-03-13',
    31,
    '2023-04-13T04:00:00.135Z',
    '2023-04-13T13:00:00.135Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2143,
    '2023-03-14',
    25,
    '2023-03-14T05:00:00.000Z',
    '2023-03-14T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2144,
    '2023-03-14',
    39,
    '2023-03-14T05:00:00.000Z',
    '2023-03-14T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2145,
    '2023-03-14',
    42,
    '2023-04-13T04:00:00.799Z',
    '2023-04-13T13:00:00.799Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2146,
    '2023-03-14',
    43,
    '2023-04-13T04:00:00.799Z',
    '2023-04-13T13:00:00.799Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2147,
    '2023-03-14',
    24,
    '2023-04-13T04:00:00.799Z',
    '2023-04-13T13:00:00.799Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2148,
    '2023-03-14',
    31,
    '2023-04-13T04:00:00.799Z',
    '2023-04-13T13:00:00.799Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2149,
    '2023-03-15',
    24,
    '2023-03-15T05:00:00.000Z',
    '2023-03-15T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2150,
    '2023-03-15',
    43,
    '2023-03-15T05:00:00.000Z',
    '2023-03-15T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2151,
    '2023-03-15',
    25,
    '2023-04-13T04:00:00.232Z',
    '2023-04-13T13:00:00.232Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2152,
    '2023-03-15',
    42,
    '2023-04-13T04:00:00.232Z',
    '2023-04-13T13:00:00.232Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2153,
    '2023-03-15',
    39,
    '2023-04-13T04:00:00.300Z',
    '2023-04-13T13:00:00.300Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2154,
    '2023-03-15',
    31,
    '2023-04-13T04:00:00.300Z',
    '2023-04-13T13:00:00.300Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2155,
    '2023-03-16',
    39,
    '2023-03-16T05:00:00.000Z',
    '2023-03-16T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2156,
    '2023-03-16',
    24,
    '2023-03-16T05:00:00.000Z',
    '2023-03-16T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2157,
    '2023-03-16',
    43,
    '2023-03-16T05:00:00.000Z',
    '2023-03-16T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2158,
    '2023-03-16',
    31,
    '2023-03-16T05:00:00.000Z',
    '2023-03-16T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2159,
    '2023-03-16',
    13,
    '2023-03-16T05:00:00.000Z',
    '2023-03-16T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2160,
    '2023-03-16',
    25,
    '2023-04-13T04:00:00.748Z',
    '2023-04-13T13:00:00+03:00',
    5.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2161,
    '2023-03-17',
    31,
    '2023-03-17T05:00:00.000Z',
    '2023-03-17T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2162,
    '2023-03-17',
    43,
    '2023-03-17T05:00:00.000Z',
    '2023-03-17T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2163,
    '2023-03-17',
    24,
    '2023-04-13T04:00:00.915Z',
    '2023-04-13T13:00:00.915Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2164,
    '2023-03-17',
    39,
    '2023-04-13T04:00:00.915Z',
    '2023-04-13T13:00:00.915Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2165,
    '2023-03-17',
    25,
    '2023-04-13T04:00:00.949Z',
    '2023-04-13T13:00:00.949Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2166,
    '2023-03-19',
    31,
    '2023-03-19T05:00:00.000Z',
    '2023-03-19T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2167,
    '2023-03-19',
    24,
    '2023-03-19T05:00:00.000Z',
    '2023-03-19T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2168,
    '2023-03-19',
    25,
    '2023-04-13T04:00:00.210Z',
    '2023-04-13T13:00:00.210Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2169,
    '2023-03-19',
    42,
    '2023-04-13T04:00:00.210Z',
    '2023-04-13T13:00:00.210Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2170,
    '2023-03-20',
    31,
    '2023-03-20T05:00:00.000Z',
    '2023-03-20T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2171,
    '2023-03-20',
    43,
    '2023-03-20T05:00:00.000Z',
    '2023-03-20T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2172,
    '2023-03-20',
    25,
    '2023-04-13T04:00:00.409Z',
    '2023-04-13T13:00:00.409Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2173,
    '2023-03-20',
    42,
    '2023-04-13T04:00:00.409Z',
    '2023-04-13T13:00:00.409Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2174,
    '2023-03-20',
    13,
    '2023-04-13T04:00:00.075Z',
    '2023-04-13T13:00:00.075Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2175,
    '2023-03-20',
    24,
    '2023-04-13T04:00:00.075Z',
    '2023-04-13T13:00:00.075Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2176,
    '2023-03-21',
    43,
    '2023-03-21T05:00:00.000Z',
    '2023-03-21T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2177,
    '2023-03-21',
    31,
    '2023-03-21T05:00:00.000Z',
    '2023-03-21T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2178,
    '2023-03-21',
    42,
    '2023-04-13T04:00:00.344Z',
    '2023-04-13T13:00:00.344Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2179,
    '2023-03-21',
    25,
    '2023-04-13T04:00:00.589Z',
    '2023-04-13T13:00:00.589Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2180,
    '2023-03-21',
    24,
    '2023-04-13T04:00:00.589Z',
    '2023-04-13T13:00:00.589Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2181,
    '2023-03-22',
    43,
    '2023-03-22T05:00:00.000Z',
    '2023-03-22T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2182,
    '2023-03-22',
    31,
    '2023-03-22T05:00:00.000Z',
    '2023-03-22T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2183,
    '2023-03-22',
    24,
    '2023-03-22T05:00:00.000Z',
    '2023-03-22T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2184,
    '2023-03-23',
    24,
    '2023-03-23T05:00:00.000Z',
    '2023-03-23T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2185,
    '2023-03-23',
    31,
    '2023-03-23T05:00:00.000Z',
    '2023-03-23T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2186,
    '2023-03-23',
    25,
    '2023-04-13T04:00:00.372Z',
    '2023-04-13T13:00:00.372Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2187,
    '2023-03-24',
    31,
    '2023-03-24T04:00:00.000Z',
    '2023-03-24T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2188,
    '2023-03-24',
    43,
    '2023-03-24T04:00:00.000Z',
    '2023-03-24T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2189,
    '2023-03-24',
    24,
    '2023-04-13T04:00:00.062Z',
    '2023-04-13T13:00:00.062Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2190,
    '2023-03-24',
    25,
    '2023-04-13T04:00:00.062Z',
    '2023-04-13T13:00:00.062Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2191,
    '2023-01-01',
    39,
    '2023-01-01T05:00:00.000Z',
    '2023-01-01T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2192,
    '2023-01-01',
    24,
    '2023-01-01T05:00:00.000Z',
    '2023-01-01T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2193,
    '2023-01-01',
    31,
    '2023-04-14T04:00:00.887Z',
    '2023-04-14T13:00:00.887Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2194,
    '2023-01-01',
    26,
    '2023-04-14T04:00:00.887Z',
    '2023-04-14T13:00:00.887Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2195,
    '2023-01-02',
    39,
    '2023-01-02T05:00:00.000Z',
    '2023-01-02T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2196,
    '2023-01-02',
    24,
    '2023-01-02T05:00:00.000Z',
    '2023-01-02T14:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2197,
    '2023-01-02',
    31,
    '2023-04-14T04:00:00.061Z',
    '2023-04-14T18:30:00+03:00',
    11,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2198,
    '2023-01-02',
    25,
    '2023-04-14T04:00:00.061Z',
    '2023-04-14T18:30:00+03:00',
    11,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2199,
    '2023-01-02',
    26,
    '2023-04-14T04:00:00.061Z',
    '2023-04-14T18:30:00+03:00',
    11,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2200,
    '2023-03-26',
    43,
    '2023-03-26T04:00:00.000Z',
    '2023-03-26T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2201,
    '2023-03-26',
    24,
    '2023-03-26T04:00:00.000Z',
    '2023-03-26T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2202,
    '2023-03-26',
    31,
    '2023-03-26T04:00:00.000Z',
    '2023-03-26T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2203,
    '2023-03-26',
    25,
    '2023-03-26T04:00:00.000Z',
    '2023-03-26T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2204,
    '2023-03-26',
    42,
    '2023-05-07T00:00:00+03:00',
    '2023-05-07T13:00:00.301Z',
    15.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2205,
    '2023-03-27',
    42,
    '2023-03-27T04:00:00.000Z',
    '2023-03-27T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2206,
    '2023-03-27',
    31,
    '2023-03-27T04:00:00.000Z',
    '2023-03-27T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2207,
    '2023-03-27',
    24,
    '2023-03-27T04:00:00.000Z',
    '2023-03-27T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2212,
    '2023-03-28',
    31,
    '2023-05-07T04:00:00.599Z',
    '2023-05-07T13:00:00.599Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2213,
    '2023-03-28',
    42,
    '2023-05-07T04:00:00.599Z',
    '2023-05-07T13:00:00.599Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2214,
    '2023-03-28',
    43,
    '2023-05-07T04:00:00.599Z',
    '2023-05-07T13:00:00.599Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2215,
    '2023-03-28',
    24,
    '2023-05-07T04:00:00.599Z',
    '2023-05-07T13:00:00.599Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2216,
    '2023-03-29',
    43,
    '2023-03-29T04:00:00.000Z',
    '2023-03-29T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2217,
    '2023-03-29',
    31,
    '2023-03-29T04:00:00.000Z',
    '2023-03-29T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2218,
    '2023-03-29',
    42,
    '2023-03-29T04:00:00.000Z',
    '2023-03-29T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2219,
    '2023-03-29',
    24,
    '2023-03-29T04:00:00.000Z',
    '2023-03-29T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2220,
    '2023-03-30',
    24,
    '2023-03-30T04:00:00.000Z',
    '2023-03-30T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2221,
    '2023-03-30',
    31,
    '2023-03-30T04:00:00.000Z',
    '2023-03-30T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2222,
    '2023-03-30',
    42,
    '2023-03-30T04:00:00.000Z',
    '2023-03-30T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2223,
    '2023-03-31',
    31,
    '2023-05-07T04:00:00.196Z',
    '2023-05-07T13:00:00.196Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2224,
    '2023-03-31',
    43,
    '2023-05-07T04:00:00.196Z',
    '2023-05-07T13:00:00.196Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2225,
    '2023-03-31',
    44,
    '2023-05-07T04:00:00.196Z',
    '2023-05-07T13:00:00.196Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2226,
    '2023-03-31',
    24,
    '2023-05-07T04:00:00.196Z',
    '2023-05-07T13:00:00.196Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2227,
    '2023-04-02',
    43,
    '2023-04-02T04:00:00.000Z',
    '2023-04-02T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2228,
    '2023-04-02',
    31,
    '2023-04-02T04:00:00.000Z',
    '2023-04-02T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2229,
    '2023-04-02',
    44,
    '2023-04-02T04:00:00.000Z',
    '2023-04-02T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );
INSERT INTO
  `employeesTimeSheet` (
    `id`,
    `date`,
    `employeeId`,
    `startAt`,
    `endAt`,
    `duration`,
    `payPerDay`,
    `notes`
  )
VALUES
  (
    2230,
    '2023-04-02',
    24,
    '2023-04-02T04:00:00.000Z',
    '2023-04-02T13:00:00.000Z',
    8.5,
    NULL,
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: mafreaot
# ------------------------------------------------------------

INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (11, 26, 200, '', '2022-09-02');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (12, 24, 200, '', '2022-09-02');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (13, 13, 200, '', '2022-09-04');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (14, 26, 200, '', '2022-09-06');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (15, 26, 800, '', '2022-09-06');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (16, 24, 1500, '', '2022-09-06');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (17, 26, 2000, '', '2022-09-13');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (18, 26, 500, '', '2022-09-16');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (19, 24, 3000, '', '2022-09-16');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (20, 13, 1000, '', '2022-09-16');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (21, 24, 300, '', '2022-09-22');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (22, 26, 260, '', '2022-09-22');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (23, 13, 1200, '', '2022-09-23');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (24, 13, 500, '', '2022-09-25');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (25, 13, 500, '', '2022-09-29');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (26, 13, 600, '', '2022-10-02');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (27, 13, 3000, '', '2022-10-05');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (28, 13, 600, '', '2022-10-11');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (29, 20, 1000, '', '2022-10-13');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (30, 21, 200, '', '2022-10-30');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (31, 21, 100, '', '2022-10-30');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (32, 38, 200, '', '2022-11-01');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (33, 43, 100, '', '2023-03-29');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (34, 31, 300, '', '2023-03-29');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (35, 24, 200, '', '2023-03-29');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (36, 44, 100, 'נעל חדש', '2023-03-31');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (37, 43, 100, '', '2023-04-02');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (38, 24, 200, '', '2023-04-02');
INSERT INTO
  `mafreaot` (`id`, `employeeId`, `amount`, `notes`, `createdAt`)
VALUES
  (39, 31, 200, '', '2023-04-02');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: project_notes
# ------------------------------------------------------------

INSERT INTO
  `project_notes` (`id`, `projectId`, `notes`, `createdAt`)
VALUES
  (2, 210, 'bebbebebe', '2023-01-01 00:00:00');
INSERT INTO
  `project_notes` (`id`, `projectId`, `notes`, `createdAt`)
VALUES
  (3, 209, 'ccc', '2023-01-02 00:00:00');
INSERT INTO
  `project_notes` (`id`, `projectId`, `notes`, `createdAt`)
VALUES
  (5, 209, 'tttt', '2023-01-09 14:46:40');
INSERT INTO
  `project_notes` (`id`, `projectId`, `notes`, `createdAt`)
VALUES
  (6, 209, 'test', '2023-01-09 14:47:07');
INSERT INTO
  `project_notes` (`id`, `projectId`, `notes`, `createdAt`)
VALUES
  (10, 210, 'jhgkbjkh', '2023-01-09 19:43:00');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: project_pays
# ------------------------------------------------------------

INSERT INTO
  `project_pays` (
    `id`,
    `paidDate`,
    `projectId`,
    `paid`,
    `method`,
    `createdAt`,
    `notes`
  )
VALUES
  (
    1,
    '2023-01-10 00:00:00',
    209,
    2000,
    'cash',
    '2023-01-10 16:49:36',
    'מקדמה'
  );
INSERT INTO
  `project_pays` (
    `id`,
    `paidDate`,
    `projectId`,
    `paid`,
    `method`,
    `createdAt`,
    `notes`
  )
VALUES
  (
    2,
    '2023-01-10 00:00:00',
    209,
    200,
    'cash',
    '2023-01-10 16:55:49',
    'dasd'
  );
INSERT INTO
  `project_pays` (
    `id`,
    `paidDate`,
    `projectId`,
    `paid`,
    `method`,
    `createdAt`,
    `notes`
  )
VALUES
  (
    6,
    '2023-01-11 00:00:00',
    209,
    424523,
    'check',
    '2023-01-11 11:10:26',
    'tegsfg'
  );
INSERT INTO
  `project_pays` (
    `id`,
    `paidDate`,
    `projectId`,
    `paid`,
    `method`,
    `createdAt`,
    `notes`
  )
VALUES
  (
    7,
    '2023-01-15 00:00:00',
    210,
    1000,
    'cash',
    '2023-01-15 11:44:09',
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: project_quotation
# ------------------------------------------------------------

INSERT INTO
  `project_quotation` (
    `id`,
    `projectId`,
    `quotation`,
    `notes`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    34,
    53,
    50000,
    '',
    '2021-11-19 12:27:13',
    '2021-11-19 12:27:13'
  );
INSERT INTO
  `project_quotation` (
    `id`,
    `projectId`,
    `quotation`,
    `notes`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    35,
    70,
    1100000,
    '',
    '2022-02-23 17:13:44',
    '2022-02-23 17:13:44'
  );
INSERT INTO
  `project_quotation` (
    `id`,
    `projectId`,
    `quotation`,
    `notes`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    38,
    209,
    2000,
    'היי',
    '2023-01-06 22:57:00',
    '2023-01-06 23:41:25'
  );
INSERT INTO
  `project_quotation` (
    `id`,
    `projectId`,
    `quotation`,
    `notes`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    39,
    210,
    25000,
    'dafdsf',
    '2023-01-06 23:52:54',
    '2023-01-10 16:19:20'
  );
INSERT INTO
  `project_quotation` (
    `id`,
    `projectId`,
    `quotation`,
    `notes`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    40,
    154,
    3900000,
    '',
    '2023-02-17 11:17:32',
    '2023-05-09 16:49:05'
  );
INSERT INTO
  `project_quotation` (
    `id`,
    `projectId`,
    `quotation`,
    `notes`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    41,
    215,
    5000,
    '',
    '2023-02-17 11:32:23',
    '2023-02-17 11:32:23'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: projects
# ------------------------------------------------------------

INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    51,
    'סלימאן גדעאן בית',
    'סלימאן גדעאן',
    '00000000000000',
    'ירכא',
    '01-09-2021',
    '2021-09-29 21:28:51'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    52,
    'בניין רמי עזרי',
    'רמי עזרי',
    '0000000000',
    'לא ידוע',
    '01-09-2021',
    '2021-09-29 21:29:55'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    53,
    'בית המורשת',
    'מעוצה מקומית',
    '0000000000',
    'ירכא',
    '2021-01-09 00:00:00',
    '2021-09-30 13:16:50'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    54,
    'בניין סלימאן גדעאן',
    'סלימאן גדעאן',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-08 10:50:51'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    55,
    'צימירים חטאר',
    'חטאר',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-08 10:55:44'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    56,
    'כללי',
    'אחמד אבו גנב',
    '0000000000',
    'כללי',
    '01-09-2021',
    '2021-10-08 10:58:09'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    57,
    'כנאן חמוד',
    'כננאן חמוד',
    '000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-08 11:01:20'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    58,
    'קינאן כנעאן',
    'קינאן כנעאן',
    '000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-08 11:09:27'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    59,
    'אוסאמה תקתוק',
    'אוסאמה תקתוק',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-08 11:15:40'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    60,
    'באסל מולא בית',
    'באסל מולא',
    '0537577338',
    'ירכא',
    '01-09-2021',
    '2021-10-08 11:16:05'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    61,
    'רב דור',
    'רב דור',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-08 11:22:42'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    62,
    'אוסאמה מולא',
    'אוסאמה מולא',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-08 11:24:34'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    63,
    'ריאד כבישי',
    'ריאד כבישי',
    '0000000000',
    'גולס',
    '01-09-2021',
    '2021-10-08 11:26:12'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    64,
    'זרם ירכא',
    'עטאללה',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 09:43:41'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    65,
    'נדאל שחאדה',
    'נדאל שחאדה',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 09:45:14'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    66,
    'נאיף דיד',
    'נאיף דיד',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 09:45:53'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    67,
    'אמיר אבו עבלה',
    'אמיר אבו עבלה',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 09:51:07'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    68,
    'מפעל אחים חביש',
    'מפעל אחים חביש',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 09:56:18'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    69,
    'תימור גביש',
    'ֿתימור גביש',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 09:59:10'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    70,
    'מול הנוף',
    'באסל מולא',
    '0537577338',
    'ירכא',
    '01-09-2021',
    '2021-10-19 10:01:30'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    71,
    'אמיר דלעונה',
    'אמיר דלעונה',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 10:37:01'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    72,
    'היתם מולא',
    'היתם מולא',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 10:40:35'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    73,
    'עמי חביש',
    'עמי חביש',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 10:40:49'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    74,
    'אמיר נקד',
    'אמיר נקד',
    '0000000000',
    'ירכא',
    '01-09-2021',
    '2021-10-19 10:45:19'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    111,
    'גאד אבו חמדה',
    'גאד אבו חמה',
    '0000000000',
    'ירכא',
    '2021-10-01 00:00:00',
    '2021-11-21 11:21:09'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    112,
    'רדואן אבו חמדה',
    'רדואן אבו חמדה',
    '0000000000',
    'חיפה',
    '2021-10-01 00:00:00',
    '2021-11-21 11:23:20'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    113,
    'אולמי תקתוק',
    'יוסף תקתוק',
    '0000000000',
    'ירכא',
    '2021-10-03 00:00:00',
    '2021-11-21 11:24:01'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    114,
    'חמודי בזבז',
    'חמודי בזבז',
    '0000000000',
    'ירכא',
    '2021-10-03 00:00:00',
    '2021-11-21 11:25:00'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    115,
    'אמין בזבז',
    'אמין בזבז',
    '0000000000',
    'ירכא',
    '2021-10-03 00:00:00',
    '2021-11-21 11:25:27'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    116,
    'צימירים סרחאן רמאל',
    'סרחאן רמאל ',
    '0000000000',
    'ירכא',
    '2021-10-04 00:00:00',
    '2021-11-21 11:26:27'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    117,
    'סלמאן עבד',
    'סלמאן עבד',
    '0000000000',
    'ירכא',
    '2021-10-05 00:00:00',
    '2021-11-21 11:30:32'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    118,
    'האדי מרזוק',
    'האדי מרזוק',
    '0000000000',
    'ירכא',
    '2021-10-05 00:00:00',
    '2021-11-21 11:31:02'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    119,
    'מוריס עבס בית עפו',
    'מוריס עבאס',
    '0000000000',
    'ירכא',
    '2021-10-05 00:00:00',
    '2021-11-21 11:32:04'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    120,
    'פואד אבו חלים',
    'פואד אבו חלים',
    '0000000000',
    'ירכא',
    '2021-10-10 00:00:00',
    '2021-11-21 11:43:58'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    121,
    'כפר הילד',
    'כפר הילד',
    '0000000000',
    'חורפיש',
    '2021-10-12 00:00:00',
    '2021-11-21 11:48:31'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    122,
    'סעיד מולא',
    'סעיד מולא',
    '0000000000',
    'ירכא',
    '2021-11-12 00:00:00',
    '2021-11-21 11:53:12'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    123,
    'פארס אבו ריש',
    'פארס אבו ריש',
    '0000000000',
    'ירכא',
    '2021-10-12 00:00:00',
    '2021-11-21 11:54:48'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    124,
    'האיל סאלח',
    'האיל סאלח',
    '0000000000',
    'ירכא',
    '2021-10-18 00:00:00',
    '2021-11-21 12:01:20'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    125,
    'יוסף חרבאוי',
    'חרבאוי',
    '0000000000',
    'ירכא',
    '2021-10-19 00:00:00',
    '2021-11-21 12:04:50'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    126,
    'סארי מרזוק',
    'סארי מרזוק',
    '0000000000',
    'ירכא',
    '2021-10-20 00:00:00',
    '2021-11-21 12:08:31'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    127,
    'מאלק חרבאוי',
    'מאלק חרבאוי',
    '0000000000',
    'ירכא',
    '2021-10-21 00:00:00',
    '2021-11-21 12:11:47'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    128,
    'מאהר חרבאוי',
    'מאהר חרבאוי',
    '0000000000',
    'ירכא',
    '2021-10-21 00:00:00',
    '2021-11-21 12:12:13'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    129,
    'וסים מולא',
    'וסים מולא',
    '0000000000',
    'ירכא',
    '2021-10-27 00:00:00',
    '2021-11-21 12:42:17'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    130,
    'רקאן אבו גנב',
    'רקאן אבו גנב',
    '0000000000',
    'ירכא',
    '2021-10-28 00:00:00',
    '2021-11-21 12:44:13'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    131,
    'אבאד חטאר בניין',
    'אבאד חטאר',
    '0000000000',
    'ירכא',
    '2021-10-31 00:00:00',
    '2021-11-21 12:47:44'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    133,
    'בית רועי',
    'רועי',
    '0000000000',
    'קרית אתא',
    '2021-11-01 00:00:00',
    '2021-12-08 16:06:00'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    134,
    'סאלח אבו חמדה',
    'סאלח אבו חמדה',
    '0000000000',
    'ירכא',
    '2021-11-04 00:00:00',
    '2021-12-08 16:53:14'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    135,
    'מהדי זיאן',
    'מהדי זיאן',
    '0',
    'ירכא',
    '2021-11-05 00:00:00',
    '2021-12-08 16:58:47'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    136,
    'עומרי חביש',
    'עומרי חביש',
    '0000000000',
    'ירכא',
    '2021-11-05 00:00:00',
    '2021-12-08 17:00:35'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    137,
    'סלמאן דיד',
    'סלמאן דיד',
    '0000000000',
    'ירכא',
    '2021-11-07 00:00:00',
    '2021-12-08 17:06:46'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    138,
    'מחמד תקתוק',
    'מחמד תקתוק',
    '0000000000',
    'ירכא',
    '2021-11-12 00:00:00',
    '2021-12-08 17:26:26'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    139,
    'דיאן סאלח',
    'דיאן סאלח',
    '0000000000',
    'ירכא',
    '2021-11-21 00:00:00',
    '2021-12-08 18:00:24'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    140,
    'מחמד חרבאוי',
    'מחמד חרבאוי',
    '0000000000',
    'ירכא',
    '2021-11-30 00:00:00',
    '2021-12-08 18:40:42'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    141,
    'שפיק חנגר',
    'שפיק חנגר',
    '0000000000',
    'גולס',
    '2021-12-01 00:00:00',
    '2021-12-08 21:31:43'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    142,
    'קניון כנעאן',
    'קניון כנעאן',
    '0000000000',
    'ירכא',
    '2021-12-10 00:00:00',
    '2022-01-09 21:55:37'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    144,
    'פואז עטאללה',
    'פואז עטאללה',
    '0000000000',
    'ירכא',
    '2021-12-10 00:00:00',
    '2022-01-09 21:58:18'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    145,
    'אימאן חזנה',
    'אימן חזנה',
    '0000000000',
    'ירכא',
    '2021-12-16 00:00:00',
    '2022-01-18 12:47:16'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    146,
    'אמל אבו עבלה',
    'אמל אבו עבלה',
    '0000000000',
    'ירכא',
    '2021-12-16 00:00:00',
    '2022-01-18 12:48:36'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    147,
    'בית מלון פקיעין',
    'בית מלון פקיעין',
    '0000000000',
    'פקיעין',
    '2021-12-17 00:00:00',
    '2022-01-18 12:56:20'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    148,
    'ענאן חביש',
    'ענאן חביש',
    '0000000000',
    'ירכא',
    '2021-12-20 00:00:00',
    '2022-01-18 14:42:40'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    149,
    'פארס כנעאן בניין',
    'פארס כנעאן',
    '0000000000',
    'ירכא',
    '2021-12-20 00:00:00',
    '2022-01-18 14:43:49'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    150,
    'גאנם חרבאוי',
    'גאנם חרבאוי',
    '0000000000',
    'ירכא',
    '2021-12-24 00:00:00',
    '2022-01-18 15:41:59'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    151,
    'אלי דן',
    'אלי דן',
    '0000000000',
    'גולס',
    '2021-12-29 00:00:00',
    '2022-01-18 15:52:28'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    152,
    'גנים',
    'מעוצה מקומית',
    '0000000000',
    'ירכא',
    '2021-12-30 00:00:00',
    '2022-01-18 16:00:53'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    153,
    'ראגי שחאדה',
    'ראגי שחאדה',
    '0000000000',
    'ירכא',
    '2022-02-07 00:00:00',
    '2022-02-10 16:08:39'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    154,
    'מול הנוף בניין חדש',
    'באסל מולא',
    '0000000000',
    'ירכא',
    '2021-09-01 00:00:00',
    '2022-02-10 16:11:35'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    155,
    'באדי חביש',
    'באדי חביש',
    '0000000000',
    'ירכא',
    '2022-01-11 00:00:00',
    '2022-02-15 21:11:23'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    156,
    'עיסאם עבד',
    'עיסאם עבד',
    '0000000000',
    'ירכא',
    '2022-01-12 00:00:00',
    '2022-02-15 21:22:05'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    157,
    'קרית אתא - אבי',
    'קרית אתא - אבי',
    '0000000000',
    'קרית אתא',
    '2022-01-14 00:00:00',
    '2022-02-15 21:36:00'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    158,
    'בניין אחמד',
    'אחמד אבו גנב',
    '0000000000',
    'ירכא שכונת חיילים',
    '2022-01-17 00:00:00',
    '2022-02-20 16:46:06'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    159,
    'אמיר אבו חמדה',
    'אמיר אבו חמדה',
    '0000000000',
    'ירכא',
    '2022-01-19 00:00:00',
    '2022-02-20 17:37:56'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    160,
    'מוניר חידר חטאר',
    'מוניר חידר חטאר',
    '0000000000',
    'ירכא',
    '2022-01-25 00:00:00',
    '2022-02-20 17:46:03'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    161,
    'מסעד עבאס',
    'מסעד עבאס',
    '0000000000',
    'ירכא',
    '2022-01-25 00:00:00',
    '2022-02-20 17:46:33'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    162,
    'מאוחדת',
    'ראיק ',
    '0000000000',
    'ירכא',
    '2022-01-27 00:00:00',
    '2022-02-20 17:51:37'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    163,
    'נאזם כנעאן',
    'נאזם כנעאן',
    '0000000000',
    'ירכא',
    '2022-03-02 00:00:00',
    '2022-03-19 21:39:49'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    164,
    'קרית אתא - אסמדר',
    'אסמדר',
    '0000000000',
    'קרית אתא',
    '2022-02-03 00:00:00',
    '2022-03-19 21:42:11'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    165,
    'מרואן חביש',
    'מרואן חביש',
    '0000000000',
    'ירכא',
    '2022-02-18 00:00:00',
    '2022-03-19 22:35:11'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    166,
    'איאד חביש בית',
    'איאד חביש',
    '0000000000',
    'ירכא',
    '2022-02-18 00:00:00',
    '2022-03-19 22:36:40'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    167,
    'עארף ברכאת',
    'עארף ברכאת',
    '0000000000',
    'ירכא',
    '2022-02-20 00:00:00',
    '2022-03-19 22:40:04'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    168,
    'סלים דאוד',
    'סלים דאוד',
    '0000000000',
    'ירכא',
    '2022-02-23 00:00:00',
    '2022-03-19 22:46:58'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    169,
    'ואאל ברכאת',
    'ואאל ברכאת',
    '0000000000',
    'ירכא',
    '2022-02-28 00:00:00',
    '2022-03-19 22:53:34'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    170,
    'בניין המעוצה ',
    'מעוצה מקומית',
    '0000000000',
    'ירכא',
    '2022-03-02 00:00:00',
    '2022-04-08 21:58:14'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    171,
    'אולמי אל אמיר',
    'אולמי אל אמיר',
    '0000000000',
    'ירכא',
    '2022-03-08 00:00:00',
    '2022-04-11 20:31:14'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    172,
    'סלון נידאא',
    'סלון נידאא',
    '0000000000',
    'ירכאֿ',
    '2022-03-10 00:00:00',
    '2022-04-11 21:10:56'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    173,
    'איוב כנעאן',
    'איוב כנעאן',
    '0000000000',
    'ירכא',
    '2022-03-24 00:00:00',
    '2022-04-12 19:51:45'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    174,
    'אמר זאהי אבו חמדה',
    'אמר זאהי אבו חמדה',
    '0000000000',
    'ירכא',
    '2022-03-25 00:00:00',
    '2022-04-12 19:52:44'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    175,
    'סוהיל מולא',
    'סוהיל מולא',
    '0000000000',
    'ירכא',
    '2022-04-04 00:00:00',
    '2022-05-08 13:55:33'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    176,
    'דיאב חטאר',
    'דיאב חטאר',
    '0000000000',
    'ירכא',
    '2022-04-19 00:00:00',
    '2022-05-08 14:28:30'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    177,
    'אדיב מולא',
    'אדיב מולא',
    '0000000000',
    'ירכא',
    '2022-05-03 00:00:00',
    '2022-06-17 21:55:07'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    178,
    'נביל שחאדה',
    'נביל שחאדה',
    '0000000000',
    'ירכא',
    '2022-05-11 00:00:00',
    '2022-06-18 08:36:34'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    179,
    'מאגד חביש',
    'מאגד חביש',
    '0000000000',
    'ירכא',
    '2022-05-18 00:00:00',
    '2022-06-18 20:41:55'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    180,
    'אמל אבו גנב',
    'אמל אבו גנב',
    '0000000000',
    '00',
    '2022-05-26 00:00:00',
    '2022-06-18 21:17:04'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    181,
    'נגאח חלבי',
    'נגאח חלבי',
    '0000000000',
    '00',
    '2022-05-26 00:00:00',
    '2022-06-18 21:18:31'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    182,
    'סרחאן בית',
    'סרחאן רמאל',
    '0000000000',
    'ירכא',
    '2022-06-10 00:00:00',
    '2022-06-30 21:05:50'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    183,
    'בניין רובין עבד',
    'רובין עבד',
    '0000000000',
    'לא ידוע',
    '2022-06-14 00:00:00',
    '2022-06-30 21:12:17'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    184,
    'ראגח אבו גנב',
    'ראגח אבו גנב',
    '0000000000',
    'ירכא',
    '2022-06-14 00:00:00',
    '2022-06-30 21:14:27'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    185,
    'פורסאן עבאס',
    'פורסאן עבאס',
    '0000000000',
    'ירכא',
    '2022-06-17 00:00:00',
    '2022-06-30 21:34:15'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    186,
    'ראזי ביבאר',
    'ראזי ביבאר',
    '0000000000',
    'גת',
    '2022-06-21 00:00:00',
    '2022-06-30 21:40:23'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    187,
    'באסל אבו ריש',
    'באסל אבו ריש',
    '0000000000',
    'ירכא',
    '2022-07-06 00:00:00',
    '2022-08-12 10:17:42'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    188,
    'בניין בלאל טהא',
    'בלאל טאהא',
    '0000000000',
    'לא ידוע',
    '2022-07-06 00:00:00',
    '2022-08-12 10:18:22'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    189,
    'אנור רמאל',
    'אנור רמאל',
    '0000000000',
    'ירכא',
    '2022-07-18 00:00:00',
    '2022-08-17 14:37:58'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    190,
    'ויסאם מולא - בית אמיר',
    'ויסאם מולא',
    '0000000000',
    'ירכא',
    '2022-07-25 00:00:00',
    '2022-08-17 15:28:05'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    191,
    'בניין פריד חלבי ',
    'סלימאן גדעאן',
    '0000000000',
    'גולס',
    '2022-08-01 00:00:00',
    '2022-08-17 16:38:16'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    192,
    'יוסף אבו מחמוד',
    'יוסף מולא',
    '0000000000',
    'ירכא',
    '2022-08-21 00:00:00',
    '2022-09-18 14:09:06'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    193,
    'ויסאם חטאר',
    'ויסאם חטאר',
    '0',
    'ירכא',
    '2022-09-08 00:00:00',
    '2022-10-12 09:05:03'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    194,
    'טארק עטאללה',
    'טארק עטאללה',
    '0',
    'ירכא',
    '2022-09-01 00:00:00',
    '2022-10-12 09:05:31'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    195,
    'עמיר רמאל',
    'עמיר רמאל',
    '0',
    'ירכא',
    '2022-09-12 00:00:00',
    '2022-10-12 09:50:52'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    196,
    'אמל אבו ריש',
    'אמל אבו ריש',
    '0',
    'ירכא',
    '2022-09-12 00:00:00',
    '2022-10-12 09:51:12'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    197,
    'איהאב מולא',
    'איהאב מולא',
    '0',
    'ירכא',
    '2022-09-13 00:00:00',
    '2022-10-12 09:54:15'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    198,
    'נביל עאמר',
    'נביל עאמר',
    '0',
    'גולס',
    '2022-09-14 00:00:00',
    '2022-10-12 09:56:17'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    199,
    'אמל זגיר',
    'אמל זגיר',
    '0',
    'ירכא',
    '2022-09-15 00:00:00',
    '2022-10-12 10:03:51'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    200,
    'שחאדה סלאמה',
    'שחאדה סלאמה',
    '0',
    'ירכא',
    '2022-09-21 00:00:00',
    '2022-10-12 11:18:29'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    201,
    'גמאל זיאן',
    'גמאל זיאן',
    '0',
    'ירכא',
    '2022-09-21 00:00:00',
    '2022-10-12 11:18:43'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    202,
    'רודי עטאללה',
    'רודי עטאללה',
    '0000000000',
    'ירכא',
    '2022-09-30 00:00:00',
    '2022-11-27 15:44:18'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    203,
    'וגדי זיאן',
    'וגדי זיאן',
    '0000000000',
    'ירכא',
    '2022-10-02 00:00:00',
    '2022-11-27 16:16:37'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    204,
    'נביה חביש',
    'נביה חביש',
    '0000000000',
    'ירכא',
    '2022-10-04 00:00:00',
    '2022-11-27 21:28:28'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    205,
    'עלי סלאמה שוקי',
    'עלי סלאמה שוקי',
    '0000000000',
    'ירכא',
    '2022-10-05 00:00:00',
    '2022-11-27 21:31:56'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    206,
    'מוניר רמאל',
    'מוניר רמאל',
    '0000000000',
    'ירכא',
    '2022-10-07 00:00:00',
    '2022-11-27 21:35:52'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    209,
    'גאלב סאלח',
    'גאלב סאלח',
    '0000000000',
    'ירכא',
    '2022-10-24 00:00:00',
    '2022-11-28 22:29:44'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    210,
    'סאלח חלבי',
    'סאלח חלבי',
    '0000000000',
    'ירכא',
    '2022-10-25 00:00:00',
    '2022-11-28 22:35:27'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    211,
    'נאזם גביש',
    'נאזם גביש',
    '00000',
    'ירכא',
    '2022-11-14 00:00:00',
    '2023-01-20 10:57:06'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    212,
    'מוהנד זיאן',
    'מוהנד זיאן',
    '00000',
    'ירכא',
    '2022-11-16 00:00:00',
    '2023-01-20 11:48:05'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    213,
    'אמיר אבו יוסף',
    'אמיר אבו יוסף',
    '00000',
    'ירכא',
    '2022-12-07 00:00:00',
    '2023-01-22 11:49:31'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    214,
    'תיימור אבו גנב',
    'תיימור אבו גנב',
    '00000',
    'ירכא',
    '2022-12-13 00:00:00',
    '2023-01-22 12:10:19'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    215,
    'כרים רמאל',
    'כרים רמאל',
    '00000',
    'ירכא',
    '2022-12-30 00:00:00',
    '2023-01-22 20:14:00'
  );
INSERT INTO
  `projects` (
    `id`,
    `projectName`,
    `clientFullName`,
    `clientPhone`,
    `location`,
    `createdAt`,
    `updatedAt`
  )
VALUES
  (
    216,
    'טארק סאלח',
    'טארק סאלח',
    '0000000000',
    'ירכא',
    '2023-03-01 00:00:00',
    '2023-04-13 20:54:30'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: salary
# ------------------------------------------------------------

INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (11, 17, '6137', '2021-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (12, 15, '988', '2021-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (13, 16, '7258', '2021-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (14, 13, '8259', '2021-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (15, 18, '4396', '2021-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (16, 14, '8875', '2021-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (17, 13, '6141', '2021-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (18, 18, '6507', '2021-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (19, 14, '9075', '2021-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (20, 17, '1048', '2021-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (21, 19, '4777', '2021-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (22, 16, '6356', '2021-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (23, 20, '2500', '2021-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (41, 13, '9411', '2021-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (42, 14, '8204', '2021-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (43, 19, '5486', '2021-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (44, 18, '9228', '2021-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (45, 16, '6620', '2021-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (46, 20, '2500', '2021-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (47, 19, '5468', '2021-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (48, 13, '10118', '2021-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (49, 14, '9525', '2021-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (50, 18, '9161', '2021-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (51, 16, '146', '2021-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (52, 20, '2500', '2021-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (53, 21, '1856', '2021-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (54, 20, '2500', '2022-01-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (55, 19, '4793', '2022-01-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (56, 14, '7757', '2022-01-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (57, 13, '8235', '2022-01-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (58, 21, '6752', '2022-01-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (59, 18, '6702', '2022-01-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (60, 13, '7942', '2022-02-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (61, 18, '8226', '2022-02-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (62, 14, '8449', '2022-02-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (63, 19, '3986', '2022-02-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (64, 21, '4094', '2022-02-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (65, 20, '2500', '2022-02-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (66, 13, '8777', '2022-03-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (67, 18, '9141', '2022-03-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (68, 14, '2973', '2022-03-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (69, 19, '4777', '2022-03-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (70, 21, '9177', '2022-03-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (71, 20, '2500', '2022-03-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (72, 21, '6610', '2022-04-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (73, 18, '7814', '2022-04-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (74, 20, '2500', '2022-04-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (75, 13, '9082', '2022-04-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (76, 19, '5041', '2022-04-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (77, 13, '11442', '2022-05-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (78, 20, '2500', '2022-05-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (79, 23, '5383', '2022-05-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (80, 18, '7857', '2022-05-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (81, 25, '2937', '2022-05-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (82, 19, '1911', '2022-05-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (83, 24, '4994', '2022-05-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (84, 22, '600', '2022-05-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (85, 21, '8470', '2022-05-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (86, 20, '2500', '2022-06-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (87, 24, '8064', '2022-06-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (88, 13, '10751', '2022-06-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (89, 25, '5624', '2022-06-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (90, 23, '7412', '2022-06-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (91, 21, '1576', '2022-06-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (92, 24, '4950', '2022-07-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (93, 25, '3400', '2022-07-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (94, 23, '4200', '2022-07-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (95, 13, '9450', '2022-07-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (96, 20, '2500', '2022-07-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (97, 26, '2900', '2022-07-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (98, 24, '5746', '2022-08-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (99, 13, '11594', '2022-08-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (100, 25, '3830', '2022-08-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (101, 26, '5398', '2022-08-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (102, 20, '2500', '2022-08-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (103, 27, '624', '2022-06-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (104, 28, '1177', '2022-06-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (105, 27, '2000', '2022-07-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (106, 28, '1600', '2022-07-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (107, 28, '2200', '2022-08-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (108, 27, '2200', '2022-08-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (109, 29, '600', '2022-08-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (110, 30, '8400', '2022-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (111, 24, '9240', '2022-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (112, 25, '5940', '2022-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (113, 31, '6510', '2022-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (114, 26, '8060', '2022-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (115, 13, '12600', '2022-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (116, 20, '2500', '2022-09-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (117, 13, '10959', '2022-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (118, 30, '5365', '2022-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (119, 38, '1588', '2022-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (120, 21, '800', '2022-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (121, 31, '7093', '2022-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (122, 26, '6929', '2022-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (123, 25, '4892', '2022-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (124, 24, '7551', '2022-10-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (125, 26, '3410', '2022-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (126, 13, '11038', '2022-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (127, 25, '2394', '2022-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (128, 39, '3607', '2022-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (129, 21, '2400', '2022-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (130, 24, '4080', '2022-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (131, 38, '4310', '2022-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (132, 31, '3671', '2022-11-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (133, 25, '3740', '2022-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (134, 13, '5400', '2022-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (135, 24, '7540', '2022-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (136, 26, '6255', '2022-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (137, 31, '4888', '2022-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (138, 41, '1960', '2022-12-01 00:00:00');
INSERT INTO
  `salary` (`id`, `employeeId`, `salary`, `salaryDate`)
VALUES
  (139, 39, '6242', '2022-12-01 00:00:00');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: settings
# ------------------------------------------------------------

INSERT INTO
  `settings` (
    `id`,
    `company_name`,
    `owner`,
    `lastName`,
    `phone`,
    `email`,
    `license_code`,
    `expaier_date`,
    `createdAt`
  )
VALUES
  (
    3,
    'אחמד אבו גנב',
    'אחמד',
    'אבו גנב',
    '0527274540',
    'ahmed.abujanb@gmail.com',
    NULL,
    NULL,
    '2022-02-28 19:07:50'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: users
# ------------------------------------------------------------

INSERT INTO
  `users` (
    `id`,
    `email`,
    `firstName`,
    `lastName`,
    `password`,
    `role`
  )
VALUES
  (
    3,
    'rafe.mulla@gmail.com',
    'rafe',
    'mulla',
    '$2a$08$Jp/ZnvgWqI2mZ1SjkYofFeEVTrergPOgpUrtSDugUNZUzI/qIxTya',
    'User'
  );
INSERT INTO
  `users` (
    `id`,
    `email`,
    `firstName`,
    `lastName`,
    `password`,
    `role`
  )
VALUES
  (
    4,
    'ahmed.abujanb@gmail.com',
    'אחמד',
    'אבו גנב',
    '$2a$08$/bam0voXyj6zPxM.ZAWh0OCZVF3pC3q7ldqrH0Gqgzcodfdwfer4y',
    'User'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: workedProjects
# ------------------------------------------------------------

INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (36, 145, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (37, 144, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (38, 146, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (39, 147, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (40, 148, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (41, 149, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (42, 150, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (43, 149, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (44, 150, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (45, 151, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (46, 151, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (47, 152, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (48, 153, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (49, 154, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (50, 155, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (51, 156, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (52, 157, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (53, 158, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (54, 159, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (55, 160, 57, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (56, 160, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (57, 161, 57, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (58, 161, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (59, 162, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (60, 162, 57, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (61, 163, 58, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (62, 164, 58, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (63, 165, 58, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (64, 167, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (65, 166, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (66, 168, 58, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (67, 169, 58, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (68, 170, 59, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (69, 170, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (70, 171, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (71, 171, 59, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (72, 171, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (73, 172, 59, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (74, 172, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (75, 173, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (76, 173, 59, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (77, 174, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (78, 174, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (79, 174, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (80, 175, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (81, 175, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (82, 175, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (83, 176, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (84, 176, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (85, 177, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (86, 177, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (87, 178, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (88, 178, 62, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (89, 179, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (90, 179, 62, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (91, 180, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (92, 180, 62, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (93, 182, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (94, 182, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (95, 181, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (96, 181, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (97, 183, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (98, 184, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (99, 185, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (100, 186, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (101, 187, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (102, 188, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (103, 189, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (104, 190, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (105, 191, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (106, 192, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (107, 193, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (108, 193, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (109, 194, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (110, 194, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (111, 195, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (112, 196, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (113, 197, 66, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (114, 197, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (115, 198, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (116, 198, 66, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (117, 199, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (118, 199, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (119, 200, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (120, 200, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (121, 201, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (122, 201, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (123, 202, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (124, 203, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (125, 204, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (126, 205, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (127, 206, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (128, 207, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (129, 208, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (130, 208, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (131, 209, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (132, 210, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (133, 212, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (134, 211, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (135, 213, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (136, 214, 69, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (137, 215, 69, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (138, 216, 69, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (139, 217, 62, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (140, 218, 62, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (141, 219, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (142, 219, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (143, 219, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (144, 220, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (145, 220, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (146, 221, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (147, 222, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (148, 223, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (149, 224, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (150, 225, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (151, 226, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (152, 227, 69, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (153, 227, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (154, 227, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (155, 228, 69, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (156, 228, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (157, 228, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (158, 229, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (159, 229, 71, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (160, 229, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (161, 230, 71, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (162, 230, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (163, 230, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (164, 231, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (165, 232, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (166, 233, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (167, 234, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (168, 234, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (169, 235, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (170, 235, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (171, 236, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (172, 236, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (173, 237, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (174, 238, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (175, 239, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (176, 240, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (177, 241, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (178, 242, 73, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (179, 243, 73, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (180, 244, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (181, 245, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (182, 246, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (183, 247, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (184, 248, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (185, 249, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (186, 249, 62, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (187, 250, 62, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (188, 250, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (189, 252, 74, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (190, 251, 74, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (249, 287, 111, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (250, 287, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (251, 288, 111, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (252, 288, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (253, 289, 113, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (254, 289, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (255, 290, 113, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (256, 290, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (257, 291, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (258, 291, 111, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (259, 293, 111, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (260, 292, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (261, 292, 111, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (262, 291, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (263, 293, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (264, 292, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (265, 293, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (266, 294, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (267, 294, 113, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (268, 295, 113, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (269, 295, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (270, 296, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (271, 297, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (272, 298, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (273, 298, 118, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (274, 298, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (275, 299, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (276, 299, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (277, 299, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (278, 300, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (279, 300, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (280, 300, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (281, 301, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (282, 302, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (283, 303, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (284, 304, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (285, 305, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (286, 306, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (287, 307, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (288, 309, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (289, 309, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (290, 308, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (291, 308, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (292, 310, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (293, 311, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (294, 312, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (295, 313, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (296, 314, 118, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (297, 314, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (298, 315, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (299, 315, 118, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (300, 316, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (301, 317, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (302, 320, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (303, 320, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (304, 318, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (305, 319, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (306, 318, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (307, 319, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (308, 322, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (309, 321, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (310, 323, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (311, 324, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (312, 325, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (313, 326, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (314, 327, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (315, 328, 121, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (316, 329, 121, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (317, 330, 122, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (318, 332, 122, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (319, 330, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (320, 332, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (321, 331, 122, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (322, 331, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (323, 333, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (324, 333, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (325, 334, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (326, 334, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (327, 335, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (328, 335, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (329, 336, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (330, 336, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (331, 337, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (332, 338, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (333, 339, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (334, 340, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (335, 340, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (336, 341, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (337, 341, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (338, 343, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (339, 342, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (340, 344, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (341, 345, 124, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (342, 346, 124, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (343, 348, 121, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (344, 347, 121, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (345, 350, 125, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (346, 349, 124, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (347, 350, 124, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (348, 349, 125, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (349, 351, 121, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (350, 352, 121, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (351, 354, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (352, 353, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (353, 353, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (354, 354, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (355, 355, 126, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (356, 355, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (357, 356, 128, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (358, 356, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (359, 356, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (360, 357, 128, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (361, 357, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (362, 357, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (363, 358, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (364, 358, 111, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (365, 359, 111, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (366, 359, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (367, 360, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (368, 362, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (369, 361, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (370, 363, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (371, 363, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (372, 364, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (373, 364, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (374, 366, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (375, 366, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (376, 366, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (377, 365, 72, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (378, 365, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (379, 365, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (380, 367, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (381, 368, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (382, 369, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (383, 369, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (384, 369, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (385, 371, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (386, 371, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (387, 371, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (388, 370, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (389, 370, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (390, 370, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (391, 372, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (392, 374, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (393, 373, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (394, 376, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (395, 375, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (396, 376, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (397, 375, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (398, 378, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (399, 378, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (400, 378, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (401, 378, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (402, 377, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (403, 377, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (404, 377, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (405, 377, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (406, 379, 129, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (407, 379, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (408, 380, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (409, 380, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (410, 380, 130, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (411, 381, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (412, 381, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (413, 381, 130, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (414, 383, 130, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (415, 382, 130, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (416, 384, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (417, 385, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (418, 387, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (419, 386, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (420, 388, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (421, 389, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (422, 390, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (423, 391, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (424, 392, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (438, 404, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (439, 405, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (440, 406, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (441, 406, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (442, 407, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (443, 408, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (444, 408, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (445, 409, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (446, 410, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (447, 411, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (448, 412, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (449, 413, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (450, 414, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (451, 415, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (452, 415, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (453, 415, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (454, 415, 134, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (455, 416, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (456, 416, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (457, 416, 134, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (458, 416, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (459, 417, 134, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (460, 417, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (461, 417, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (462, 418, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (463, 419, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (464, 420, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (465, 421, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (466, 422, 135, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (467, 422, 136, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (468, 423, 135, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (469, 423, 136, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (470, 424, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (471, 425, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (472, 425, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (473, 426, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (474, 426, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (475, 428, 137, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (476, 427, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (477, 428, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (478, 427, 137, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (479, 429, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (480, 431, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (481, 430, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (482, 432, 137, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (483, 432, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (484, 433, 137, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (485, 433, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (486, 434, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (487, 434, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (488, 435, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (489, 435, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (490, 436, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (491, 437, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (492, 438, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (493, 439, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (494, 441, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (495, 440, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (496, 442, 134, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (497, 442, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (498, 443, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (499, 442, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (500, 443, 134, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (501, 443, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (502, 444, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (503, 445, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (504, 446, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (505, 446, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (506, 447, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (507, 448, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (508, 449, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (509, 450, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (510, 451, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (511, 452, 138, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (512, 453, 138, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (513, 455, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (514, 454, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (515, 456, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (516, 457, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (517, 458, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (518, 459, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (519, 459, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (520, 460, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (521, 460, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (522, 462, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (523, 461, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (524, 463, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (525, 465, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (526, 464, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (527, 466, 134, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (528, 466, 129, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (529, 467, 134, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (530, 467, 129, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (531, 468, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (532, 469, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (533, 470, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (534, 473, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (535, 471, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (536, 471, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (537, 473, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (538, 472, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (539, 472, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (540, 474, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (541, 475, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (542, 476, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (543, 477, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (544, 478, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (545, 479, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (546, 480, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (547, 481, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (548, 482, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (549, 483, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (550, 484, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (551, 486, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (552, 485, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (553, 487, 121, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (554, 487, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (555, 488, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (556, 488, 121, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (557, 488, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (558, 487, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (559, 489, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (560, 490, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (561, 491, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (562, 493, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (563, 492, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (564, 495, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (565, 494, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (566, 496, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (567, 497, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (568, 498, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (569, 499, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (570, 500, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (571, 501, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (572, 502, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (573, 503, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (574, 504, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (575, 506, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (576, 505, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (577, 507, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (578, 508, 127, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (579, 509, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (580, 509, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (581, 510, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (582, 510, 123, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (583, 511, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (584, 513, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (585, 512, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (586, 515, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (587, 515, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (588, 514, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (589, 514, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (590, 516, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (591, 516, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (592, 518, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (593, 518, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (594, 517, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (595, 517, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (596, 519, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (597, 519, 140, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (598, 520, 140, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (599, 520, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (600, 522, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (601, 523, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (602, 526, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (603, 524, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (604, 525, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (605, 527, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (606, 528, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (607, 529, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (608, 530, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (609, 531, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (610, 532, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (611, 533, 139, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (612, 534, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (613, 534, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (614, 535, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (615, 535, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (616, 537, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (617, 536, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (618, 538, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (619, 538, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (620, 539, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (621, 542, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (622, 540, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (623, 541, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (624, 543, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (625, 544, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (626, 545, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (627, 545, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (628, 545, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (629, 546, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (630, 546, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (631, 546, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (632, 547, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (634, 556, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (635, 557, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (636, 558, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (637, 558, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (638, 559, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (639, 559, 64, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (640, 561, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (641, 560, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (642, 562, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (643, 562, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (644, 562, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (645, 563, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (646, 563, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (647, 563, 55, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (648, 564, 144, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (649, 564, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (650, 564, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (651, 565, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (652, 565, 144, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (653, 565, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (654, 566, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (655, 567, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (656, 568, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (657, 569, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (658, 570, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (659, 571, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (660, 572, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (661, 574, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (662, 573, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (663, 575, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (664, 577, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (665, 576, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (666, 580, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (667, 578, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (668, 579, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (669, 581, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (670, 582, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (671, 583, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (672, 585, 145, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (673, 585, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (674, 584, 145, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (675, 585, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (676, 584, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (677, 584, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (678, 586, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (679, 586, 145, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (680, 586, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (681, 587, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (682, 588, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (683, 589, 147, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (684, 590, 147, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (685, 591, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (686, 592, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (687, 593, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (688, 594, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (689, 594, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (690, 594, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (691, 595, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (692, 595, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (693, 595, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (694, 596, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (695, 596, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (696, 596, 148, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (697, 597, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (698, 597, 148, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (699, 597, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (700, 598, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (701, 598, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (702, 599, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (703, 599, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (704, 600, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (705, 601, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (706, 602, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (707, 602, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (708, 603, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (709, 603, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (710, 604, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (711, 604, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (712, 605, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (713, 605, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (714, 606, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (715, 607, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (716, 608, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (717, 609, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (718, 610, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (719, 611, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (720, 612, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (721, 613, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (722, 614, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (723, 615, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (724, 616, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (725, 617, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (726, 618, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (727, 619, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (728, 619, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (729, 620, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (730, 620, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (731, 621, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (732, 621, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (733, 622, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (734, 622, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (735, 623, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (736, 624, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (737, 625, 151, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (738, 626, 151, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (739, 627, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (740, 628, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (741, 629, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (742, 630, 152, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (743, 630, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (744, 631, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (745, 632, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (746, 633, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (747, 634, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (748, 635, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (749, 635, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (750, 636, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (751, 636, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (752, 637, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (753, 638, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (754, 639, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (755, 640, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (756, 640, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (757, 641, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (758, 642, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (759, 644, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (760, 643, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (761, 645, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (762, 645, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (763, 646, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (764, 647, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (765, 649, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (766, 648, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (767, 650, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (768, 651, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (769, 652, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (770, 653, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (771, 654, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (772, 656, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (773, 655, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (774, 657, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (775, 658, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (776, 659, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (777, 660, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (778, 662, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (779, 661, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (780, 660, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (781, 661, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (782, 662, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (783, 663, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (784, 663, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (785, 664, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (786, 664, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (787, 665, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (788, 666, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (795, 671, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (796, 672, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (797, 673, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (798, 674, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (799, 675, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (800, 677, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (801, 676, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (802, 678, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (803, 678, 151, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (804, 679, 151, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (805, 679, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (806, 680, 155, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (807, 682, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (808, 681, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (809, 683, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (810, 684, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (811, 685, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (812, 685, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (813, 686, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (814, 687, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (815, 688, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (816, 689, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (817, 690, 126, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (818, 690, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (819, 691, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (820, 691, 157, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (821, 692, 157, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (822, 692, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (823, 693, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (824, 694, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (825, 695, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (826, 695, 130, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (827, 696, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (828, 696, 130, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (829, 697, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (830, 697, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (831, 697, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (832, 698, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (833, 698, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (834, 698, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (835, 699, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (836, 700, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (837, 701, 140, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (838, 702, 140, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (839, 701, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (840, 701, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (841, 702, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (842, 702, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (843, 703, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (844, 703, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (845, 704, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (846, 704, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (847, 705, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (848, 707, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (849, 706, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (850, 709, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (851, 710, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (852, 708, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (853, 711, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (854, 713, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (855, 712, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (856, 714, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (857, 715, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (858, 716, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (859, 717, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (860, 719, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (861, 718, 159, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (862, 720, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (863, 721, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (864, 723, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (865, 722, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (866, 724, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (867, 725, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (868, 725, 160, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (869, 725, 161, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (870, 725, 155, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (871, 726, 160, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (872, 726, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (873, 726, 161, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (874, 726, 155, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (875, 728, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (876, 727, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (877, 729, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (878, 730, 161, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (879, 730, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (880, 731, 161, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (881, 731, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (882, 732, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (883, 732, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (884, 734, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (885, 735, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (886, 734, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (887, 735, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (888, 733, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (889, 733, 70, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (890, 735, 162, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (891, 732, 162, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (892, 733, 162, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (893, 736, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (894, 737, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (895, 738, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (896, 739, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (897, 740, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (898, 741, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (899, 740, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (900, 742, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (901, 742, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (902, 741, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (903, 744, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (904, 743, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (905, 745, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (906, 746, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (907, 747, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (908, 748, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (909, 749, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (910, 750, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (911, 751, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (912, 751, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (913, 752, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (914, 752, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (915, 753, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (916, 754, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (917, 755, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (918, 756, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (919, 757, 51, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (920, 758, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (921, 759, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (922, 760, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (923, 762, 162, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (924, 762, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (925, 761, 162, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (926, 761, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (927, 763, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (928, 764, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (929, 766, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (930, 766, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (931, 765, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (932, 765, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (933, 767, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (934, 768, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (935, 769, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (936, 770, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (937, 771, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (938, 772, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (939, 773, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (940, 774, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (941, 774, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (942, 775, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (943, 775, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (944, 777, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (945, 776, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (946, 778, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (947, 779, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (948, 780, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (949, 780, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (950, 781, 52, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (951, 781, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (952, 782, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (953, 782, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (954, 784, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (955, 783, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (956, 783, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (957, 784, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (958, 785, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (959, 785, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (960, 787, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (961, 787, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (962, 786, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (963, 786, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (964, 788, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (965, 789, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (966, 791, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (967, 790, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (968, 792, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (969, 792, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (970, 793, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (971, 793, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (972, 795, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (973, 794, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (974, 796, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (975, 798, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (976, 798, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (977, 797, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (978, 797, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (979, 799, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (980, 799, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (981, 800, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (982, 801, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (983, 803, 165, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (984, 803, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (985, 802, 120, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (986, 802, 165, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (987, 804, 166, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (988, 805, 166, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (989, 806, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (990, 807, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (991, 808, 167, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (992, 809, 167, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (993, 810, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (994, 811, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (995, 812, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (996, 813, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (997, 815, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (998, 815, 133, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (999, 814, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1000, 814, 133, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1001, 816, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1002, 817, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1003, 818, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1004, 818, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1005, 820, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1006, 820, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1007, 819, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1008, 819, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1009, 821, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1010, 821, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1011, 822, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1012, 822, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1013, 823, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1014, 826, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1015, 826, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1016, 825, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1017, 825, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1018, 824, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1019, 827, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1020, 824, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1021, 827, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1022, 828, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1023, 830, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1024, 830, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1025, 829, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1026, 829, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1027, 832, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1028, 831, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1029, 833, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1030, 834, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1031, 835, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1032, 836, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1033, 836, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1034, 837, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1035, 838, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1036, 839, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1037, 840, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1038, 841, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1039, 841, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1040, 842, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1041, 842, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1042, 843, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1043, 844, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1044, 845, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1045, 846, 166, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1046, 847, 166, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1047, 849, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1048, 848, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1049, 850, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1050, 851, 137, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1051, 852, 137, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1052, 853, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1053, 854, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1054, 855, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1055, 858, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1056, 856, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1057, 857, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1058, 859, 166, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1059, 859, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1060, 860, 166, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1061, 860, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1062, 861, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1063, 862, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1064, 864, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1065, 863, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1066, 865, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1067, 866, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1068, 866, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1069, 867, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1070, 867, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1071, 868, 171, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1072, 869, 171, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1073, 870, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1074, 870, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1075, 870, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1076, 871, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1077, 872, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1078, 873, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1079, 874, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1080, 875, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1081, 876, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1082, 877, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1083, 878, 172, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1084, 878, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1085, 878, 147, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1086, 879, 147, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1087, 879, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1088, 879, 172, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1089, 880, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1090, 881, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1091, 882, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1092, 883, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1093, 884, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1094, 885, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1095, 886, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1096, 887, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1097, 888, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1098, 890, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1099, 889, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1100, 891, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1101, 892, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1102, 893, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1103, 893, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1104, 894, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1105, 895, 145, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1106, 895, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1107, 895, 140, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1108, 896, 145, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1109, 896, 140, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1110, 896, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1111, 898, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1112, 897, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1113, 899, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1114, 900, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1115, 902, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1116, 901, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1117, 903, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1118, 904, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1119, 905, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1120, 906, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1121, 906, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1122, 906, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1123, 906, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1124, 907, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1125, 907, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1126, 907, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1127, 907, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1128, 908, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1129, 908, 66, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1130, 909, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1131, 909, 66, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1132, 910, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1133, 911, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1134, 912, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1135, 913, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1136, 914, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1137, 914, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1138, 915, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1139, 915, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1140, 916, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1141, 917, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1142, 918, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1143, 918, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1144, 919, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1145, 919, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1146, 920, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1147, 920, 174, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1148, 921, 174, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1149, 921, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1150, 922, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1151, 923, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1152, 924, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1153, 926, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1154, 926, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1155, 925, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1156, 925, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1157, 927, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1158, 928, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1159, 928, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1160, 929, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1161, 929, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1162, 930, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1163, 931, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1164, 932, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1165, 933, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1166, 934, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1167, 935, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1168, 936, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1172, 940, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1173, 940, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1174, 941, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1175, 940, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1176, 941, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1177, 941, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1178, 942, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1179, 943, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1180, 944, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1181, 945, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1182, 946, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1183, 948, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1184, 947, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1185, 949, 175, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1186, 950, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1187, 951, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1188, 952, 175, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1189, 953, 175, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1190, 954, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1191, 954, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1192, 955, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1193, 955, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1194, 956, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1195, 956, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1196, 957, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1197, 957, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1198, 957, 175, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1199, 958, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1200, 959, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1201, 960, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1202, 960, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1203, 960, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1204, 961, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1205, 961, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1206, 961, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1207, 962, 135, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1208, 962, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1209, 963, 138, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1210, 964, 138, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1211, 965, 135, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1212, 965, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1213, 966, 135, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1214, 966, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1215, 967, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1216, 968, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1217, 970, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1218, 969, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1219, 971, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1220, 972, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1221, 973, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1222, 974, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1223, 975, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1224, 976, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1225, 977, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1226, 978, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1227, 979, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1228, 980, 122, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1229, 981, 145, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1230, 982, 145, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1231, 983, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1232, 983, 115, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1233, 984, 133, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1234, 985, 133, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1235, 987, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1236, 986, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1237, 988, 175, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1238, 988, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1239, 988, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1240, 989, 175, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1241, 989, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1242, 989, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1243, 990, 145, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1244, 991, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1245, 992, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1246, 993, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1247, 994, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1248, 994, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1249, 995, 126, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1250, 995, 145, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1251, 995, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1252, 996, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1253, 997, 133, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1254, 998, 133, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1255, 999, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1256, 999, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1257, 999, 175, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1258, 999, 60, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1259, 1000, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1260, 1001, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1261, 1002, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1262, 1002, 122, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1263, 1003, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1264, 1005, 137, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1265, 1004, 137, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1266, 1006, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1267, 1006, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1268, 1007, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1269, 1007, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1270, 1008, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1271, 1009, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1272, 1010, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1273, 1011, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1274, 1014, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1275, 1012, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1276, 1013, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1277, 1015, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1278, 1017, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1279, 1016, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1280, 1019, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1281, 1020, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1282, 1018, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1283, 1021, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1284, 1022, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1285, 1023, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1294, 1030, 175, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1303, 1037, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1304, 1037, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1305, 1038, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1306, 1038, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1307, 1039, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1308, 1039, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1309, 1040, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1310, 1040, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1311, 1041, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1312, 1041, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1313, 1042, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1314, 1042, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1315, 1043, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1316, 1044, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1317, 1045, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1318, 1046, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1319, 1047, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1320, 1048, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1321, 1048, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1322, 1049, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1323, 1050, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1324, 1051, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1325, 1052, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1326, 1053, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1327, 1054, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1328, 1055, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1330, 1057, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1331, 1058, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1332, 1059, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1333, 1060, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1334, 1061, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1335, 1062, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1336, 1063, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1337, 1064, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1338, 1065, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1339, 1066, 122, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1340, 1067, 122, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1341, 1068, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1342, 1068, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1343, 1069, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1344, 1069, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1345, 1070, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1346, 1071, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1347, 1071, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1348, 1071, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1349, 1072, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1350, 1072, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1351, 1073, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1352, 1074, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1354, 1076, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1355, 1077, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1356, 1078, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1358, 1080, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1359, 1080, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1360, 1081, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1361, 1081, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1362, 1082, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1363, 1083, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1364, 1084, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1365, 1086, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1366, 1085, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1367, 1087, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1368, 1088, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1369, 1089, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1370, 1091, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1371, 1090, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1372, 1092, 177, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1373, 1093, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1374, 1093, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1375, 1094, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1376, 1094, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1377, 1095, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1378, 1098, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1379, 1096, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1380, 1097, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1381, 1099, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1382, 1099, 179, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1383, 1099, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1384, 1100, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1385, 1101, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1386, 1102, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1387, 1103, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1388, 1104, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1389, 1105, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1390, 1106, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1391, 1107, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1392, 1108, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1393, 1109, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1394, 1110, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1395, 1111, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1396, 1111, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1397, 1111, 122, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1398, 1112, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1399, 1112, 122, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1400, 1112, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1401, 1113, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1402, 1114, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1403, 1115, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1404, 1116, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1405, 1117, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1406, 1118, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1407, 1119, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1408, 1121, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1409, 1120, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1410, 1123, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1411, 1122, 112, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1412, 1124, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1413, 1125, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1414, 1126, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1415, 1127, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1416, 1129, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1417, 1128, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1418, 1130, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1419, 1131, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1420, 1133, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1421, 1132, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1422, 1134, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1423, 1135, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1424, 1136, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1425, 1137, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1426, 1137, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1427, 1138, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1428, 1138, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1429, 1139, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1430, 1139, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1431, 1140, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1432, 1140, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1433, 1141, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1434, 1142, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1435, 1143, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1436, 1144, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1437, 1145, 181, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1438, 1146, 181, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1439, 1147, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1440, 1147, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1441, 1148, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1442, 1148, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1443, 1150, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1444, 1149, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1445, 1152, 167, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1446, 1151, 167, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1447, 1153, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1448, 1154, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1449, 1155, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1450, 1155, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1451, 1156, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1452, 1156, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1453, 1157, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1454, 1157, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1455, 1158, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1456, 1159, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1457, 1160, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1458, 1160, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1459, 1160, 133, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1460, 1161, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1461, 1161, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1462, 1162, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1463, 1162, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1464, 1163, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1465, 1163, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1466, 1163, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1467, 1164, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1468, 1164, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1469, 1164, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1470, 1166, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1471, 1165, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1472, 1167, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1473, 1168, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1474, 1169, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1475, 1170, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1476, 1171, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1477, 1173, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1478, 1172, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1479, 1174, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1480, 1175, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1481, 1176, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1482, 1177, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1483, 1179, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1484, 1178, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1485, 1180, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1486, 1181, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1487, 1181, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1488, 1182, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1489, 1184, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1490, 1183, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1491, 1186, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1492, 1185, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1493, 1187, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1494, 1188, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1495, 1189, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1496, 1190, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1497, 1191, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1498, 1192, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1499, 1193, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1500, 1193, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1501, 1194, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1502, 1194, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1503, 1195, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1504, 1196, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1505, 1197, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1506, 1198, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1507, 1198, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1508, 1199, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1509, 1199, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1510, 1200, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1511, 1201, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1512, 1202, 131, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1513, 1202, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1516, 1205, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1517, 1206, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1518, 1207, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1519, 1207, 113, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1520, 1208, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1521, 1208, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1522, 1209, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1523, 1209, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1524, 1210, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1525, 1211, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1526, 1212, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1527, 1212, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1528, 1212, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1529, 1213, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1530, 1212, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1531, 1213, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1532, 1213, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1533, 1213, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1534, 1214, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1535, 1215, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1536, 1216, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1537, 1217, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1538, 1218, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1539, 1219, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1540, 1219, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1541, 1220, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1542, 1221, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1543, 1222, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1544, 1223, 184, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1545, 1223, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1546, 1224, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1547, 1225, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1548, 1226, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1549, 1227, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1550, 1228, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1551, 1228, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1552, 1228, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1553, 1229, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1554, 1229, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1555, 1229, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1556, 1231, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1557, 1230, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1558, 1232, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1559, 1232, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1560, 1233, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1561, 1233, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1562, 1233, 185, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1563, 1232, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1564, 1234, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1565, 1234, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1566, 1235, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1567, 1236, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1568, 1237, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1569, 1238, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1570, 1239, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1571, 1241, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1572, 1240, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1573, 1243, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1574, 1243, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1575, 1243, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1576, 1242, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1577, 1242, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1578, 1242, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1579, 1245, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1580, 1244, 156, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1581, 1246, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1582, 1247, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1583, 1248, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1584, 1249, 186, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1585, 1250, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1586, 1251, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1587, 1253, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1588, 1252, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1589, 1254, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1590, 1255, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1591, 1256, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1592, 1257, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1593, 1257, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1594, 1258, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1595, 1258, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1596, 1259, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1597, 1259, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1598, 1260, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1599, 1262, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1600, 1262, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1601, 1261, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1602, 1261, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1603, 1263, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1604, 1263, 169, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1605, 1265, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1606, 1264, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1607, 1266, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1608, 1267, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1609, 1268, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1610, 1268, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1611, 1269, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1612, 1270, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1613, 1271, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1614, 1272, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1615, 1273, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1616, 1275, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1617, 1274, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1618, 1277, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1619, 1276, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1620, 1279, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1621, 1278, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1622, 1280, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1623, 1281, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1624, 1282, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1625, 1283, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1626, 1284, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1627, 1285, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1628, 1286, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1629, 1286, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1630, 1287, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1631, 1288, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1632, 1288, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1633, 1289, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1634, 1290, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1635, 1291, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1636, 1292, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1637, 1293, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1638, 1294, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1639, 1295, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1640, 1296, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1641, 1297, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1642, 1298, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1643, 1298, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1644, 1299, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1645, 1300, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1646, 1302, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1647, 1301, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1648, 1303, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1649, 1303, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1650, 1304, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1651, 1305, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1652, 1306, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1653, 1307, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1654, 1308, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1655, 1308, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1656, 1309, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1657, 1309, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1658, 1310, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1659, 1310, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1660, 1310, 189, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1661, 1311, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1662, 1311, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1663, 1311, 189, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1664, 1312, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1665, 1313, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1666, 1314, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1667, 1315, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1668, 1316, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1670, 1318, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1671, 1319, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1672, 1320, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1673, 1320, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1674, 1321, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1675, 1321, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1676, 1322, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1677, 1323, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1678, 1324, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1679, 1325, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1680, 1326, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1681, 1326, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1682, 1326, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1683, 1327, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1684, 1327, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1685, 1327, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1686, 1328, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1687, 1328, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1688, 1329, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1689, 1328, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1690, 1329, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1691, 1329, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1692, 1330, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1693, 1331, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1694, 1332, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1695, 1332, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1696, 1333, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1697, 1333, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1698, 1334, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1699, 1334, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1700, 1335, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1701, 1336, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1702, 1336, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1703, 1336, 181, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1704, 1337, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1705, 1338, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1706, 1337, 181, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1707, 1338, 181, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1708, 1338, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1709, 1337, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1710, 1339, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1711, 1340, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1712, 1341, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1713, 1342, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1714, 1343, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1715, 1344, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1716, 1345, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1717, 1346, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1718, 1348, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1719, 1347, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1720, 1350, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1721, 1350, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1722, 1349, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1723, 1349, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1724, 1352, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1725, 1352, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1726, 1351, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1727, 1351, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1728, 1353, 151, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1729, 1354, 151, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1731, 1356, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1732, 1357, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1733, 1358, 151, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1734, 1359, 151, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1735, 1359, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1736, 1358, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1737, 1360, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1738, 1360, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1739, 1361, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1740, 1361, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1741, 1362, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1742, 1363, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1743, 1363, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1744, 1363, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1745, 1364, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1746, 1364, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1747, 1364, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1748, 1365, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1749, 1365, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1750, 1365, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1751, 1366, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1752, 1366, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1753, 1366, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1754, 1367, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1755, 1367, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1756, 1368, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1757, 1369, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1758, 1370, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1759, 1371, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1760, 1371, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1761, 1372, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1762, 1372, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1763, 1373, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1764, 1374, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1765, 1375, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1766, 1375, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1767, 1376, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1768, 1377, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1769, 1377, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1770, 1378, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1771, 1378, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1772, 1379, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1773, 1379, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1774, 1380, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1775, 1380, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1776, 1381, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1777, 1382, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1778, 1383, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1779, 1384, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1780, 1385, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1781, 1386, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1782, 1388, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1783, 1388, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1784, 1387, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1785, 1387, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1786, 1389, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1787, 1390, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1788, 1391, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1789, 1392, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1790, 1393, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1791, 1394, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1792, 1396, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1793, 1395, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1794, 1398, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1795, 1397, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1796, 1396, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1797, 1396, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1798, 1401, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1799, 1402, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1800, 1399, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1801, 1400, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1802, 1403, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1803, 1404, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1804, 1405, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1805, 1406, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1806, 1408, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1807, 1407, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1808, 1410, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1809, 1409, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1810, 1411, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1811, 1412, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1812, 1414, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1813, 1413, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1814, 1415, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1815, 1415, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1816, 1415, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1817, 1416, 116, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1818, 1416, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1819, 1416, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1820, 1418, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1821, 1417, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1822, 1419, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1823, 1420, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1824, 1421, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1825, 1422, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1826, 1423, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1827, 1423, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1828, 1424, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1829, 1423, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1830, 1424, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1831, 1424, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1832, 1426, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1833, 1425, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1834, 1427, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1835, 1428, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1836, 1429, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1837, 1431, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1838, 1431, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1839, 1431, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1840, 1430, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1841, 1430, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1842, 1430, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1843, 1432, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1844, 1433, 130, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1845, 1434, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1846, 1435, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1847, 1436, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1848, 1438, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1849, 1439, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1850, 1440, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1851, 1437, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1852, 1441, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1853, 1441, 130, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1854, 1442, 130, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1855, 1442, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1856, 1443, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1857, 1444, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1858, 1445, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1859, 1445, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1860, 1445, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1861, 1446, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1862, 1446, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1863, 1446, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1864, 1447, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1865, 1448, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1866, 1449, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1867, 1450, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1868, 1451, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1869, 1452, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1870, 1453, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1871, 1454, 187, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1872, 1454, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1873, 1454, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1874, 1455, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1875, 1455, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1876, 1456, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1877, 1456, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1878, 1457, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1879, 1457, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1880, 1458, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1881, 1458, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1882, 1459, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1883, 1460, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1884, 1461, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1885, 1462, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1886, 1463, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1887, 1463, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1888, 1463, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1889, 1464, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1890, 1464, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1891, 1464, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1892, 1465, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1893, 1466, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1894, 1467, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1895, 1468, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1896, 1468, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1897, 1469, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1898, 1470, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1899, 1471, 149, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1900, 1472, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1901, 1473, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1902, 1474, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1903, 1475, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1904, 1475, 61, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1905, 1476, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1906, 1476, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1907, 1477, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1908, 1477, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1909, 1478, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1910, 1479, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1911, 1480, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1912, 1480, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1913, 1481, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1914, 1481, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1915, 1482, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1916, 1483, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1917, 1483, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1918, 1484, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1919, 1484, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1920, 1485, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1921, 1486, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1922, 1486, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1923, 1487, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1924, 1488, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1925, 1488, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1926, 1489, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1927, 1489, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1928, 1490, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1929, 1491, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1930, 1492, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1931, 1493, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1932, 1495, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1933, 1494, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1934, 1496, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1935, 1495, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1936, 1496, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1937, 1494, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1938, 1497, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1939, 1498, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1951, 1504, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1952, 1505, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1953, 1506, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1954, 1507, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1955, 1508, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1956, 1510, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1957, 1509, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1958, 1512, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1959, 1511, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1960, 1513, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1961, 1514, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1962, 1515, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1963, 1515, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1964, 1517, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1965, 1517, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1966, 1516, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1967, 1516, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1968, 1519, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1969, 1518, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1970, 1520, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1971, 1521, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1972, 1522, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1973, 1523, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1974, 1524, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1975, 1525, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1976, 1526, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1977, 1527, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1978, 1528, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1979, 1529, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1980, 1530, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1981, 1531, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1982, 1532, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1983, 1533, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1984, 1534, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1985, 1535, 194, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1986, 1535, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1987, 1535, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1988, 1535, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1989, 1536, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1990, 1536, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1991, 1537, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1992, 1537, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1993, 1537, 194, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1994, 1536, 194, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1995, 1537, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1996, 1536, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1997, 1538, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1998, 1539, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (1999, 1540, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2000, 1540, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2001, 1541, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2002, 1541, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2003, 1543, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2004, 1543, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2005, 1543, 181, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2006, 1543, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2007, 1542, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2008, 1542, 181, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2009, 1542, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2010, 1542, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2011, 1545, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2012, 1545, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2013, 1545, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2014, 1544, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2015, 1544, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2016, 1544, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2017, 1546, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2018, 1546, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2019, 1547, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2020, 1547, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2021, 1548, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2022, 1549, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2023, 1551, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2024, 1550, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2025, 1552, 195, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2026, 1552, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2027, 1553, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2028, 1553, 195, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2029, 1554, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2030, 1555, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2031, 1556, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2032, 1557, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2033, 1559, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2034, 1558, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2035, 1560, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2036, 1561, 197, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2037, 1561, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2038, 1562, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2039, 1562, 197, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2040, 1563, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2041, 1563, 197, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2042, 1564, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2043, 1564, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2044, 1564, 198, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2045, 1564, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2046, 1565, 198, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2047, 1565, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2048, 1565, 117, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2049, 1565, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2050, 1567, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2051, 1567, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2052, 1567, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2053, 1569, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2054, 1566, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2055, 1566, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2056, 1566, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2057, 1569, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2058, 1569, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2059, 1568, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2060, 1568, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2061, 1568, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2062, 1571, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2063, 1571, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2064, 1572, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2065, 1572, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2066, 1570, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2067, 1570, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2068, 1573, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2069, 1575, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2070, 1574, 119, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2071, 1577, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2072, 1577, 199, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2073, 1576, 199, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2074, 1576, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2075, 1579, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2076, 1578, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2077, 1580, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2078, 1583, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2079, 1582, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2080, 1581, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2081, 1584, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2082, 1585, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2083, 1586, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2084, 1587, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2085, 1588, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2086, 1589, 160, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2087, 1589, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2088, 1589, 199, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2089, 1589, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2090, 1590, 160, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2091, 1590, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2092, 1590, 199, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2093, 1590, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2094, 1591, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2095, 1591, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2096, 1592, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2097, 1592, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2098, 1593, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2099, 1593, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2100, 1595, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2101, 1594, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2102, 1594, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2103, 1595, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2104, 1596, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2105, 1596, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2106, 1597, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2107, 1597, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2108, 1598, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2109, 1598, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2110, 1599, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2111, 1599, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2112, 1599, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2113, 1599, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2114, 1600, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2115, 1600, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2116, 1600, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2117, 1600, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2118, 1601, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2119, 1601, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2120, 1601, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2121, 1602, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2122, 1602, 150, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2123, 1602, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2124, 1603, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2125, 1604, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2126, 1605, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2127, 1606, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2128, 1607, 201, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2129, 1608, 201, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2130, 1610, 201, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2131, 1610, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2132, 1609, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2133, 1609, 201, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2134, 1612, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2135, 1612, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2136, 1611, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2137, 1611, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2138, 1613, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2139, 1614, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2140, 1616, 138, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2141, 1616, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2142, 1615, 173, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2143, 1615, 138, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2144, 1618, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2145, 1617, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2146, 1619, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2147, 1620, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2148, 1621, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2149, 1621, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2150, 1622, 53, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2151, 1622, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2152, 1623, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2153, 1623, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2154, 1624, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2155, 1624, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2156, 1625, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2157, 1625, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2158, 1626, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2159, 1626, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2160, 1628, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2161, 1627, 67, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2162, 1629, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2163, 1630, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2164, 1632, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2165, 1632, 135, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2166, 1632, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2167, 1632, 197, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2168, 1631, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2169, 1631, 168, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2170, 1631, 135, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2171, 1631, 197, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2172, 1633, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2181, 1637, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2182, 1637, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2183, 1636, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2184, 1636, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2185, 1638, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2186, 1640, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2187, 1639, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2188, 1641, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2189, 1642, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2190, 1642, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2191, 1643, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2192, 1643, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2193, 1644, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2194, 1647, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2195, 1646, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2196, 1645, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2197, 1648, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2198, 1651, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2199, 1649, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2200, 1650, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2201, 1652, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2202, 1652, 198, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2203, 1653, 198, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2204, 1653, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2205, 1654, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2206, 1654, 202, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2207, 1655, 202, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2208, 1655, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2209, 1656, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2210, 1657, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2211, 1658, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2212, 1658, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2213, 1659, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2214, 1659, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2215, 1660, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2216, 1660, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2217, 1661, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2218, 1661, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2219, 1662, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2220, 1663, 200, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2221, 1664, 203, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2222, 1664, 165, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2223, 1664, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2224, 1665, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2225, 1665, 165, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2226, 1665, 203, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2227, 1667, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2228, 1667, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2229, 1666, 192, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2230, 1666, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2231, 1668, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2232, 1671, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2233, 1670, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2234, 1669, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2235, 1672, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2236, 1674, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2237, 1673, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2238, 1676, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2239, 1675, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2240, 1677, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2241, 1675, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2242, 1672, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2243, 1678, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2244, 1679, 68, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2245, 1680, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2246, 1681, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2247, 1682, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2248, 1683, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2249, 1684, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2250, 1685, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2251, 1686, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2252, 1687, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2253, 1689, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2254, 1688, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2255, 1690, 206, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2256, 1691, 206, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2257, 1693, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2258, 1692, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2259, 1694, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2260, 1694, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2261, 1695, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2262, 1695, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2263, 1696, 201, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2264, 1696, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2265, 1696, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2266, 1697, 201, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2267, 1697, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2268, 1697, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2269, 1698, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2270, 1698, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2271, 1698, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2272, 1698, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2273, 1699, 178, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2274, 1699, 153, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2275, 1699, 180, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2276, 1699, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2277, 1700, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2278, 1700, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2279, 1701, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2280, 1701, 146, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2281, 1702, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2282, 1703, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2283, 1704, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2284, 1705, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2285, 1706, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2286, 1709, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2287, 1708, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2288, 1707, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2289, 1710, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2290, 1711, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2291, 1712, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2292, 1712, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2293, 1714, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2294, 1715, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2295, 1713, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2296, 1714, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2297, 1715, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2298, 1713, 114, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2299, 1716, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2300, 1717, 183, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2301, 1718, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2302, 1718, 197, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2303, 1719, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2304, 1719, 197, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2305, 1720, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2306, 1720, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2307, 1721, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2308, 1721, 56, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2309, 1722, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2310, 1725, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2311, 1724, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2312, 1723, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2313, 1726, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2314, 1726, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2315, 1727, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2316, 1727, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2317, 1725, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2318, 1728, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2319, 1731, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2320, 1732, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2321, 1730, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2322, 1733, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2323, 1729, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2324, 1735, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2325, 1736, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2326, 1734, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2327, 1737, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2328, 1738, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2329, 1739, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2330, 1741, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2331, 1740, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2332, 1742, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2333, 1743, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2334, 1743, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2335, 1745, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2336, 1745, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2337, 1744, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2338, 1744, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2339, 1746, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2340, 1747, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2341, 1748, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2342, 1750, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2343, 1749, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2344, 1751, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2345, 1752, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2346, 1753, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2347, 1754, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2348, 1755, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2349, 1756, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2350, 1757, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2351, 1758, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2352, 1759, 205, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2353, 1760, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2354, 1761, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2355, 1762, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2356, 1763, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2357, 1765, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2358, 1764, 158, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2359, 1766, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2360, 1767, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2361, 1768, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2362, 1769, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2363, 1770, 209, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2364, 1771, 209, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2365, 1772, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2366, 1773, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2367, 1774, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2368, 1775, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2369, 1777, 210, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2370, 1776, 210, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2371, 1778, 170, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2372, 1778, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2373, 1779, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2374, 1781, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2375, 1780, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2376, 1782, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2377, 1782, 210, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2378, 1782, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2379, 1783, 63, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2380, 1783, 210, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2381, 1783, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2382, 1785, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2383, 1785, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2384, 1784, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2385, 1784, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2386, 1786, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2387, 1787, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2388, 1788, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2389, 1790, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2390, 1789, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2391, 1793, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2392, 1792, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2393, 1791, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2394, 1790, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2395, 1793, 65, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2396, 1790, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2397, 1793, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2398, 1794, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2399, 1795, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2400, 1796, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2401, 1797, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2402, 1797, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2403, 1798, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2404, 1798, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2405, 1799, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2406, 1800, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2407, 1801, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2408, 1802, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2409, 1802, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2410, 1803, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2411, 1803, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2412, 1804, 191, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2413, 1804, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2414, 1805, 209, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2415, 1805, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2416, 1805, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2417, 1806, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2418, 1806, 142, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2419, 1806, 209, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2420, 1807, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2421, 1807, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2422, 1807, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2423, 1808, 154, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2424, 1808, 163, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2425, 1808, 190, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2426, 1810, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2427, 1809, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2428, 1811, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2429, 1812, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2430, 1812, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2431, 1812, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2432, 1812, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2433, 1813, 193, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2434, 1813, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2435, 1813, 141, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2436, 1813, 204, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2437, 1814, 69, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2438, 1815, 69, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2439, 1815, 164, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2440, 1816, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2441, 1816, 128, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2442, 1817, 128, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2443, 1817, 182, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2444, 1818, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2445, 1819, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2446, 1820, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2447, 1821, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2448, 1822, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2449, 1823, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2450, 1824, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2451, 1825, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2452, 1826, 188, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2453, 1827, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2454, 1828, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2455, 1829, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2456, 1828, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2457, 1830, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2458, 1830, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2459, 1832, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2460, 1832, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2461, 1831, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2462, 1831, 176, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2463, 1833, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2464, 1834, 54, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2465, 1835, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2466, 1836, 196, '  ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2530, 1906, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2531, 1907, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2532, 1906, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2533, 1907, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2534, 1908, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2535, 1908, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2536, 1909, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2537, 1909, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2538, 1911, 196, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2539, 1913, 196, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2540, 1910, 196, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2542, 1911, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2543, 1913, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2545, 1910, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2546, 1912, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2547, 1912, 196, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2548, 1914, 205, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2549, 1915, 205, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2552, 1918, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2553, 1919, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2554, 1920, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2555, 1920, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2556, 1921, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2557, 1921, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2558, 1922, 205, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2559, 1923, 205, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2560, 1924, 163, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2561, 1925, 163, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2562, 1916, 163, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2563, 1917, 163, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2564, 1926, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2565, 1926, 210, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2570, 1927, 210, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2571, 1927, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2572, 1928, 210, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2573, 1928, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2574, 1931, 205, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2575, 1932, 205, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2576, 1934, 183, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2577, 1933, 183, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2578, 1934, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2579, 1934, 212, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2580, 1933, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2581, 1935, 212, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2582, 1935, 183, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2583, 1933, 212, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2584, 1935, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2585, 1936, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2586, 1937, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2587, 1938, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2588, 1939, 114, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2589, 1940, 114, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2590, 1941, 204, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2591, 1941, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2592, 1942, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2593, 1942, 204, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2594, 1943, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2595, 1943, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2596, 1945, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2597, 1945, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2598, 1944, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2599, 1944, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2600, 1946, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2601, 1947, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2602, 1948, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2603, 1948, 204, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2604, 1950, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2605, 1949, 204, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2606, 1950, 204, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2607, 1949, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2608, 1951, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2609, 1954, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2610, 1953, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2611, 1957, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2612, 1952, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2613, 1955, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2614, 1956, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2615, 1958, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2616, 1958, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2617, 1959, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2618, 1959, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2619, 1960, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2620, 1960, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2621, 1961, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2622, 1962, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2623, 1963, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2624, 1964, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2625, 1965, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2629, 1967, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2630, 1967, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2631, 1966, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2632, 1966, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2633, 1968, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2634, 1968, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2635, 1969, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2636, 1970, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2637, 1972, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2638, 1971, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2639, 1973, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2640, 1974, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2641, 1975, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2642, 1976, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2643, 1977, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2644, 1978, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2645, 1978, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2646, 1979, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2647, 1980, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2648, 1981, 204, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2649, 1981, 197, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2650, 1982, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2651, 1983, 183, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2652, 1983, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2653, 1984, 204, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2654, 1984, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2655, 1986, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2656, 1985, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2657, 1987, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2658, 1988, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2660, 1989, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2661, 1991, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2662, 1993, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2663, 1990, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2664, 1992, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2665, 1994, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2666, 1997, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2667, 1996, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2668, 1995, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2669, 1998, 213, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2670, 1999, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2671, 2000, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2672, 2001, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2673, 2002, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2674, 2003, 119, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2675, 2003, 210, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2676, 2003, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2677, 2004, 119, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2678, 2004, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2679, 2004, 210, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2680, 2005, 211, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2681, 2006, 211, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2682, 2007, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2683, 2008, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2684, 2009, 176, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2689, 2010, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2690, 2010, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2691, 2011, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2692, 2011, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2693, 2012, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2694, 2013, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2695, 2014, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2696, 2015, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2697, 2016, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2698, 2017, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2699, 2018, 214, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2700, 2019, 214, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2701, 2020, 214, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2702, 2021, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2703, 2021, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2704, 2024, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2705, 2022, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2706, 2024, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2707, 2022, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2708, 2023, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2709, 2023, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2710, 2025, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2711, 2026, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2712, 2027, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2713, 2028, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2714, 2029, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2715, 2031, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2716, 2031, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2717, 2030, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2718, 2030, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (
    2722,
    2034,
    54,
    'השלמות מרזב 4 צול, + ניקוז נישה ראשית'
  );
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (
    2723,
    2033,
    54,
    'השלמות מרזב 4 צול, + ניקוז נישה ראשית'
  );
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (
    2724,
    2032,
    54,
    'השלמות מרזב 4 צול, + ניקוז נישה ראשית'
  );
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2725, 2035, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2726, 2036, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2727, 2037, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2728, 2038, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2729, 2039, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2730, 2040, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2731, 2041, 56, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2735, 2044, 56, 'לואי מסעדה');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2736, 2044, 183, 'העלאת מרזבים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2737, 2044, 54, 'פינישים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2738, 2043, 56, 'לואי מסעדה');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2739, 2043, 183, 'העלאת מרזבים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2740, 2043, 54, 'פינישים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2741, 2042, 54, 'פינישים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2742, 2042, 56, 'לואי מסעדה');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2743, 2042, 183, 'העלאת מרזבים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2744, 2046, 56, 'מסעדה לואי');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2745, 2045, 56, 'מסעדה לואי');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2746, 2047, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2747, 2048, 56, 'לואי מסעדה');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2748, 2048, 204, 'הכנת גג');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2749, 2049, 204, 'הכנת גג');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2750, 2049, 56, 'לואי מסעדה');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2751, 2050, 56, 'מסעדה לואי');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2752, 2051, 56, 'מסעדה לואי');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2753, 2052, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2754, 2053, 169, 'כלים סיניטארים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2755, 2054, 169, 'כלים סיניטארים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2756, 2055, 56, 'מסעדה לואי');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2757, 2056, 56, 'מסעדה לואי');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2758, 2057, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2759, 2058, 54, 'כלים סיניטארים + קווי מים ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2760, 2058, 212, 'הזזת נקודת מים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2761, 2059, 54, 'כלים סיניטארים + קווי מים ');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2762, 2059, 212, 'הזזת נקודת מים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2763, 2061, 68, 'השלמות');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2764, 2060, 68, 'השלמות');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2765, 2062, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2766, 2063, 53, 'ניקוז מזגנים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2767, 2064, 53, 'ניקוז מזגנים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2768, 2065, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2769, 2066, 56, 'מסעדה לואי');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2770, 2067, 56, 'מסעדה לואי');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2771, 2068, 54, 'פינישים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2772, 2069, 54, 'פינישים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2773, 2070, 65, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2774, 2070, 56, 'לואי מסעדה');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2775, 2070, 153, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2776, 2071, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2777, 2073, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2778, 2073, 214, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2779, 2073, 197, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2780, 2074, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2781, 2074, 197, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2782, 2074, 214, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2783, 2072, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2784, 2075, 188, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2785, 2075, 214, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2786, 2075, 197, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2787, 2072, 197, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2788, 2072, 214, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2789, 2076, 53, 'ניקוז מזגנים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2790, 2077, 53, 'ניקוז מזגנים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2791, 2078, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2792, 2078, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2793, 2079, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2794, 2079, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2795, 2080, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2796, 2081, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2797, 2082, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2798, 2084, 169, 'קווי ביוב');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2799, 2083, 169, 'קווי ביוב');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2800, 2085, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2801, 2086, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2802, 2086, 68, 'חיבור אסלות');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2803, 2087, 68, 'חיבור אסלות');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2804, 2087, 54, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2805, 2089, 53, 'ניקוז מזגנים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2806, 2088, 53, 'ניקוז מזגנים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2807, 2090, 158, 'יציקה');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2808, 2092, 169, 'קווי מים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2809, 2092, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2810, 2091, 169, 'קווי מים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2811, 2091, 170, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2812, 2094, 170, 'עבודות גבס וצבע');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2813, 2094, 215, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2814, 2093, 215, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2815, 2093, 170, 'עבודות גבס וצבע');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2816, 2096, 170, 'עבודות גבס וצבע');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2817, 2095, 170, 'עבודות גבס וצבע');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2818, 2097, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2819, 2098, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2820, 2099, 158, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2838, 2102, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2839, 2100, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2840, 2100, 138, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2841, 2103, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2842, 2104, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2843, 2106, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2844, 2106, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2845, 2106, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2846, 2106, 153, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2847, 2105, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2848, 2105, 153, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2849, 2105, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2850, 2105, 200, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2851, 2107, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2852, 2108, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2853, 2110, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2854, 2109, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2855, 2111, 138, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2856, 2112, 138, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2857, 2113, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2858, 2113, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2859, 2114, 68, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2860, 2114, 198, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2861, 2115, 138, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2862, 2116, 138, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2863, 2118, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2864, 2117, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2865, 2119, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2866, 2120, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2867, 2121, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2868, 2122, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2869, 2122, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2870, 2123, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2871, 2123, 201, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2872, 2124, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2873, 2126, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2874, 2125, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2875, 2127, 56, 'הרכבת גמל');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2876, 2127, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2877, 2128, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2878, 2129, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2879, 2131, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2880, 2130, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2881, 2132, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2882, 2133, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2883, 2134, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2884, 2135, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2885, 2136, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2886, 2137, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2887, 2139, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2888, 2138, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2889, 2140, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2890, 2141, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2891, 2142, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2892, 2143, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2893, 2144, 149, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2894, 2145, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2895, 2145, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2896, 2146, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2897, 2147, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2898, 2146, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2899, 2148, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2900, 2147, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2901, 2148, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2902, 2149, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2903, 2150, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2904, 2151, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2905, 2152, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2906, 2153, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2907, 2154, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2908, 2155, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2909, 2158, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2910, 2159, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2911, 2156, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2912, 2157, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2913, 2160, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2914, 2161, 154, 'קומה 1');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2915, 2162, 154, 'קומה 1');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2916, 2163, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2917, 2164, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2918, 2165, 56, 'אצל אחמד');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2919, 2166, 154, 'קומה 1');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2920, 2167, 154, 'קומה 1');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2921, 2168, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2922, 2169, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2923, 2170, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2924, 2171, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2925, 2173, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2926, 2172, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2929, 2174, 54, 'תיקונים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2930, 2174, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2931, 2174, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2932, 2175, 191, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2933, 2175, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2934, 2175, 54, 'תיקונים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2935, 2176, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2936, 2177, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2937, 2178, 70, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2938, 2178, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2939, 2179, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2940, 2180, 53, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2941, 2181, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2942, 2183, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2943, 2182, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2944, 2184, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2945, 2185, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2946, 2186, 56, 'אצל אחמד');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2947, 2187, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2948, 2188, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2949, 2189, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2950, 2189, 216, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2951, 2190, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2952, 2190, 216, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2953, 2191, 53, 'ניקוז מזגנים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2954, 2192, 53, 'ניקוז מזגנים');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2955, 2193, 198, 'קומת מרתף חציבות');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2956, 2194, 198, 'קומת מרתף חציבות');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2957, 2195, 198, 'קווי ביוב');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2958, 2196, 198, 'קווי ביוב');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2959, 2197, 56, 'ויאם שיפוץ בבית');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2960, 2199, 56, 'ויאם שיפוץ בבית');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2961, 2198, 56, 'ויאם שיפוץ בבית');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2962, 2200, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2963, 2201, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2964, 2202, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2965, 2203, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2966, 2204, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2967, 2205, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2968, 2207, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2969, 2206, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2974, 2212, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2975, 2214, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2976, 2213, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2977, 2215, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2978, 2216, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2979, 2217, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2980, 2219, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2981, 2218, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2982, 2221, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2983, 2220, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2984, 2222, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2985, 2223, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2986, 2226, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2987, 2224, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2988, 2225, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2989, 2227, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2990, 2228, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2991, 2229, 154, '');
INSERT INTO
  `workedProjects` (`id`, `dayId`, `projectId`, `notes`)
VALUES
  (2992, 2230, 154, '');

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
