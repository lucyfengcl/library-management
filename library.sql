CREATE DATABASE library;
USE library;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for book
-- ----------------------------
DROP TABLE IF EXISTS book;
CREATE TABLE book (
  ISBN int(14) UNSIGNED NOT NULL,
  BookName varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  Author varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  Introduction varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PublicationDate datetime(6) NULL DEFAULT NULL,
  Publisher varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  BorrowingTimes int(5) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (ISBN) USING BTREE,
  INDEX ISBN(ISBN) USING BTREE,
  INDEX ISBN_2(ISBN) USING BTREE,
  INDEX ISBN_3(ISBN) USING BTREE,
  INDEX ISBN_4(ISBN) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for booklist
-- ----------------------------
DROP TABLE IF EXISTS `booklist`;
CREATE TABLE booklist  (
  `BarCode` int(14) UNSIGNED NOT NULL,
  `ISBN` int(14) UNSIGNED NULL DEFAULT NULL,
  `State` int(1) UNSIGNED NULL DEFAULT NULL,
  `BorrowingRoom` int(10) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`BarCode`) USING BTREE,
  UNIQUE INDEX `BarCode_UNIQUE`(`BarCode`) USING BTREE,
  INDEX `ISBN_idx`(`ISBN`) USING BTREE,
  INDEX `BorrowingRoom_idx`(`BorrowingRoom`) USING BTREE,
  INDEX `BarCode`(`BarCode`) USING BTREE,
  CONSTRAINT `BorrowingRoom` FOREIGN KEY (`BorrowingRoom`) REFERENCES `borrowingroom` (`no.`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `ISBN` FOREIGN KEY (`ISBN`) REFERENCES `book` (`isbn`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for borrowcard
-- ----------------------------
DROP TABLE IF EXISTS `borrowcard`;
CREATE TABLE `borrowcard`  (
  `CID` int(10) UNSIGNED NOT NULL,
  `SID` int(10) UNSIGNED NOT NULL,
  `StudentName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `State` int(1) UNSIGNED NULL DEFAULT NULL,
  `Password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `TotalBorrowingTimes` int(5) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`CID`) USING BTREE,
  UNIQUE INDEX `CID_UNIQUE`(`CID`) USING BTREE,
  INDEX `SID_idx`(`SID`) USING BTREE,
  INDEX `CID`(`CID`) USING BTREE,
  CONSTRAINT `SID` FOREIGN KEY (`SID`) REFERENCES `student` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for borrowingroom
-- ----------------------------
DROP TABLE IF EXISTS `borrowingroom`;
CREATE TABLE `borrowingroom`  (
  `No.` int(10) UNSIGNED NOT NULL,
  `RoomName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`No.`) USING BTREE,
  INDEX `No.`(`No.`) USING BTREE,
  INDEX `No._2`(`No.`) USING BTREE,
  INDEX `No._3`(`No.`) USING BTREE,
  INDEX `No._4`(`No.`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for borrowrecord
-- ----------------------------
DROP TABLE IF EXISTS `borrowrecord`;
CREATE TABLE borrowrecord  (
  SerialNumber int(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  CID int(10) UNSIGNED NULL DEFAULT NULL,
  BarCode int(14) UNSIGNED NULL DEFAULT NULL,
  BorrowDate datetime NULL DEFAULT NULL,
  ReturnDate datetime NULL DEFAULT NULL,
  State int(1) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (SerialNumber) USING BTREE,
  UNIQUE INDEX `SerialNo.Borrow_UNIQUE`(`SerialNumber`) USING BTREE,
  INDEX `CID_idx`(`CID`) USING BTREE,
  INDEX `BarCode_idx`(`BarCode`) USING BTREE,
  INDEX `SerialNumber`(`SerialNumber`) USING BTREE,
  CONSTRAINT `BarCode` FOREIGN KEY (`BarCode`) REFERENCES `booklist` (`barcode`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `CID` FOREIGN KEY (`CID`) REFERENCES `borrowcard` (`cid`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for collectrecord
-- ----------------------------
DROP TABLE IF EXISTS `collectrecord`;
CREATE TABLE `collectrecord`  (
  `SerialNumber` int(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Date` datetime NULL DEFAULT NULL,
  `FineAmount` float(255, 2) NULL DEFAULT NULL,
  `Collector` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SerialNumber`) USING BTREE,
  INDEX `SerialNumber`(`SerialNumber`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for finerecord
-- ----------------------------
DROP TABLE IF EXISTS `finerecord`;
CREATE TABLE `finerecord`  (
  `SerialNumber` int(5) NOT NULL,
  `SerialNumberBorrow` int(5) UNSIGNED NOT NULL,
  `SerialNumberCollect` int(5) UNSIGNED NOT NULL,
  `OverDueDays` int(3) UNSIGNED NULL DEFAULT NULL,
  `FineAmount` float(255, 2) UNSIGNED NULL DEFAULT NULL,
  `State` int(1) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`SerialNumber`) USING BTREE,
  UNIQUE INDEX `SerialNumber_UNIQUE`(`SerialNumber`) USING BTREE,
  INDEX `SerialNumberBorrow_idx`(`SerialNumberBorrow`) USING BTREE,
  INDEX `SerialNumberCollect_idx`(`SerialNumberCollect`) USING BTREE,
  CONSTRAINT `SerialNumberBorrow` FOREIGN KEY (`SerialNumberBorrow`) REFERENCES `borrowrecord` (`serialnumber`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `SerialNumberCollect` FOREIGN KEY (`SerialNumberCollect`) REFERENCES `collectrecord` (`serialnumber`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student`  (
  `ID` int(10) UNSIGNED NOT NULL,
  `Name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `Gender` binary(1) NULL DEFAULT NULL,
  `Age` int(3) UNSIGNED NULL DEFAULT NULL,
  `Major` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NativePlace` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  INDEX `ID`(`ID`) USING BTREE,
  INDEX `ID_2`(`ID`) USING BTREE,
  INDEX `ID_3`(`ID`) USING BTREE,
  INDEX `ID_4`(`ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
