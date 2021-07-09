
--[[
    desc:数据库结构
    auth:Caorl Luo
]]

return {
    --创建账号数据库
    [[
        DROP DATABASE IF EXISTS `dbthink`;
        CREATE DATABASE `dbthink` CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_general_ci';
    ]],
    ---切换数据库使用
    [[  USE `dbthink`;]],
}