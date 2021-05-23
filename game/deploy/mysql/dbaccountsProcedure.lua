
--[[
    file:dbaccounts.lua 
    desc:数据库结构
    auth:Caorl Luo
]]
return {
    ---切换数据库使用
    [[USE `dbaccounts`;]],
    --创建账号注册存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureRegisteredAccounts`(
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
      END]],
    --创建游客登陆存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureLoginTourists`(IN `@accredit` VARCHAR(256))
      BEGIN
      	SET @bindrid = 0; 
      	SELECT `rid` INTO @bindrid FROM `bind_tourists` WHERE `key` = @accredit;
        IF 0 = @bindrid THEN
            #注册账号
            SET @maxRid = 0;
            SET @logolnk = "";
            SELECT COUNT(1) INTO @maxRid FROM `accounts`;
            SELECT `logo` INTO @logolnk FROM `library_logo` WHERE `use` = 0 LIMIT 1;
            CALL procedureRegisteredAccounts(CONCAT("tourists:",@maxRid + 1),CONCAT("游客:",@maxRid + 1),@logolnk,@bindrid);
            #绑定游客
            INSERT INTO `bind_tourists`(`rid`,`key`) VALUES (@bindrid, `@accredit`); 
        END IF;
      	SELECT * FROM `accounts` WHERE rid = @bindrid;
      END]],
    --创建手机登陆存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureLoginPhone`(
        IN `@number` VARCHAR(16),
        IN `@password` VARCHAR(32))
      BEGIN
        SET @bindrid = 0; 
        SELECT `rid` INTO @bindrid FROM `bind_phone` WHERE `num` = @number and `pwd` = @password;
        SELECT * FROM `accounts` WHERE rid = @bindrid;
      END]],
    --创建手机注册存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureRegisterPhone`(
        IN `@nickname` VARCHAR(32),   #昵称
        IN `@logolnk`  VARCHAR(256),  #头像
        IN `@number` VARCHAR(16),     #号码
        IN `@password` VARCHAR(32))   #密码
      BEGIN
        SET @bindrid = 0; 
        SELECT `rid` INTO @bindrid FROM `bind_phone` WHERE `num` = @number and `pwd` = @password;
        IF 0 = @bindrid THEN
          #注册账号
          SET @maxRid = 0;
          SELECT COUNT(1) INTO @maxRid FROM `accounts`;
          CALL procedureRegisteredAccounts(CONCAT("phone:",@maxRid + 1),@nickname,@logolnk,@bindrid);
          #绑定手机
          INSERT INTO `bind_phone`(`rid`,`num`,`pwd`) VALUES (@bindrid, `@number`,`@password`); 
        END IF;
        SELECT * FROM `accounts` WHERE rid = @bindrid;
      END]],
    --创建微信登陆存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureLoginWechat`(
        IN `@nickname` VARCHAR(32),   #微信昵称
        IN `@logolnk`  VARCHAR(256),  #微信头像
        IN `@accredit` VARCHAR(256)   #登录凭证
      )
      BEGIN
        SET @bindrid = 0; 
        SELECT `rid` INTO @bindrid FROM `bind_wechat` WHERE `key` = @accredit;
        IF 0 = @bindrid THEN
          #注册账号
          SET @maxRid = 0;
          SELECT COUNT(1) INTO @maxRid FROM `accounts`;
          CALL procedureRegisteredAccounts(CONCAT("wechat:",@maxRid + 1),@nickname,@logolnk,@bindrid);
          #绑定微信
          INSERT INTO `bind_phone`(`rid`,`key`) VALUES (@bindrid, @accredit); 
        END IF;
        SELECT * FROM `accounts` WHERE rid = @bindrid;
      END]],
    --创建手机绑定存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureBindPhone`(
        IN `@rid` int(10),
        IN `@number` VARCHAR(16),
        IN `@password` VARCHAR(32)
      )
      BEGIN
        IF EXISTS(SELECT 1 FROM `bind_phone` WHERE `rid` = @rid) THEN
          SELECT "该用户已绑定手机！" AS failure;
        ELSEIF EXISTS(SELECT 1 FROM `bind_phone` WHERE `num` = @number) THEN
          SELECT "该手机已绑定用户！" AS failure;
        ELSEIF NOT EXISTS(SELECT 1 FROM `accounts` WHERE `rid` = @rid) THEN
          SELECT "该用户数据不存在！" AS failure;
        ELSE
          INSERT INTO `bind_phone`(`rid`, `num`, `pwd`) VALUES (@rid, @number, @password); 
          SELECT "您手机号绑定成功！" AS successful;
        END IF;
      END]],
    --创建微信绑定存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureBindWechat`(
        IN `@rid` int(10),
        IN `@accredit` VARCHAR(16)
      )
      BEGIN
        IF EXISTS(SELECT 1 FROM `bind_wechat` WHERE `rid` = @rid) THEN
          SELECT "该用户已绑定微信！" AS failure;
        ELSEIF EXISTS(SELECT 1 FROM `bind_wechat` WHERE `num` = @number) THEN
          SELECT "该微信已绑定用户！" AS failure;
        ELSEIF NOT EXISTS(SELECT 1 FROM `accounts` WHERE `rid` = @rid) THEN
          SELECT "该用户数据不存在！" AS failure;
        ELSE
          INSERT INTO `bind_wechat`(`rid`, `key`) VALUES (@rid, @accredit); 
          SELECT "您微信号绑定成功！" AS successful;
        END IF;
      END]],
   
}