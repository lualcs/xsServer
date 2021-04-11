
--[[
    file:dbplatform.lua 
    desc:数据库结构
    auth:Caorl Luo
]]

return {
    --创建账号数据库
    [[
        DROP DATABASE IF EXISTS `dbplatform`;
        CREATE DATABASE `dbplatform` CHARACTER SET 'utf8' COLLATE 'utf8_general_ci';
    ]],
}