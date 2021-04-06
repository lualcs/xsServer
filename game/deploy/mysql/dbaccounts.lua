
--[[
    file:struct.lua 
    desc:数据库结构
    auth:Caorl Luo
]]
return {
    --创建账号数据库
    [[
      DROP DATABASE IF EXISTS `dbaccounts`;
      CREATE DATABASE `dbaccounts` CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
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
        `accounts` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
        `nickname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
        `logo` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '头像',
        `coin` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏硬币',
        `silver` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏银币',
        `gold` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏金币',
        `masonry` bigint(20) NOT NULL DEFAULT 0 COMMENT '游戏砖石',
        PRIMARY KEY (`rid`,`accounts`) USING BTREE
      ) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT '角色信息' ROW_FORMAT = Dynamic;

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
      CREATE TABLE `bindwechat`  (
        `rid` int(10) UNSIGNED NOT NULL COMMENT '角色id',
        `key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登陆凭证',
        PRIMARY KEY (`key`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT '微信绑定' ROW_FORMAT = Dynamic;

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
      CREATE TABLE `bindphone`  (
        `rid` int(10) UNSIGNED NOT NULL COMMENT '角色id',
        `num` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '手机号码',
        `pwd` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登陆凭证',
        PRIMARY KEY (`num`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT '手机绑定' ROW_FORMAT = Dynamic;

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
      CREATE TABLE `bindtourists`  (
        `rid` int(10) UNSIGNED NOT NULL COMMENT '角色id',
        `key` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登陆凭证',
        PRIMARY KEY (`key`) USING BTREE
      ) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT '游客绑定' ROW_FORMAT = Dynamic;

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
      CREATE DEFINER=`root`@`%` PROCEDURE `procLoginTourists`(IN `@openid` VARCHAR(256))
      BEGIN
      	SET @bindrid = 0; 
      	SELECT `rid` INTO @bindrid FROM `bindtourists` WHERE `key` = `@openid`;
        IF 0 = @bindrid THEN
            #注册账号
            SET @maxRid = 0;
            SELECT COUNT(1) INTO @maxRid FROM `accounts`;
            CALL procRegisteredAccounts(CONCAT("yk",@maxRid + 1),CONCAT("游客",@maxRid + 1),NULL,@bindrid);
            #绑定游客
            INSERT INTO `bindtourists`(`rid`,`key`) VALUES (@bindrid, `@openid`); 
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
        SELECT `rid` INTO @bindrid FROM `bindphone` WHERE `num` = `@number` and `pwd` = `@password`;
        SELECT * FROM `accounts` WHERE rid = @bindrid;
      END
    ]],
    --创建微信登陆存储过程
    [[
      USE `dbaccounts`;
      CREATE DEFINER=`root`@`%` PROCEDURE `procLoginWechat`(IN `@openid` VARCHAR(256))
      BEGIN
        SET @bindrid = 0; 
        SELECT `rid` INTO @bindrid FROM `bindwechat` WHERE `key` = `@openid`;
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
        IF EXISTS(SELECT 1 FROM `bindphone` WHERE `rid` = `@rid`) THEN
          SELECT "该用户已绑定手机！" as failure;
        ELSEIF EXISTS(SELECT 1 FROM `bindphone` WHERE `num` = `@number`) THEN
          SELECT "该手机已绑定用户！" as failure;
        ELSEIF NOT EXISTS(SELECT 1 FROM `accounts` WHERE `rid` = `@rid`) THEN
          SELECT "该用户数据不存在！" as failure;
        ELSE
          INSERT INTO `bindphone`(`rid`, `num`, `pwd`) VALUES (`@rid`, `@number`, `@password`); 
          SELECT "您手机号绑定成功！" as successful;
        END IF;
      END
    ]],
    --创建微信绑定存储过程
    [[
      USE `dbaccounts`;
      CREATE DEFINER=`root`@`%` PROCEDURE `procBindWechat`(
        IN `@rid` int(10),
        IN `@openid` VARCHAR(16)
      )
      BEGIN
        IF EXISTS(SELECT 1 FROM `bindwechat` WHERE `rid` = `@rid`) THEN
          SELECT "该用户已绑定微信！" as failure;
        ELSEIF EXISTS(SELECT 1 FROM `bindwechat` WHERE `num` = `@number`) THEN
          SELECT "该微信已绑定用户！" as failure;
        ELSEIF NOT EXISTS(SELECT 1 FROM `accounts` WHERE `rid` = `@rid`) THEN
          SELECT "该用户数据不存在！" as failure;
        ELSE
          INSERT INTO `bindwechat`(`rid`, `key`) VALUES (`@rid`, `@openid`); 
          SELECT "您微信号绑定成功！" as successful;
        END IF;
      END
    ]],
   
}