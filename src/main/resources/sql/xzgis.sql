/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50629
Source Host           : localhost:3306
Source Database       : xzgis

Target Server Type    : MYSQL
Target Server Version : 50629
File Encoding         : 65001

Date: 2018-03-16 18:35:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for color_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `color_dictionary`;
CREATE TABLE `color_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of color_dictionary
-- ----------------------------
INSERT INTO `color_dictionary` VALUES ('4', '#778a92', '<div style=\'background-color:#778a92;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('5', '#bbc9b7', '<div style=\'background-color:#bbc9b7;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('6', '#c98b6a', '<div style=\'background-color:#c98b6a;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('7', '#73729e', '<div style=\'background-color:#73729e;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('8', '#dcf9f6', '<div style=\'background-color:#dcf9f6;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('9', '#c78c72', '<div style=\'background-color:#c78c72;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('10', '#85865c', '<div style=\'background-color:#85865c;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('11', '#bfb0a1', '<div style=\'background-color:#bfb0a1;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('12', '#cfcfcf', '<div style=\'background-color:#cfcfcf;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('13', '#929e92', '<div style=\'background-color:#929e92;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('14', '#b8afa6', '<div style=\'background-color:#b8afa6;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('15', '#f1ebd4', '<div style=\'background-color:#f1ebd4;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('16', '#cc8c6d', '<div style=\'background-color:#cc8c6d;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('17', '#f0ebd5', '<div style=\'background-color:#f0ebd5;color:white\'>文字效果</div>');
INSERT INTO `color_dictionary` VALUES ('18', '#b9afaa', '<div style=\'background-color:#b9afaa;color:white\'>文字效果</div>');

-- ----------------------------
-- Table structure for gis_main
-- ----------------------------
DROP TABLE IF EXISTS `gis_main`;
CREATE TABLE `gis_main` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `serial_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '编号',
  `bind_district` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所属区县',
  `bind_street` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '所属街镇',
  `responsible_department` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '负责单位',
  `gis_kind` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '种类',
  `facility_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设施类型',
  `facility_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设施代码',
  `facility_starttime` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `facility_agelimit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设施年限',
  `facility_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设施状态是否正常，1为true，0为flase',
  `facility_status_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '状态类型,损坏,老旧,使用功能下降,影响美观',
  `lng` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '经度',
  `lat` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纬度',
  `datacollection_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据采集录入时间',
  `dataupdate_time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据更新时间',
  `datainput_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据录入人',
  `datacheck_user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '数据检查人',
  `customer_level` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '客户等级',
  `facility_volume` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设施体积',
  `facility_length` double DEFAULT NULL COMMENT '设施长',
  `facility_width` double DEFAULT NULL COMMENT '设施宽',
  `facility_height` double DEFAULT NULL COMMENT '设施高',
  `photo_number` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '照片编号',
  `photo_taketime` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '照片时间',
  `photo_spot` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '照片靶点',
  `photo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图片存储路径',
  `detailed_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT ' 详细地址',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of gis_main
-- ----------------------------

-- ----------------------------
-- Table structure for operate_history
-- ----------------------------
DROP TABLE IF EXISTS `operate_history`;
CREATE TABLE `operate_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `operate_user_id` varchar(32) DEFAULT NULL,
  `operete_type_id` int(32) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `operate_user_ip` varchar(32) DEFAULT NULL,
  `operate_user_mac` varchar(32) DEFAULT NULL,
  `local_server` varchar(32) DEFAULT NULL,
  `operate_user_city` varchar(32) DEFAULT NULL,
  `operate_summary` text,
  `is_success` int(32) DEFAULT NULL,
  `downfile_path` varchar(255) DEFAULT NULL,
  `downfile_type` varchar(100) DEFAULT NULL,
  `type` int(2) DEFAULT '0' COMMENT '0:后台，1前台，2APP',
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_RS_operate_history_ID` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=391 DEFAULT CHARSET=utf8 COMMENT='is_success : 0 false(失败)，1 true (成功)';

-- ----------------------------
-- Records of operate_history
-- ----------------------------
INSERT INTO `operate_history` VALUES ('2', '2bb49d9d514c48c5bebbf78beab3e179', '5', '2018-03-14 17:13:21', 'null', '', 'null', '', '运行出错：PreparedStatementCallback; SQL [ insert into project_detail(id,project_id ,ext1,ext2,ext3,ext4,ext5,ext6,ext7,ext8,ext9,ext10,ext11,ext12,ext13,ext14,ext15,ext16,ext17,ext18,ext19,ext20,ext21,ext22,ext23,ext24,ext25,ext26,ext27,ext28,ext29,ext30,ext31,ext32,ext33,ext34,ext35,ext36,ext37)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)]; Data truncation: Data too long for column \'ext10\' at row 1; nested exception is com.mysql.jdbc.MysqlDataTruncation: Data truncation: Data too long for column \'ext10\' at row 1', '0', null, null, '0');
INSERT INTO `operate_history` VALUES ('3', '2bb49d9d514c48c5bebbf78beab3e179', '5', '2018-03-16 13:26:59', 'null', '', 'null', '', null, '1', null, null, '0');
INSERT INTO `operate_history` VALUES ('4', '2bb49d9d514c48c5bebbf78beab3e179', '16', '2018-03-16 13:27:45', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '0');
INSERT INTO `operate_history` VALUES ('5', '2bb49d9d514c48c5bebbf78beab3e179', '1', '2018-03-16 13:27:54', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('6', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:27:55', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('7', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:27:55', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('8', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:27:56', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('9', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:28:01', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('10', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:28:02', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('11', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:28:03', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('12', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:28:03', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('13', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:28:04', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('14', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:28:07', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('15', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:28:11', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('16', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:28:12', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('17', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:28:13', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('18', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:28:13', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('19', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:28:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('20', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:28:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('21', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:28:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('22', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:28:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('23', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:28:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('24', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:28:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('25', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:30:10', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('26', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:30:10', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('27', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:30:10', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('28', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('29', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('30', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('31', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('32', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('33', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:18', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('34', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:45', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('35', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:45', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('36', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:47', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('37', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:47', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('38', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:30:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('39', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('40', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:30:50', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('41', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:50', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('42', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:30:51', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('43', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:51', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('44', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:30:52', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('45', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:52', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('46', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:30:53', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('47', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:53', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('48', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:56', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('49', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:56', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('50', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:57', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('51', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:57', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('52', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:30:58', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('53', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:30:59', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('54', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:31:01', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('55', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:31:44', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('56', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:31:44', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('57', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:31:44', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('58', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:31:47', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('59', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:31:47', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('60', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:31:48', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('61', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:31:48', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('62', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:31:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('63', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:31:51', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('64', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:31:53', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('65', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:33:04', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('66', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:33:04', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('67', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:33:04', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('68', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:33:07', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('69', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:33:08', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('70', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:33:09', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('71', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:33:09', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('72', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:33:10', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('73', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:33:11', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('74', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:34:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('75', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:34:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('76', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:34:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('77', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:34:41', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('78', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:34:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('79', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:34:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('80', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:34:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('81', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:34:44', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('82', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:34:46', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('83', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:38:18', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('84', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:38:18', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('85', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:38:29', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('86', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:38:41', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('87', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:38:47', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('88', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:38:52', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('89', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:38:58', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('90', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:09', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('91', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:39:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('92', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:39:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('93', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:39:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('94', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('95', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('96', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('97', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:44', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('98', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:44', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('99', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:39:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('100', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:39:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('101', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:39:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('102', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:52', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('103', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:53', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('104', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:53', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('105', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:39:54', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('106', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:45:07', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('107', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:45:12', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('108', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:45:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('109', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:48:23', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('110', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:48:23', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('111', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:48:29', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('112', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:31', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('113', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:31', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('114', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:32', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('115', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:32', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('116', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:33', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('117', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:34', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('118', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:48:36', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('119', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:48:36', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('120', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:41', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('121', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:48:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('122', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:48:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('123', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:44', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('124', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:48:45', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('125', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:48:45', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('126', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:46', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('127', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:48:48', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('128', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:48:48', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('129', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('130', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:48:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('131', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:48:51', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('132', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:48:51', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('133', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:54', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('134', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:48:56', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('135', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:48:56', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('136', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:48:58', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('137', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:48:59', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('138', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:00', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('139', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:01', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('140', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:01', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('141', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:49:04', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('142', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:06', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('143', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:06', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('144', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:49:07', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('145', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:09', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('146', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:10', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('147', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:10', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('148', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('149', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('150', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:49:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('151', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:49:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('152', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('153', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:28', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('154', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:29', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('155', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:29', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('156', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:49:37', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('157', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:38', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('158', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:38', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('159', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('160', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('161', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:49:40', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('162', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:49:40', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('163', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('164', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('165', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:49:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('166', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('167', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:48', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('168', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:48', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('169', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('170', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:50', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('171', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:52', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('172', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:52', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('173', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:55', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('174', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:55', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('175', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:49:57', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('176', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:49:57', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('177', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:49:59', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('178', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:01', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('179', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:01', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('180', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:04', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('181', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:04', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('182', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:06', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('183', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:07', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('184', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:08', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('185', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:08', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('186', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:09', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('187', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:09', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('188', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:11', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('189', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:11', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('190', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:12', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('191', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:12', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('192', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:13', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('193', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:13', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('194', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('195', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('196', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('197', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('198', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('199', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('200', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:18', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('201', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:18', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('202', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('203', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('204', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('205', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:50:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('206', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:20', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('207', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:21', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('208', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:21', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('209', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:22', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('210', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:22', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('211', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:23', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('212', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:24', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('213', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:50:25', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('214', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:50:25', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('215', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:53:07', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('216', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:53:08', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('217', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:53:08', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('218', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:53:11', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('219', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:53:12', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('220', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:53:12', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('221', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:53:13', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('222', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:53:13', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('223', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:53:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('224', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:53:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('225', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:53:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('226', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:53:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('227', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:53:20', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('228', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:53:20', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('229', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:53:21', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('230', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:53:22', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('231', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:53:23', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('232', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:53:25', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('233', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:53:25', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('234', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:54:37', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('235', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:54:37', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('236', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:54:37', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('237', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:54:40', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('238', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:54:41', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('239', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:54:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('240', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:54:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('241', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:54:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('242', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:54:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('243', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:54:44', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('244', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:54:45', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('245', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:54:45', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('246', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:54:48', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('247', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:54:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('248', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:54:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('249', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:54:51', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('250', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:54:52', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('251', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:54:55', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('252', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:54:55', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('253', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:54:56', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('254', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:54:57', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('255', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:55:00', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('256', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:55:00', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('257', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:55:01', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('258', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:55:02', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('259', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:55:03', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('260', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:55:03', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('261', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('262', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:16', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('263', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('264', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('265', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('266', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('267', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:20', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('268', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:20', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('269', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:21', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('270', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:21', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('271', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:22', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('272', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:24', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('273', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:24', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('274', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:26', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('275', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:26', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('276', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:28', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('277', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:29', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('278', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:30', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('279', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:33', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('280', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:33', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('281', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:36', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('282', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:37', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('283', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:38', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('284', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:38', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('285', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('286', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:42', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('287', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('288', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:44', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('289', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:45', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('290', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:46', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('291', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:46', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('292', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:49', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('293', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:50', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('294', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:50', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('295', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:52', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('296', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:52', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('297', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:57:56', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('298', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:56', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('299', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:57:57', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('300', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:58', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('301', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:57:59', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('302', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:58:00', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('303', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:58:00', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('304', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:58:03', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('305', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:58:03', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('306', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:58:05', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('307', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:58:05', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('308', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 13:59:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('309', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 13:59:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('310', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 13:59:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('311', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:59:18', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('312', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:59:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('313', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:59:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('314', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:59:20', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('315', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:59:20', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('316', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:59:21', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('317', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:59:22', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('318', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:59:25', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('319', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:59:25', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('320', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 13:59:27', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('321', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:59:28', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('322', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:59:29', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('323', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:59:29', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('324', '2bb49d9d514c48c5bebbf78beab3e179', '23', '2018-03-16 13:59:32', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('325', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 13:59:32', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('326', '2bb49d9d514c48c5bebbf78beab3e179', '5', '2018-03-16 18:13:24', 'null', '', 'null', '', null, '1', null, null, '0');
INSERT INTO `operate_history` VALUES ('327', '2bb49d9d514c48c5bebbf78beab3e179', '16', '2018-03-16 18:14:00', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '0');
INSERT INTO `operate_history` VALUES ('328', '2bb49d9d514c48c5bebbf78beab3e179', '1', '2018-03-16 18:14:11', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('329', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:14:11', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('330', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:14:11', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('331', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:14:12', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('332', '2bb49d9d514c48c5bebbf78beab3e179', '21', '2018-03-16 18:14:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('333', '2bb49d9d514c48c5bebbf78beab3e179', '21', '2018-03-16 18:14:20', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('334', '2bb49d9d514c48c5bebbf78beab3e179', '21', '2018-03-16 18:14:22', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('335', '2bb49d9d514c48c5bebbf78beab3e179', '21', '2018-03-16 18:14:23', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('336', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:15:30', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('337', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:15:30', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('338', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:15:30', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('339', '2bb49d9d514c48c5bebbf78beab3e179', '21', '2018-03-16 18:15:34', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('340', '2bb49d9d514c48c5bebbf78beab3e179', '1', '2018-03-16 18:16:58', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('341', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:16:59', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('342', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:16:59', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('343', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:17:25', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('344', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:19:08', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('345', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:19:08', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('346', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:19:22', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('347', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:20:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('348', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:20:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('349', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:20:33', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('350', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:20:37', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('351', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:20:37', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('352', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:21:47', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('353', '2bb49d9d514c48c5bebbf78beab3e179', '1', '2018-03-16 18:22:33', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('354', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:22:34', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('355', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:22:34', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('356', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:22:56', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('357', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:23:05', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('358', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:23:06', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('359', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:23:07', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('360', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:23:08', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('361', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:23:09', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('362', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:23:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('363', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 18:23:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('364', '2bb49d9d514c48c5bebbf78beab3e179', '7', '2018-03-16 18:23:17', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('365', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:23:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('366', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:23:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('367', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:23:20', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('368', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:23:29', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('369', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:23:29', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('370', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:24:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('371', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:24:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('372', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:24:39', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('373', '2bb49d9d514c48c5bebbf78beab3e179', '1', '2018-03-16 18:29:11', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('374', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:29:12', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('375', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:29:12', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('376', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:29:43', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('377', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:29:46', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('378', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:29:47', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('379', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:29:50', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('380', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:29:50', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('381', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:29:50', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('382', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:29:55', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('383', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:30:25', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('384', '2bb49d9d514c48c5bebbf78beab3e179', '1', '2018-03-16 18:32:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('385', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:32:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('386', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:32:14', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('387', '2bb49d9d514c48c5bebbf78beab3e179', '8', '2018-03-16 18:32:15', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('388', '2bb49d9d514c48c5bebbf78beab3e179', '22', '2018-03-16 18:32:19', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('389', '2bb49d9d514c48c5bebbf78beab3e179', '2', '2018-03-16 18:32:33', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');
INSERT INTO `operate_history` VALUES ('390', '2bb49d9d514c48c5bebbf78beab3e179', '3', '2018-03-16 18:32:33', '0:0:0:0:0:0:0:1', '', '0:0:0:0:0:0:0:1', '', null, '1', null, null, '1');

-- ----------------------------
-- Table structure for operate_type
-- ----------------------------
DROP TABLE IF EXISTS `operate_type`;
CREATE TABLE `operate_type` (
  `id` int(10) NOT NULL,
  `operate_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_RS_operate_type_ID` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of operate_type
-- ----------------------------
INSERT INTO `operate_type` VALUES ('1', 'PC WEB 登陆');
INSERT INTO `operate_type` VALUES ('2', 'PC WEB根据用户角色获取项目列表信息');
INSERT INTO `operate_type` VALUES ('3', 'PC WEB根据用户角色获取筛选条件，动态展示在地图上');
INSERT INTO `operate_type` VALUES ('4', 'PC WEB根据用户选择的条件获取地图点信息');
INSERT INTO `operate_type` VALUES ('5', '导入项目数据');
INSERT INTO `operate_type` VALUES ('7', 'PC WEB根据用户点击地图的点传递project_detail的ID获取详细信息');
INSERT INTO `operate_type` VALUES ('8', 'PC WEB地图初始化，根据用户角色获取全部地图点信息');
INSERT INTO `operate_type` VALUES ('9', '重置密码');
INSERT INTO `operate_type` VALUES ('10', '添加用户');
INSERT INTO `operate_type` VALUES ('11', '编辑用户');
INSERT INTO `operate_type` VALUES ('12', '删除用户');
INSERT INTO `operate_type` VALUES ('13', '编辑角色');
INSERT INTO `operate_type` VALUES ('14', '添加角色');
INSERT INTO `operate_type` VALUES ('15', '删除角色');
INSERT INTO `operate_type` VALUES ('16', '权限设置');
INSERT INTO `operate_type` VALUES ('17', '前台用户登陆');
INSERT INTO `operate_type` VALUES ('18', '导入项目图片数据');
INSERT INTO `operate_type` VALUES ('19', '删除手机标识码');
INSERT INTO `operate_type` VALUES ('20', '导入调研编号');
INSERT INTO `operate_type` VALUES ('21', 'PC WEB根据用户角色和项目编号获取全部地图点信息');
INSERT INTO `operate_type` VALUES ('22', 'PC WEB根据用户选择的坐标点，获取该坐标点的下一级坐标');
INSERT INTO `operate_type` VALUES ('23', 'PC WEB返回上一级坐标');
INSERT INTO `operate_type` VALUES ('24', 'PC WEB重设密码填写用户名');
INSERT INTO `operate_type` VALUES ('25', 'PC WEB重设密码发送邮箱验证码');
INSERT INTO `operate_type` VALUES ('26', 'PC WEB重设密码验证邮箱验证码');
INSERT INTO `operate_type` VALUES ('27', 'PC WEB重设密码更新密码');
INSERT INTO `operate_type` VALUES ('28', 'APP 用户登陆');
INSERT INTO `operate_type` VALUES ('29', 'APP 根据登陆用户获取菜单');
INSERT INTO `operate_type` VALUES ('30', 'APP 根据用不选择菜单获取地图点信息');
INSERT INTO `operate_type` VALUES ('31', 'APP 根据当前点击坐标点获取下一级坐标');
INSERT INTO `operate_type` VALUES ('32', 'APP 根据用户点击坐标获取坐标点详细信息');
INSERT INTO `operate_type` VALUES ('33', 'APP 根据详细信息ID获取图片信息');
INSERT INTO `operate_type` VALUES ('34', 'PC WEB忘记密码填写用户名');
INSERT INTO `operate_type` VALUES ('35', 'PC WEB忘记密码 发送邮箱验证码');
INSERT INTO `operate_type` VALUES ('36', 'PC WEB 忘记密码验证 邮箱验证码');
INSERT INTO `operate_type` VALUES ('37', 'PC WEB 忘记密码 重设密码');
INSERT INTO `operate_type` VALUES ('38', '地址解析');

-- ----------------------------
-- Table structure for project_attribute
-- ----------------------------
DROP TABLE IF EXISTS `project_attribute`;
CREATE TABLE `project_attribute` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '属性名',
  `attribute_type` int(2) DEFAULT NULL COMMENT '属性类型：1，经度；2，维度；3，详细地址；4，图片编号',
  `attribute_info_type` int(2) DEFAULT NULL COMMENT '详细信息展示设置',
  `attribute_index` int(3) DEFAULT NULL COMMENT '属性列数，当前属性位于detail的第几列',
  `attribute_active` int(1) DEFAULT '0' COMMENT '设置为筛选条件，激活时：1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of project_attribute
-- ----------------------------
INSERT INTO `project_attribute` VALUES ('001521195204334000015cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '序号', null, null, '1', '0');
INSERT INTO `project_attribute` VALUES ('001521195204336000025cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '调研编号', '5', '9', '2', '0');
INSERT INTO `project_attribute` VALUES ('001521195204337000035cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '省份', null, '10', '3', '0');
INSERT INTO `project_attribute` VALUES ('001521195204338000045cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '城市', null, '11', '4', '0');
INSERT INTO `project_attribute` VALUES ('001521195204338000055cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '区域', null, null, '5', '0');
INSERT INTO `project_attribute` VALUES ('001521195204339000065cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '街镇', null, '12', '6', '0');
INSERT INTO `project_attribute` VALUES ('001521195204340000075cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '名称', null, null, '7', '0');
INSERT INTO `project_attribute` VALUES ('001521195204341000085cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '地址', null, null, '8', '1');
INSERT INTO `project_attribute` VALUES ('001521195204342000095cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '问题分类', '6', null, '9', '0');
INSERT INTO `project_attribute` VALUES ('001521195204342000105cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '问题地址', null, null, '10', '1');
INSERT INTO `project_attribute` VALUES ('001521195204343000115cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '照片编号', null, null, '11', '0');
INSERT INTO `project_attribute` VALUES ('001521195204344000125cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '完成时间', null, null, '12', '0');
INSERT INTO `project_attribute` VALUES ('001521195204345000135cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '检查人员', null, null, '13', '0');
INSERT INTO `project_attribute` VALUES ('001521195204346000145cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '经度', '1', null, '14', '0');
INSERT INTO `project_attribute` VALUES ('001521195204346000155cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '纬度', '2', null, '15', '0');

-- ----------------------------
-- Table structure for project_attribute_condition
-- ----------------------------
DROP TABLE IF EXISTS `project_attribute_condition`;
CREATE TABLE `project_attribute_condition` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_condition` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `leaf` int(11) DEFAULT '1',
  `type` int(11) DEFAULT NULL COMMENT '0:detail,1:属性或者项目标题',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of project_attribute_condition
-- ----------------------------
INSERT INTO `project_attribute_condition` VALUES ('12', '16号', '001521195204342000105cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('13', '42号', '001521195204342000105cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('14', '34号', '001521195204342000105cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('15', '77号', '001521195204342000105cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('16', '56号', '001521195204342000105cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('17', '61号', '001521195204342000105cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('18', '74号', '001521195204342000105cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('19', '77号3层', '001521195204342000105cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('20', '67号3层', '001521195204342000105cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('27', '富漕路461弄', '001521195204341000085cc5d4d2e6f0', '1', null);
INSERT INTO `project_attribute_condition` VALUES ('28', '岳阳街道中山二路125弄', '001521195204341000085cc5d4d2e6f0', '1', null);

-- ----------------------------
-- Table structure for project_attribute_type
-- ----------------------------
DROP TABLE IF EXISTS `project_attribute_type`;
CREATE TABLE `project_attribute_type` (
  `id` int(2) NOT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `alias_name` varchar(100) DEFAULT NULL,
  `type` int(2) DEFAULT '0' COMMENT '0:必要信息，1：显示信息',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_attribute_type
-- ----------------------------
INSERT INTO `project_attribute_type` VALUES ('0', '无', null, '0');
INSERT INTO `project_attribute_type` VALUES ('1', '经度', 'longitude', '0');
INSERT INTO `project_attribute_type` VALUES ('2', '纬度', 'latitude', '0');
INSERT INTO `project_attribute_type` VALUES ('3', '详细地址', 'detail_address', '0');
INSERT INTO `project_attribute_type` VALUES ('4', '图片编号', 'img_url', '0');
INSERT INTO `project_attribute_type` VALUES ('5', '调研编号', 'research_no', '0');
INSERT INTO `project_attribute_type` VALUES ('6', '问题分类', 'question_type', '0');
INSERT INTO `project_attribute_type` VALUES ('9', '标题', 'detail_1', '1');
INSERT INTO `project_attribute_type` VALUES ('10', '详细信息2', 'detail_2', '1');
INSERT INTO `project_attribute_type` VALUES ('11', '详细信息3', 'detail_3', '1');
INSERT INTO `project_attribute_type` VALUES ('12', '详细信息4', 'detail_4', '1');
INSERT INTO `project_attribute_type` VALUES ('13', '详细信息5', 'detail_5', '1');
INSERT INTO `project_attribute_type` VALUES ('14', '详细信息6', 'detail_6', '1');
INSERT INTO `project_attribute_type` VALUES ('15', '详细信息7', 'detail_7', '1');
INSERT INTO `project_attribute_type` VALUES ('16', '无', null, '1');

-- ----------------------------
-- Table structure for project_condition_auth
-- ----------------------------
DROP TABLE IF EXISTS `project_condition_auth`;
CREATE TABLE `project_condition_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `condition_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `web_user_role_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of project_condition_auth
-- ----------------------------
INSERT INTO `project_condition_auth` VALUES ('12', '001521195203440000005cc5d4d2e6f0', '1');
INSERT INTO `project_condition_auth` VALUES ('13', '001521195204342000105cc5d4d2e6f0', '1');
INSERT INTO `project_condition_auth` VALUES ('14', '20', '1');
INSERT INTO `project_condition_auth` VALUES ('15', '19', '1');
INSERT INTO `project_condition_auth` VALUES ('16', '18', '1');
INSERT INTO `project_condition_auth` VALUES ('17', '17', '1');
INSERT INTO `project_condition_auth` VALUES ('18', '16', '1');
INSERT INTO `project_condition_auth` VALUES ('19', '15', '1');
INSERT INTO `project_condition_auth` VALUES ('20', '14', '1');
INSERT INTO `project_condition_auth` VALUES ('21', '13', '1');
INSERT INTO `project_condition_auth` VALUES ('22', '12', '1');
INSERT INTO `project_condition_auth` VALUES ('23', '001521195204341000085cc5d4d2e6f0', '1');
INSERT INTO `project_condition_auth` VALUES ('24', '28', '1');
INSERT INTO `project_condition_auth` VALUES ('25', '27', '1');

-- ----------------------------
-- Table structure for project_detail
-- ----------------------------
DROP TABLE IF EXISTS `project_detail`;
CREATE TABLE `project_detail` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext1` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext2` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext3` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext4` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext5` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext6` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext7` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext8` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext9` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext10` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext11` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext12` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext13` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext14` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext15` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext16` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext17` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext18` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext19` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext20` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext21` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext22` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext23` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext24` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext25` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext26` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext27` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext28` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext29` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext30` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext31` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext32` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext33` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext34` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext35` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext36` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext37` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext38` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext39` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext40` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext41` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext42` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext43` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext44` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext45` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext46` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext47` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext48` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext49` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext50` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext51` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext52` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext53` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext54` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext55` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext56` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext57` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext58` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext59` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext60` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext61` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext62` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext63` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext64` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext65` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext66` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext67` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext68` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext69` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext70` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext71` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext72` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext73` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext74` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext75` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext76` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext77` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext78` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext79` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext80` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext81` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext82` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext83` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext84` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext85` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext86` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext87` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext88` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext89` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext90` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext91` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext92` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext93` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext94` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext95` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext96` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext97` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext98` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext99` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ext100` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `img_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '经度',
  `latitude` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '纬度',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of project_detail
-- ----------------------------
INSERT INTO `project_detail` VALUES ('001521195204347000165cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '1', '0001010010010001PP', '上海', '上海', '金山区', '漕泾镇', '绿地漕泾新苑二期', '富漕路461弄', '垃圾', '16号', '1', '2017-11-18 00:00:00', '赵苏鸣', '121.411', '30.803', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `project_detail` VALUES ('001521195204349000175cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '2', '0001010010010001PP', '上海', '上海', '金山区', '漕泾镇', '绿地漕泾新苑二期', '富漕路461弄', '垃圾', '42号', '2', '2017-11-18 00:00:00', '赵苏鸣', '121.411', '30.803', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `project_detail` VALUES ('001521195204351000185cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '3', '0001010010010002PP', '上海', '上海', '金山区', '漕泾镇', '绿地漕泾新苑二期', '富漕路461弄', '植被', '34号', '3', '2017-11-18 00:00:00', '赵苏鸣', '121.411', '30.803', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `project_detail` VALUES ('001521195204352000195cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '4', '0001010010010002PP', '上海', '上海', '金山区', '漕泾镇', '绿地漕泾新苑二期', '富漕路461弄', '4', '42号', '4', '2017-11-18 00:00:00', '赵苏鸣', '121.41', '30.805', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `project_detail` VALUES ('001521195204353000205cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '5', '0001020010010001PP', '上海', '上海', '松江区', '岳阳街道', '南龙谭苑小区', '岳阳街道中山二路125弄', '2', '77号', '5', '2017-11-18 00:00:00', '赵苏鸣', '121.239', '31.015', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `project_detail` VALUES ('001521195204354000215cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '6', '0001020010010001PP', '上海', '上海', '松江区', '岳阳街道', '南龙谭苑小区', '岳阳街道中山二路125弄', '2', '56号', '6', '2017-11-18 00:00:00', '赵苏鸣', '121.24', '31.015', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `project_detail` VALUES ('001521195204355000225cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '7', '0001020010010002PP', '上海', '上海', '松江区', '岳阳街道', '南龙谭苑小区', '岳阳街道中山二路125弄', '2', '61号', '7', '2017-11-18 00:00:00', '赵苏鸣', '121.24', '31.015', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `project_detail` VALUES ('001521195204356000235cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '8', '0001020010010002PP', '上海', '上海', '松江区', '岳阳街道', '南龙谭苑小区', '岳阳街道中山二路125弄', '2', '74号', '8', '2017-11-18 00:00:00', '赵苏鸣', '121.239', '31.015', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `project_detail` VALUES ('001521195204357000245cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '9', '0001020010010002PP', '上海', '上海', '松江区', '岳阳街道', '南龙谭苑小区', '岳阳街道中山二路125弄', '4', '77号3层', '9', '2017-11-18 00:00:00', '赵苏鸣', '121.24', '31.015', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `project_detail` VALUES ('001521195204358000255cc5d4d2e6f0', '001521195203440000005cc5d4d2e6f0', '10', '0001020010010002PP', '上海', '上海', '松江区', '岳阳街道', '南龙谭苑小区', '岳阳街道中山二路125弄', '4', '67号3层', '10', '2017-11-18 00:00:00', '赵苏鸣', '121.24', '31.015', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for project_main
-- ----------------------------
DROP TABLE IF EXISTS `project_main`;
CREATE TABLE `project_main` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_user_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '保存路径',
  `type` int(11) DEFAULT '0' COMMENT '0:未设置筛选属性，1设置筛选属性',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of project_main
-- ----------------------------
INSERT INTO `project_main` VALUES ('001521195203440000005cc5d4d2e6f0', '1111111', '2018-03-16 18:13:24', null, '2bb49d9d514c48c5bebbf78beab3e179', 'F:\\tempfilepath\\20180316\\1521195202957管小区汇总2 - 更新调研编号18位.xlsx', '1');

-- ----------------------------
-- Table structure for project_questiontype_color
-- ----------------------------
DROP TABLE IF EXISTS `project_questiontype_color`;
CREATE TABLE `project_questiontype_color` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of project_questiontype_color
-- ----------------------------

-- ----------------------------
-- Table structure for project_searchno_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `project_searchno_dictionary`;
CREATE TABLE `project_searchno_dictionary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `search_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `search_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=182 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of project_searchno_dictionary
-- ----------------------------
INSERT INTO `project_searchno_dictionary` VALUES ('176', '01', '上海省', '2018-03-16 13:28:39', '2018-03-16 13:28:39');
INSERT INTO `project_searchno_dictionary` VALUES ('177', '0101', '上海市', '2018-03-16 13:28:51', '2018-03-16 13:28:51');
INSERT INTO `project_searchno_dictionary` VALUES ('178', '010101', '金山区', '2018-03-16 13:29:26', '2018-03-16 13:29:26');
INSERT INTO `project_searchno_dictionary` VALUES ('179', '010101001', '漕泾镇', '2018-03-16 13:29:40', '2018-03-16 13:29:40');
INSERT INTO `project_searchno_dictionary` VALUES ('180', '010101001001', '绿地漕泾新苑二期', '2018-03-16 13:29:53', '2018-03-16 13:29:53');

-- ----------------------------
-- Table structure for question_color
-- ----------------------------
DROP TABLE IF EXISTS `question_color`;
CREATE TABLE `question_color` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of question_color
-- ----------------------------
INSERT INTO `question_color` VALUES ('1', '1', '4', null, '2018-01-16 10:04:48');
INSERT INTO `question_color` VALUES ('2', '2', '5', null, '2018-01-16 10:04:54');
INSERT INTO `question_color` VALUES ('3', '3', '7', '2018-01-12 16:46:08', '2018-01-16 10:05:01');
INSERT INTO `question_color` VALUES ('4', '4', '8', '2018-01-12 16:46:20', '2018-01-16 10:05:09');
INSERT INTO `question_color` VALUES ('5', '5', '11', '2018-01-12 16:57:05', '2018-01-16 10:05:13');
INSERT INTO `question_color` VALUES ('7', '6', '5', '2018-01-16 14:26:39', '2018-01-16 14:26:39');
INSERT INTO `question_color` VALUES ('8', '7', '16', '2018-01-16 14:35:45', '2018-01-16 14:35:45');
INSERT INTO `question_color` VALUES ('9', '8', '8', '2018-01-19 14:59:33', '2018-01-19 14:59:33');

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

-- ----------------------------
-- Table structure for user_auth
-- ----------------------------
DROP TABLE IF EXISTS `user_auth`;
CREATE TABLE `user_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_auth
-- ----------------------------
INSERT INTO `user_auth` VALUES ('127', '3', '1');
INSERT INTO `user_auth` VALUES ('128', '133', '1');
INSERT INTO `user_auth` VALUES ('129', '132', '1');
INSERT INTO `user_auth` VALUES ('130', '131', '1');
INSERT INTO `user_auth` VALUES ('131', '2', '1');
INSERT INTO `user_auth` VALUES ('132', '123', '1');
INSERT INTO `user_auth` VALUES ('133', '121', '1');
INSERT INTO `user_auth` VALUES ('134', '120', '1');
INSERT INTO `user_auth` VALUES ('135', '1', '1');
INSERT INTO `user_auth` VALUES ('136', '115', '1');
INSERT INTO `user_auth` VALUES ('137', '114', '1');
INSERT INTO `user_auth` VALUES ('138', '113', '1');
INSERT INTO `user_auth` VALUES ('139', '112', '1');
INSERT INTO `user_auth` VALUES ('140', '111', '1');

-- ----------------------------
-- Table structure for user_login
-- ----------------------------
DROP TABLE IF EXISTS `user_login`;
CREATE TABLE `user_login` (
  `id` varchar(32) NOT NULL,
  `user_name` varchar(32) DEFAULT NULL,
  `user_password` varchar(32) DEFAULT NULL,
  `user_role` int(32) DEFAULT NULL,
  `is_delete` int(32) DEFAULT '0',
  `parent_id` varchar(255) DEFAULT NULL COMMENT '从属关系，父级id',
  `type` varchar(255) DEFAULT NULL,
  `create_date` varchar(255) DEFAULT NULL,
  `update_date` varchar(255) DEFAULT NULL,
  `is_allow_weblogin` int(10) DEFAULT '1' COMMENT '0:允许，1：不允许',
  `real_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `USER_LOGIN_ID` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_login
-- ----------------------------
INSERT INTO `user_login` VALUES ('2bb49d9d514c48c5bebbf78beab3e179', 'admin', 'admin', '1', '0', null, null, null, null, '0', null);
INSERT INTO `user_login` VALUES ('60672052e98a45ec800173a9b1829f5b', 'user', 'user', '7', '0', null, null, null, null, '1', null);

-- ----------------------------
-- Table structure for user_login_copy1
-- ----------------------------
DROP TABLE IF EXISTS `user_login_copy1`;
CREATE TABLE `user_login_copy1` (
  `id` varchar(32) NOT NULL,
  `user_name` varchar(32) DEFAULT NULL,
  `user_password` varchar(32) DEFAULT NULL,
  `user_role` int(32) DEFAULT NULL,
  `is_delete` int(32) DEFAULT '0',
  `parent_id` varchar(255) DEFAULT NULL COMMENT '从属关系，父级id',
  `type` varchar(255) DEFAULT NULL,
  `create_date` varchar(255) DEFAULT NULL,
  `update_date` varchar(255) DEFAULT NULL,
  `is_allow_weblogin` int(10) DEFAULT '1' COMMENT '0:允许，1：不允许',
  `real_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `USER_LOGIN_ID` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_login_copy1
-- ----------------------------
INSERT INTO `user_login_copy1` VALUES ('2bb49d9d514c48c5bebbf78beab3e179', 'admin', 'admin', '1', '0', null, null, null, null, '0', null);
INSERT INTO `user_login_copy1` VALUES ('60672052e98a45ec800173a9b1829f5b', 'user', 'user', '7', '0', null, null, null, null, '1', null);

-- ----------------------------
-- Table structure for user_menu
-- ----------------------------
DROP TABLE IF EXISTS `user_menu`;
CREATE TABLE `user_menu` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `menu_url` varchar(255) DEFAULT NULL,
  `menu_name` varchar(255) DEFAULT NULL,
  `leaf` varchar(255) DEFAULT NULL,
  `button` int(10) DEFAULT NULL,
  `auth_leaf` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_menu
-- ----------------------------
INSERT INTO `user_menu` VALUES ('1', null, null, '系统管理', '0', '0', '0');
INSERT INTO `user_menu` VALUES ('2', null, null, '前端管理', '0', '0', '0');
INSERT INTO `user_menu` VALUES ('3', null, null, '项目管理', '0', '0', '0');
INSERT INTO `user_menu` VALUES ('111', '1', 'qrcode.jsp', '二维码管理', '1', null, '01');
INSERT INTO `user_menu` VALUES ('112', '1', 'operateHistory.jsp', '操作记录', '1', '0', '1');
INSERT INTO `user_menu` VALUES ('113', '1', 'PasswordMgr.jsp', '密码管理', '1', '0', '1');
INSERT INTO `user_menu` VALUES ('114', '1', 'userMgr.jsp', '用户管理', '1', '0', '1');
INSERT INTO `user_menu` VALUES ('115', '1', 'userAuth.jsp', '权限管理', '1', '0', '1');
INSERT INTO `user_menu` VALUES ('120', '2', 'webUserPhoneMgr.jsp', '前端用户APP登陆管理', '1', '0', '1');
INSERT INTO `user_menu` VALUES ('121', '2', 'webUserMgr.jsp', '前端用户管理', '1', '0', '1');
INSERT INTO `user_menu` VALUES ('123', '2', 'webUserAuth.jsp', '前端筛选权限设置', '1', '0', '1');
INSERT INTO `user_menu` VALUES ('131', '3', 'searchnoMgr.jsp', '调研编号字典管理', '1', '0', '1');
INSERT INTO `user_menu` VALUES ('132', '3', 'questionColor.jsp', '问题类型颜色配置', '1', '0', '1');
INSERT INTO `user_menu` VALUES ('133', '3', 'projectMgr.jsp', '项目数据管理', '1', '0', '1');

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) DEFAULT NULL,
  `is_delete` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='is_delete : 0   未删除 1：已删除';

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('1', '管理员', '0');
INSERT INTO `user_role` VALUES ('2', '普通用户', '1');
INSERT INTO `user_role` VALUES ('4', '超级管理员', '1');
INSERT INTO `user_role` VALUES ('5', 'user', '1');
INSERT INTO `user_role` VALUES ('6', '普通用户', '1');
INSERT INTO `user_role` VALUES ('7', 'user', '0');
INSERT INTO `user_role` VALUES ('8', '123213', '1');
INSERT INTO `user_role` VALUES ('9', '123213', '0');

-- ----------------------------
-- Table structure for web_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `web_user_auth`;
CREATE TABLE `web_user_auth` (
  `id` varchar(50) NOT NULL,
  `attribute_condition_id` varchar(50) DEFAULT NULL,
  `web_user_role_id` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_user_auth
-- ----------------------------

-- ----------------------------
-- Table structure for web_user_login
-- ----------------------------
DROP TABLE IF EXISTS `web_user_login`;
CREATE TABLE `web_user_login` (
  `id` varchar(32) NOT NULL,
  `user_name` varchar(32) NOT NULL,
  `user_password` varchar(32) DEFAULT NULL,
  `user_role` int(32) DEFAULT NULL,
  `is_delete` int(32) DEFAULT '0',
  `parent_id` varchar(255) DEFAULT NULL COMMENT '从属关系，父级id',
  `type` varchar(255) DEFAULT NULL,
  `create_date` varchar(255) DEFAULT NULL,
  `update_date` varchar(255) DEFAULT NULL,
  `allow_phone_size` int(10) DEFAULT '1' COMMENT '允许登陆的设备数量',
  `real_name` varchar(255) DEFAULT NULL,
  `enable_time` varchar(50) DEFAULT NULL COMMENT '启用时间',
  `disable_time` varchar(50) DEFAULT NULL COMMENT '禁用时间',
  `email` varchar(255) DEFAULT NULL,
  `wx_appid` varchar(100) DEFAULT NULL,
  `wx_bind_time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `WEB_USER_LOGIN_USER_NAME` (`user_name`) USING BTREE,
  KEY `WEB_USER_LOGIN_ID` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of web_user_login
-- ----------------------------
INSERT INTO `web_user_login` VALUES ('2bb49d9d514c48c5bebbf78beab3e179', 'admin', 'admin', '1', '0', null, null, null, null, '123', '12123啊实打实', '2018-01-03', '2023-01-06', '930725713@qq.com', null, null);
INSERT INTO `web_user_login` VALUES ('60672052e98a45ec800173a9b1829f5b', 'zhou', 'user', '7', '1', null, null, null, null, '1', '周期', null, null, null, null, null);
INSERT INTO `web_user_login` VALUES ('8e81294de42949f6b18d4262cdd6bebe', '123', '123', '2', '0', null, null, null, null, '1', '123', null, null, null, null, null);
INSERT INTO `web_user_login` VALUES ('e2058de4d2704de08c952c768578bd20', '546a', 'asd', '9', '1', null, null, null, null, '1', '阿斯顿', null, null, null, null, null);
INSERT INTO `web_user_login` VALUES ('f36df2a40fe248589b99ce0a3f4a05b8', 'wuqiuming', 'wuqiuming', '12', '0', null, null, null, null, '3', '吴秋明', null, null, null, null, null);

-- ----------------------------
-- Table structure for web_user_login_phone
-- ----------------------------
DROP TABLE IF EXISTS `web_user_login_phone`;
CREATE TABLE `web_user_login_phone` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `web_user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of web_user_login_phone
-- ----------------------------
INSERT INTO `web_user_login_phone` VALUES ('1', '2bb49d9d514c48c5bebbf78beab3e179', 'asd1232', '2017-12-15 14:51:13');
INSERT INTO `web_user_login_phone` VALUES ('2', '2bb49d9d514c48c5bebbf78beab3e179', 'asd1232', '2017-12-15 16:05:38');
INSERT INTO `web_user_login_phone` VALUES ('4', '2bb49d9d514c48c5bebbf78beab3e179', '7a49ddf0dc913e6b9b80a6d26ec9619e', '2017-12-27 17:15:02');
INSERT INTO `web_user_login_phone` VALUES ('5', '2bb49d9d514c48c5bebbf78beab3e179', '7a49ddf0dc913e6b9b80a6d26ec9619e', '2017-12-27 17:18:04');
INSERT INTO `web_user_login_phone` VALUES ('6', '2bb49d9d514c48c5bebbf78beab3e179', '7a49ddf0dc913e6b9b80a6d26ec9619e', '2017-12-27 17:57:47');
INSERT INTO `web_user_login_phone` VALUES ('7', '2bb49d9d514c48c5bebbf78beab3e179', '7a49ddf0dc913e6b9b80a6d26ec9619e', '2017-12-27 18:17:23');
INSERT INTO `web_user_login_phone` VALUES ('8', '2bb49d9d514c48c5bebbf78beab3e179', '7a49ddf0dc913e6b9b80a6d26ec9619e', '2017-12-27 18:20:16');
INSERT INTO `web_user_login_phone` VALUES ('9', '2bb49d9d514c48c5bebbf78beab3e179', '7a49ddf0dc913e6b9b80a6d26ec9619e', '2017-12-29 16:11:38');
INSERT INTO `web_user_login_phone` VALUES ('10', '2bb49d9d514c48c5bebbf78beab3e179', '7a49ddf0dc913e6b9b80a6d26ec9619e', '2017-12-29 16:12:01');
INSERT INTO `web_user_login_phone` VALUES ('11', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2017-12-29 16:13:03');
INSERT INTO `web_user_login_phone` VALUES ('12', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2017-12-29 16:14:50');
INSERT INTO `web_user_login_phone` VALUES ('13', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2017-12-29 16:26:41');
INSERT INTO `web_user_login_phone` VALUES ('14', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2017-12-29 16:56:13');
INSERT INTO `web_user_login_phone` VALUES ('15', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2017-12-29 16:59:06');
INSERT INTO `web_user_login_phone` VALUES ('16', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2017-12-29 17:04:01');
INSERT INTO `web_user_login_phone` VALUES ('17', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2017-12-30 08:55:36');
INSERT INTO `web_user_login_phone` VALUES ('18', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2017-12-31 11:08:08');
INSERT INTO `web_user_login_phone` VALUES ('19', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2018-01-12 15:01:56');
INSERT INTO `web_user_login_phone` VALUES ('20', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2018-01-18 14:00:05');
INSERT INTO `web_user_login_phone` VALUES ('21', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2018-01-18 14:00:59');
INSERT INTO `web_user_login_phone` VALUES ('22', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2018-01-18 14:27:26');
INSERT INTO `web_user_login_phone` VALUES ('23', '2bb49d9d514c48c5bebbf78beab3e179', '4695ee0f36f6ae9b305f82f883f5fcac', '2018-01-18 15:17:34');
INSERT INTO `web_user_login_phone` VALUES ('24', '2bb49d9d514c48c5bebbf78beab3e179', 'a4sd655555', '2018-01-19 10:24:21');
INSERT INTO `web_user_login_phone` VALUES ('25', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:38:30');
INSERT INTO `web_user_login_phone` VALUES ('26', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:41');
INSERT INTO `web_user_login_phone` VALUES ('27', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:41');
INSERT INTO `web_user_login_phone` VALUES ('28', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:41');
INSERT INTO `web_user_login_phone` VALUES ('29', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:41');
INSERT INTO `web_user_login_phone` VALUES ('30', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:41');
INSERT INTO `web_user_login_phone` VALUES ('31', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:41');
INSERT INTO `web_user_login_phone` VALUES ('32', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:41');
INSERT INTO `web_user_login_phone` VALUES ('33', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('34', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('35', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('36', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('37', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('38', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('39', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('40', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('41', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('42', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('43', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('44', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('45', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('46', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('47', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('48', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('49', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('50', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('51', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('52', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('53', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:42');
INSERT INTO `web_user_login_phone` VALUES ('54', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('55', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('56', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('57', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('58', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('59', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('60', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('61', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('62', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('63', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('64', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('65', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('66', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('67', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('68', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('69', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('70', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('71', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('72', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('73', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('74', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:43');
INSERT INTO `web_user_login_phone` VALUES ('75', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:40:44');
INSERT INTO `web_user_login_phone` VALUES ('76', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('77', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('78', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('79', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('80', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('81', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('82', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('83', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('84', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('85', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('86', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('87', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('88', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('89', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:41');
INSERT INTO `web_user_login_phone` VALUES ('90', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('91', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('92', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('93', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('94', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('95', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('96', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('97', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('98', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('99', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('100', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('101', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('102', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('103', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('104', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('105', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('106', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('107', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('108', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('109', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('110', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('111', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('112', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('113', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:42');
INSERT INTO `web_user_login_phone` VALUES ('114', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('115', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('116', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('117', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('118', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('119', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('120', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('121', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('122', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('123', '2bb49d9d514c48c5bebbf78beab3e179', '456123', '2018-01-19 10:41:43');
INSERT INTO `web_user_login_phone` VALUES ('124', '2bb49d9d514c48c5bebbf78beab3e179', 'a4sd655555', '2018-01-24 09:16:29');

-- ----------------------------
-- Table structure for web_user_role
-- ----------------------------
DROP TABLE IF EXISTS `web_user_role`;
CREATE TABLE `web_user_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) DEFAULT NULL,
  `is_delete` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='is_delete : 0   未删除 1：已删除';

-- ----------------------------
-- Records of web_user_role
-- ----------------------------
INSERT INTO `web_user_role` VALUES ('1', '上海市绿化管理员', '0');
INSERT INTO `web_user_role` VALUES ('2', '静安区管理', '0');
INSERT INTO `web_user_role` VALUES ('7', '宝山区绿化', '1');
INSERT INTO `web_user_role` VALUES ('9', '上海市绿化', '1');
INSERT INTO `web_user_role` VALUES ('10', 'asdsad', '1');
INSERT INTO `web_user_role` VALUES ('11', '宝山区总管', '0');
INSERT INTO `web_user_role` VALUES ('12', 'wuqiuming', '0');
