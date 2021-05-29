
--[[
    file:dbaccounts.lua 
    desc:数据库结构
    auth:Caorl Luo
]]
return {
    --创建账号数据库
    [[
      DROP DATABASE IF EXISTS `dbaccounts`;
      CREATE DATABASE `dbaccounts` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
    ]],
    ---切换数据库使用
    [[  USE `dbaccounts`;]],
    --创建账号信息数据表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      CREATE TABLE `accounts`  (
        `rid` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色id',
        `office` enum('robot','player','admin','root') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '身份',
        `accounts` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号',
        `nickname` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
        `logo` VARCHAR(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像',
        `coin` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '游戏硬币',
        `silver` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '游戏银币',
        `gold` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '游戏金币',
        `masonry` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '游戏砖石',
        PRIMARY KEY (`rid`, `accounts`) USING BTREE,
        UNIQUE INDEX `index1`(`rid`) USING BTREE COMMENT '唯一索引',
        UNIQUE INDEX `index2`(`accounts`) USING BTREE COMMENT '唯一索引'
      ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息' ROW_FORMAT = Dynamic;
      SET FOREIGN_KEY_CHECKS = 1;
    ]],
    
    --创建机器账号数据表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      USE `dbaccounts`;
      CREATE TABLE `bind_robots`  (
        `rid` INT(10) UNSIGNED NOT NULL COMMENT '[代表这个账号是机器人]',
        PRIMARY KEY (`rid`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '机器人账号表' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
    --创建微信绑定数据表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      USE `dbaccounts`;
      CREATE TABLE `bind_wechat`  (
        `rid` INT(10) UNSIGNED NOT NULL COMMENT '角色id',
        `key` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登陆凭证',
        PRIMARY KEY (`key`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '微信绑定' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
    --创建手机绑定数据表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      USE `dbaccounts`;
      CREATE TABLE `bind_phone`  (
        `rid` INT(10) UNSIGNED NOT NULL COMMENT '角色id',
        `num` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号码',
        `pwd` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登陆凭证',
        PRIMARY KEY (`num`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '手机绑定' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
     --创建游客绑定数据表
     [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;
      USE `dbaccounts`;
      CREATE TABLE `bind_tourists`  (
        `rid` INT(10) UNSIGNED NOT NULL COMMENT '角色id',
        `key` VARCHAR(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登陆凭证',
        PRIMARY KEY (`key`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '游客绑定' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
}