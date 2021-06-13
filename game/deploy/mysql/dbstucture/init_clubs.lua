--[[
    desc:初始数据
    auth:Carol Luo
]]

return {
    ---切换数据库使用
    [[  USE `dbclubs`;]],
    ---构造系统联盟
    [[
        #超级管理员
        SELECT `rid` INTO @leaderRID FROM `dbusers`.`accounts` WHERE `office` = "root";

        #系统盟主号
        INSERT INTO `clubs`
        (`name`,`personality`, `rid`, `assignRule`, `gameInfos`) 
        VALUES 
        ('虾聊联盟','虾聊一整天,瞎聊联盟欢迎您！(￣～￣) 嚼！', @leaderRID, '{}', '{}');

        #系统盟主ID
        SET @leaderALID = LAST_INSERT_ID();

        #系统盟主代理
        INSERT INTO `admins`
        (`rid`, `clubID`) 
        VALUES 
        (@leaderRID,@leaderALID);

        #系统盟主代理ID
        SET @leaderAGID = LAST_INSERT_ID();

        #系统盟主成员
        INSERT INTO `members`
        (`rid`,`office`,`agentID`, `clubID`) 
        VALUES 
        (@leaderRID,'club',@leaderAGID,@leaderALID);

        #管理代理
        INSERT INTO `admins`
        (`rid`, `clubID`) 
        SELECT `rid`,@leaderAGID
        FROM `dbusers`.`accounts`
        WHERE `office` = 'admin'
        ORDER BY `rid`;

        #代理成员
        INSERT INTO `members`
        (`rid`,`office`,`agentID`, `clubID`) 
        SELECT `rid`,'admin',`agentID`,clubID
        FROM `admins`
        WHERE `clubID` = @leaderALID AND `agentID` !=  @leaderAGID
        ORDER BY `agentID`;

    ]],

    ---机器人默认联盟
    [[
        #系统联盟ID
        SELECT `al`.`clubID`,`al`.`rid` INTO @systemALID,@systemRID
        FROM 
            `clubs` AS `al` 
            INNER JOIN 
            `dbusers`.`accounts` AS `ac`
            USING (`rid`)
        WHERE `ac`.`office` = 'root';

        #系统盟主代理ID
        SELECT `agentID` INTO @systemAGID
        FROM `admins`
        WHERE `clubID` = @systemALID AND `rid` = @systemRID;

        #机器人入盟
        INSERT INTO `members`
        (`rid`, `office`, `agentID`, `clubID`)
        SELECT `rid`,'member',@systemAGID ,@systemALID 
        FROM `dbusers`.`bind_robots`
        ORDER BY `rid`;
    ]]
}