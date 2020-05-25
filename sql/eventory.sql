-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 25, 2020 at 08:12 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_client`
--

CREATE TABLE `tbl_client` (
  `clientID` int(200) NOT NULL,
  `userPhoto` varchar(200) DEFAULT NULL,
  `userPhone` varchar(12) DEFAULT NULL,
  `userAddress` varchar(100) DEFAULT NULL,
  `userGender` varchar(6) DEFAULT NULL,
  `accountID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_events`
--

CREATE TABLE `tbl_events` (
  `eventID` int(10) NOT NULL,
  `eventName` varchar(50) NOT NULL,
  `clientID` int(11) NOT NULL,
  `supplierID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_favorites`
--

CREATE TABLE `tbl_favorites` (
  `favoriteID` int(10) NOT NULL,
  `dateAdded` date NOT NULL,
  `clientID` int(11) NOT NULL,
  `supplierID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_reviews`
--

CREATE TABLE `tbl_reviews` (
  `reviewID` int(10) NOT NULL,
  `rating` double NOT NULL,
  `dateAdded` date NOT NULL,
  `comment` varchar(35) NOT NULL,
  `clientID` int(11) NOT NULL,
  `supplierID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_supplier`
--

CREATE TABLE `tbl_supplier` (
  `supplierID` int(10) NOT NULL,
  `image` varchar(50) DEFAULT NULL,
  `supplierPhone` varchar(12) DEFAULT NULL,
  `supplierAddress` varchar(50) DEFAULT NULL,
  `supplierGender` varchar(6) DEFAULT NULL,
  `supplierRate` int(8) DEFAULT NULL,
  `supplierYears` int(2) DEFAULT NULL,
  `supplierBio` varchar(200) DEFAULT NULL,
  `isAvailable` tinyint(1) DEFAULT NULL,
  `isFavorite` tinyint(1) DEFAULT NULL,
  `isVerified` tinyint(1) NOT NULL DEFAULT 0,
  `accountID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_supplier`
--

INSERT INTO `tbl_supplier` (`supplierID`, `image`, `supplierPhone`, `supplierAddress`, `supplierGender`, `supplierRate`, `supplierYears`, `supplierBio`, `isAvailable`, `isFavorite`, `isVerified`, `accountID`) VALUES
(47, NULL, '09067954506', 'Zone 11 Upper Carmen', NULL, 1000, 5, 'Tired being handsome', NULL, NULL, 0, 0),
(48, NULL, '09067954506', 'Zone 11 Upper Carmen', NULL, 1000, 5, 'Tired being handsome', NULL, NULL, 0, 0),
(49, NULL, '', '', NULL, 0, 0, '', NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tbl_useraccounts`
--

CREATE TABLE `tbl_useraccounts` (
  `accountID` int(10) NOT NULL,
  `fullName` varchar(50) NOT NULL,
  `email` varchar(50) CHARACTER SET latin1 NOT NULL,
  `password` varchar(50) CHARACTER SET latin1 NOT NULL,
  `accountType` varchar(50) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `tbl_useraccounts`
--

INSERT INTO `tbl_useraccounts` (`accountID`, `fullName`, `email`, `password`, `accountType`) VALUES
(18, 'Admin', 'admin@gmail.com', '123123', 'I am Client');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_client`
--
ALTER TABLE `tbl_client`
  ADD PRIMARY KEY (`clientID`),
  ADD KEY `accountID` (`accountID`);

--
-- Indexes for table `tbl_events`
--
ALTER TABLE `tbl_events`
  ADD PRIMARY KEY (`eventID`),
  ADD KEY `supplierID` (`supplierID`),
  ADD KEY `clientID` (`clientID`);

--
-- Indexes for table `tbl_favorites`
--
ALTER TABLE `tbl_favorites`
  ADD PRIMARY KEY (`favoriteID`),
  ADD KEY `supplierID` (`supplierID`),
  ADD KEY `clientID` (`clientID`);

--
-- Indexes for table `tbl_reviews`
--
ALTER TABLE `tbl_reviews`
  ADD PRIMARY KEY (`reviewID`),
  ADD KEY `supplierID` (`supplierID`),
  ADD KEY `clientID` (`clientID`);

--
-- Indexes for table `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  ADD PRIMARY KEY (`supplierID`),
  ADD KEY `accountID` (`accountID`);

--
-- Indexes for table `tbl_useraccounts`
--
ALTER TABLE `tbl_useraccounts`
  ADD PRIMARY KEY (`accountID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_client`
--
ALTER TABLE `tbl_client`
  MODIFY `clientID` int(200) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_events`
--
ALTER TABLE `tbl_events`
  MODIFY `eventID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tbl_favorites`
--
ALTER TABLE `tbl_favorites`
  MODIFY `favoriteID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_reviews`
--
ALTER TABLE `tbl_reviews`
  MODIFY `reviewID` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_supplier`
--
ALTER TABLE `tbl_supplier`
  MODIFY `supplierID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `tbl_useraccounts`
--
ALTER TABLE `tbl_useraccounts`
  MODIFY `accountID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
