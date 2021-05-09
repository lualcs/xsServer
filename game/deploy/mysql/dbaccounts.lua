
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
    --创建账号信息数据表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;

      -- ----------------------------
      -- Table structure for accounts
      -- ----------------------------
      USE `dbaccounts`;
      CREATE TABLE `accounts`  (
        `rid` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '角色id',
        `accounts` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号',
        `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
        `logo` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像',
        `coin` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏硬币',
        `silver` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏银币',
        `gold` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏金币',
        `masonry` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏砖石',
        PRIMARY KEY (`rid`,`accounts`) USING BTREE
      ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '角色信息' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
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

    --创建头像库存
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;

      -- ----------------------------
      -- Table structure for accounts
      -- ----------------------------
      USE `dbaccounts`;
      CREATE TABLE `library_logo`  (
        `index` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '序号',
        `logo` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像',
        `use` bit(1) NOT NULL DEFAULT 0 COMMENT '是否使用',
        PRIMARY KEY (`index`) USING BTREE
      ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '头像库存' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
    --创建昵称库存
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;

      -- ----------------------------
      -- Table structure for accounts
      -- ----------------------------
      USE `dbaccounts`;
      CREATE TABLE `library_name`  (
        `index` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '序号',
        `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
        `use` bit(1) NOT NULL DEFAULT 0 COMMENT '是否使用',
        PRIMARY KEY (`index`) USING BTREE
      ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '头像库存' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
    --创建机器账号数据表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;

      -- ----------------------------
      -- Table structure for accounts
      -- ----------------------------
      USE `dbaccounts`;
      CREATE TABLE `bind_robots`  (
        `rid` int(10) UNSIGNED NOT NULL COMMENT '[代表这个账号是机器人]',
        PRIMARY KEY (`rid`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '机器人账号表' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
    --创建微信绑定数据表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;

      -- ----------------------------
      -- Table structure for accounts
      -- ----------------------------
      USE `dbaccounts`;
      CREATE TABLE `bind_wechat`  (
        `rid` int(10) UNSIGNED NOT NULL COMMENT '角色id',
        `key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登陆凭证',
        PRIMARY KEY (`key`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '微信绑定' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
    --创建手机绑定数据表
    [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;

      -- ----------------------------
      -- Table structure for accounts
      -- ----------------------------
      USE `dbaccounts`;
      CREATE TABLE `bind_phone`  (
        `rid` int(10) UNSIGNED NOT NULL COMMENT '角色id',
        `num` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号码',
        `pwd` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登陆凭证',
        PRIMARY KEY (`num`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '手机绑定' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
     --创建游客绑定数据表
     [[
      SET NAMES utf8mb4;
      SET FOREIGN_KEY_CHECKS = 0;

      -- ----------------------------
      -- Table structure for accounts
      -- ----------------------------
      USE `dbaccounts`;
      CREATE TABLE `bind_tourists`  (
        `rid` int(10) UNSIGNED NOT NULL COMMENT '角色id',
        `key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登陆凭证',
        PRIMARY KEY (`key`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT '游客绑定' ROW_FORMAT = Dynamic;

      SET FOREIGN_KEY_CHECKS = 1;
    ]],
     --创建账号注册存储过程
    [[
      USE `dbaccounts`;
      CREATE DEFINER=`root`@`%` PROCEDURE `procRegisteredAccounts`(
        IN  `@accounts`  VARCHAR(32),
        IN  `@nickname`  VARCHAR(32),
        IN  `@logo`      VARCHAR(256),
        OUT `@rid`       INT(10)
      )
      BEGIN
        #注册账号
      	IF NOT EXISTS(SELECT 1 FROM `accounts` WHERE `accounts` = `@accounts`) THEN
            INSERT INTO `accounts`(`accounts`,`nickname`, `logo`) VALUES (`@accounts`,`@nickname`, `@logo`); 
            SET `@rid` = LAST_INSERT_ID();
        END IF;
      END
    ]],
    --创建游客登陆存储过程
    [[
      USE `dbaccounts`;
      CREATE DEFINER=`root`@`%` PROCEDURE `procLoginTourists`(IN `@accredit` VARCHAR(256))
      BEGIN
      	SET @bindrid = 0; 
      	SELECT `rid` INTO @bindrid FROM `bind_tourists` WHERE `key` = `@accredit`;
        IF 0 = @bindrid THEN
            #注册账号
            SET @maxRid = 0;
            SET @logolnk = "";
            SELECT COUNT(1) INTO @maxRid FROM `accounts`;
            SELECT `logo` INTO @logolnk FROM `library_logo` WHERE `use` = 0 LIMIT 1;
            CALL procRegisteredAccounts(CONCAT("tourists:",@maxRid + 1),CONCAT("游客:",@maxRid + 1),@logolnk,@bindrid);
            #绑定游客
            INSERT INTO `bind_tourists`(`rid`,`key`) VALUES (@bindrid, `@accredit`); 
        END IF;
      	SELECT * FROM `accounts` WHERE rid = @bindrid;
      END
    ]],
    --创建手机登陆存储过程
    [[
      USE `dbaccounts`;
      CREATE DEFINER=`root`@`%` PROCEDURE `procLoginPhone`(IN `@number` VARCHAR(16),IN `@password` VARCHAR(32))
      BEGIN
        SET @bindrid = 0; 
        SELECT `rid` INTO @bindrid FROM `bind_phone` WHERE `num` = `@number` and `pwd` = `@password`;
        SELECT * FROM `accounts` WHERE rid = @bindrid;
      END
    ]],
    --创建手机注册存储过程
    [[
      USE `dbaccounts`;
      CREATE DEFINER=`root`@`%` PROCEDURE `procRegisterPhone`(
        IN `@nickname` VARCHAR(32),   #昵称
        IN `@logolnk`  VARCHAR(256),  #头像
        IN `@number` VARCHAR(16),     #号码
        IN `@password` VARCHAR(32))   #密码
      BEGIN
        SET @bindrid = 0; 
        SELECT `rid` INTO @bindrid FROM `bind_phone` WHERE `num` = `@number` and `pwd` = `@password`;
        IF 0 = @bindrid THEN
          #注册账号
          SET @maxRid = 0;
          SELECT COUNT(1) INTO @maxRid FROM `accounts`;
          CALL procRegisteredAccounts(CONCAT("phone:",@maxRid + 1),@nickname,@logolnk,@bindrid);
          #绑定手机
          INSERT INTO `bind_phone`(`rid`,`num`,`pwd`) VALUES (@bindrid, `@number`,`@password`); 
        END IF;
        SELECT * FROM `accounts` WHERE rid = @bindrid;
      END
    ]],
    --创建微信登陆存储过程
    [[
      USE `dbaccounts`;
      CREATE DEFINER=`root`@`%` PROCEDURE `procLoginWechat`(
        IN `@nickname` VARCHAR(32),   #微信昵称
        IN `@logolnk`  VARCHAR(256),  #微信头像
        IN `@accredit` VARCHAR(256)   #登录凭证
      )
      BEGIN
        SET @bindrid = 0; 
        SELECT `rid` INTO @bindrid FROM `bind_wechat` WHERE `key` = `@accredit`;
        IF 0 = @bindrid THEN
          #注册账号
          SET @maxRid = 0;
          SELECT COUNT(1) INTO @maxRid FROM `accounts`;
          CALL procRegisteredAccounts(CONCAT("wechat:",@maxRid + 1),@nickname,@logolnk,@bindrid);
          #绑定微信
          INSERT INTO `bind_phone`(`rid`,`key`) VALUES (@bindrid, `@accredit`); 
        END IF;
        SELECT * FROM `accounts` WHERE rid = @bindrid;
      END
    ]],
    --创建手机绑定存储过程
    [[
      USE `dbaccounts`;
      CREATE DEFINER=`root`@`%` PROCEDURE `procBindPhone`(
        IN `@rid` int(10),
        IN `@number` VARCHAR(16),
        IN `@password` VARCHAR(32)
      )
      BEGIN
        IF EXISTS(SELECT 1 FROM `bind_phone` WHERE `rid` = `@rid`) THEN
          SELECT "该用户已绑定手机！" as failure;
        ELSEIF EXISTS(SELECT 1 FROM `bind_phone` WHERE `num` = `@number`) THEN
          SELECT "该手机已绑定用户！" as failure;
        ELSEIF NOT EXISTS(SELECT 1 FROM `accounts` WHERE `rid` = `@rid`) THEN
          SELECT "该用户数据不存在！" as failure;
        ELSE
          INSERT INTO `bind_phone`(`rid`, `num`, `pwd`) VALUES (`@rid`, `@number`, `@password`); 
          SELECT "您手机号绑定成功！" as successful;
        END IF;
      END
    ]],
    --创建微信绑定存储过程
    [[
      USE `dbaccounts`;
      CREATE DEFINER=`root`@`%` PROCEDURE `procBindWechat`(
        IN `@rid` int(10),
        IN `@accredit` VARCHAR(16)
      )
      BEGIN
        IF EXISTS(SELECT 1 FROM `bind_wechat` WHERE `rid` = `@rid`) THEN
          SELECT "该用户已绑定微信！" as failure;
        ELSEIF EXISTS(SELECT 1 FROM `bind_wechat` WHERE `num` = `@number`) THEN
          SELECT "该微信已绑定用户！" as failure;
        ELSEIF NOT EXISTS(SELECT 1 FROM `accounts` WHERE `rid` = `@rid`) THEN
          SELECT "该用户数据不存在！" as failure;
        ELSE
          INSERT INTO `bind_wechat`(`rid`, `key`) VALUES (`@rid`, `@accredit`); 
          SELECT "您微信号绑定成功！" as successful;
        END IF;
      END
    ]],
   
}