
--[[
    desc:数据库结构
    auth:Caorl Luo
]]
return {
    ---切换数据库使用
    [[USE `dballiances`;]],
    --创建联盟存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureCreateAlliance`(
        IN  `@rid`          INT(10),        #申请角色
        IN  `@name`         VARCHAR(32),    #联盟名字
        IN  `@personality`  VARCHAR(16)     #联盟签名
      )
        BEGIN
            IF EXISTS(SELECT 1 FROM `dbaccounts`.`accounts` WHERE `rid` = @rid) THEN
                INSERT INTO `alliances`
                (`name`,`personality`, `rid`, `assignRule`, `gameInfos`) 
                VALUES 
                (@name,@personality, @rid, '{}', '{}');
                SET @allianceID = LAST_INSERT_ID();
                INSERT INTO `agencys`(`rid`, `allianceID`) VALUES (@rid, @allianceID);
                SET @agentID = LAST_INSERT_ID();
                INSERT INTO `agencys`
                (`rid`,`office`,`agentID`, `allianceID`,``) 
                VALUES 
                (@rid,"alliance",@agentID,@allianceID);
                SELECT "联盟创建成功！" AS successful;
            ELSE
                SELECT "账号数据错误！" AS failure; 
            END IF;
        END
    ]],
    --创建加入联盟存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureApplyForInAlliance`(
        IN  `@rid`          INT(10),   #申请角色
        IN  `@agentID`      INT(10)    #上级代理
      )
      BEGIN
          #联盟ID
          SET @allianceID = 0;
          SELECT `allianceID` INTO @allianceID FROM `agencys` WHERE `agentID` = @agentID; 

          #数据检查
          IF @allianceID <= 0 THEN
                SELECT "该代理成员不存在!" AS failure;
          #重复检查
      	  ELSEIF EXISTS(SELECT 1 FROM `members` WHERE `rid` = @rid AND `allianceID` = @allianceID) THEN
                SELECT "已经是该联盟成员!" AS failure;
          ELSE
                INSERT INTO `members`(`rid`, `office`, `agentID`, `allianceID`) VALUES (@rid,'member', @agentID, @allianceID);
                SET @memberID = LAST_INSERT_ID();
                SELECT * FROM `members` WHERE `memberID` = @memberID;
          END IF;
      END
    ]],

    --创建加入系统联盟存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureApplyForInSystemAlliance`(
        IN  `@rid`          INT(10)   #申请角色
      )
      BEGIN

            #盟主角色
            SELECT `rid` INTO @rootRID FROM `dbaccounts`.`accounts` WHERE `office` = "root";
            #系统联盟
            SET @allianceID = 0;
            SELECT `allianceID` INTO @allianceID FROM `alliances` WHERE `rid` = @rootRID;  
            #系统联盟
            SET @agentID = 0;
            SELECT `agentID` INTO @agentID FROM `agencys` WHERE `rid` = @rootRID; 
      
            #重复检查
      	    IF EXISTS(SELECT 1 FROM `members` WHERE `rid` = @rid AND `allianceID` = @allianceID) THEN
                SELECT "已经是该联盟成员!" AS failure;
            ELSE
                INSERT INTO `members`(`rid`, `office`, `agentID`, `allianceID`) VALUES (`@rid`,'member', @agentID, @allianceID);
                SET @memberID = LAST_INSERT_ID();
                SELECT * FROM `members` WHERE `memberID` = @memberID;
            END IF;
      END
    ]],
    --创建升级代理身份
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureUpgradeAgencys`(
        IN  `@memberID`          INT(10)   #申请成员
      )
      BEGIN
            IF EXISTS(SELECT 1 FROM `dballiances`.`members` WHERE `memberID` = @memberID AND `office` = 'member') THEN
                SET @rid = 0;
                SET @allianceID = 0;
                SELECT `rid`,`allianceID` INTO @rid,@allianceID 
                FROM `dballiances`.`members` WHERE `memberID` = @memberID;
                INSERT INTO `agencys`(`rid`, `allianceID`) VALUES (@rid, @allianceID); 
            ELSE
                SELECT "申请成员数据错误!" AS failure;
            END IF;
      END
    ]],
}