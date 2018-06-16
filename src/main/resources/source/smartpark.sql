/*
Navicat MySQL Data Transfer

Source Server         : 107.150.28.244_inzoom
Source Server Version : 50611
Source Host           : 107.150.28.244:3306
Source Database       : smartpark

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2018-06-16 16:15:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for order_refund
-- ----------------------------
DROP TABLE IF EXISTS `order_refund`;
CREATE TABLE `order_refund` (
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
-- Records of order_refund
-- ----------------------------

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
INSERT INTO `smart_member` VALUES ('0015289415565600000000163c5bc4c4', null, null, '2018-06-14 09:59:16', '2018-06-14 09:59:16', 'oqH-90aLdhE9em9ej4JwBvmPXGxw', '18936483081');

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
INSERT INTO `smart_mobile_code_send` VALUES ('1', '18936483081', '2018-06-14 09:59:06', '245926', '10');
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_mobile_code_send_history
-- ----------------------------
INSERT INTO `smart_mobile_code_send_history` VALUES ('1', '18936483081', '2018-06-04 10:48:05', '972946');
INSERT INTO `smart_mobile_code_send_history` VALUES ('2', '18936483081', '2018-06-14 09:59:06', '245926');

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of smart_order
-- ----------------------------
INSERT INTO `smart_order` VALUES ('0015289419081620001800163c5bc4c4', '0015289415734270000100163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-14 10:05:12', '2018-06-14 10:05:16', '1.01', null, '2018-06-14 10:05:08', null, '0015289419121300001900163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015289439875040000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-14 10:39:50', '2018-06-14 10:40:21', '1.01', null, '2018-06-14 10:39:47', null, '0015289439900900000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015289691369580000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-14 17:38:59', '2018-06-14 17:39:04', '1.01', null, '2018-06-14 17:38:56', null, '0015289691399980000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015289704682980000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-14 18:01:10', '2018-06-14 18:01:12', '1.01', null, '2018-06-14 18:01:08', null, '0015289704701000000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015290422606490000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-15 13:57:42', '2018-06-15 13:57:44', '1.01', null, '2018-06-15 13:57:40', null, '0015290422626100000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015290485143880000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-15 15:41:56', '2018-06-15 15:42:01', '1.01', null, '2018-06-15 15:41:54', null, '0015290485163240000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015290526695100000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-15 16:51:12', '2018-06-15 16:51:13', '1.01', null, '2018-06-15 16:51:09', null, '0015290526720260000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015290536469760000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-15 17:07:28', '2018-06-15 17:07:30', '1.01', null, '2018-06-15 17:07:26', null, '0015290536485900000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015290556499070000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-15 17:40:51', '2018-06-15 17:40:54', '1.01', null, '2018-06-15 17:40:49', null, '0015290556514830000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015290567688830000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-15 17:59:31', '2018-06-15 17:59:34', '1.01', null, '2018-06-15 17:59:28', null, '0015290567716020000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015290574209310000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-15 18:10:23', '2018-06-15 18:10:26', '1.01', null, '2018-06-15 18:10:20', null, '0015290574232840000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015291044095530000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-16 07:13:32', '2018-06-16 07:13:40', '1.01', null, '2018-06-16 07:13:29', null, '0015291044121200000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015291058796010000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-16 07:38:02', '2018-06-16 07:38:10', '1.01', null, '2018-06-16 07:37:59', null, '0015291058820120000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015291090785170000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-16 08:31:20', '2018-06-16 08:31:26', '1.01', null, '2018-06-16 08:31:18', null, '0015291090807030000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015291121403710000200163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-16 09:22:23', '2018-06-16 09:22:25', '2.01', null, '2018-06-16 09:22:20', null, '0015291121430290000300163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015291150277060000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-16 10:10:31', '2018-06-16 10:10:38', '1.01', null, '2018-06-16 10:10:27', null, '0015291150312240000100163c5bc4c4', null, null);
INSERT INTO `smart_order` VALUES ('0015291161116710000000163c5bc4c4', '0015289415883020000200163c5bc4c4', '0015289418593630001300163c5bc4c4', '0015289418595880001400163c5bc4c4', '0', '3', '2018-06-16 10:28:33', '2018-06-16 10:28:41', '1.01', null, '2018-06-16 10:28:31', null, '0015291161136870000100163c5bc4c4', null, null);

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
INSERT INTO `smart_park_space` VALUES ('0015289418032970000400163c5bc4c4', '0015289418030610000300163c5bc4c4', '1', '200', '11', '2.02', 'assaas', '2018-06-14 10:03:23', '2018-06-14 10:03:23');
INSERT INTO `smart_park_space` VALUES ('0015289418037100000700163c5bc4c4', '0015289418030610000300163c5bc4c4', '2', '333', '111', '2.02', 'asassa', '2018-06-14 10:03:23', '2018-06-14 10:03:23');
INSERT INTO `smart_park_space` VALUES ('0015289418178580000900163c5bc4c4', '0015289418175980000800163c5bc4c4', '2', '333', '111', '2.02', 'asassa', '2018-06-14 10:03:37', '2018-06-14 10:03:37');
INSERT INTO `smart_park_space` VALUES ('0015289418178630001100163c5bc4c4', '0015289418175980000800163c5bc4c4', '1', '200', '11', '2.02', 'assaas', '2018-06-14 10:03:37', '2018-06-14 10:03:37');
INSERT INTO `smart_park_space` VALUES ('0015289418595880001400163c5bc4c4', '0015289418593630001300163c5bc4c4', '2', '333', '111', '2.02', 'asassa', '2018-06-14 10:04:19', '2018-06-14 10:04:19');
INSERT INTO `smart_park_space` VALUES ('0015289418595900001500163c5bc4c4', '0015289418593630001300163c5bc4c4', '1', '200', '11', '2.02', 'assaas', '2018-06-14 10:04:19', '2018-06-14 10:04:19');

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
