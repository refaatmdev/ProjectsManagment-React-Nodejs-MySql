-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: pms-mysql-app: 3306
-- Generation Time: Mar 01, 2022 at 02:30 PM
-- Server version: 5.7.33
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+03:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projects_managment`
--

-- --------------------------------------------------------

--
-- Table structure for table `agreement`
--

CREATE TABLE `agreement` (
  `id` int(11) NOT NULL,
  `imagePath` varchar(250) DEFAULT 'images/default/default-placeholder-150x150.png',
  `projectId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `checks_imgs`
--

CREATE TABLE `checks_imgs` (
  `id` int(11) NOT NULL,
  `checksImgPath` varchar(250) DEFAULT NULL,
  `payId` int(11) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `id` int(11) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `bankAccount` varchar(45) DEFAULT NULL,
  `bankBranch` varchar(45) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` varchar(45) DEFAULT 'null'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employeeDailyWage`
--

CREATE TABLE `employeeDailyWage` (
  `id` int(11) NOT NULL,
  `employeeId` int(11) DEFAULT NULL,
  `dailyWage` int(11) DEFAULT NULL,
  `startFromDate` varchar(45) DEFAULT '2021-10-01T00:00:00.000Z'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `employeesTimeSheet`
--

CREATE TABLE `employeesTimeSheet` (
  `id` int(11) NOT NULL,
  `date` varchar(50) DEFAULT NULL,
  `employeeId` int(11) DEFAULT NULL,
  `startAt` varchar(50) DEFAULT NULL,
  `endAt` varchar(50) DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `payPerDay` float DEFAULT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `id` int(11) NOT NULL,
  `projectName` varchar(250) NOT NULL,
  `clientFullName` varchar(45) NOT NULL,
  `clientPhone` varchar(45) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `createdAt` varchar(45) DEFAULT NULL,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_pays`
--

CREATE TABLE `project_pays` (
  `id` int(11) NOT NULL,
  `paidDate` datetime DEFAULT NULL,
  `projectId` int(11) NOT NULL,
  `paid` int(11) NOT NULL,
  `method` enum('cash','check','other') DEFAULT 'cash',
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `notes` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_quotation`
--

CREATE TABLE `project_quotation` (
  `id` int(11) NOT NULL,
  `projectId` int(11) NOT NULL,
  `quotation` int(11) NOT NULL DEFAULT '0',
  `notes` varchar(250) DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `salary`
--

CREATE TABLE `salary` (
  `id` int(11) NOT NULL,
  `employeeId` int(11) DEFAULT NULL,
  `salary` varchar(45) DEFAULT '0',
  `salaryDate` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `company_name` varchar(200) DEFAULT NULL,
  `owner` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(250) DEFAULT NULL,
  `license_code` varchar(250) DEFAULT NULL,
  `expaier_date` datetime DEFAULT NULL,
  `createdAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(250) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `password` varchar(250) NOT NULL,
  `role` enum('User','Admin') NOT NULL DEFAULT 'User'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `workedProjects`
--

CREATE TABLE `workedProjects` (
  `id` int(11) NOT NULL,
  `dayId` int(11) NOT NULL,
  `projectId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agreement`
--
ALTER TABLE `agreement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projectId_idx` (`projectId`);

--
-- Indexes for table `checks_imgs`
--
ALTER TABLE `checks_imgs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payFk_idx` (`payId`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `employeeDailyWage`
--
ALTER TABLE `employeeDailyWage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_idx` (`employeeId`);

--
-- Indexes for table `employeesTimeSheet`
--
ALTER TABLE `employeesTimeSheet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `employeeId` (`employeeId`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `project_pays`
--
ALTER TABLE `project_pays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projectFK_idx` (`projectId`);

--
-- Indexes for table `project_quotation`
--
ALTER TABLE `project_quotation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `projectfk_idx` (`projectId`);

--
-- Indexes for table `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`id`),
  ADD KEY `empFK_idx` (`employeeId`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `workedProjects`
--
ALTER TABLE `workedProjects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pk_dayId_idx` (`dayId`),
  ADD KEY `pk_projectId_idx` (`projectId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agreement`
--
ALTER TABLE `agreement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `checks_imgs`
--
ALTER TABLE `checks_imgs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `employeeDailyWage`
--
ALTER TABLE `employeeDailyWage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `employeesTimeSheet`
--
ALTER TABLE `employeesTimeSheet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=743;

--
-- AUTO_INCREMENT for table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=163;

--
-- AUTO_INCREMENT for table `project_pays`
--
ALTER TABLE `project_pays`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `project_quotation`
--
ALTER TABLE `project_quotation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `salary`
--
ALTER TABLE `salary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `workedProjects`
--
ALTER TABLE `workedProjects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=903;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agreement`
--
ALTER TABLE `agreement`
  ADD CONSTRAINT `projectId` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `checks_imgs`
--
ALTER TABLE `checks_imgs`
  ADD CONSTRAINT `payFk` FOREIGN KEY (`payId`) REFERENCES `project_pays` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `employeeDailyWage`
--
ALTER TABLE `employeeDailyWage`
  ADD CONSTRAINT `id` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `employeesTimeSheet`
--
ALTER TABLE `employeesTimeSheet`
  ADD CONSTRAINT `fk_employeeId` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `project_pays`
--
ALTER TABLE `project_pays`
  ADD CONSTRAINT `projectFK` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `project_quotation`
--
ALTER TABLE `project_quotation`
  ADD CONSTRAINT `projectQFK` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `salary`
--
ALTER TABLE `salary`
  ADD CONSTRAINT `empFK` FOREIGN KEY (`employeeId`) REFERENCES `employee` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `workedProjects`
--
ALTER TABLE `workedProjects`
  ADD CONSTRAINT `pk_dayId` FOREIGN KEY (`dayId`) REFERENCES `employeesTimeSheet` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pk_projectId` FOREIGN KEY (`projectId`) REFERENCES `projects` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
