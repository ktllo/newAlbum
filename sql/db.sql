-- phpMyAdmin SQL Dump
-- version 4.3.9
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 18, 2017 at 07:49 AM
-- Server version: 5.7.9-log
-- PHP Version: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `newalbum`
--

-- --------------------------------------------------------

--
-- Table structure for table `album`
--

DROP TABLE IF EXISTS `album`;
CREATE TABLE IF NOT EXISTS `album` (
  `albumId` varchar(32) CHARACTER SET ascii NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `description` text COLLATE utf8_bin NOT NULL,
  `created` date NOT NULL,
  `owner` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `album_photo`
--

DROP TABLE IF EXISTS `album_photo`;
CREATE TABLE IF NOT EXISTS `album_photo` (
  `albumId` varchar(32) CHARACTER SET ascii NOT NULL,
  `photoID` int(10) unsigned NOT NULL,
  `displayOrder` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `album_thumbnail`
--

DROP TABLE IF EXISTS `album_thumbnail`;
CREATE TABLE IF NOT EXISTS `album_thumbnail` (
  `albumId` varchar(32) CHARACTER SET ascii NOT NULL,
  `photoID` int(11) unsigned NOT NULL,
  `thumbnailID` smallint(6) unsigned NOT NULL,
  `probability` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `exif`
--

DROP TABLE IF EXISTS `exif`;
CREATE TABLE IF NOT EXISTS `exif` (
  `photoID` int(10) unsigned NOT NULL,
  `keyName` varchar(90) CHARACTER SET ascii NOT NULL,
  `keyValue` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
CREATE TABLE IF NOT EXISTS `photo` (
  `photoID` int(10) unsigned NOT NULL,
  `fileName` varchar(255) COLLATE utf8_bin NOT NULL,
  `owner` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `description` text CHARACTER SET utf8 NOT NULL,
  `fileSize` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `thumbnail`
--

DROP TABLE IF EXISTS `thumbnail`;
CREATE TABLE IF NOT EXISTS `thumbnail` (
  `photoID` int(10) unsigned NOT NULL,
  `thumbnailID` smallint(5) unsigned NOT NULL,
  `width` int(10) unsigned NOT NULL,
  `height` int(10) unsigned NOT NULL,
  `size` int(10) unsigned NOT NULL,
  `hash` char(40) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userId` int(10) unsigned NOT NULL,
  `userName` varchar(30) CHARACTER SET ascii NOT NULL,
  `password` varchar(255) CHARACTER SET ascii COLLATE ascii_bin NOT NULL,
  `created` datetime NOT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `last_pwd` datetime NOT NULL,
  `flags` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `album`
--
ALTER TABLE `album`
  ADD PRIMARY KEY (`albumId`), ADD KEY `owner` (`owner`);

--
-- Indexes for table `album_photo`
--
ALTER TABLE `album_photo`
  ADD PRIMARY KEY (`albumId`,`photoID`), ADD KEY `photoID` (`photoID`);

--
-- Indexes for table `album_thumbnail`
--
ALTER TABLE `album_thumbnail`
  ADD PRIMARY KEY (`albumId`,`photoID`,`thumbnailID`), ADD KEY `photoID` (`photoID`,`thumbnailID`);

--
-- Indexes for table `exif`
--
ALTER TABLE `exif`
  ADD PRIMARY KEY (`photoID`,`keyName`);

--
-- Indexes for table `photo`
--
ALTER TABLE `photo`
  ADD PRIMARY KEY (`photoID`), ADD KEY `owner` (`owner`), ADD FULLTEXT KEY `title` (`title`), ADD FULLTEXT KEY `description` (`description`);

--
-- Indexes for table `thumbnail`
--
ALTER TABLE `thumbnail`
  ADD PRIMARY KEY (`photoID`,`thumbnailID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `photo`
--
ALTER TABLE `photo`
  MODIFY `photoID` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userId` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `album`
--
ALTER TABLE `album`
ADD CONSTRAINT `album_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `user` (`userId`);

--
-- Constraints for table `album_photo`
--
ALTER TABLE `album_photo`
ADD CONSTRAINT `album_photo_ibfk_1` FOREIGN KEY (`albumId`) REFERENCES `album` (`albumId`),
ADD CONSTRAINT `album_photo_ibfk_2` FOREIGN KEY (`photoID`) REFERENCES `photo` (`photoID`);

--
-- Constraints for table `album_thumbnail`
--
ALTER TABLE `album_thumbnail`
ADD CONSTRAINT `album_thumbnail_ibfk_1` FOREIGN KEY (`albumId`) REFERENCES `album` (`albumId`),
ADD CONSTRAINT `album_thumbnail_ibfk_2` FOREIGN KEY (`photoID`, `thumbnailID`) REFERENCES `thumbnail` (`photoID`, `thumbnailID`);

--
-- Constraints for table `photo`
--
ALTER TABLE `photo`
ADD CONSTRAINT `photo_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `user` (`userId`);

--
-- Constraints for table `thumbnail`
--
ALTER TABLE `thumbnail`
ADD CONSTRAINT `thumbnail_ibfk_1` FOREIGN KEY (`photoID`) REFERENCES `photo` (`photoID`);

