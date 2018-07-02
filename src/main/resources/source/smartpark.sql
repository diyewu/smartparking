/*
Navicat MySQL Data Transfer

Source Server         : 118.24.85.246_成都
Source Server Version : 50611
Source Host           : 118.24.85.246:3306
Source Database       : smartpark

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2018-07-02 10:39:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for location_area
-- ----------------------------
DROP TABLE IF EXISTS `location_area`;
CREATE TABLE `location_area` (
  `name` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of location_area
-- ----------------------------
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.392987,31.162703');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.383636,31.163446');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.386986,31.153154');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.388369,31.139664');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.391962,31.132678');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.400676,31.135275');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.398107,31.146077');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.402455,31.147282');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.406443,31.149878');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.406623,31.149786');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.408851,31.143635');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.413162,31.145861');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.416217,31.147808');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.416217,31.148271');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.415857,31.150713');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.41672,31.151207');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.40921,31.168265');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.401233,31.165268');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.402239,31.161683');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.394693,31.159705');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.393975,31.162796');
INSERT INTO `location_area` VALUES ('上海市静安区古美街道', '121.383636,31.163446');

-- ----------------------------
-- Table structure for smart_car
-- ----------------------------
DROP TABLE IF EXISTS `smart_car`;
CREATE TABLE `smart_car` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `member_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `car_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `car_owner_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '车辆拥有者',
  `car_type` int(2) DEFAULT NULL,
  `create_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_car
-- ----------------------------
INSERT INTO `smart_car` VALUES ('0015289415734270000100163c5bc4c4', '0015289415565600000000163c5bc4c4', '苏Q14456', '0015289415565600000000163c5bc4c4', '1', '2018-06-14 09:59:33', '2018-06-14 09:59:33');
INSERT INTO `smart_car` VALUES ('0015289415883020000200163c5bc4c4', '0015289415565600000000163c5bc4c4', '苏W34565', '0015289415565600000000163c5bc4c4', '1', '2018-06-14 09:59:48', '2018-06-14 09:59:48');
INSERT INTO `smart_car` VALUES ('0015304357921050000152540045a4a7', '0015304356972170000052540045a4a7', '豫E6777T', '0015304356972170000052540045a4a7', '1', '2018-07-01 17:03:12', '2018-07-01 17:03:12');

-- ----------------------------
-- Table structure for smart_car_owner
-- ----------------------------
DROP TABLE IF EXISTS `smart_car_owner`;
CREATE TABLE `smart_car_owner` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `owner_phone` int(20) DEFAULT NULL,
  `create_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `member_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_car_owner
-- ----------------------------

-- ----------------------------
-- Table structure for smart_car_park_record
-- ----------------------------
DROP TABLE IF EXISTS `smart_car_park_record`;
CREATE TABLE `smart_car_park_record` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `car_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `park_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `space_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entrance_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parking_type` int(1) DEFAULT NULL COMMENT '停车类型，0：驶入 1 驶出',
  `create_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci COMMENT '说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_car_park_record
-- ----------------------------
INSERT INTO `smart_car_park_record` VALUES ('0015289419121300001900163c5bc4c4', '0015289415734270000100163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-14 10:05:12', null);
INSERT INTO `smart_car_park_record` VALUES ('0015289439900900000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-14 10:39:50', null);
INSERT INTO `smart_car_park_record` VALUES ('0015289691399980000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-14 17:39:00', null);
INSERT INTO `smart_car_park_record` VALUES ('0015289704701000000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-14 18:01:10', null);
INSERT INTO `smart_car_park_record` VALUES ('0015290422626100000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-15 13:57:42', null);
INSERT INTO `smart_car_park_record` VALUES ('0015290485163240000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-15 15:41:56', null);
INSERT INTO `smart_car_park_record` VALUES ('0015290526720260000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-15 16:51:12', null);
INSERT INTO `smart_car_park_record` VALUES ('0015290536485900000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-15 17:07:28', null);
INSERT INTO `smart_car_park_record` VALUES ('0015290556514830000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-15 17:40:51', null);
INSERT INTO `smart_car_park_record` VALUES ('0015290567716020000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-15 17:59:31', null);
INSERT INTO `smart_car_park_record` VALUES ('0015290574232840000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-15 18:10:23', null);
INSERT INTO `smart_car_park_record` VALUES ('0015291044121200000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-16 07:13:32', null);
INSERT INTO `smart_car_park_record` VALUES ('0015291058820120000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-16 07:38:02', null);
INSERT INTO `smart_car_park_record` VALUES ('0015291090807030000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-16 08:31:20', null);
INSERT INTO `smart_car_park_record` VALUES ('0015291121430290000300163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-16 09:22:23', null);
INSERT INTO `smart_car_park_record` VALUES ('0015291150312240000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-16 10:10:31', null);
INSERT INTO `smart_car_park_record` VALUES ('0015291161136870000100163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-16 10:28:33', null);
INSERT INTO `smart_car_park_record` VALUES ('0015302429954430000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-29 11:29:55', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303254104930000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 10:23:30', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303254652330000352540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 10:24:25', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303265646600000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 10:42:44', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303268784610000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 10:47:58', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303269771070000352540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 10:49:37', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303281496910000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 11:09:09', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303284061220000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 11:13:26', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303292033050000352540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 11:26:43', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303358391260000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 13:17:19', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303406658830000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 14:37:45', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303417786260000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 14:56:18', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303419619890000352540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 14:59:21', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303669176980000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 21:55:17', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303671729230000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 21:59:32', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303674155960000352540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 22:03:35', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303676667440000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 22:07:46', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303685900130000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 22:23:10', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303686557330000352540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 22:24:15', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303687758890000552540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 22:26:15', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303689150000000752540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 22:28:35', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303690220070000952540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 22:30:22', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303702367800000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 22:50:36', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303704545160000352540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-06-30 22:54:14', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303949897770000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 05:43:09', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303958252350000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 05:57:05', null);
INSERT INTO `smart_car_park_record` VALUES ('0015303961413110000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 06:02:21', null);
INSERT INTO `smart_car_park_record` VALUES ('0015304041125770000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 08:15:12', null);
INSERT INTO `smart_car_park_record` VALUES ('0015304046941540000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 08:24:54', null);
INSERT INTO `smart_car_park_record` VALUES ('0015304087871440000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 09:33:07', null);
INSERT INTO `smart_car_park_record` VALUES ('0015304092908280000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 09:41:30', null);
INSERT INTO `smart_car_park_record` VALUES ('0015304101542960000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 09:55:54', null);
INSERT INTO `smart_car_park_record` VALUES ('0015304105003000000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 10:01:40', null);
INSERT INTO `smart_car_park_record` VALUES ('0015304124161470000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 10:33:36', null);
INSERT INTO `smart_car_park_record` VALUES ('0015304338711530000152540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', null, '0', '2018-07-01 16:31:11', null);
INSERT INTO `smart_car_park_record` VALUES ('0015304342463910000952540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418030610000300163c5bc4c4', '0015289418032970000400163c5bc4c4', null, '0', '2018-07-01 16:37:26', null);

-- ----------------------------
-- Table structure for smart_member
-- ----------------------------
DROP TABLE IF EXISTS `smart_member`;
CREATE TABLE `smart_member` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `member_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '会员名称',
  `member_sex` int(1) DEFAULT NULL COMMENT '性别,0 女性，1 男性,2 未知',
  `create_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `open_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `member_open_id` (`open_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_member
-- ----------------------------
INSERT INTO `smart_member` VALUES ('0015304356972170000052540045a4a7', null, null, '2018-07-01 17:01:37', '2018-07-01 17:01:37', 'oqH-90aLdhE9em9ej4JwBvmPXGxw', '18936483081');

-- ----------------------------
-- Table structure for smart_mobile_code_send
-- ----------------------------
DROP TABLE IF EXISTS `smart_mobile_code_send`;
CREATE TABLE `smart_mobile_code_send` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_send_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` int(6) DEFAULT NULL,
  `remain_time` int(2) DEFAULT '10' COMMENT '当天手机验证码剩余次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `mobile_code_number` (`mobile`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_mobile_code_send
-- ----------------------------
INSERT INTO `smart_mobile_code_send` VALUES ('1', '18936483081', '2018-07-01 17:01:30', '443789', '9');
INSERT INTO `smart_mobile_code_send` VALUES ('2', '1111111111', '2018-05-08 15:09:38', '122121', '10');
INSERT INTO `smart_mobile_code_send` VALUES ('3', '18717743728', '2018-06-08 11:01:42', '797957', '10');

-- ----------------------------
-- Table structure for smart_mobile_code_send_history
-- ----------------------------
DROP TABLE IF EXISTS `smart_mobile_code_send_history`;
CREATE TABLE `smart_mobile_code_send_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_code` int(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mobilesend_his_mobile` (`mobile`) USING BTREE,
  KEY `mobilesend_his_time` (`send_time`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_mobile_code_send_history
-- ----------------------------
INSERT INTO `smart_mobile_code_send_history` VALUES ('1', '18936483081', '2018-06-04 10:48:05', '972946');
INSERT INTO `smart_mobile_code_send_history` VALUES ('2', '18936483081', '2018-06-14 09:59:06', '245926');
INSERT INTO `smart_mobile_code_send_history` VALUES ('3', '18936483081', '2018-07-01 17:01:30', '443789');

-- ----------------------------
-- Table structure for smart_order
-- ----------------------------
DROP TABLE IF EXISTS `smart_order`;
CREATE TABLE `smart_order` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `car_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `park_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `space_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order_type` int(1) DEFAULT NULL COMMENT '订单类型：0:实时停车  1:预约停车',
  `order_state_id` int(2) DEFAULT NULL,
  `begin_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `end_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `receivable_amount` double DEFAULT NULL COMMENT '应收费用',
  `actual_amount` double DEFAULT NULL COMMENT '实收费用',
  `create_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_way_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付渠道',
  `record_in_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '驶入记录id',
  `record_out_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '驶出记录id',
  `order_refund_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '退款订单编号',
  `transaction_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信订单号-微信生成的订单号，在支付通知中有返回',
  `total_fee` double DEFAULT NULL COMMENT '应收总金额',
  `cash_fee` double DEFAULT NULL COMMENT '实收金额',
  `coupon_fee` double DEFAULT NULL COMMENT '优惠券金额',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_order
-- ----------------------------
INSERT INTO `smart_order` VALUES ('0015304338688470000052540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '4', '2018-07-01 16:31:11', '2018-07-01 16:31:13', '0.01', null, '2018-07-01 16:31:08', null, '0015304338711530000152540045a4a7', null, null, '4200000127201807013812811015', null, null, null);
INSERT INTO `smart_order` VALUES ('0015304342442910000852540045a4a7', '0015289415883020000200163c5bc4c4', '0015289418030610000300163c5bc4c4', '0015289418032970000400163c5bc4c4', '0', '3', '2018-07-01 16:37:26', '2018-07-01 16:37:28', '0.01', null, '2018-07-01 16:37:24', null, '0015304342463910000952540045a4a7', null, null, null, null, null, null);

-- ----------------------------
-- Table structure for smart_order_refund
-- ----------------------------
DROP TABLE IF EXISTS `smart_order_refund`;
CREATE TABLE `smart_order_refund` (
  `id` varchar(50) NOT NULL,
  `create_time` varchar(30) DEFAULT NULL,
  `update_time` varchar(30) DEFAULT NULL,
  `refund_fee` int(11) DEFAULT NULL COMMENT '退款金额，退款总金额,单位为分,可以做部分退款',
  `settlement_refund_fee` int(11) DEFAULT NULL COMMENT '应结退款金额，去掉非充值代金券退款金额后的退款金额，退款金额=申请退款金额-非充值代金券退款金额，退款金额<=申请退款金额',
  `total_fee` int(11) DEFAULT NULL COMMENT '标价金额,订单总金额，单位为分，只能为整数',
  `settlement_total_fee` int(11) DEFAULT NULL COMMENT '应结订单金额,去掉非充值代金券金额后的订单总金额，应结订单金额=订单金额-非充值代金券金额，应结订单金额<=订单金额。',
  `fee_type` varchar(20) DEFAULT NULL COMMENT '标价币种',
  `cash_fee` int(11) DEFAULT NULL COMMENT '现金支付金额',
  `cash_fee_type` varchar(20) DEFAULT NULL COMMENT '现金支付币种',
  `cash_refund_fee` int(11) DEFAULT NULL COMMENT '现金退款金额',
  `coupon` text COMMENT '代金券,json格式，包括单个代金券退款金额，退款代金券ID',
  `coupon_refund_fee` int(11) DEFAULT NULL COMMENT '代金券退款总金额',
  `coupon_refund_count` int(11) DEFAULT NULL COMMENT '退款代金券使用数量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smart_order_refund
-- ----------------------------

-- ----------------------------
-- Table structure for smart_order_state_dictionory
-- ----------------------------
DROP TABLE IF EXISTS `smart_order_state_dictionory`;
CREATE TABLE `smart_order_state_dictionory` (
  `id` int(2) DEFAULT NULL,
  `state_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `show_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_order_state_dictionory
-- ----------------------------
INSERT INTO `smart_order_state_dictionory` VALUES ('0', '完结，正常驶出停车场', '完结');
INSERT INTO `smart_order_state_dictionory` VALUES ('1', '申请驶进停车场', '申请驶入');
INSERT INTO `smart_order_state_dictionory` VALUES ('2', '停车中', '停车中');
INSERT INTO `smart_order_state_dictionory` VALUES ('3', '申请驶出停车场，待支付', '待支付');
INSERT INTO `smart_order_state_dictionory` VALUES ('4', '支付完成，待出场', '待出场');
INSERT INTO `smart_order_state_dictionory` VALUES ('5', '强制完结，无法正常完结', '异常');
INSERT INTO `smart_order_state_dictionory` VALUES ('6', '取消', '取消');
INSERT INTO `smart_order_state_dictionory` VALUES ('7', '已退款', '已退款');

-- ----------------------------
-- Table structure for smart_park
-- ----------------------------
DROP TABLE IF EXISTS `smart_park`;
CREATE TABLE `smart_park` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `park_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '场地名称',
  `park_description` text COLLATE utf8mb4_unicode_ci COMMENT '描述',
  `park_longitude` double DEFAULT NULL COMMENT '停车经度',
  `park_latitude` double DEFAULT NULL COMMENT '停车场维度',
  `support_mobile_pay` int(1) DEFAULT '0' COMMENT '0: 支持 1 不支持',
  `create_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manager_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '场地管理员编号，场地管理员或后台操作管理员不能同时为空',
  `operate_user_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '后台操作管理员编号,场地管理员或后台操作管理员不能同时为空',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_park
-- ----------------------------
INSERT INTO `smart_park` VALUES ('0015289418030610000300163c5bc4c4', '江桥万达B1', '啊啊啊啊啊啊啊', '121.473', '31.25', '0', '2018-06-14 10:03:23', '2018-06-14 10:03:23', 'null', null);
INSERT INTO `smart_park` VALUES ('0015289418593630001300163c5bc4c4', '江桥万达B2', '啊啊啊啊啊啊啊', '121.473', '31.25', '0', '2018-06-14 10:04:19', '2018-06-14 10:04:19', 'null', null);

-- ----------------------------
-- Table structure for smart_park_entrance
-- ----------------------------
DROP TABLE IF EXISTS `smart_park_entrance`;
CREATE TABLE `smart_park_entrance` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `park_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entrance_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '入口名称',
  `entrance_longitude` double DEFAULT NULL COMMENT '经度',
  `entrance_latitude` double DEFAULT NULL COMMENT '纬度',
  `entrance_description` text COLLATE utf8mb4_unicode_ci,
  `create_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_park_entrance
-- ----------------------------
INSERT INTO `smart_park_entrance` VALUES ('00152618393378800006', '00152618393373100004', '正门-阿萨大声道了', '121.239131', '31.015213', '啊实打实大师', '2018-05-13 11:58:53', '2018-05-13 11:58:53');
INSERT INTO `smart_park_entrance` VALUES ('00152618401477300008', '00152618401473500007', '正门-阿萨大声道了', '121.239131', '31.015213', '啊实打实大师', '2018-05-13 12:00:14', '2018-05-13 12:00:14');
INSERT INTO `smart_park_entrance` VALUES ('00152618412974200012', '00152618412961800010', '正门', '121.409973', '30.805171', '啊四大四大撒多', '2018-05-13 12:02:09', '2018-05-13 12:02:09');
INSERT INTO `smart_park_entrance` VALUES ('00152618430185500014', '00152618430181300013', '1111', '121.411439', '30.803186', '啊实打实的', '2018-05-13 12:05:01', '2018-05-13 12:05:01');
INSERT INTO `smart_park_entrance` VALUES ('00152618430185500015', '00152618430181300013', '2222', '2222', '31.015213', '啊四大四大撒多', '2018-05-13 12:05:01', '2018-05-13 12:05:01');
INSERT INTO `smart_park_entrance` VALUES ('00152618440635600021', '00152618440631400018', '1111', '121.411439', '30.803186', '啊实打实的', '2018-05-13 12:06:46', '2018-05-13 12:06:46');
INSERT INTO `smart_park_entrance` VALUES ('00152618440635700022', '00152618440631400018', '2222', '2222', '31.015213', '啊四大四大撒多', '2018-05-13 12:06:46', '2018-05-13 12:06:46');
INSERT INTO `smart_park_entrance` VALUES ('0015289418036860000600163c5bc4c4', '0015289418030610000300163c5bc4c4', '正门', '121.473', '31.25', '阿萨阿萨', '2018-06-14 10:03:23', '2018-06-14 10:03:23');
INSERT INTO `smart_park_entrance` VALUES ('0015289418178590001000163c5bc4c4', '0015289418175980000800163c5bc4c4', '正门', '121.473', '31.25', '阿萨阿萨', '2018-06-14 10:03:37', '2018-06-14 10:03:37');
INSERT INTO `smart_park_entrance` VALUES ('0015289418596060001600163c5bc4c4', '0015289418593630001300163c5bc4c4', '正门', '121.473', '31.25', '阿萨阿萨', '2018-06-14 10:04:19', '2018-06-14 10:04:19');

-- ----------------------------
-- Table structure for smart_park_space
-- ----------------------------
DROP TABLE IF EXISTS `smart_park_space`;
CREATE TABLE `smart_park_space` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `park_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `space_type` int(2) DEFAULT NULL COMMENT '车位类型，无分类统一为0',
  `space_total` int(11) DEFAULT NULL COMMENT '类型车位总数',
  `space_used` int(11) DEFAULT NULL COMMENT '已占用停车位',
  `space_price_perhour` double DEFAULT NULL COMMENT '类型车位每小时停车费价格',
  `space_description` text COLLATE utf8mb4_unicode_ci,
  `create_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_park_space
-- ----------------------------
INSERT INTO `smart_park_space` VALUES ('00152618440634800019', '00152618440631400018', '2', '3345', '222', '33', '撒打算', '2018-05-13 12:06:46', '2018-05-13 12:06:46');
INSERT INTO `smart_park_space` VALUES ('00152618440635000020', '00152618440631400018', '1', '1112', '11', '14', '啊实打实', '2018-05-13 12:06:46', '2018-05-13 12:06:46');
INSERT INTO `smart_park_space` VALUES ('0015289418032970000400163c5bc4c4', '0015289418030610000300163c5bc4c4', '1', '200', '11', '0.02', 'assaas', '2018-06-14 10:03:23', '2018-06-14 10:03:23');
INSERT INTO `smart_park_space` VALUES ('0015289418037100000700163c5bc4c4', '0015289418030610000300163c5bc4c4', '2', '333', '111', '0.02', 'asassa', '2018-06-14 10:03:23', '2018-06-14 10:03:23');
INSERT INTO `smart_park_space` VALUES ('0015289418178580000900163c5bc4c4', '0015289418175980000800163c5bc4c4', '2', '333', '111', '0.02', 'asassa', '2018-06-14 10:03:37', '2018-06-14 10:03:37');
INSERT INTO `smart_park_space` VALUES ('0015289418178630001100163c5bc4c4', '0015289418175980000800163c5bc4c4', '1', '200', '11', '0.02', 'assaas', '2018-06-14 10:03:37', '2018-06-14 10:03:37');
INSERT INTO `smart_park_space` VALUES ('0015289418595880001400163c5bc4c4', '0015289418593630001300163c5bc4c4', '2', '333', '111', '0.02', 'asassa', '2018-06-14 10:04:19', '2018-06-14 10:04:19');
INSERT INTO `smart_park_space` VALUES ('0015289418595900001500163c5bc4c4', '0015289418593630001300163c5bc4c4', '1', '200', '11', '0.02', 'assaas', '2018-06-14 10:04:19', '2018-06-14 10:04:19');

-- ----------------------------
-- Table structure for smart_park_space_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `smart_park_space_dictionary`;
CREATE TABLE `smart_park_space_dictionary` (
  `id` int(11) NOT NULL,
  `space_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `space_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_park_space_dictionary
-- ----------------------------
INSERT INTO `smart_park_space_dictionary` VALUES ('1', '地上停车位', '1');
INSERT INTO `smart_park_space_dictionary` VALUES ('2', '地下停车位', '2');

-- ----------------------------
-- Table structure for smart_pay_detail_record
-- ----------------------------
DROP TABLE IF EXISTS `smart_pay_detail_record`;
CREATE TABLE `smart_pay_detail_record` (
  `id` varchar(50) NOT NULL,
  `order_id` varchar(50) DEFAULT NULL COMMENT '订单编号',
  `type` int(2) DEFAULT NULL COMMENT '类型：0，获取预支付ID；1，查询订单结果；2、微信通知；3，申请退款;4、查询退款结果',
  `description` text,
  `create_time` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `paydetail_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of smart_pay_detail_record
-- ----------------------------
INSERT INTO `smart_pay_detail_record` VALUES ('0015304041416910000252540045a4a7', '0015304041103720000052540045a4a7', '0', '{\"nonce_str\":\"8hCde5oYYjyJ99Z6\",\"device_info\":\"WEB\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"FF03F8EC9EA297C90DEDBB517DD0CF83\",\"trade_type\":\"JSAPI\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx01081541577590918d7dd45e3610060925\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304041485420000352540045a4a7', '0015304041103720000052540045a4a7', '2', '{\"transaction_id\":\"4200000121201807014217192938\",\"nonce_str\":\"ea9f4a1de89243169ac1049f13543a1e\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"5C20258068F44241F4BD9DF331EC9DDA\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304041103720000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"time_end\":\"20180701081547\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304047704650000252540045a4a7', '0015304046918590000052540045a4a7', '0', '{\"nonce_str\":\"dX19lHtsd220qK7f\",\"device_info\":\"WEB\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"30B8420A4D1B1C2191E2CB8E6A3996C1\",\"trade_type\":\"JSAPI\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx01082610377632f3283271e44291307683\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304047781530000352540045a4a7', '0015304046918590000052540045a4a7', '2', '{\"transaction_id\":\"4200000123201807010834772926\",\"nonce_str\":\"05c4dc235a3744ee841a72805be2f7eb\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"02ABE1B31AD1F2341CC7017042CBF57E\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304046918590000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"time_end\":\"20180701082617\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304088185900000252540045a4a7', '0015304087853200000052540045a4a7', '0', '{\"nonce_str\":\"n3vk3wgadO1DndIc\",\"device_info\":\"WEB\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"B6DF4ABF58A283DE360A2A811B41BE28\",\"trade_type\":\"JSAPI\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx01093338486115bfa4e33c4f0442118302\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304093252300000252540045a4a7', '0015304092884570000052540045a4a7', '0', '{\"nonce_str\":\"y5wL23C8zmTmRVVN\",\"device_info\":\"WEB\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"B09E86ABF0460E78B23D386CCD5FFF91\",\"trade_type\":\"JSAPI\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx0109420508942020611fc1d51439594077\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304101774440000252540045a4a7', '0015304101524730000052540045a4a7', '0', '{\"nonce_str\":\"rNdcASwW14yGq7it\",\"device_info\":\"WEB\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"81EA59E0EAE75D3B63E9343D3AF4BCE8\",\"trade_type\":\"JSAPI\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx0109561729052870bb4b84604222536208\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304101777790000352540045a4a7', '0015304101524730000052540045a4a7', '1', '{\"nonce_str\":\"5TAXuS8Y5ThPdg50\",\"out_trade_no\":\"0015304101524730000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"8D019917A41F23D62955DE26E71D01E8\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304101826850000452540045a4a7', '0015304101524730000052540045a4a7', '1', '{\"nonce_str\":\"S7qUb11qQoLeJ1xh\",\"out_trade_no\":\"0015304101524730000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"1A577A10FC4B4479779FA98587B477D6\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304101850820000552540045a4a7', '0015304101524730000052540045a4a7', '2', '{\"transaction_id\":\"4200000121201807010150643215\",\"nonce_str\":\"ef9ad281e3654588a91f0ba2a4ff4235\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"13C0682209077FC2AF32E4C93B09B09A\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304101524730000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"time_end\":\"20180701095623\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304101854050000652540045a4a7', '0015304101524730000052540045a4a7', '1', '{\"transaction_id\":\"4200000121201807010150643215\",\"nonce_str\":\"xVpYHwAR47lADiGL\",\"trade_state\":\"SUCCESS\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"BA8935932D32EC89648CFBFB9461F523\",\"return_msg\":\"OK\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304101524730000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_state_desc\":\"支付成功\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"attach\":\"\",\"time_end\":\"20180701095623\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304101877800000752540045a4a7', '0015304101524730000052540045a4a7', '1', '{\"transaction_id\":\"4200000121201807010150643215\",\"nonce_str\":\"Zfbk2EFdO10hRcvy\",\"trade_state\":\"SUCCESS\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"A7ACC2BA14656D6149A30EC1C35177BD\",\"return_msg\":\"OK\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304101524730000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_state_desc\":\"支付成功\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"attach\":\"\",\"time_end\":\"20180701095623\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304105367900000252540045a4a7', '0015304104911250000052540045a4a7', '0', '{\"nonce_str\":\"tdDd3hk6sCQB2G9W\",\"device_info\":\"WEB\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"01F2B3D31457BDB8878EC59A743DE01C\",\"trade_type\":\"JSAPI\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx011002167049264198a2059c2834963027\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304105372330000352540045a4a7', '0015304104911250000052540045a4a7', '1', '{\"nonce_str\":\"Qyx9P73V0wAk5oRc\",\"out_trade_no\":\"0015304104911250000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"B0AFFE1E85D49718A417D1FCCA72E837\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304105422640000452540045a4a7', '0015304104911250000052540045a4a7', '1', '{\"nonce_str\":\"dJOEJGsQqwoMHwT6\",\"out_trade_no\":\"0015304104911250000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"FC83F5E2F513630CA7B6F2298104DDA4\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304105467550000552540045a4a7', '0015304104911250000052540045a4a7', '2', '{\"transaction_id\":\"4200000127201807011778884765\",\"nonce_str\":\"0a3b15b93305416cb6a83ce2f8640562\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"5E280BA5FB42115B1FD305A722E34B69\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304104911250000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"time_end\":\"20180701100225\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304105470670000652540045a4a7', '0015304104911250000052540045a4a7', '1', '{\"transaction_id\":\"4200000127201807011778884765\",\"nonce_str\":\"861z9Sh9lkbNaZiU\",\"trade_state\":\"SUCCESS\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"1B5E88B69D039C13F22E0D45AE566A88\",\"return_msg\":\"OK\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304104911250000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_state_desc\":\"支付成功\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"attach\":\"\",\"time_end\":\"20180701100225\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304105475300000752540045a4a7', '0015304104911250000052540045a4a7', '1', '{\"transaction_id\":\"4200000127201807011778884765\",\"nonce_str\":\"bpbhXEjwHvPjZBp8\",\"trade_state\":\"SUCCESS\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"BBC2C84B5D4D8049FC62873EAE592101\",\"return_msg\":\"OK\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304104911250000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_state_desc\":\"支付成功\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"attach\":\"\",\"time_end\":\"20180701100225\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', null);
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124554520000252540045a4a7', '0015304124142750000052540045a4a7', '0', '{\"nonce_str\":\"SBFfB7coGGc3yjC5\",\"device_info\":\"WEB\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"2D620B66023BEDEEE5E8B305AC33EEA8\",\"trade_type\":\"JSAPI\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx011034153464159fd75001410436575191\"}', '2018-07-01 10:34:15');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124557570000352540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"HCbdLRVU5iiIGfqg\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"3A385B21BEE810187E7E8570047F1CEE\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:15');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124606910000452540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"kItLPmbEMt0zYew1\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"02E87D8A5B3AB207734ABEA589E83F9A\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:20');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124660570000552540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"4tfbumCVZNhf77nr\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"3A1F68423B1148873229CCED12F5B794\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:26');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124663400000652540045a4a7', '0015304124142750000052540045a4a7', '0', '{\"nonce_str\":\"rm7JtrgpV5gyHLOJ\",\"device_info\":\"WEB\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"F5C616A4DC6786DC1D4CA727CA61B52C\",\"trade_type\":\"JSAPI\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx011034262578569fd75001412728579544\"}', '2018-07-01 10:34:26');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124665710000752540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"CA7nsnJpQbiCmA1U\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"A26DF91DBE45DBE31CDE28B686011596\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:26');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124707220000852540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"8donx6G7aB8Vt96V\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"2CCB5A3850B3860FD8E8ED3FA86DD2BC\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:30');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124718230000952540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"YZa8ZrPZbmu5pZmd\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"576FFC5E24FF2EF05C04EE867F0DE370\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:31');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124757040001052540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"dvY4YMSjNiKR76l8\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"1B82A001D3D4117E80677C4D75F0893E\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:35');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124765420001152540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"8BScYAqriyegA7Iy\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"4C81E78AF6022AB3F11EB085AC2AEF3E\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:36');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124806770001252540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"OMdQhvTSATAvJqJo\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"1007FA9DB7FBE224BB79221CDEB442A5\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:40');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124815630001352540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"Walokyc1zVCcGxnF\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"D510BBB74C82FD2C64364D428E111489\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:41');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124857130001452540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"wFJLNcuA6UTHZKPZ\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"C5FE549BA442E15E535E344B4EEB0CE9\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:45');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304124865390001552540045a4a7', '0015304124142750000052540045a4a7', '1', '{\"nonce_str\":\"46EafVwYEltDfPSP\",\"out_trade_no\":\"0015304124142750000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"5E252774A591116CB944176A05989AAB\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 10:34:46');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304339410520000252540045a4a7', '0015304338688470000052540045a4a7', '0', '{\"nonce_str\":\"1uWl2qOLhnKH5fKp\",\"device_info\":\"WEB\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"A549D10B11F02C226FD29805302B9A0D\",\"trade_type\":\"JSAPI\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\",\"prepay_id\":\"wx011632209296891d76fe0ac43700000108\"}', '2018-07-01 16:32:21');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304339413580000352540045a4a7', '0015304338688470000052540045a4a7', '1', '{\"nonce_str\":\"c0i5aUW8JCIcupy6\",\"out_trade_no\":\"0015304338688470000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"BAD547D626589784E631B9E2BF397DBE\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 16:32:21');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304339463890000452540045a4a7', '0015304338688470000052540045a4a7', '1', '{\"nonce_str\":\"wmkIMGwTDSR8jMuY\",\"out_trade_no\":\"0015304338688470000052540045a4a7\",\"trade_state\":\"NOTPAY\",\"appid\":\"wx4307e5a5bb1ced6c\",\"sign\":\"33E5511E2C574CFC4F3186CADFC342B2\",\"trade_state_desc\":\"订单未支付\",\"return_msg\":\"OK\",\"result_code\":\"SUCCESS\",\"mch_id\":\"1505894581\",\"return_code\":\"SUCCESS\"}', '2018-07-01 16:32:26');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304339505800000552540045a4a7', '0015304338688470000052540045a4a7', '2', '{\"transaction_id\":\"4200000127201807013812811015\",\"nonce_str\":\"82dc482a05d4438c8234d9c131abf412\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"C4EC54C6ACC3BC70ECE3774BE573CB78\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304338688470000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"time_end\":\"20180701163229\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', '2018-07-01 16:32:30');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304339509000000652540045a4a7', '0015304338688470000052540045a4a7', '1', '{\"transaction_id\":\"4200000127201807013812811015\",\"nonce_str\":\"zaA8bXLhYqSIE8Hn\",\"trade_state\":\"SUCCESS\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"75F01A6DDD064507FAF3E50B51827042\",\"return_msg\":\"OK\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304338688470000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_state_desc\":\"支付成功\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"attach\":\"\",\"time_end\":\"20180701163229\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', '2018-07-01 16:32:30');
INSERT INTO `smart_pay_detail_record` VALUES ('0015304339513730000752540045a4a7', '0015304338688470000052540045a4a7', '1', '{\"transaction_id\":\"4200000127201807013812811015\",\"nonce_str\":\"A0hkz2fsreGKhaYl\",\"trade_state\":\"SUCCESS\",\"bank_type\":\"CFT\",\"openid\":\"oqH-90aLdhE9em9ej4JwBvmPXGxw\",\"sign\":\"BCC52DF63451A0188AFE55C4D9851C6E\",\"return_msg\":\"OK\",\"fee_type\":\"CNY\",\"mch_id\":\"1505894581\",\"cash_fee\":\"1\",\"device_info\":\"WEB\",\"out_trade_no\":\"0015304338688470000052540045a4a7\",\"appid\":\"wx4307e5a5bb1ced6c\",\"total_fee\":\"1\",\"trade_state_desc\":\"支付成功\",\"trade_type\":\"JSAPI\",\"result_code\":\"SUCCESS\",\"attach\":\"\",\"time_end\":\"20180701163229\",\"is_subscribe\":\"Y\",\"return_code\":\"SUCCESS\"}', '2018-07-01 16:32:31');

-- ----------------------------
-- Table structure for smart_pay_way
-- ----------------------------
DROP TABLE IF EXISTS `smart_pay_way`;
CREATE TABLE `smart_pay_way` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pay_way` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付方式',
  `create_time` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_pay_way
-- ----------------------------
INSERT INTO `smart_pay_way` VALUES ('1', '微信', null);
INSERT INTO `smart_pay_way` VALUES ('2', '支付宝', null);

-- ----------------------------
-- Table structure for sqlmapoutput
-- ----------------------------
DROP TABLE IF EXISTS `sqlmapoutput`;
CREATE TABLE `sqlmapoutput` (
  `data` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sqlmapoutput
-- ----------------------------

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '1', '1', '1', '1', null);
INSERT INTO `t_user` VALUES ('2', 'zhao', null, null, null, null);
INSERT INTO `t_user` VALUES ('3', 'test', null, null, null, null);
