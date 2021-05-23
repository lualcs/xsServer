--[[
    desc:联盟信息表
    auth:Carol Luo
]]

return {
    ---切换数据库使用
    [[  USE `dballiances`;]],
    ---插入联盟数据
    [[
        INSERT INTO `alliances`(`name`, `rid`, `assignRule`, `gameInfos`) VALUES ('系统联盟', 0, '{}', '{}');
        INSERT INTO `agencys`(`rid`, `allianceID`) VALUES (0, LAST_INSERT_ID());
    ]],
}