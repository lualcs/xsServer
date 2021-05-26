
--[[
    desc:数据库结构
    auth:Caorl Luo
]]
return {
    --创建联盟数据库
    [[
      DROP DATABASE IF EXISTS `dballiances`;
      CREATE DATABASE `dballiances` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
    ]],
    ---切换数据库使用
    [[USE `dballiances`;]],
    ---创建联盟信息表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      
      -- ----------------------------
      -- Table structure for alliances
      -- ---------------------------- 
      DROP TABLE IF EXISTS `alliances`;
      CREATE TABLE `alliances`  (
        `allianceID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '联盟ID',
        `name` VARCHAR(32) NOT NULL COMMENT '联盟名字',
        `personality` VARCHAR(16) NOT NULL DEFAULT '欢迎大家加入俱乐部！' COMMENT '个性签名',
        `rid` INT(11) NOT NULL COMMENT '归属角色',
        `profitPlatformRate` INT(11) NOT NULL DEFAULT 20 COMMENT '平台分润比例千分比',
        `profitAllianceRate` INT(11) NOT NULL DEFAULT 30 COMMENT '盟主分润比例千分比',
        `profitAgencyRate` INT(11) NOT NULL DEFAULT 50 COMMENT '代理分润比例千分比',
        `assignRule` JSON NOT NULL DEFAULT '{}'COMMENT '分配规则',
        `gameInfos` JSON NOT NULL DEFAULT '{}'COMMENT '游戏信息',
        `birthday` DATATIIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
        PRIMARY KEY (`allianceID`) USING BTREE
      ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '联盟信息' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],

    ---创建代理信息表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;

      -- ----------------------------
      -- Table structure for agencys
      -- ----------------------------
      DROP TABLE IF EXISTS `agencys`;
      CREATE TABLE `agencys`  (
        `agentID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '代理ID',
        `rid` INT(11) NOT NULL COMMENT '所属角色',
        `allianceID` INT(11) NOT NULL COMMENT '所属联盟',
        `birthday` DATATIIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
        PRIMARY KEY (`agentID`) USING BTREE
      ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '代理信息' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],

    ---创建联盟成员表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;

      -- ----------------------------
      -- Table structure for members
      -- ----------------------------
      DROP TABLE IF EXISTS `members`;
      CREATE TABLE `members`  (
        `memberID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '成员ID',
        `rid` INT(11) NOT NULL COMMENT '联盟成员',
        `identity` VARCHAR(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联盟身份',
        `superiorID` INT(11) NOT NULL COMMENT '上级代理',
        `allianceID` INT(11) NOT NULL COMMENT '所属联盟',
        `birthday` DATATIIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
        PRIMARY KEY (`memberID`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '联盟成员' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],

    ---创建统计联盟税收
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;

        -- ----------------------------
        -- Table structure for statisticsTaxes
        -- ----------------------------
        DROP TABLE IF EXISTS `statisticsTaxes`;
        CREATE TABLE `statisticsTaxes`  (
          `memberID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '联盟成员',
          `taxScore` bigINT(20) NOT NULL DEFAULT 0 AUTO_INCREMENT COMMENT '税收贡献',
          `taxProfit` bigINT(20) NOT NULL DEFAULT 0 AUTO_INCREMENT COMMENT '已分税收',
          `taxProfitPlatformat` bigINT(20) NOT NULL DEFAULT 0 AUTO_INCREMENT COMMENT '平台已分税收',
          `taxProfitAlliance` bigINT(20) NOT NULL DEFAULT 0 AUTO_INCREMENT COMMENT '盟主已分税收',
          `taxProfitAgencys` bigINT(20) NOT NULL DEFAULT 0 AUTO_INCREMENT COMMENT '代理已分税收',
          PRIMARY KEY (`memberID`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '税收统计' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],

    ---创建统计联盟收益
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;

        -- ----------------------------
        -- Table structure for statisticsEarnings
        -- ----------------------------
        DROP TABLE IF EXISTS `statisticsEarnings`;
        CREATE TABLE `statisticsEarnings`  (
          `memberID` INT(11) NOT NULL AUTO_INCREMENT COMMENT '联盟成员',
          `earningsScore` bigINT(20) NOT NULL DEFAULT 0 AUTO_INCREMENT COMMENT '收益分数',
          `earningsWithdraw` bigINT(20) NOT NULL DEFAULT 0 AUTO_INCREMENT COMMENT '已分税收',
          PRIMARY KEY (`memberID`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '收益统计' ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
    ]],
}