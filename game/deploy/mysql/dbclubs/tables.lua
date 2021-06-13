
--[[
    desc:数据库结构
    auth:Caorl Luo
]]
return {
    --创建联盟数据库
    [[
      DROP DATABASE IF EXISTS `dbclubs`;
      CREATE DATABASE `dbclubs` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
    ]],
    ---切换数据库使用
    [[USE `dbclubs`;]],
    ---创建联盟信息表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      CREATE TABLE `clubs`  (
        `clubID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '联盟ID',
        `name` VARCHAR(32) NOT NULL COMMENT '联盟名字',
        `personality` VARCHAR(32) NOT NULL DEFAULT '欢迎大家加入俱乐部！' COMMENT '个性签名',
        `rid` INT(11) NOT NULL COMMENT '归属角色',
        `profitPlatformRate` INT(11) NOT NULL DEFAULT 20 COMMENT '平台分润比例千分比',
        `profitclubRate` INT(11) NOT NULL DEFAULT 30 COMMENT '盟主分润比例千分比',
        `profitAgencyRate` INT(11) NOT NULL DEFAULT 50 COMMENT '代理分润比例千分比',
        `assignRule` JSON NOT NULL COMMENT '分配规则',
        `gameInfos` JSON NOT NULL COMMENT '游戏信息',
        `birthday` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
        PRIMARY KEY (`clubID`) USING BTREE
      ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '联盟信息' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],

    ---创建代理信息表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      CREATE TABLE `admins`  (
        `agentID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '代理ID',
        `rid` INT(11) NOT NULL COMMENT '所属角色',
        `clubID` INT(11) NOT NULL COMMENT '所属联盟',
        `birthday` DATeTIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
        PRIMARY KEY (`agentID`) USING BTREE
      ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '代理信息' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],

    ---创建联盟成员表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      CREATE TABLE `members`  (
        `memberID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '成员ID',
        `rid` INT(11) NOT NULL COMMENT '联盟成员',
        `office` enum('member','agency','club') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联盟身份',
        `agentID` INT(11) NOT NULL COMMENT '上级代理',
        `clubID` INT(11) NOT NULL COMMENT '所属联盟',
        `birthday` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
        PRIMARY KEY (`memberID`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '联盟成员' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],

    ---创建统计联盟税收
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        CREATE TABLE `statisticsTaxes`  (
          `memberID` INT(11) NOT NULL COMMENT '联盟成员',
          `taxScore` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '税收贡献',
          `taxProfit` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '已分税收',
          `taxProfitPlatformat` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '平台已分税收',
          `taxProfitclub` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '盟主已分税收',
          `taxProfitadmins` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '代理已分税收',
          PRIMARY KEY (`memberID`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '税收统计' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    ---创建统计联盟收益
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        CREATE TABLE `statisticsEarnings`  (
          `memberID` INT(11) NOT NULL COMMENT '联盟成员',
          `earningsScore` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '收益分数',
          `earningsWithdraw` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '已分税收',
          PRIMARY KEY (`memberID`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '收益统计' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],
}