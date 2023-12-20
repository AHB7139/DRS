-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 21, 2023 at 12:33 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `drs_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `document_id` varchar(36) NOT NULL,
  `tracking_number` varchar(20) NOT NULL,
  `originating_office_id` int(11) DEFAULT NULL,
  `is_terminal` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`document_id`, `tracking_number`, `originating_office_id`, `is_terminal`, `created_at`) VALUES
('d11', 't11', 111, 1, '2023-12-20 08:39:08'),
('d12', 't12', 222, 1, '2023-12-20 23:22:58'),
('d13', 't13', 333, 0, '2023-12-20 23:28:22');

-- --------------------------------------------------------

--
-- Table structure for table `documenttrail`
--

CREATE TABLE `documenttrail` (
  `document_id` varchar(36) DEFAULT NULL,
  `office_id` int(11) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documenttrail`
--

INSERT INTO `documenttrail` (`document_id`, `office_id`, `timestamp`) VALUES
('d11', 333, '2023-12-20 16:42:40'),
('d11', 444, '2023-12-20 16:43:14'),
('d12', 333, '2023-12-21 07:23:29'),
('d12', 444, '2023-12-21 07:24:16');

-- --------------------------------------------------------

--
-- Table structure for table `offices`
--

CREATE TABLE `offices` (
  `office_id` int(11) NOT NULL,
  `office_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offices`
--

INSERT INTO `offices` (`office_id`, `office_name`) VALUES
(111, 'Office1'),
(222, 'Office2'),
(333, 'Office3'),
(444, 'Office4'),
(555, 'Office5');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`document_id`),
  ADD UNIQUE KEY `tracking_number` (`tracking_number`),
  ADD KEY `originating_office_id` (`originating_office_id`);

--
-- Indexes for table `documenttrail`
--
ALTER TABLE `documenttrail`
  ADD KEY `document_id` (`document_id`),
  ADD KEY `office_id` (`office_id`);

--
-- Indexes for table `offices`
--
ALTER TABLE `offices`
  ADD PRIMARY KEY (`office_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `offices`
--
ALTER TABLE `offices`
  MODIFY `office_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=556;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`originating_office_id`) REFERENCES `offices` (`office_id`);

--
-- Constraints for table `documenttrail`
--
ALTER TABLE `documenttrail`
  ADD CONSTRAINT `documenttrail_ibfk_1` FOREIGN KEY (`document_id`) REFERENCES `documents` (`document_id`),
  ADD CONSTRAINT `documenttrail_ibfk_2` FOREIGN KEY (`office_id`) REFERENCES `offices` (`office_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
