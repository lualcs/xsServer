--[[
    desc:初始数据
    auth:Carol Luo
]]

return {
    ---切换数据库使用
    [[  USE `dballiances`;]],
    ---构造系统联盟
    [[
        #超级管理员
        SELECT `rid` INTO @leaderRID FROM `dbaccounts`.`accounts` WHERE `office` = "root";

        #系统盟主号
        INSERT INTO `alliances`
        (`name`,`personality`, `rid`, `assignRule`, `gameInfos`) 
        VALUES 
        ('虾聊联盟','虾聊一整天,瞎聊联盟欢迎您！(￣～￣) 嚼！', @leaderRID, '{}', '{}');

        #系统盟主ID
        SET @leaderALID = LAST_INSERT_ID();

        #系统盟主代理
        INSERT INTO `agencys`
        (`rid`, `allianceID`) 
        VALUES 
        (@leaderRID,@leaderALID);

        #系统盟主代理ID
        SET @leaderAGID = LAST_INSERT_ID();

        #系统盟主成员
        INSERT INTO `members`
        (`rid`,`office`,`agentID`, `allianceID`) 
        VALUES 
        (@leaderRID,'alliance',@leaderAGID,@leaderALID);

        #管理代理
        INSERT INTO `agencys`
        (`rid`, `allianceID`) 
        SELECT `rid`,@leaderAGID
        FROM `dbaccounts`.`accounts`
        WHERE `office` = 'admin'
        ORDER BY `rid`;

        #代理成员
        INSERT INTO `members`
        (`rid`,`office`,`agentID`, `allianceID`) 
        SELECT `rid`,'agency',`agentID`,allianceID
        FROM `agencys`
        WHERE `allianceID` = @leaderALID AND `agentID` !=  @leaderAGID
        ORDER BY `agentID`;

    ]],

    ---机器人默认联盟
    [[
        #系统联盟ID
        SELECT `al`.`allianceID`,`al`.`rid` INTO @systemALID,@systemRID
        FROM 
            `alliances` AS `al` 
            INNER JOIN 
            `dbaccounts`.`accounts` AS `ac`
            USING (`rid`)
        WHERE `ac`.`office` = 'root';

        #系统盟主代理ID
        SELECT `agentID` INTO @systemAGID
        FROM `agencys`
        WHERE `allianceID` = @systemALID AND `rid` = @systemRID;

        #机器人入盟
        INSERT INTO `members`
        (`rid`, `office`, `agentID`, `allianceID`)
        SELECT `rid`,'member',@systemAGID ,@systemALID 
        FROM `dbaccounts`.`bind_robots`
        ORDER BY `rid`;
    ]]
}