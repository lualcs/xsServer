
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
    [[ USE `dballiances`;]],
    ---创建联盟信息表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      
      -- ----------------------------
      -- Table structure for alliances
      -- ----------------------------
      DROP TABLE IF EXISTS `alliances`;
      CREATE TABLE `alliances`  (
        `allianceID` int(11) NOT NULL AUTO_INCREMENT COMMENT '联盟ID',
        `name` varchar(32) NOT NULL COMMENT '联盟名字',
        `rid` int(11) NOT NULL COMMENT '归属角色',
        `assignRule` json NOT NULL COMMENT '分配规则',
        `gameInfos` json NOT NULL COMMENT '游戏信息',
        `birthday` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
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
        `agentID` int(11) NOT NULL AUTO_INCREMENT COMMENT '代理ID',
        `rid` int(11) NOT NULL COMMENT '所属角色',
        `allianceID` int(11) NOT NULL COMMENT '所属联盟',
        `birthday` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
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
        `memberID` int(11) NOT NULL AUTO_INCREMENT COMMENT '成员ID',
        `rid` int(11) NOT NULL COMMENT '联盟成员',
        `identity` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '联盟身份',
        `superiorID` int(11) NOT NULL COMMENT '上级代理',
        `allianceID` int(11) NOT NULL COMMENT '所属联盟',
        `birthday` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建日期',
        PRIMARY KEY (`memberID`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '联盟成员' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
}