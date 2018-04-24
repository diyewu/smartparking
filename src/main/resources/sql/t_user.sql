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
  UNIQUE KEY `IDX_RS_operate_history_ID` (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='is_success : 0 false(失败)，1 true (成功)';

CREATE TABLE `operate_type` (
  `id` int(10) NOT NULL,
  `operate_name` varchar(32) DEFAULT NULL,
  UNIQUE KEY `IDX_RS_operate_type_ID` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `project_attribute` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `attribute_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '属性名',
  `attribute_type` int(2) DEFAULT NULL COMMENT '属性类型：1，经度；2，维度；3，详细地址；4，图片编号',
  `attribute_index` int(3) DEFAULT NULL COMMENT '属性列数，当前属性位于detail的第几列',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `project_main` (
  `id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `project_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_time` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `create_user_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_path` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '保存路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `t_user` (
  `id` bigint(32) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

CREATE TABLE `user_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8;

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

CREATE TABLE `user_login_copy` (
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

CREATE TABLE `user_role` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(32) DEFAULT NULL,
  `is_delete` int(10) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='is_delete : 0   未删除 1：已删除';

CREATE TABLE `project_attribute_type` (
  `id` int(2) NOT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for project_attribute_type
-- ----------------------------
DROP TABLE IF EXISTS `project_attribute_type`;
CREATE TABLE `project_attribute_type` (
  `id` int(2) NOT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project_attribute_type
-- ----------------------------
INSERT INTO `project_attribute_type` VALUES ('1', '经度');
INSERT INTO `project_attribute_type` VALUES ('2', '维度');
INSERT INTO `project_attribute_type` VALUES ('3', '详细地址');
INSERT INTO `project_attribute_type` VALUES ('4', '图片编号');
