
--[[
    desc:数据库结构
    auth:Caorl Luo
]]
return {
    ---切换数据库使用
    [[USE `dballiances`;]],
    --创建联盟申请存储过程
    [[CREATE DEFINER=`root`@`%` PROCEDURE `procedureApplyForInAlliance`(
        IN  `@rid`          INT(10),   #申请角色
        IN  `@agentID`      INT(10)    #上级代理
      )
      BEGIN
          #联盟ID
          SET @allianceID = 0;
          SELECT `allianceID` INTO @allianceID FROM `dballiances`.`agencys` WHERE `agentID` = @agentID; 

          #数据检查
          IF @allianceID <= 0 THEN
              SELECT "该代理成员不存在!" AS failure;
          #重复检查
      	  ELSEIF EXISTS(SELECT 1 FROM `members` WHERE `rid` = @rid AND `allianceID` = @allianceID) THEN
              SELECT "已经是该联盟成员!" AS failure;
          ELSE
              INSERT INTO `members`(`rid`, `identity`, `superiorID`, `allianceID`) VALUES (@rid,'member', @agentID, @allianceID);
              SET @memberID = LAST_INSERT_ID();
              SELECT * FROM `members` WHERE `memberID` = @memberID;
          END IF;
      END
    ]],
   
}