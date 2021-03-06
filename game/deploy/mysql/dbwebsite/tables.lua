
--[[
    desc:数据库结构
    auth:Caorl Luo
]]

return {
    --创建账号数据库
    [[
        DROP DATABASE IF EXISTS `dbwebsite`;
        CREATE DATABASE `dbwebsite` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
    ]],
    ---切换数据库使用
    [[  USE `dbwebsite`;]],

    ---创建后台账号表
    [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        DROP TABLE IF EXISTS `admins`;
        CREATE TABLE `admins`  (
          `admin` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '后台账号',
          `verify` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号秘密',
          `right` enum('root','admin','waiter') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '后台权限',
          PRIMARY KEY (`admin`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
   ]],

   ---创建域名对应表
   [[
        SET NAMES utf8mb4;
        SET FOREIGN_KEY_CHECKS = 0;
        DROP TABLE IF EXISTS `domains`;
        CREATE TABLE `domains`  (
          `domain` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '域名',
          `hosts` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地址',
          `genre` enum('xsServer','xsWebsite','xsClient')
          CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '域名类型',
          PRIMARY KEY (`domain`) USING BTREE
        ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

        SET FOREIGN_KEY_CHECKS = 1;
   ]],

}